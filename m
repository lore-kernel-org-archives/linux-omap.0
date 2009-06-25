From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP2/3 SDRC: don't set SDRC_POWER.PWDENA on boot
Date: Thu, 25 Jun 2009 01:11:43 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906250110450.2676@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57527 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbZFYHLk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 03:11:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Stop setting SDRC_POWER.PWDENA on boot.  Turns out there is a nasty
erratum (34xx erratum 1.150) that can cause memory corruption if
PWDENA is enabled.

Based originally on a patch from Samu P. Onkalo <samu.p.onkalo@nokia.com>.

Tested on BeagleBoard rev C2.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Samu P. Onkalo <samu.p.onkalo@nokia.com>.
---
 arch/arm/mach-omap2/sdrc.c     |    5 ++++-
 arch/arm/mach-omap2/sram34xx.S |    2 --
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index 2e9e38d..9e3bd4f 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -125,8 +125,11 @@ void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 	sdrc_init_params_cs1 = sdrc_cs1;
 
 	/* XXX Enable SRFRONIDLEREQ here also? */
+	/*
+	 * PWDENA should not be set due to 34xx erratum 1.150 - PWDENA
+	 * can cause random memory corruption
+	 */
 	l = (1 << SDRC_POWER_EXTCLKDIS_SHIFT) |
-		(1 << SDRC_POWER_PWDENA_SHIFT) |
 		(1 << SDRC_POWER_PAGEPOLICY_SHIFT);
 	sdrc_write_reg(l, SDRC_POWER);
 }
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index 3aef744..9c2d046 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -58,7 +58,6 @@
 
 /* SDRC_POWER bit settings */
 #define SRFRONIDLEREQ_MASK		0x40
-#define PWDENA_MASK			0x4
 
 /* CM_IDLEST1_CORE bit settings */
 #define ST_SDRC_MASK			0x2
@@ -160,7 +159,6 @@ sdram_in_selfrefresh:
 	ldr	r12, [r11]		@ read the contents of SDRC_POWER
 	mov	r9, r12			@ keep a copy of SDRC_POWER bits
 	orr 	r12, r12, #SRFRONIDLEREQ_MASK	@ enable self refresh on idle
-	bic 	r12, r12, #PWDENA_MASK	@ clear PWDENA
 	str 	r12, [r11]		@ write back to SDRC_POWER register
 	ldr	r12, [r11]		@ posted-write barrier for SDRC
 idle_sdrc:
-- 
1.6.3.3.334.g916e1

