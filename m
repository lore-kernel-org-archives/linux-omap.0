From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [OMAPZOOM][PATCH]DSPBRIDGE: Change GFP_ATOMIC to GFP_KERNEL
Date: Wed, 21 Jan 2009 18:46:01 -0600
Message-ID: <496565EC904933469F292DDA3F1663E60284C6C596@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_496565EC904933469F292DDA3F1663E60284C6C596dlee06enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33967 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754485AbZAVAqK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Jan 2009 19:46:10 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0M0k3Ff023507
	for <linux-omap@vger.kernel.org>; Wed, 21 Jan 2009 18:46:08 -0600
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n0M0k35j028097
	for <linux-omap@vger.kernel.org>; Wed, 21 Jan 2009 18:46:03 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

--_002_496565EC904933469F292DDA3F1663E60284C6C596dlee06enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Wed, 21 Jan 2009 17:39:38 -0600
Subject: [PATCH] BRIDGE: Change GFP_ATOMIC to GFP_KERNEL

This patch replace the memory allocations which use
GFP_ATOMIC with GFP_KERNEL since the calls for memory
allocation in dspbridge are not in interrupt context.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

---
 drivers/dsp/bridge/services/mem.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/service=
s/mem.c
index 9256744..95efe92
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -281,10 +281,10 @@ void *MEM_Alloc(u32 cBytes, enum MEM_POOLATTRS type)
 		/* If non-paged memory required, see note at top of file. */
 		case MEM_PAGED:
 #ifndef MEM_CHECK
