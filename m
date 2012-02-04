From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Sat, 4 Feb 2012 23:14:37 +0000
Message-ID: <20120204231437.GA26382@n2100.arm.linux.org.uk>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56379 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767Ab2BDXOp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Feb 2012 18:14:45 -0500
Content-Disposition: inline
In-Reply-To: <20120204203453.GD17309@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

Here's another problem to add to the list:

2fd149645eb46d26130d7070c6de037dddf34880 totally screws serial on
OMAP3430 - and by that I mean running the port at 115200 baud causes
a simple 'dmesg' output to take 5+ minutes to output in 16 character
blocks every two seconds.

This fixes it in so far as it effectively reverts that change (the
change itself won't revert cleanly), but it's far from nice.

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 464cffd..1e9256c 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -259,6 +259,8 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
        struct omap3_idle_statedata *cx;
        int ret;
 
+       { new_state_idx = drv->safe_state_index; goto select_state; }
+
        /*
         * Prevent idle completely if CAM is active.
         * CAM does not have wakeup capability in OMAP3.
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b77df73..4b76c4c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -420,7 +420,7 @@ static void omap3_pm_idle(void)
 {
        local_fiq_disable();
 
-       if (omap_irq_pending())
+       if (omap_irq_pending() || 1)
                goto out;
 
        trace_power_start(POWER_CSTATE, 1, smp_processor_id());

