From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP3 clock: camera module has no target IDLEST bit
Date: Fri, 5 Sep 2008 13:34:03 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809051332380.32223@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51473 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbYIETeE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 15:34:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: saaguirre@ti.com


We must not attempt to wait for the CAM module to become ready after
clock enable, since it has no target IDLEST bit.

Thanks to Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com> for
reporting this and testing the patch.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Tested-by: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>

---
 arch/arm/mach-omap2/clock.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index be5c616..189b8a6 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -256,6 +256,10 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	/* REVISIT: What are the appropriate exclusions for 34XX? */
 	if (cpu_is_omap34xx()) {
 
+		/* CAM */
+		if (prcm_mod == OMAP34XX_CM_REGADDR(OMAP3430_CAM_MOD, 0))
+			return;
+
 		/* SSI */
 		if (prcm_mod == OMAP34XX_CM_REGADDR(CORE_MOD, 0) &&
 		    (reg & 0x0f) == 0 &&
