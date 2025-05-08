import SwiftUI

struct ToDo: Identifiable {
    var id = UUID()
    var title: String
    var isCompeleted: Bool
}

struct ContentView: View {
    @State private var toDos: [ToDo] = [] //할 일을 저장하는 목록
    @State private var newToDoTitle: String = "" //새 할 일을 입력받는 변수
    @State private var showingAddAlert = false //할 일 추가 알림 창
    
    var body: some View {
        NavigationView {
            List(toDos) { todo in
                HStack {
                    Text(todo.title)
                    Spacer()
                    Image(systemName: todo.isCompeleted ? "checkmark.circle.fill" : "circle")
                }
                .onTapGesture {
                    toggleToDoCompletion(todo)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        if let index = toDos.firstIndex(where: { $0.id == todo.id }) {
                            toDos.remove(at: index)
                        }
                    } label: {
                        Label("삭제", systemImage: "trash")
                    }
                }
            }
            .navigationTitle("오늘의 할일")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddAlert.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .alert("새 할일", isPresented: $showingAddAlert) {
                TextField("입력하세요", text: $newToDoTitle)
                Button("취소", role: .cancel) {
                    newToDoTitle = ""
                }
                Button("추가") {
                    addToDo()
                }
            }
        }
    }
    
    // 할일 추가 함수
    func addToDo() {
        if !newToDoTitle.isEmpty {
            let newToDo = ToDo(title: newToDoTitle, isCompeleted: false)
            toDos.append(newToDo)
            newToDoTitle = ""
        }
    }
    
    // 할일 삭제 함수
    func deleteItems(at offsets: IndexSet) {
        toDos.remove(atOffsets: offsets)
    }
    
    // 할일 완료 상태 함수
    func toggleToDoCompletion(_ todo: ToDo) {
        if let index = toDos.firstIndex(where: { $0.id == todo.id }) {
            toDos[index].isCompeleted.toggle()
        }
    }
}

#Preview {
    ContentView()
}
