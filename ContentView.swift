import SwiftUI

struct ContentView: View {
    struct ToDo: Identifiable {
        let id = UUID()
        var title: String
        var isCompleted: Bool
    }
    
    @State private var toDos: [ToDo] = []
    @State private var newTitle = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(toDos) { todo in
                    HStack {
                        Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                        Spacer()
                        Text(todo.title)
                    }
                    // 할 일 완료 체크표시
                    .onTapGesture {
                        if let i = toDos.firstIndex(where: { $0.id == todo.id }) {
                            toDos[i].isCompleted.toggle()
                        }
                    }
                    // 할 일 삭제
                    .swipeActions {
                        Button(role: .destructive) {
                            toDos.removeAll { $0.id == todo.id }
                        } label: {
                            Label("삭제", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle("오늘의 할일")
            .toolbar {
                Button {
                    showAlert = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .alert("새 할일", isPresented: $showAlert) {
                TextField("입력하세요", text: $newTitle)
                Button("취소", role: .cancel) {
                    newTitle = ""
                }
                Button("추가") {
                    if !newTitle.isEmpty{
                        toDos.append(ToDo(title: newTitle, isCompleted: false))
                        newTitle = ""
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
