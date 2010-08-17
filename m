From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH] iommu: fix end address of vm area comparation in
 alloc_iovm_area
Date: Mon, 16 Aug 2010 23:48:14 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CA4D894C@dlee06.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602CA4D8949@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44688 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799Ab0HQEwC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 00:52:02 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602CA4D8949@dlee06.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>


There was a mistake with Hiroshi email. Looping in Hiroshi

Sorry for the noise.

Regards,
=46ernando.
________________________________________
=46rom: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.=
org] On Behalf Of Guzman Lugo, Fernando [fernando.lugo@ti.com]
Sent: Monday, August 16, 2010 10:51 PM
To: linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org
Cc: Hiroshi.DOYO@nokia.com; Kanigeri, Hari
Subject: [PATCH] iommu: fix end address of vm area comparation in alloc=
_iovm_area

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

-               if ((prev_end <=3D start) && (start + bytes < tmp->da_s=
tart))
+               if ((prev_end <=3D start) && (start + bytes <=3D tmp->d=
a_start))
                        goto found;

                if (flags & IOVMF_DA_ANON)
--
1.7.0.4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
