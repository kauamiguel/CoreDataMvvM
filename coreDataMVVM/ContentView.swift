//
//  ContentView.swift
//  coreDataMVVM
//
//  Created by Kaua Miguel on 14/08/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = CoreDataViewModel()
    @State var aluno:String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                TextField("Adicionar Aluno", text: $aluno)
                    .padding()
                Button("Adicione") {
                    viewModel.addAluno(text: aluno)
                    aluno = ""
                }
                Spacer()
                
                List {
                    ForEach(viewModel.savedEntities){ entity in
                        Text(entity.name ?? "")
                            .onTapGesture {
                                viewModel.updateAluno(entity: entity)
                            }
                    }
                    .onDelete(perform: viewModel.removeAluno)
                }
            }
            .navigationTitle("Alunos")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
