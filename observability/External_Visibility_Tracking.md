# External Visibility Tracking

This document defines how external visibility of LUMINA-30, PCR-C, related DOI records, Zenodo records, arXiv entries, and GitHub repositories should be monitored.

It does not claim external adoption.  
It only defines what evidence should be collected to determine whether external visibility exists.

---

## 1. Purpose

LUMINA-30 requires observable external reference paths.

The purpose of this tracking layer is to avoid relying on impressions such as:

- “it may have been seen”;
- “it is probably visible”;
- “the DOI exists”;
- “the GitHub repository is public.”

Instead, visibility should be evaluated using recorded evidence.

---

## 2. Observation Categories

External visibility should be tracked in five categories:

1. GitHub traffic;
2. Zenodo views and downloads;
3. DOI / DataCite usage and linking events;
4. arXiv presence and external references;
5. search, citation, and referral evidence.

Each category should be recorded separately.

---

## 3. GitHub Traffic

GitHub repository visibility should be tracked using repository traffic data where available.

Minimum fields:

| Field | Meaning |
|---|---|
| Repository | Repository name |
| Views | Repository views within the available traffic window |
| Unique visitors | Distinct visitors where available |
| Clones | Repository clones |
| Unique cloners | Distinct cloners |
| Popular paths | Pages or files receiving traffic |
| Referrers | External domains sending traffic |
| Observation date | Date when the data was recorded |

GitHub traffic data is time-limited.  
Therefore, snapshots should be taken periodically.

---

## 4. Zenodo Visibility

Zenodo visibility should be tracked for each relevant record and DOI.

Minimum fields:

| Field | Meaning |
|---|---|
| Record title | Zenodo record title |
| Concept DOI | DOI representing all versions |
| Version DOI | DOI for the specific version |
| Views | Record views |
| Unique views | Unique record views where displayed |
| Downloads | File downloads |
| Unique downloads | Unique file downloads where displayed |
| Data volume | Downloaded data volume where displayed |
| Observation date | Date when the data was recorded |

When both Concept DOI and Version DOI exist, both should be recorded.

---

## 5. DOI / DataCite Evidence

DOI visibility should be tracked through DataCite where available.

Minimum fields:

| Field | Meaning |
|---|---|
| DOI | DOI being checked |
| Metadata status | Whether the DOI resolves correctly |
| Usage events | Usage events reported through DataCite |
| Citation/reference events | Linking events involving the DOI |
| Related identifiers | Related DOI / URL relationships |
| Observation date | Date when the data was recorded |

Absence of DataCite events should not be treated as absence of all external visibility.  
It should only be recorded as “no DataCite event observed.”

---

## 6. arXiv Evidence

arXiv does not provide paper-level download statistics.

Therefore, arXiv visibility should be tracked using proxy evidence:

| Field | Meaning |
|---|---|
| arXiv ID | arXiv identifier |
| arXiv URL resolves | Whether the abstract page resolves |
| DOI linked | Whether DOI / journal reference is present where applicable |
| External mentions | Mentions of the arXiv ID outside arXiv |
| Search visibility | Whether the title / arXiv ID appears in search results |
| Citation evidence | Citations detected through external indexes |
| Observation date | Date when the data was recorded |

Do not claim arXiv download counts unless arXiv itself provides such data.

---

## 7. External Search Evidence

Search evidence should be recorded conservatively.

Minimum queries:

- "LUMINA-30"
- "LUMINA-30 Boundary Check"
- "Pre-Critical Recursive Cutoff"
- "PCR-C irreversibility risk"
- "effective human refusal before irreversibility"
- exact DOI strings
- exact arXiv IDs, if available

Record only observable evidence:

| Field | Meaning |
|---|---|
| Query | Exact query used |
| Result found | Yes / No |
| Result type | GitHub / Zenodo / arXiv / citation / discussion / other |
| Source | Domain or platform |
| Date observed | Observation date |
| Notes | Minimal factual note |

Do not infer adoption from search presence alone.

---

## 8. Interpretation Rules

Use the following interpretation rules:

| Evidence | Interpretation |
|---|---|
| GitHub views / clones | Visibility or technical access, not adoption |
| Zenodo views | Record-level interest, not endorsement |
| Zenodo downloads | Stronger than views, but not adoption |
| DOI events | Traceable scholarly or metadata interaction |
| External citation | Strong evidence of scholarly reference |
| External discussion | Evidence of attention, not adoption |
| Incident-review usage | Strongest evidence of practical uptake |

---

## 9. Status Labels

Use these labels:

| Label | Meaning |
|---|---|
| Not observed | No evidence checked or no result found |
| Observable | Metrics or search evidence exists |
| Visited | Views or traffic observed |
| Downloaded | Zenodo or file download observed |
| Referenced | External page, paper, or record links to it |
| Cited | Scholarly citation or DOI citation event observed |
| Used | Evidence of practical use in review, audit, governance, or incident analysis |

---

## 10. Non-Overclaim Rule

Visibility is not adoption.

Do not describe LUMINA-30, PCR-C, or related documents as adopted, recognized, cited, or used unless the corresponding evidence is recorded.

If evidence is limited to views, downloads, or traffic, describe it only as visibility or access.
