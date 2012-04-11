From: Kevin Hilman <khilman@ti.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Wed, 11 Apr 2012 12:17:58 -0700
Message-ID: <87hawqt6vt.fsf@ti.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	<4F859C5D.3090400@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:36944 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932836Ab2DKTRt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 15:17:49 -0400
Received: by pbcun15 with SMTP id un15so1696150pbc.5
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 12:17:48 -0700 (PDT)
In-Reply-To: <4F859C5D.3090400@mlbassoc.com> (Gary Thomas's message of "Wed,
	11 Apr 2012 08:59:41 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Gary Thomas <gary@mlbassoc.com> writes:

[...]

> I fear I'm seeing similar problems with 3.3.  I have my board (similar
> to the BeagleBoard) ported to 3.0 and 3.3.  I'm seeing terrible network
> performance on 3.3.  For example, if I use TFTP to download a large file
> (~35MB), I get this:
>   3.0:  42.5 sec
>   3.3: 625.0 sec
> That's a factor of 15 worse!

This might not be the same problem.  What is the NIC being used, and
does it have GPIO interrupts?

If it's using GPIO interrupts, then you likely need this patch from
mainline (v3.4-rc1)

If that doesn't work, or you're not using GPIO interrupts, could you
confirm if the patch below[2] (based on idea from Grasvydas) increases
performance for you when CONFIG_PM=y.

Kevin

[1]
Author: Kevin Hilman <khilman@ti.com>  2012-03-05 15:10:04
Committer: Grant Likely <grant.likely@secretlab.ca>  2012-03-12 09:16:11
Parent: 25db711df3258d125dc1209800317e5c0ef3c870 (gpio/omap: Fix IRQ handling for SPARSE_IRQ)
Child:  8805f410e4fb88a56552c1af42d61b38837a38fd (gpio/omap: Fix section warning for omap_mpuio_alloc_gc())
Branches: many (66)
Follows: v3.3-rc7
Precedes: v3.4-rc1

    gpio/omap: fix wakeups on level-triggered GPIOs
    
    While both level- and edge-triggered GPIOs are capable of generating
    interrupts, only edge-triggered GPIOs are capable of generating a
    module-level wakeup to the PRCM (c.f. 34xx NDA TRM section 25.5.3.2.)
    
    In order to ensure that devices using level-triggered GPIOs as
    interrupts can also cause wakeups (e.g. from idle), this patch enables
    edge-triggering for wakeup-enabled, level-triggered GPIOs when a GPIO
    bank is runtime-suspended (which also happens during idle.)
    
    This fixes a problem found in GPMC-connected network cards with GPIO
    interrupts (e.g. smsc911x on Zoom3, Overo, ...) where network booting
    with NFSroot was very slow since the GPIO IRQs used by the NIC were
    not generating PRCM wakeups, and thus not waking the system from idle.
    NOTE: until v3.3, this boot-time problem was somewhat masked because
    the UART init prevented WFI during boot until the full serial driver
    was available.  Preventing WFI allowed regular GPIO interrupts to fire
    and this problem was not seen.  After the UART runtime PM cleanups, we
    no longer avoid WFI during boot, so GPIO IRQs that were not causing
    wakeups resulted in very slow IRQ response times.
    
    Tested on platforms using level-triggered GPIOs for network IRQs using
    the SMSC911x NIC: 3530/Overo and 3630/Zoom3.
    
    Reported-by: Tony Lindgren <tony@atomide.com>
    Tested-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
    Tested-by: Tony Lindgren <tony@atomide.com>
    Signed-off-by: Kevin Hilman <khilman@ti.com>
    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

[2]
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 413aac4..ace4bf6 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -120,7 +120,10 @@ static int __omap3_enter_idle(struct cpuidle_device *dev,
 		cpu_pm_enter();
 
 	/* Execute ARM wfi */
-	omap_sram_idle();
+	if (index == 0)
+		cpu_do_idle();
+	else
+		omap_sram_idle();
 
 	/*
 	 * Call idle CPU PM enter notifier chain to restore
