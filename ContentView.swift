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
                ForEach($toDos) {$todo in
                    HStack {
                        Button(action:{
                            todo.isCompleted.toggle()
                        }){
                            Image(systemName: todo.isCompleted ? "checkmark.circle" : "circle")}
                        Spacer()
                        Text(todo.title)
                    }
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
