From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [OMAPZOOM][PATCH] DSPBRIDGE Memory flush function fix
Date: Fri, 19 Dec 2008 16:54:05 -0600
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E1A1B206A@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_8F7AF80515AF0D4D93307E594F3CB40E1A1B206Adlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43584 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359AbYLSWyM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Dec 2008 17:54:12 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id mBJMs6L7013865
	for <linux-omap@vger.kernel.org>; Fri, 19 Dec 2008 16:54:11 -0600
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id mBJMs6lf019873
	for <linux-omap@vger.kernel.org>; Fri, 19 Dec 2008 16:54:06 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>

--_002_8F7AF80515AF0D4D93307E594F3CB40E1A1B206Adlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

DSPBridge memory flush function flushing/invalidating
one less byte than specified

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 drivers/dsp/bridge/services/mem.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/service=
s/mem.c
index 565b0b8..9256744 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -481,21 +481,21 @@ void MEM_FlushCache(void *pMemBuf, u32 cBytes, s32 Fl=
ushType)
 	switch (FlushType) {
 	/* invalidate only */
 	case PROC_INVALIDATE_MEM:
-		dmac_inv_range(pMemBuf, pMemBuf + cBytes - 1);
+		dmac_inv_range(pMemBuf, pMemBuf + cBytes);
 		outer_inv_range(__pa((u32)pMemBuf), __pa((u32)pMemBuf +
-				cBytes - 1));
+				cBytes));
 	break;
 	/* writeback only */
 	case PROC_WRITEBACK_MEM:
-		dmac_clean_range(pMemBuf, pMemBuf + cBytes - 1);
+		dmac_clean_range(pMemBuf, pMemBuf + cBytes);
 		outer_clean_range(__pa((u32)pMemBuf), __pa((u32)pMemBuf +
-				  cBytes - 1));
+				  cBytes));
 	break;
 	/* writeback and invalidate */
 	case PROC_WRITEBACK_INVALIDATE_MEM:
