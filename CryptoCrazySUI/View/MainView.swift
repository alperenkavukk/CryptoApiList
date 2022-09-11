//
//  MainView.swift
//  CryptoCrazySUI
//
//  Created by Alperen Kavuk on 11.09.2022.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var cryptoListViewModel : CryptoListViewModel
    init(){
        self.cryptoListViewModel =  CryptoListViewModel()
    }
    
    var body: some View {
            
        NavigationView {
            List(cryptoListViewModel.cryptoList, id : \.id) { crypto in
                VStack{
                    Text(crypto.currency).font(.title3).foregroundColor(.blue).frame(  maxWidth: .infinity, alignment: .center)
                    Text(crypto.price).foregroundColor(.red)
                }
            }.toolbar(content: {
                Button {
                    Task.init {
                        cryptoListViewModel.cryptoList = []
                    await cryptoListViewModel.downloadCryptoAsync(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
                    }
                    
                } label: {
                    Text("Refresh")
                }
            })
            .navigationTitle("CryptoCrayz")
            
        }.task{
            await cryptoListViewModel.downloadCryptoAsync(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
        }
        
        
      /*  .onAppear {
          //  cryptoListViewModel.downloadCryptos(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
        }*/
    
    
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
