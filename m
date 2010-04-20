From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [PATCH 2/3][v2] OMAP:iommu - missing check for TLB valid entry
Date: Tue, 20 Apr 2010 16:31:16 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B3445E6@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_8F7AF80515AF0D4D93307E594F3CB40E4B3445E6dlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51100 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755379Ab0DTVbU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Apr 2010 17:31:20 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "tony@atomide.com" <tony@atomide.com>

--_002_8F7AF80515AF0D4D93307E594F3CB40E4B3445E6dlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From a93efa72db7e5bcf601c7c14866f081df176289b Mon Sep 17 00:00:00 2001
From: Hari Kanigeri <h-kanigeri2@ti.com>
Date: Tue, 20 Apr 2010 12:08:26 -0500
Subject: [PATCH 2/3] OMAP:iommu - missing check for TLB valid entry

Added the missing TLB valid entry setting for cam register

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/iommu2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index 6f4b7cc..f01f985 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -183,7 +183,7 @@ static struct cr_regs *omap2_alloc_cr(struct iommu *obj=
, struct iotlb_entry *e)
 	if (!cr)
 		return ERR_PTR(-ENOMEM);
=20
-	cr->cam =3D (e->da & MMU_CAM_VATAG_MASK) | e->prsvd | e->pgsz;
+	cr->cam =3D (e->da & MMU_CAM_VATAG_MASK) | e->prsvd | e->pgsz | e->valid;
 	cr->ram =3D e->pa | e->endian | e->elsz | e->mixed;
=20
 	return cr;
--=20
1.7.0

Thank you,
Best regards,
Hari


--_002_8F7AF80515AF0D4D93307E594F3CB40E4B3445E6dlee03entticom_
Content-Type: application/octet-stream;
	name="0002-OMAP-iommu-missing-check-for-TLB-valid-entry.patch"
Content-Description: 0002-OMAP-iommu-missing-check-for-TLB-valid-entry.patch
Content-Disposition: attachment;
	filename="0002-OMAP-iommu-missing-check-for-TLB-valid-entry.patch"; size=953;
	creation-date="Tue, 20 Apr 2010 16:19:05 GMT";
	modification-date="Tue, 20 Apr 2010 16:19:05 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhOTNlZmE3MmRiN2U1YmNmNjAxYzdjMTQ4NjZmMDgxZGYxNzYyODliIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJpIEthbmlnZXJpIDxoLWthbmlnZXJpMkB0aS5jb20+CkRh
dGU6IFR1ZSwgMjAgQXByIDIwMTAgMTI6MDg6MjYgLTA1MDAKU3ViamVjdDogW1BBVENIIDIvM10g
T01BUDppb21tdSAtIG1pc3NpbmcgY2hlY2sgZm9yIFRMQiB2YWxpZCBlbnRyeQoKQWRkZWQgdGhl
IG1pc3NpbmcgVExCIHZhbGlkIGVudHJ5IHNldHRpbmcgZm9yIGNhbSByZWdpc3RlcgoKU2lnbmVk
LW9mZi1ieTogSGFyaSBLYW5pZ2VyaSA8aC1rYW5pZ2VyaTJAdGkuY29tPgotLS0KIGFyY2gvYXJt
L21hY2gtb21hcDIvaW9tbXUyLmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAy
L2lvbW11Mi5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9pb21tdTIuYwppbmRleCA2ZjRiN2NjLi5m
MDFmOTg1IDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL2lvbW11Mi5jCisrKyBiL2Fy
Y2gvYXJtL21hY2gtb21hcDIvaW9tbXUyLmMKQEAgLTE4Myw3ICsxODMsNyBAQCBzdGF0aWMgc3Ry
dWN0IGNyX3JlZ3MgKm9tYXAyX2FsbG9jX2NyKHN0cnVjdCBpb21tdSAqb2JqLCBzdHJ1Y3QgaW90
bGJfZW50cnkgKmUpCiAJaWYgKCFjcikKIAkJcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7CiAKLQlj
ci0+Y2FtID0gKGUtPmRhICYgTU1VX0NBTV9WQVRBR19NQVNLKSB8IGUtPnByc3ZkIHwgZS0+cGdz
ejsKKwljci0+Y2FtID0gKGUtPmRhICYgTU1VX0NBTV9WQVRBR19NQVNLKSB8IGUtPnByc3ZkIHwg
ZS0+cGdzeiB8IGUtPnZhbGlkOwogCWNyLT5yYW0gPSBlLT5wYSB8IGUtPmVuZGlhbiB8IGUtPmVs
c3ogfCBlLT5taXhlZDsKIAogCXJldHVybiBjcjsKLS0gCjEuNy4wCgo=

--_002_8F7AF80515AF0D4D93307E594F3CB40E4B3445E6dlee03entticom_--