-		dmac_flush_range(pMemBuf, pMemBuf + cBytes - 1);
+		dmac_flush_range(pMemBuf, pMemBuf + cBytes);
 		outer_flush_range(__pa((u32)pMemBuf), __pa((u32)pMemBuf +
-				  cBytes - 1));
+				  cBytes));
 	break;
 	default:
 		GT_1trace(MEM_debugMask, GT_6CLASS, "MEM_FlushCache: invalid "
--=20
1.5.6.rc2

Thank you,
Best regards,
Hari


--_002_8F7AF80515AF0D4D93307E594F3CB40E1A1B206Adlee03entticom_
Content-Type: application/octet-stream;
	name="0001-DSPBRIDGE-Memory-flush-function-fix.patch"
Content-Description: 0001-DSPBRIDGE-Memory-flush-function-fix.patch
Content-Disposition: attachment;
	filename="0001-DSPBRIDGE-Memory-flush-function-fix.patch"; size=1627;
	creation-date="Fri, 19 Dec 2008 16:30:34 GMT";
	modification-date="Fri, 19 Dec 2008 16:30:34 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiZjcxZDkzM2ZhYTFlNmRkMWIwZTY2MWNmZjE4Y2QzNGMxNGU1YjRmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJpIEthbmlnZXJpIDxoLWthbmlnZXJpMkB0aS5jb20+CkRh
dGU6IEZyaSwgMTkgRGVjIDIwMDggMTY6MjM6MDQgLTA2MDAKU3ViamVjdDogW1BBVENIXSBEU1BC
UklER0UgTWVtb3J5IGZsdXNoIGZ1bmN0aW9uIGZpeAoKRFNQQnJpZGdlIG1lbW9yeSBmbHVzaCBm
dW5jdGlvbiBmbHVzaGluZy9pbnZhbGlkYXRpbmcKb25lIGxlc3MgYnl0ZSB0aGFuIHNwZWNpZmll
ZAoKU2lnbmVkLW9mZi1ieTogSGFyaSBLYW5pZ2VyaSA8aC1rYW5pZ2VyaTJAdGkuY29tPgotLS0K
IGRyaXZlcnMvZHNwL2JyaWRnZS9zZXJ2aWNlcy9tZW0uYyB8ICAgMTIgKysrKysrLS0tLS0tCiAx
IGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2RzcC9icmlkZ2Uvc2VydmljZXMvbWVtLmMgYi9kcml2ZXJzL2RzcC9icmlk
Z2Uvc2VydmljZXMvbWVtLmMKaW5kZXggNTY1YjBiOC4uOTI1Njc0NCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9kc3AvYnJpZGdlL3NlcnZpY2VzL21lbS5jCisrKyBiL2RyaXZlcnMvZHNwL2JyaWRnZS9z
ZXJ2aWNlcy9tZW0uYwpAQCAtNDgxLDIxICs0ODEsMjEgQEAgdm9pZCBNRU1fRmx1c2hDYWNoZSh2
b2lkICpwTWVtQnVmLCB1MzIgY0J5dGVzLCBzMzIgRmx1c2hUeXBlKQogCXN3aXRjaCAoRmx1c2hU
eXBlKSB7CiAJLyogaW52YWxpZGF0ZSBvbmx5ICovCiAJY2FzZSBQUk9DX0lOVkFMSURBVEVfTUVN
OgotCQlkbWFjX2ludl9yYW5nZShwTWVtQnVmLCBwTWVtQnVmICsgY0J5dGVzIC0gMSk7CisJCWRt
YWNfaW52X3JhbmdlKHBNZW1CdWYsIHBNZW1CdWYgKyBjQnl0ZXMpOwogCQlvdXRlcl9pbnZfcmFu
Z2UoX19wYSgodTMyKXBNZW1CdWYpLCBfX3BhKCh1MzIpcE1lbUJ1ZiArCi0JCQkJY0J5dGVzIC0g
MSkpOworCQkJCWNCeXRlcykpOwogCWJyZWFrOwogCS8qIHdyaXRlYmFjayBvbmx5ICovCiAJY2Fz
ZSBQUk9DX1dSSVRFQkFDS19NRU06Ci0JCWRtYWNfY2xlYW5fcmFuZ2UocE1lbUJ1ZiwgcE1lbUJ1
ZiArIGNCeXRlcyAtIDEpOworCQlkbWFjX2NsZWFuX3JhbmdlKHBNZW1CdWYsIHBNZW1CdWYgKyBj
Qnl0ZXMpOwogCQlvdXRlcl9jbGVhbl9yYW5nZShfX3BhKCh1MzIpcE1lbUJ1ZiksIF9fcGEoKHUz
MilwTWVtQnVmICsKLQkJCQkgIGNCeXRlcyAtIDEpKTsKKwkJCQkgIGNCeXRlcykpOwogCWJyZWFr
OwogCS8qIHdyaXRlYmFjayBhbmQgaW52YWxpZGF0ZSAqLwogCWNhc2UgUFJPQ19XUklURUJBQ0tf
SU5WQUxJREFURV9NRU06Ci0JCWRtYWNfZmx1c2hfcmFuZ2UocE1lbUJ1ZiwgcE1lbUJ1ZiArIGNC
eXRlcyAtIDEpOworCQlkbWFjX2ZsdXNoX3JhbmdlKHBNZW1CdWYsIHBNZW1CdWYgKyBjQnl0ZXMp
OwogCQlvdXRlcl9mbHVzaF9yYW5nZShfX3BhKCh1MzIpcE1lbUJ1ZiksIF9fcGEoKHUzMilwTWVt
QnVmICsKLQkJCQkgIGNCeXRlcyAtIDEpKTsKKwkJCQkgIGNCeXRlcykpOwogCWJyZWFrOwogCWRl
ZmF1bHQ6CiAJCUdUXzF0cmFjZShNRU1fZGVidWdNYXNrLCBHVF82Q0xBU1MsICJNRU1fRmx1c2hD
YWNoZTogaW52YWxpZCAiCi0tIAoxLjUuNi5yYzIKCg==

--_002_8F7AF80515AF0D4D93307E594F3CB40E1A1B206Adlee03entticom_--
