//
//  TestListView.swift
//  TCA scrollTo
//
//  Created by Chan Jung on 5/19/25.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct TestListView: View {
    init() {
        let store = Store(initialState: TestListMotherFeature.State()) {
            TestListMotherFeature()
        }
        self.motherStore = store
    }
    
    @Bindable var motherStore: StoreOf<TestListMotherFeature>
    
    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                Button {
                    proxy.scrollTo("Skylar")
                } label: {
                    Text("jump to Skylar")
                }
                
                // does not work
                List(motherStore.scope(state: \.items, action: \.itemAction)) { itemStore in
                    Text(itemStore.name)
                        .id(itemStore.id)
                }
                
                Divider()
                
                List(motherStore.names, id: \.self) { name in
                    Text(name)
                        .bold()
                        .id(name)
                }
            }
            .onAppear {
                motherStore.send(.buildItems)
            }
        }
    }
}

@Reducer
struct TestListMotherFeature {
    @ObservableState
    struct State {
        let names: [String] = [
            "Ava", "Liam", "Olivia", "Noah", "Emma", "Elijah", "Charlotte", "James",
            "Amelia", "Benjamin", "Sophia", "Lucas", "Isabella", "Mason", "Mia", "Ethan",
            "Harper", "Logan", "Evelyn", "Alexander", "Abigail", "Henry", "Ella", "Jackson",
            "Scarlett", "Sebastian", "Grace", "Aiden", "Chloe", "Matthew", "Lily", "Samuel",
            "Aurora", "David", "Hannah", "Joseph", "Zoe", "Carter", "Penelope", "Owen",
            "Layla", "Wyatt", "Aria", "John", "Riley", "Jack", "Nora", "Luke", "Ellie",
            "Jayden", "Stella", "Dylan", "Natalie", "Grayson", "Zoey", "Levi", "Violet",
            "Isaac", "Hazel", "Gabriel", "Lillian", "Julian", "Addison", "Lincoln", "Willow",
            "Anthony", "Paisley", "Hudson", "Lucy", "Hunter", "Brooklyn", "Thomas", "Claire",
            "Charles", "Skylar", "Ezra", "Samantha", "Christopher", "Naomi", "Jaxon", "Aubrey"
        ]
        var items: IdentifiedArrayOf<TestListElementFeature.State> = []
    }
    
    enum Action {
        case buildItems
        case itemAction(IdentifiedActionOf<TestListElementFeature>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .buildItems:
                state.items = []
                
                for name in state.names {
                    state.items.append(.init(name: name))
                }
                return .none
            case .itemAction:
                return .none
            }
        }
        .forEach(\.items, action: \.itemAction) {
            TestListElementFeature()
        }
    }
}

@Reducer
struct TestListElementFeature {
    @ObservableState
    struct State: Identifiable {
        var name: String
        var id: String { name }
        
        init(name: String) {
            self.name = name
        }
    }
    
    enum Action {
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            }
        }
    }
}