-			pMem =3D kmalloc(cBytes, GFP_ATOMIC);
+			pMem =3D kmalloc(cBytes, GFP_KERNEL);
 #else
 			pMem =3D kmalloc(cBytes + sizeof(struct memInfo),
-			       GFP_ATOMIC);
+			       GFP_KERNEL);
 			if (pMem) {
 				pMem->size =3D cBytes;
 				pMem->caller =3D __builtin_return_address(0);
@@ -303,11 +303,11 @@ void *MEM_Alloc(u32 cBytes, enum MEM_POOLATTRS type)
 		case MEM_LARGEVIRTMEM:
 #ifndef MEM_CHECK
 			/* FIXME - Replace with 'vmalloc' after BP fix */
-			pMem =3D __vmalloc(cBytes, GFP_ATOMIC, PAGE_KERNEL);
+			pMem =3D __vmalloc(cBytes, GFP_KERNEL, PAGE_KERNEL);
 #else
 			/* FIXME - Replace with 'vmalloc' after BP fix */
 			pMem =3D __vmalloc((cBytes + sizeof(struct memInfo)),
-				GFP_ATOMIC, PAGE_KERNEL);
+				GFP_KERNEL, PAGE_KERNEL);
 			if (pMem) {
 				pMem->size =3D cBytes;
 				pMem->caller =3D __builtin_return_address(0);
@@ -357,7 +357,7 @@ void *MEM_AllocPhysMem(u32 cBytes, u32 ulAlign, OUT u32=
 *pPhysicalAddress)
 						    (u32 *)&paMem);
 		} else
 			pVaMem =3D dma_alloc_coherent(NULL, cBytes, &paMem,
-						   GFP_ATOMIC);
+						   GFP_KERNEL);
 		if (pVaMem =3D=3D NULL) {
 			*pPhysicalAddress =3D 0;
 			GT_1trace(MEM_debugMask, GT_6CLASS,
@@ -389,13 +389,13 @@ void *MEM_Calloc(u32 cBytes, enum MEM_POOLATTRS type)
 		/* If non-paged memory required, see note at top of file. */
 		case MEM_PAGED:
 #ifndef MEM_CHECK
-			pMem =3D kmalloc(cBytes, GFP_ATOMIC);
+			pMem =3D kmalloc(cBytes, GFP_KERNEL);
 			if (pMem)
 				memset(pMem, 0, cBytes);
=20
 #else
 			pMem =3D kmalloc(cBytes + sizeof(struct memInfo),
-				      GFP_ATOMIC);
+				      GFP_KERNEL);
 			if (pMem) {
 				memset((void *)((u32)pMem +
 					sizeof(struct memInfo)), 0, cBytes);
@@ -414,14 +414,14 @@ void *MEM_Calloc(u32 cBytes, enum MEM_POOLATTRS type)
 		case MEM_LARGEVIRTMEM:
 #ifndef MEM_CHECK
 			/* FIXME - Replace with 'vmalloc' after BP fix */
-			pMem =3D __vmalloc(cBytes, GFP_ATOMIC, PAGE_KERNEL);
+			pMem =3D __vmalloc(cBytes, GFP_KERNEL, PAGE_KERNEL);
 			if (pMem)
 				memset(pMem, 0, cBytes);
=20
 #else
 			/* FIXME - Replace with 'vmalloc' after BP fix */
 			pMem =3D __vmalloc(cBytes + sizeof(struct memInfo),
-				GFP_ATOMIC, PAGE_KERNEL);
+				GFP_KERNEL, PAGE_KERNEL);
 			if (pMem) {
 				memset((void *)((u32)pMem +
 					sizeof(struct memInfo)), 0, cBytes);
--=20
1.5.6.4

--_002_496565EC904933469F292DDA3F1663E60284C6C596dlee06enttico_
Content-Type: application/octet-stream;
	name="0001-BRIDGE-Change-GFP_ATOMIC-to-GFP_KERNEL.patch"
Content-Description: 0001-BRIDGE-Change-GFP_ATOMIC-to-GFP_KERNEL.patch
Content-Disposition: attachment;
	filename="0001-BRIDGE-Change-GFP_ATOMIC-to-GFP_KERNEL.patch"; size=3227;
	creation-date="Wed, 21 Jan 2009 17:53:15 GMT";
	modification-date="Wed, 21 Jan 2009 17:53:15 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjOWU2ZWVmZjIxMWE4ZGQxN2MxNzcyOWFjYTg2ZWYzMDYyNDVlMjk4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGZXJuYW5kbyBHdXptYW4gTHVnbyA8eDAwOTU4NDBAdGkuY29t
PgpEYXRlOiBXZWQsIDIxIEphbiAyMDA5IDE3OjM5OjM4IC0wNjAwClN1YmplY3Q6IFtQQVRDSF0g
QlJJREdFOiBDaGFuZ2UgR0ZQX0FUT01JQyB0byBHRlBfS0VSTkVMCgpUaGlzIHBhdGNoIHJlcGxh
Y2UgdGhlIG1lbW9yeSBhbGxvY2F0aW9ucyB3aGljaCB1c2UKR0ZQX0FUT01JQyB3aXRoIEdGUF9L
RVJORUwgc2luY2UgdGhlIGNhbGxzIGZvciBtZW1vcnkKYWxsb2NhdGlvbiBpbiBkc3BicmlkZ2Ug
YXJlIG5vdCBpbiBpbnRlcnJ1cHQgY29udGV4dC4KClNpZ25lZC1vZmYtYnk6IEZlcm5hbmRvIEd1
em1hbiBMdWdvIDx4MDA5NTg0MEB0aS5jb20+CkFja2VkLWJ5OiBIaXJvc2hpIERPWVUgPEhpcm9z
aGkuRE9ZVUBub2tpYS5jb20+CgotLS0KIGRyaXZlcnMvZHNwL2JyaWRnZS9zZXJ2aWNlcy9tZW0u
YyB8ICAgMTggKysrKysrKysrLS0tLS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RzcC9icmlkZ2Uvc2Vy
dmljZXMvbWVtLmMgYi9kcml2ZXJzL2RzcC9icmlkZ2Uvc2VydmljZXMvbWVtLmMKaW5kZXggOTI1
Njc0NC4uOTVlZmU5MgotLS0gYS9kcml2ZXJzL2RzcC9icmlkZ2Uvc2VydmljZXMvbWVtLmMKKysr
IGIvZHJpdmVycy9kc3AvYnJpZGdlL3NlcnZpY2VzL21lbS5jCkBAIC0yODEsMTAgKzI4MSwxMCBA
QCB2b2lkICpNRU1fQWxsb2ModTMyIGNCeXRlcywgZW51bSBNRU1fUE9PTEFUVFJTIHR5cGUpCiAJ
CS8qIElmIG5vbi1wYWdlZCBtZW1vcnkgcmVxdWlyZWQsIHNlZSBub3RlIGF0IHRvcCBvZiBmaWxl
LiAqLwogCQljYXNlIE1FTV9QQUdFRDoKICNpZm5kZWYgTUVNX0NIRUNLCi0JCQlwTWVtID0ga21h
bGxvYyhjQnl0ZXMsIEdGUF9BVE9NSUMpOworCQkJcE1lbSA9IGttYWxsb2MoY0J5dGVzLCBHRlBf
S0VSTkVMKTsKICNlbHNlCiAJCQlwTWVtID0ga21hbGxvYyhjQnl0ZXMgKyBzaXplb2Yoc3RydWN0
IG1lbUluZm8pLAotCQkJICAgICAgIEdGUF9BVE9NSUMpOworCQkJICAgICAgIEdGUF9LRVJORUwp
OwogCQkJaWYgKHBNZW0pIHsKIAkJCQlwTWVtLT5zaXplID0gY0J5dGVzOwogCQkJCXBNZW0tPmNh
bGxlciA9IF9fYnVpbHRpbl9yZXR1cm5fYWRkcmVzcygwKTsKQEAgLTMwMywxMSArMzAzLDExIEBA
IHZvaWQgKk1FTV9BbGxvYyh1MzIgY0J5dGVzLCBlbnVtIE1FTV9QT09MQVRUUlMgdHlwZSkKIAkJ
Y2FzZSBNRU1fTEFSR0VWSVJUTUVNOgogI2lmbmRlZiBNRU1fQ0hFQ0sKIAkJCS8qIEZJWE1FIC0g
UmVwbGFjZSB3aXRoICd2bWFsbG9jJyBhZnRlciBCUCBmaXggKi8KLQkJCXBNZW0gPSBfX3ZtYWxs
b2MoY0J5dGVzLCBHRlBfQVRPTUlDLCBQQUdFX0tFUk5FTCk7CisJCQlwTWVtID0gX192bWFsbG9j
KGNCeXRlcywgR0ZQX0tFUk5FTCwgUEFHRV9LRVJORUwpOwogI2Vsc2UKIAkJCS8qIEZJWE1FIC0g
UmVwbGFjZSB3aXRoICd2bWFsbG9jJyBhZnRlciBCUCBmaXggKi8KIAkJCXBNZW0gPSBfX3ZtYWxs
b2MoKGNCeXRlcyArIHNpemVvZihzdHJ1Y3QgbWVtSW5mbykpLAotCQkJCUdGUF9BVE9NSUMsIFBB
R0VfS0VSTkVMKTsKKwkJCQlHRlBfS0VSTkVMLCBQQUdFX0tFUk5FTCk7CiAJCQlpZiAocE1lbSkg
ewogCQkJCXBNZW0tPnNpemUgPSBjQnl0ZXM7CiAJCQkJcE1lbS0+Y2FsbGVyID0gX19idWlsdGlu
X3JldHVybl9hZGRyZXNzKDApOwpAQCAtMzU3LDcgKzM1Nyw3IEBAIHZvaWQgKk1FTV9BbGxvY1Bo
eXNNZW0odTMyIGNCeXRlcywgdTMyIHVsQWxpZ24sIE9VVCB1MzIgKnBQaHlzaWNhbEFkZHJlc3Mp
CiAJCQkJCQkgICAgKHUzMiAqKSZwYU1lbSk7CiAJCX0gZWxzZQogCQkJcFZhTWVtID0gZG1hX2Fs
bG9jX2NvaGVyZW50KE5VTEwsIGNCeXRlcywgJnBhTWVtLAotCQkJCQkJICAgR0ZQX0FUT01JQyk7
CisJCQkJCQkgICBHRlBfS0VSTkVMKTsKIAkJaWYgKHBWYU1lbSA9PSBOVUxMKSB7CiAJCQkqcFBo
eXNpY2FsQWRkcmVzcyA9IDA7CiAJCQlHVF8xdHJhY2UoTUVNX2RlYnVnTWFzaywgR1RfNkNMQVNT
LApAQCAtMzg5LDEzICszODksMTMgQEAgdm9pZCAqTUVNX0NhbGxvYyh1MzIgY0J5dGVzLCBlbnVt
IE1FTV9QT09MQVRUUlMgdHlwZSkKIAkJLyogSWYgbm9uLXBhZ2VkIG1lbW9yeSByZXF1aXJlZCwg
c2VlIG5vdGUgYXQgdG9wIG9mIGZpbGUuICovCiAJCWNhc2UgTUVNX1BBR0VEOgogI2lmbmRlZiBN
RU1fQ0hFQ0sKLQkJCXBNZW0gPSBrbWFsbG9jKGNCeXRlcywgR0ZQX0FUT01JQyk7CisJCQlwTWVt
ID0ga21hbGxvYyhjQnl0ZXMsIEdGUF9LRVJORUwpOwogCQkJaWYgKHBNZW0pCiAJCQkJbWVtc2V0
KHBNZW0sIDAsIGNCeXRlcyk7CiAKICNlbHNlCiAJCQlwTWVtID0ga21hbGxvYyhjQnl0ZXMgKyBz
aXplb2Yoc3RydWN0IG1lbUluZm8pLAotCQkJCSAgICAgIEdGUF9BVE9NSUMpOworCQkJCSAgICAg
IEdGUF9LRVJORUwpOwogCQkJaWYgKHBNZW0pIHsKIAkJCQltZW1zZXQoKHZvaWQgKikoKHUzMilw
TWVtICsKIAkJCQkJc2l6ZW9mKHN0cnVjdCBtZW1JbmZvKSksIDAsIGNCeXRlcyk7CkBAIC00MTQs
MTQgKzQxNCwxNCBAQCB2b2lkICpNRU1fQ2FsbG9jKHUzMiBjQnl0ZXMsIGVudW0gTUVNX1BPT0xB
VFRSUyB0eXBlKQogCQljYXNlIE1FTV9MQVJHRVZJUlRNRU06CiAjaWZuZGVmIE1FTV9DSEVDSwog
CQkJLyogRklYTUUgLSBSZXBsYWNlIHdpdGggJ3ZtYWxsb2MnIGFmdGVyIEJQIGZpeCAqLwotCQkJ
cE1lbSA9IF9fdm1hbGxvYyhjQnl0ZXMsIEdGUF9BVE9NSUMsIFBBR0VfS0VSTkVMKTsKKwkJCXBN
ZW0gPSBfX3ZtYWxsb2MoY0J5dGVzLCBHRlBfS0VSTkVMLCBQQUdFX0tFUk5FTCk7CiAJCQlpZiAo
cE1lbSkKIAkJCQltZW1zZXQocE1lbSwgMCwgY0J5dGVzKTsKIAogI2Vsc2UKIAkJCS8qIEZJWE1F
IC0gUmVwbGFjZSB3aXRoICd2bWFsbG9jJyBhZnRlciBCUCBmaXggKi8KIAkJCXBNZW0gPSBfX3Zt
YWxsb2MoY0J5dGVzICsgc2l6ZW9mKHN0cnVjdCBtZW1JbmZvKSwKLQkJCQlHRlBfQVRPTUlDLCBQ
QUdFX0tFUk5FTCk7CisJCQkJR0ZQX0tFUk5FTCwgUEFHRV9LRVJORUwpOwogCQkJaWYgKHBNZW0p
IHsKIAkJCQltZW1zZXQoKHZvaWQgKikoKHUzMilwTWVtICsKIAkJCQkJc2l6ZW9mKHN0cnVjdCBt
ZW1JbmZvKSksIDAsIGNCeXRlcyk7Ci0tIAoxLjUuNi40Cgo=

--_002_496565EC904933469F292DDA3F1663E60284C6C596dlee06enttico_--
