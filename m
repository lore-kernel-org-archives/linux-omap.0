From: Kevin Hilman <khilman@ti.com>
Subject: Re: DSS and USBHOST powerdomains not entering low-power states on 37xx EVM
Date: Mon, 06 Aug 2012 14:31:48 -0700
Message-ID: <877gtb6723.fsf@ti.com>
References: <alpine.DEB.2.00.1208031355450.28888@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:58760 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755996Ab2HFVbv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Aug 2012 17:31:51 -0400
Received: by pbbrp12 with SMTP id rp12so6543875pbb.29
        for <linux-omap@vger.kernel.org>; Mon, 06 Aug 2012 14:31:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1208031355450.28888@utopia.booyaka.com> (Paul
	Walmsley's message of "Fri, 3 Aug 2012 14:05:55 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

Paul Walmsley <paul@pwsan.com> writes:

> On v3.6-rc1 on 37xx EVM, DSS and USBHOST powerdomains aren't entering 
> low-power states.  Test log is below.

Is this only happening on this 37xx platform?    Just curious, because
it seems to be a problem on any OMAP3xxx SoC.

[...]

> # echo mem > /sys/power/state
> [   35.068359] PM: Syncing filesystems ... done.
> [   35.083038] Freezing user space processes ... (elapsed 0.00 seconds) 
> done.
> [   35.090698] Freezing remaining freezable tasks ... (elapsed 0.02 
> seconds) done.
> [   35.122833] Suspending console(s) (use no_console_suspend to debug)
> [   35.144409] PM: suspend of devices complete after 11.260 msecs
> [   35.147369] PM: late suspend of devices complete after 2.929 msecs
> [   35.152465] PM: noirq suspend of devices complete after 5.096 msecs
> [   35.152526] Disabling non-boot CPUs ...
> [   36.958343] Successfully put all powerdomains to target state

According to the readback of prev pwrst, it seems they are hitting the
target pwrst (retention by default), so...

> [   36.960662] PM: noirq resume of devices complete after 2.166 msecs
> [   36.964050] PM: early resume of devices complete after 1.892 msecs
> [   36.973388] PM: resume of devices complete after 9.185 msecs
> [   37.025207] Restarting tasks ... done.
> # cat  /debug/pm_debug/count
> usbhost_pwrdm 
> (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> core_pwrdm 
> (ON),OFF:0,RET:1,INA:0,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
> per_pwrdm (ON),OFF:0,RET:1,INA:0,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> dss_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> neon_pwrdm (ON),OFF:0,RET:673,INA:0,ON:674,RET-LOGIC-OFF:0
> mpu_pwrdm (ON),OFF:0,RET:673,INA:0,ON:674,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-ME
> MBANK4-OFF:0
> usbhost_clkdm->usbhost_pwrdm (1)
> sgx_clkdm->sgx_pwrdm (0)
> per_clkdm->per_pwrdm (22)
> cam_clkdm->cam_pwrdm (0)
> dss_clkdm->dss_pwrdm (1)
> d2d_clkdm->core_pwrdm (0)
> iva2_clkdm->iva2_pwrdm (0)
> mpu_clkdm->mpu_pwrdm (0)
> core_l4_clkdm->core_pwrdm (24)
> core_l3_clkdm->core_pwrdm (4)
> neon_clkdm->neon_pwrdm (0)

...it must be the usecounts that are not being updated.  This seems to
be a side effect of the pre/post transition optimization I did.  A quick
hack seems to indicate that that's indeed the case[1].  By default,
omap_sram_idle() is now only calling the pre/post callbacks for MPU,
NEON, PER, and CORE, and only if those domains are transitioning, so any
other domains not explicitly managed by the idle path have lots their
usecounting.  Oops.

I guess Tero's usecounting series should fix this up.

Kevin

[1] 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e4fc88c..d87416f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -70,6 +70,7 @@ void (*omap3_do_wfi_sram)(void);
 
 static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
 static struct powerdomain *core_pwrdm, *per_pwrdm;
+static struct powerdomain *dss_pwrdm, *usbhost_pwrdm;
 
 static void omap3_core_save_context(void)
 {
@@ -393,7 +394,11 @@ static int omap3_pm_suspend(void)
 
 	omap3_intc_suspend();
 
+	pwrdm_pre_transition(dss_pwrdm);
+	pwrdm_pre_transition(usbhost_pwrdm);
 	omap_sram_idle();
+	pwrdm_post_transition(usbhost_pwrdm);
+	pwrdm_post_transition(dss_pwrdm);
 
 restore:
 	/* Restore next_pwrsts */
@@ -718,6 +723,8 @@ int __init omap3_pm_init(void)
 	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
 	per_pwrdm = pwrdm_lookup("per_pwrdm");
 	core_pwrdm = pwrdm_lookup("core_pwrdm");
+	dss_pwrdm = pwrdm_lookup("dss_pwrdm");
+	usbhost_pwrdm = pwrdm_lookup("usbhost_pwrdm");
 
 	neon_clkdm = clkdm_lookup("neon_clkdm");
 	mpu_clkdm = clkdm_lookup("mpu_clkdm");
