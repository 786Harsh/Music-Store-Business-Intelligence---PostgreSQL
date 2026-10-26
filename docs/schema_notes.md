# Chinook Database Schema Notes

## Data Model Overview

The Chinook data model represents a digital media store, including
tables for artists, albums, media tracks, invoices, and customers.

The database uses primary keys and foreign keys to establish
relationships between the tables.

## Main Tables and Relationships

### Artist → Album

- `Artist.ArtistId` is the primary key.
- `Album.AlbumId` is the primary key.
- `Album.ArtistId` is a foreign key referencing `Artist.ArtistId`.
- One artist can have multiple albums.

**Relationship:**

`Artist → Album`

---

### Album → Track

- `Album.AlbumId` is the primary key.
- `Track.TrackId` is the primary key.
- `Track.AlbumId` is a foreign key referencing `Album.AlbumId`.
- One album can contain multiple tracks.

**Relationship:**

`Album → Track`

---

### Track → MediaType

- `MediaType.MediaTypeId` is the primary key.
- `Track.MediaTypeId` is a foreign key referencing `MediaType.MediaTypeId`.
- A media type can be associated with multiple tracks.

**Relationship:**

`MediaType → Track`

---

### Track → Genre

- `Genre.GenreId` is the primary key.
- `Track.GenreId` is a foreign key referencing `Genre.GenreId`.
- One genre can contain multiple tracks.

**Relationship:**

`Genre → Track`

---

### Track → InvoiceLine

- `Track.TrackId` is the primary key.
- `InvoiceLine.InvoiceLineId` is the primary key.
- `InvoiceLine.TrackId` is a foreign key referencing `Track.TrackId`.
- A track can appear in multiple invoice lines.

**Relationship:**

`Track → InvoiceLine`

---

### Invoice → InvoiceLine

- `Invoice.InvoiceId` is the primary key.
- `InvoiceLine.InvoiceId` is a foreign key referencing `Invoice.InvoiceId`.
- One invoice can contain multiple invoice lines.

**Relationship:**

`Invoice → InvoiceLine`

---

### Customer → Invoice

- `Customer.CustomerId` is the primary key.
- `Invoice.CustomerId` is a foreign key referencing `Customer.CustomerId`.
- One customer can have multiple invoices.

**Relationship:**

`Customer → Invoice`

---

### Employee → Customer

- `Employee.EmployeeId` is the primary key.
- `Customer.SupportRepId` is a foreign key referencing `Employee.EmployeeId`.
- An employee can support multiple customers.

**Relationship:**

`Employee → Customer`

---

### Employee → Employee

The `Employee` table contains a `ReportsTo` column.

- `Employee.EmployeeId` identifies an employee.
- `Employee.ReportsTo` references another employee.
- This creates a self-referencing relationship representing the employee hierarchy.

**Relationship:**

`Employee → Employee`

---

### Playlist → PlaylistTrack → Track

The database also contains a many-to-many relationship between
playlists and tracks.

- `Playlist.PlaylistId` identifies a playlist.
- `PlaylistTrack.PlaylistId` references `Playlist.PlaylistId`.
- `PlaylistTrack.TrackId` references `Track.TrackId`.
- `PlaylistTrack` acts as a junction table.

**Relationship:**

`Playlist → PlaylistTrack ← Track`

---

## Main Sales Flow

The most important relationship for sales analysis is:

`Customer → Invoice → InvoiceLine → Track`

Track information can then be connected to:

`Track → Album → Artist`

and:

`Track → Genre`

This allows sales to be analyzed by:

- Customer
- Invoice
- Track
- Album
- Artist
- Genre


## Key Tables for Sales Analysis

`Invoice` and `InvoiceLine` are the main tables used for sales
analysis.

`Invoice` contains the overall purchase information, while
`InvoiceLine` contains the individual tracks purchased, their
quantities, and unit prices.

The sales structure can therefore be represented as:

`Customer → Invoice → InvoiceLine → Track → Album → Artist`

Additional analysis can be performed by connecting `Track` to
`Genre` and `MediaType`.