From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: [PATCH] iommu: fix end address of vm area comparation in
 alloc_iovm_area
Date: Mon, 16 Aug 2010 22:51:53 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CA4D8949@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Hiroshi.DOYO@nokia.com" <Hiroshi.DOYO@nokia.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>
List-Id: linux-omap@vger.kernel.org

=46rom cc48c0adaee97c8385a356aefa5b64a51818b4fd Mon Sep 17 00:00:00 200=
1
=46rom: Fernando Guzman Lugo <x0095840@ti.com>
Date: Mon, 16 Aug 2010 22:28:24 -0500
Subject: [PATCH] iommu: fix end address of vm area comparation in alloc=
_iovm_area

End address of the vm area is =93start + bytes -1=94,
not =93start + byte=94. This patch fixes that issue by doing
an inclusive comparison with tmp->da_start. This issue
was preventing allocate an area of size exactly the same
than the free area. I did no change the value of da_end
of each vm area because it is used to get area size in
several places.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/iovmm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index b8bcad5..8745d4e 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -295,7 +295,7 @@ static struct iovm_struct *alloc_iovm_area(struct i=
ommu *obj, u32 da,
 	prev_end =3D 0;
 	list_for_each_entry(tmp, &obj->mmap, list) {
=20
-		if ((prev_end <=3D start) && (start + bytes < tmp->da_start))
+		if ((prev_end <=3D start) && (start + bytes <=3D tmp->da_start))
 			goto found;
=20
 		if (flags & IOVMF_DA_ANON)
--=20
1.7.0.4
