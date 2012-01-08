From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2 2/3] arm:omap:omap4: Maintain virtual addr in in _prm_bases table
Date: Sun, 8 Jan 2012 15:48:13 +0530
Message-ID: <1326017894-7632-3-git-send-email-hvaibhav@ti.com>
References: <1326017894-7632-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59039 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751955Ab2AHKSY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 8 Jan 2012 05:18:24 -0500
In-Reply-To: <1326017894-7632-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>

Since, now omap4 prm code is reused for AM33XX device where,
PRM module fall under different domain than omap4.
So instead of maintaining phy addr for PRM partition
in _prm_bases[] table and then changing it to virt addr for r/w,
just directly maintain respective virt addr.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/prminst44xx.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index f6de5bc..3d9894f 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -26,11 +26,11 @@

 static u32 _prm_bases[OMAP4_MAX_PRCM_PARTITIONS] = {
 	[OMAP4430_INVALID_PRCM_PARTITION]	= 0,
-	[OMAP4430_PRM_PARTITION]		= OMAP4430_PRM_BASE,
+	[OMAP4430_PRM_PARTITION]		= OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE),
 	[OMAP4430_CM1_PARTITION]		= 0,
 	[OMAP4430_CM2_PARTITION]		= 0,
 	[OMAP4430_SCRM_PARTITION]		= 0,
-	[OMAP4430_PRCM_MPU_PARTITION]		= OMAP4430_PRCM_MPU_BASE,
+	[OMAP4430_PRCM_MPU_PARTITION]		= OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE),
 };

 /* Read a register in a PRM instance */
@@ -39,8 +39,7 @@ u32 omap4_prminst_read_inst_reg(u8 part, s16 inst, u16 idx)
 	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
 	       part == OMAP4430_INVALID_PRCM_PARTITION ||
 	       !_prm_bases[part]);
-	return __raw_readl(OMAP2_L4_IO_ADDRESS(_prm_bases[part] + inst +
-					       idx));
+	return __raw_readl(_prm_bases[part] + inst + idx);
 }

 /* Write into a register in a PRM instance */
@@ -49,7 +48,7 @@ void omap4_prminst_write_inst_reg(u32 val, u8 part, s16 inst, u16 idx)
 	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
 	       part == OMAP4430_INVALID_PRCM_PARTITION ||
 	       !_prm_bases[part]);
-	__raw_writel(val, OMAP2_L4_IO_ADDRESS(_prm_bases[part] + inst + idx));
+	__raw_writel(val, _prm_bases[part] + inst + idx);
 }

 /* Read-modify-write a register in PRM. Caller must lock */
--
1.7.0.4

