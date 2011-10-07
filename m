From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHv2 7/7] ARM: OMAP3 PM: Enable IO Daisychain for supported chips
Date: Fri, 7 Oct 2011 23:17:51 +0530
Message-ID: <1318009671-12813-8-git-send-email-vishwanath.bs@ti.com>
References: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45715 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753700Ab1JGRzM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Oct 2011 13:55:12 -0400
In-Reply-To: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

IO Daisychain has to be enabled only if the corresponding omap has
io wake up capability.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/prm2xxx_3xxx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 0c70bc4..9a92fef 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -168,7 +168,7 @@ void omap3_trigger_wuclk_ctrl(void)
 {
 	int i = 0;
 
-	if (omap_rev() >= OMAP3430_REV_ES3_1) {
+	if ((omap_rev() >= OMAP3430_REV_ES3_1) && omap3_has_io_wakeup()) {
 		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
 				     PM_WKEN);
 		/* Do a readback to assure write has been done */
-- 
1.7.0.4

