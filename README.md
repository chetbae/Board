# Board

An iOS app for interacting with system training boards. *(development starting with kilter, then moonboard, then tb2)*

## Setup

### Prerequisites
- Xcode 15.0+
- Python 3.7+
- pip (Python package installer)

### Database Setup

The app requires a Kilterboard database file (`kilter.db`) which contains route and hold information. Due to its size (>100MB), this file is not included in the repository and needs to be downloaded separately.

1. Install boardlib using pip:
```bash
python3 -m pip install boardlib
```

2. Download and sync the Kilterboard database:
```bash
# From the project root directory:
mkdir -p Board/Resources
boardlib database kilter Board/Resources/kilter.db
```

3. Open `Board.xcodeproj` in Xcode and build the project

The database file will be automatically copied into the app bundle during the build process.

### Development

- `Board/` - Contains the main app source code
  - `Data/` - Data layer (repositories, services)
  - `Domain/` - Business logic and models
  - `Presentation/` - UI layer (views, view models)
  - `Resources/` - App resources including the Kilterboard database

### Troubleshooting

If you encounter database-related issues:
1. Ensure `kilter.db` exists in `Board/Resources/`
2. Try re-running the boardlib command to get a fresh copy of the database
3. Clean the build folder in Xcode (Shift + Cmd + K) and rebuild
