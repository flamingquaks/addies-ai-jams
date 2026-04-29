# Addie's AI Jams — Claude Instructions

This is a GitHub Pages music site that showcases AI-generated songs.
Live site: https://flamingquaks.github.io/addies-ai-jams

## Project Structure

```
addies-ai-jams/
├── index.html        # The website (dark music player UI)
├── songs.json        # Song data — THIS is what the site reads
├── audio/            # Track files live here
│   ├── *.mp4         # Track files (Suno video exports)
│   ├── *.mp3         # Track files (audio-only)
│   └── sources/      # Shared "source" / inspiration audio files
│       └── *.mp3
└── CLAUDE.md         # You are here
```

## songs.json Format

The site reads `songs.json` directly. There are two top-level arrays:
`songs` (the tracks shown on the site, in order) and `sources` (a shared
library of inspiration audio that one or more tracks can reference).
**Order in the `songs` array = order on the site.**

```json
{
  "sources": [
    {
      "id": "apr-26-recording",
      "title": "Sound Inspiration",
      "audio": "audio/sources/apr-26-recording.mp3"
    }
  ],
  "songs": [
    {
      "title": "Song Name Here",
      "video": "audio/filename.mp4",
      "audio": "audio/filename.mp3",
      "lyrics": "https://docs.google.com/document/d/...",
      "original": "https://drive.google.com/file/d/...",
      "sources": ["apr-26-recording"]
    }
  ]
}
```

### Song fields
- `title` — display name shown on the site
- `video` — path to mp4 in the `audio/` folder (e.g. `audio/my-song.mp4`). If set, the site renders a video player. Takes precedence over `audio`.
- `audio` — path to mp3 in the `audio/` folder (e.g. `audio/my-song.mp3`). Used when there is no video. Can be empty string `""`.
- `lyrics` — link to a Google Doc with the lyrics (can be empty string `""`)
- `original` — link to original recording on Google Drive or Dropbox (can be empty string `""`)
- `sources` — array of source `id`s from the top-level `sources` library. Each id renders as a small audio player under the track in an "Inspiration" section. Unknown ids are skipped silently. Can be `[]` or omitted.

### Source fields (top-level `sources` library)
- `id` — stable identifier, lowercase + hyphens (e.g. `apr-26-recording`). Songs reference this via their `sources` array.
- `title` — label shown above the audio player (e.g. `"Sound Inspiration"`, `"Voice memo"`).
- `audio` — path to the source mp3 in `audio/sources/` (e.g. `audio/sources/apr-26-recording.mp3`).

The same source `id` can appear in any number of songs' `sources` arrays — that's the whole point of the shared library.

## How to Add a Source (and link it to tracks)

When Addie says "add a source", "add an inspiration", or "this audio is the source/inspiration for [track(s)]":

1. Get the source mp3 (Addie drops it in `~/projects/addies-ai-jams/audio/sources/` or sends it via chat). File names use lowercase + hyphens.
2. Ask for a title (e.g. "Sound Inspiration", "Voice memo - guitar sketch") and which tracks it inspires.
3. Add a new entry to the top-level `sources` array in `songs.json` with a stable `id`, `title`, and `audio` path.
4. For each track that should show this source, add the `id` to that song's `sources` array.
5. Commit and push (commit message: `🌱 Add source: [title]` or similar).

To link an **existing** source to another track, just append its `id` to that song's `sources` array — do NOT duplicate the source entry.

## How to Add a New Song

When Addie says "add a song" or "add [song name]":

1. Ask for the mp4/mp3 file if not already in `audio/` — Addie will drop it into `~/projects/addies-ai-jams/audio/`
2. Ask for the song title, lyrics link (optional), and original recording link (optional)
   - For Suno songs: use the `video` field for mp4 files, `audio` field for mp3-only songs
3. Add the song to the END of the `songs` array in `songs.json`
4. Commit and push:
   ```bash
   cd ~/projects/addies-ai-jams
   git add -A
   git commit -m "🎵 Add: [Song Title]"
   git push
   ```
5. The site updates automatically within ~60 seconds via GitHub Pages

## How to Reorder Songs

When Addie wants to change the order:
- Reorder the objects in the `songs` array in `songs.json`
- Commit and push

## How to Remove a Song

- Remove the song object from `songs.json`
- Optionally delete the mp3 from `audio/`
- Commit and push

## How to Edit a Song

- Update the relevant fields in `songs.json`
- Commit and push

## Naming Convention for Audio Files

Use lowercase, hyphen-separated names. No spaces.
- Good: `audio/my-first-song.mp3`
- Good: `audio/rainy-day-vibes.mp3`
- Bad: `audio/My First Song.mp3`

## Google Drive Links (for original recordings)

Addie stores original recordings in Google Drive. Share links look like:
`https://drive.google.com/file/d/FILE_ID/view?usp=sharing`

Use them as-is in the `original` field — the site shows them as a button that opens in a new tab.

## Lyrics Links

Addie writes lyrics in Google Docs. The doc must be shared as "Anyone with the link can view."
Use the standard Google Docs URL in the `lyrics` field.

## GitHub Pages

- Site deploys from `main` branch automatically
- After a `git push`, the site refreshes within ~60 seconds
- URL: https://flamingquaks.github.io/addies-ai-jams
