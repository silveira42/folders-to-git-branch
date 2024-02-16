# Folders to git branches (linux-only)

## Usage

```$ ./branchfy.sh <project-directory>```

## Explanation

In some older projects, some people used to versionate the code by creating one version per folder, as such:

```
└── project
    └── main
        ├── app.js
        ├── models.js
        ├── routes.js
    └── dev
        ├── app.js
        ├── models.js
        ├── routes.js
    └── hom
        ├── app.js
        ├── models.js
        ├── routes.js
```

Nowadays, using Git is a way more common and mainstream way to versionate your code, but changing from this folder structure to individual git branches as displayed below can be rather tiresome and repetitive.

```
└── project (main)
    ├── app.js
    ├── models.js
    ├── routes.js
```

```
└── project (dev)
    ├── app.js
    ├── models.js
    ├── routes.js
```
Therefore I developed this script to do this tedious task in an automated fashion.

Use freely!
