From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH] ARM: OMAP: make iommu subsys_initcall to fix builtin omap3isp
Date: Sun, 26 Feb 2012 12:14:14 +0200
Message-ID: <1330251254-14693-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42433 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111Ab2BZKO3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Feb 2012 05:14:29 -0500
Received: by eaah12 with SMTP id h12so1764574eaa.19
        for <linux-omap@vger.kernel.org>; Sun, 26 Feb 2012 02:14:27 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <Joerg.Roedel@amd.com>
Cc: linux-omap@vger.kernel.org, Hiroshi Doyu <hdoyu@nvidia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

omap3isp depends on omap's iommu and will fail to probe if
initialized before it (which always happen if they are builtin).

Make omap's iommu subsys_initcall as an interim solution until
the probe deferral mechanism is merged.

Reported-by: James <angweiyang@gmail.com>
Debugged-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Cc: stable <stable@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Hiroshi Doyu <hdoyu@nvidia.com>
Cc: Joerg Roedel <Joerg.Roedel@amd.com>
---
 arch/arm/mach-omap2/mailbox.c |    3 ++-
 drivers/iommu/omap-iommu.c    |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 609ea2d..a6db1e4 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -412,7 +412,8 @@ static void __exit omap2_mbox_exit(void)
 	platform_driver_unregister(&omap2_mbox_driver);
 }
 
-module_init(omap2_mbox_init);
+/* must be ready before omap3isp is probed */
+subsys_initcall(omap2_mbox_init);
 module_exit(omap2_mbox_exit);
 
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 4e661f0..821062a 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1222,7 +1222,8 @@ static int __init omap_iommu_init(void)
 
 	return platform_driver_register(&omap_iommu_driver);
 }
-module_init(omap_iommu_init);
+/* must be ready before omap3isp is probed */
+subsys_initcall(omap_iommu_init);
 
 static void __exit omap_iommu_exit(void)
 {
-- 
1.7.5.4

