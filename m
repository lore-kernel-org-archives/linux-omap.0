From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] PM: Changed secure RAM storage size from 0x8000 to 0x803F
Date: Thu, 13 Nov 2008 13:41:05 +0200
Message-ID: <1226576465-14387-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49221 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbYKMLnx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 06:43:53 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mADBheRx019502
	for <linux-omap@vger.kernel.org>; Thu, 13 Nov 2008 13:43:50 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mADBhFqF027644
	for <linux-omap@vger.kernel.org>; Thu, 13 Nov 2008 13:43:15 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Without this, causes some random crashes related to memory management.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 0df3245..58d0479 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -883,7 +883,7 @@ int __init omap3_pm_init(void)
 
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
 		omap3_secure_ram_storage =
-			kmalloc(0x8000, GFP_KERNEL);
+			kmalloc(0x803F, GFP_KERNEL);
 		if (!omap3_secure_ram_storage)
 			printk(KERN_ERR "Memory allocation failed when"
 					"allocating for secure sram context\n");
-- 
1.5.4.3

