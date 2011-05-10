From: "Anna, Suman" <s-anna@ti.com>
Subject: [PATCH] omap: iommu: fix pte attributes for super section
Date: Tue, 10 May 2011 10:25:17 -0700
Message-ID: <BANLkTinqPkftv7KmghCCBpEdULh0cNivHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:56352 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750866Ab1EJRZS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 May 2011 13:25:18 -0400
Received: by pxi19 with SMTP id 19so5053099pxi.1
        for <linux-omap@vger.kernel.org>; Tue, 10 May 2011 10:25:17 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, Hiroshi.DOYU@nokia.com

>From 5796d8d8a0ea5aee342b78ca6ead229971cff6c5 Mon Sep 17 00:00:00 2001
From: Suman Anna <s-anna@ti.com>
Date: Wed, 4 May 2011 17:45:37 -0500
Subject: [PATCH] omap: iommu: fix pte attributes for super section

The PTE programming causes a 16MB entry to be interpreted
as a 4K entry because of the bitwise check, and therefore does
not set the attributes properly in the first-level descriptor
table. The bitwise check has been replaced appropriately.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/iommu2.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index adb083e..c21fbe6 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -225,7 +225,8 @@ static u32 omap2_get_pte_attr(struct iotlb_entry *e)
        attr = e->mixed << 5;
        attr |= e->endian;
        attr |= e->elsz >> 3;
-       attr <<= ((e->pgsz & MMU_CAM_PGSZ_4K) ? 0 : 6);
+       attr <<= (((e->pgsz == MMU_CAM_PGSZ_4K) ||
+                       (e->pgsz == MMU_CAM_PGSZ_64K)) ? 0 : 6);

        return attr;
 }
--
1.7.0.4
