From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] Fix compile-time warning
Date: Wed, 20 Aug 2008 00:00:01 +0530
Message-ID: <1219170601-23337-1-git-send-email-premi@ti.com>
References: <premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57305 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752685AbYHSSaM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Aug 2008 14:30:12 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7JIU4Fg015133
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 19 Aug 2008 13:30:11 -0500
In-Reply-To: <premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Fixes this warning:
  CC      arch/arm/mach-omap2/board-omap3evm-flash.o
arch/arm/mach-omap2/board-omap3evm-flash.c:61: warning: initialization from incompatible pointer type

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm-flash.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm-flash.c b/arch/arm/mach-omap2/board-omap3evm-flash.c
index 0aa8ef2..5f3663d 100644
--- a/arch/arm/mach-omap2/board-omap3evm-flash.c
+++ b/arch/arm/mach-omap2/board-omap3evm-flash.c
@@ -23,7 +23,7 @@
 #include <mach/gpmc.h>
 #include <mach/nand.h>
 
-static int omap3evm_onenand_setup(void __iomem *);
+static int omap3evm_onenand_setup(void __iomem *, int freq);
 
 static struct mtd_partition omap3evm_onenand_partitions[] = {
 	{
@@ -76,8 +76,8 @@ static struct platform_device omap3evm_onenand_device = {
  *
  */
 
-static int omap3evm_onenand_setup(void __iomem *onenand_base)
-	{
+static int omap3evm_onenand_setup(void __iomem *onenand_base, int freq)
+{
 	/* nothing is required to be setup for onenand as of now */
 	return 0;
 }
-- 
1.5.6

