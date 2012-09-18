From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv4 8/8] ARM: OMAP3: do not delete per_clkdm autodeps during
 idle
Date: Tue, 18 Sep 2012 22:25:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209182156330.4747@utopia.booyaka.com>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com> <1342189185-5306-9-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:55160 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755813Ab2IRWZG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 18:25:06 -0400
In-Reply-To: <1342189185-5306-9-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

Hi Tero,

just looking at the usecounting series to see what is mergeable and 
noticed this:

On Fri, 13 Jul 2012, Tero Kristo wrote:

> Secondly, there are multiple erratas for omap3, which say that the 
> wakedeps should be enabled for the PER domain, see e.g. errata i582 for 
> omap3630.

Erratum i582 mentions that a wakeup dependency needs to exist between PER 
and WKUP such that PER will wake when CORE_L3 does.  Our autodeps would 
not add this dependency; they just would attempt to add a wakeup 
dependency between PER and MPU/IVA2.  So we need a different mechanism.  
What do you think about the following patch to handle part of the i582 
workaround?

Also, do you have any of the other errata information handy, so we can 
track those down also?  I'm pretty sure we need to enable the wakeup 
dependency between PER and CORE also for OMAP3, but can't recall the 
reference.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Tue, 18 Sep 2012 16:02:38 -0600
Subject: [PATCH] ARM: OMAP36xx: PM: apply part of the erratum i582 workaround

On OMAP36xx chips with ES < 1.2, if the PER powerdomain goes to OSWR
or OFF while CORE stays at CSWR or ON, or if, upon chip wakeup from
OSWR or OFF, the CORE powerdomain goes ON before PER, the UART3/4
FIFOs and McBSP2/3 SIDETONE memories will be unusable.  This is
erratum i582 in the OMAP36xx Silicon Errata document.

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
 arch/arm/mach-omap2/pm34xx.c |   24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

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
index 05bd8f0..5e99345 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -651,7 +651,8 @@ static void __init pm_errata_configure(void)
 		/* Enable the l2 cache toggling in sleep logic */
 		enable_omap3630_toggle_l2_on_restore();
 		if (omap_rev() < OMAP3630_REV_ES1_2)
-			pm34xx_errata |= PM_SDRC_WAKEUP_ERRATUM_i583;
+			pm34xx_errata |= (PM_SDRC_WAKEUP_ERRATUM_i583 |
+					  PM_PER_ERRATUM_i582);
 	}
 }
 
@@ -726,6 +727,27 @@ int __init omap3_pm_init(void)
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

