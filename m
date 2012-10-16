From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv4 8/8] ARM: OMAP3: do not delete per_clkdm autodeps during
 idle
Date: Tue, 16 Oct 2012 07:29:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210160603390.9767@utopia.booyaka.com>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com> <1342189185-5306-9-git-send-email-t-kristo@ti.com> <alpine.DEB.2.00.1209182156330.4747@utopia.booyaka.com> <alpine.DEB.2.00.1209182241400.4747@utopia.booyaka.com>
 <87k3vpek28.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43338 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764Ab2JPH3W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 03:29:22 -0400
In-Reply-To: <87k3vpek28.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org


Hi Kevin,

Here's an updated version of this one, with the erratum coverage expanded 
to include OMAP34xx/35xx.

I think this one can replace Tero's "[PATCHv6 06/11] ARM: OMAP: 
clockdomain: add support for preventing autodep delete" and "[PATCHv6 
07/11] ARM: OMAP3: do not delete per_clkdm autodeps during idle".  Tero, 
please let us know if you feel otherwise.

The patch seems to pass testing on 37xx.  Was not able to really test it 
on 35xx due to PM regressions in v3.7-rc1.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Tue, 16 Oct 2012 00:08:53 -0600
Subject: [PATCH] ARM: OMAP3: PM: apply part of the erratum i582 workaround

On OMAP34xx/35xx, and OMAP36xx chips with ES < 1.2, if the PER
powerdomain goes to OSWR or OFF while CORE stays at CSWR or ON, or if,
upon chip wakeup from OSWR or OFF, the CORE powerdomain goes ON before
PER, the UART3/4 FIFOs and McBSP2/3 SIDETONE memories will be
unusable.  This is erratum i582 in the OMAP36xx Silicon Errata
document.

This patch implements one of several parts of the workaround: the
addition of the wakeup dependency between the PER and WKUP
clockdomains, such that PER will wake up at the same time CORE_L3
does.

This is not a complete workaround.  For it to be complete:

1. the PER powerdomain's next power state must not be set to OSWR or
   OFF if the CORE powerdomain's next power state is set to CSWR or
   ON;

2. the UART3/4 FIFO and McBSP2/3 SIDETONE loopback tests should be run
   if the LASTPOWERSTATEENTERED bits for PER and CORE indicate that
   PER went OFF while CORE stayed on.  If loopback tests fail, then
   those devices will be unusable until PER and CORE can undergo a
   transition from ON to OSWR/OFF and back ON.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm.h     |    1 +
 arch/arm/mach-omap2/pm34xx.c |   30 ++++++++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 686137d..67d6613 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -91,6 +91,7 @@ extern void omap3_save_scratchpad_contents(void);
 
 #define PM_RTA_ERRATUM_i608		(1 << 0)
 #define PM_SDRC_WAKEUP_ERRATUM_i583	(1 << 1)
+#define PM_PER_MEMORIES_ERRATUM_i582	(1 << 2)
 
 #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
 extern u16 pm34xx_errata;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c0f8a78..2e0c9e8 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -651,14 +651,17 @@ static void __init pm_errata_configure(void)
 		/* Enable the l2 cache toggling in sleep logic */
 		enable_omap3630_toggle_l2_on_restore();
 		if (omap_rev() < OMAP3630_REV_ES1_2)
-			pm34xx_errata |= PM_SDRC_WAKEUP_ERRATUM_i583;
+			pm34xx_errata |= (PM_SDRC_WAKEUP_ERRATUM_i583 |
+					  PM_PER_MEMORIES_ERRATUM_i582);
+	} else if (cpu_is_omap34xx()) {
+		pm34xx_errata |= PM_PER_MEMORIES_ERRATUM_i582;
 	}
 }
 
 int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst, *tmp;
-	struct clockdomain *neon_clkdm, *mpu_clkdm;
+	struct clockdomain *neon_clkdm, *mpu_clkdm, *per_clkdm, *wkup_clkdm;
 	int ret;
 
 	if (!omap3_has_io_chain_ctrl())
@@ -710,6 +713,8 @@ int __init omap3_pm_init(void)
 
 	neon_clkdm = clkdm_lookup("neon_clkdm");
 	mpu_clkdm = clkdm_lookup("mpu_clkdm");
+	per_clkdm = clkdm_lookup("per_clkdm");
+	wkup_clkdm = clkdm_lookup("wkup_clkdm");
 
 #ifdef CONFIG_SUSPEND
 	omap_pm_suspend = omap3_pm_suspend;
@@ -726,6 +731,27 @@ int __init omap3_pm_init(void)
 	if (IS_PM34XX_ERRATUM(PM_RTA_ERRATUM_i608))
 		omap3630_ctrl_disable_rta();
 
+	/*
+	 * The UART3/4 FIFO and the sidetone memory in McBSP2/3 are
+	 * not correctly reset when the PER powerdomain comes back
+	 * from OFF or OSWR when the CORE powerdomain is kept active.
+	 * See OMAP36xx Erratum i582 "PER Domain reset issue after
+	 * Domain-OFF/OSWR Wakeup".  This wakeup dependency is not a
+	 * complete workaround.  The kernel must also prevent the PER
+	 * powerdomain from going to OSWR/OFF while the CORE
+	 * powerdomain is not going to OSWR/OFF.  And if PER last
+	 * power state was off while CORE last power state was ON, the
+	 * UART3/4 and McBSP2/3 SIDETONE devices need to run a
+	 * self-test using their loopback tests; if that fails, those
+	 * devices are unusable until the PER/CORE can complete a transition
+	 * from ON to OSWR/OFF and then back to ON.
+	 *
+	 * XXX Technically this workaround is only needed if off-mode
+	 * or OSWR is enabled.
+	 */
+	if (IS_PM34XX_ERRATUM(PM_PER_MEMORIES_ERRATUM_i582))
+		clkdm_add_wkdep(per_clkdm, wkup_clkdm);
+
 	clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
 		omap3_secure_ram_storage =
-- 
1.7.10.4

