From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH] OMAP4: iommu: fix clock name
Date: Wed, 15 Jun 2011 16:47:25 +0300
Message-ID: <1308145645-22882-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62703 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857Ab1FONse (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jun 2011 09:48:34 -0400
Received: by wya21 with SMTP id 21so314864wya.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Jun 2011 06:48:33 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>

0e43327 "OMAP4: clock: Fix clock names and align with hwmod names"
renamed ducati_ick to ipu_fck.

Update OMAP4's iommu_device accordingly, so that omap_iommu_probe
doesn't break when calling clk_get.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 arch/arm/mach-omap2/omap-iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index 3fc5dc7..e61fead 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -67,7 +67,7 @@ static struct iommu_device omap4_devices[] = {
 		.pdata = {
 			.name = "ducati",
 			.nr_tlb_entries = 32,
-			.clk_name = "ducati_ick",
+			.clk_name = "ipu_fck",
 			.da_start = 0x0,
 			.da_end = 0xFFFFF000,
 		},
-- 
1.7.1

