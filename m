From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/8] ARM: OMAP5: Reuse prm read_inst/write_inst
Date: Wed, 20 Feb 2013 20:57:10 +0530
Message-ID: <1361374034-21831-5-git-send-email-santosh.shilimkar@ti.com>
References: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53695 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933698Ab3BTPZ7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 10:25:59 -0500
In-Reply-To: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Tero Kristo <t-kristo@ti.com>

Make use of 'prm_base' so that  prm read_inst/write_inst can work on
OMAP5 devices.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 1aae198..cb24b26 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -81,13 +81,13 @@ static struct prm_reset_src_map omap44xx_prm_reset_src_map[] = {
 /* Read a register in a CM/PRM instance in the PRM module */
 u32 omap4_prm_read_inst_reg(s16 inst, u16 reg)
 {
-	return __raw_readl(OMAP44XX_PRM_REGADDR(inst, reg));
+	return __raw_readl(prm_base + inst + reg);
 }
 
 /* Write into a register in a CM/PRM instance in the PRM module */
 void omap4_prm_write_inst_reg(u32 val, s16 inst, u16 reg)
 {
-	__raw_writel(val, OMAP44XX_PRM_REGADDR(inst, reg));
+	__raw_writel(val, prm_base + inst + reg);
 }
 
 /* Read-modify-write a register in a PRM module. Caller must lock */
-- 
1.7.9.5

