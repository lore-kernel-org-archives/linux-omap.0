From: Sricharan R <r.sricharan@ti.com>
Subject: RE: [PATCH] omap: wd_timer: Fix crash frm wdt_probe when !CONFIG_RUNTIME_PM
Date: Thu, 24 Feb 2011 21:43:12 +0530
Message-ID: <f0b57f3b0e11566d8c1864d3388ce5e6@mail.gmail.com>
References: <1294234855-6623-1-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.00.1101061120480.31961@utopia.booyaka.com> <007049e3361a3c4d0e7d2cfa105e2e67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:49976 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753845Ab1BXQOF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 11:14:05 -0500
Received: by mail-vw0-f43.google.com with SMTP id 18so658666vws.2
        for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 08:14:03 -0800 (PST)
In-Reply-To: <007049e3361a3c4d0e7d2cfa105e2e67@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi paul,
>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Santosh Shilimkar
>Sent: Monday, January 17, 2011 10:09 PM
>To: Paul Walmsley
>Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>Subject: RE: [PATCH] omap: wd_timer: Fix crash frm wdt_probe when
>!CONFIG_RUNTIME_PM
>
>> -----Original Message-----
>> From: Paul Walmsley [mailto:paul@pwsan.com]
>> Sent: Thursday, January 06, 2011 11:56 PM
>> To: Santosh Shilimkar
>> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH] omap: wd_timer: Fix crash frm wdt_probe when
>> !CONFIG_RUNTIME_PM
>>
>> Hi Santosh,
>>
>> On Wed, 5 Jan 2011, Santosh Shilimkar wrote:
>>
>> > Commit ff2516fb 'wd_timer: disable on boot via hwmod postsetup
>> mechanism'
>> > introduced watchdog timer state state management using
>> postsetup_state.
>> > This was done to allow some board files to support watchdog
>> coverage
>> > throughout kernel initialization and it work as intended when
>> RUNTIME_PM
>> > is enabled.
>> >
>> > With !CONFIG_RUNTIME_PM and no board is specifically requests
>> watchdog
>> > to remain enabled the omap_wdt_probe crashesh. This is because
>> hwmod
>> > in absense of runtime PM unable to turn watchdog clocks because
>> it's
>> > state is set to be disabled. For rest of the device, the state is
>> > set as enabled in absense of RUNTIME_PM
>> >
>> > [    1.372558] Unhandled fault: imprecise external abort (0x1406)
>> at 0xad733eeb
>> > [    1.379913] Internal error: : 1406 [#1] SMP
>> > [    1.384277] last sysfs file:
>> > [    1.387359] Modules linked in:
>> > [    1.390563] CPU: 0    Tainted: G        W    (2.6.37-rc7-00265-
>> g4298a4c-dirty #23)
>> > [    1.398468] PC is at omap_wdt_disable+0x2c/0x3c
>> > [    1.403198] LR is at omap_wdt_probe+0x124/0x1e0
>> > [    1.407928] pc : [<c02f5bf4>]    lr : [<c03be10c>]    psr:
>> 60000013
>> > [    1.407958] sp : df833f00  ip : 00000000  fp : 00000000
>> > [    1.419921] r10: c0ac57ac  r9 : df959e00  r8 : 00000000
>> > [    1.425384] r7 : df959e08  r6 : df8000c0  r5 : df95bebc  r4 :
>> df87dde0
>> > [    1.432189] r3 : fc314000  r2 : 00005555  r1 : fc314034  r0 :
>> df87dde0
>> >
>> > This patch make the default watchdog state to be enabled in case
>> of
>> > !CONFIG_RUNTIME_PM. This fixes the crash
>> >
>> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> > Cc: Paul Walmsley <paul@pwsan.com>
>> > ---
>> > Paul, I am not too sure if it breaks your _shutdown idea of
>> watchdog
>> > timer.
>>
>> Maybe.  What happens in a case where the bootloader enables the
>> watchdog,
>> but the booting kernel is compiled with !CONFIG_OMAP_WATCHDOG and
>> !CONFIG_PM_RUNTIME?  Won't the watchdog reset the MPU unexpectedly
>> in that
>> case?  Or am I missing something...
>>
>I tried this scenario and some how the WDT isn't reseting MPU with my
>patch.
>
>Actually I was expecting it should reset but it didn't.
>
>Regards,
>Santosh
In the case of !CONFIG_PM_RUNTIME and !CONFIG_OMAP_WATCHDOG, if
the boot loader or hwmod enables the watchdog, then it generates
an un wanted reset.

So to avoid this in the case of !CONFIG_OMAP_WATCHDOG then the
watchdog should always be disabled.

So there are two cases:
   Case 1: (!CONFIG_OMAP_WATCHDOG and !CONFIG_PM_RUNTIME)
             Watchdog should be disabled.

   Case 2: (!CONFIG_PM_RUNTIME) and ( driver is present and board file
enables it)
		 Watchdog should run.

   Solution1:
          Introduce a new hwmod watchdog reset function, by populating
          the .reset entry of the hwmod.
          This function is called during the hwmod init.
          This function resets the watchdog always and also
          disables it if !CONFIG_OMAP_WATCHDOG.

        ( or )

  Solution2:
          Introduce a state variable to differentiate if
          hwmod post_setup_state is set to enabled by
          by board file or io.c file.

          Use this state variable in the reset function as

          If it is enabled by io.c then disable watchdog
          Otherwise if it is set to enabled by board file
          then enable watchdog.

The below is the patch for solution1, that I have mentioned.
Please suggest which would be the right approach ?

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 657f3c8..2641d73 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -382,24 +382,6 @@ void __init omap2_init_common_infrastructure(void)
 #endif
 	omap_hwmod_for_each(_set_hwmod_postsetup_state, &postsetup_state);

-	/*
-	 * Set the default postsetup state for unusual modules (like
-	 * MPU WDT).
-	 *
-	 * The postsetup_state is not actually used until
-	 * omap_hwmod_late_init(), so boards that desire full watchdog
-	 * coverage of kernel initialization can reprogram the
-	 * postsetup_state between the calls to
-	 * omap2_init_common_infra() and omap2_init_common_devices().
-	 *
-	 * XXX ideally we could detect whether the MPU WDT was currently
-	 * enabled here and make this conditional
-	 */
-	postsetup_state = _HWMOD_STATE_DISABLED;
-	omap_hwmod_for_each_by_class("wd_timer",
-				     _set_hwmod_postsetup_state,
-				     &postsetup_state);
-
 	omap_pm_if_early_init();

 	if (cpu_is_omap2420())
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 879f55f..d665ee5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -545,7 +545,8 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
 static struct omap_hwmod_class omap3xxx_wd_timer_hwmod_class = {
 	.name		= "wd_timer",
 	.sysc		= &omap3xxx_wd_timer_sysc,
-	.pre_shutdown	= &omap2_wd_timer_disable
+	.pre_shutdown	= &omap2_wd_timer_disable,
+	.reset		= &omap2_wd_timer_reset
 };

 /* wd_timer2 */
diff --git a/arch/arm/mach-omap2/wd_timer.c
b/arch/arm/mach-omap2/wd_timer.c
index 4067669..e11c5f3 100644
--- a/arch/arm/mach-omap2/wd_timer.c
+++ b/arch/arm/mach-omap2/wd_timer.c
@@ -24,7 +24,8 @@
  */
 #define OMAP_WDT_WPS		0x34
 #define OMAP_WDT_SPR		0x48
-
+#define OMAP_WDT_DSC		0x10
+#define OMAP_WDT_DST		0x14

 int omap2_wd_timer_disable(struct omap_hwmod *oh)
 {
@@ -54,3 +55,32 @@ int omap2_wd_timer_disable(struct omap_hwmod *oh)
 	return 0;
 }

+int omap2_wd_timer_reset(struct omap_hwmod *oh)
+{
+	void __iomem *base;
+	pr_err("\n\n\n\n\n\n\n\n\n omap2_wd_timer_reset \n\n\n\n\n");
+
+	if (!oh) {
+		pr_err("%s: could not look up wdtimer_hwmod\n",__func__);
+	}
+
+	base = omap_hwmod_get_mpu_rt_va(oh);
+	if(!base) {
+		pr_err("%s: Could not get the base address for %s\n",
+				oh->name, __func__);
+		return -EINVAL;
+	}
+
+	/* soft reset on watch dog timer */
+	__raw_writel(0x02, base + OMAP_WDT_DSC);
+	while (__raw_readl(base + OMAP_WDT_DST) & 0x1)
+		cpu_relax();
+
+#ifdef CONFIG_OMAP_WATCHDOG
+	/* Disable the watchdog */
+	omap2_wd_timer_disable(oh);
+#endif
+
+	return 0;
+}
+
diff --git a/arch/arm/mach-omap2/wd_timer.h
b/arch/arm/mach-omap2/wd_timer.h
index e0054a2..f6bbba7 100644
--- a/arch/arm/mach-omap2/wd_timer.h
+++ b/arch/arm/mach-omap2/wd_timer.h
@@ -13,5 +13,6 @@
 #include <plat/omap_hwmod.h>

 extern int omap2_wd_timer_disable(struct omap_hwmod *oh);
+extern int omap2_wd_timer_reset(struct omap_hwmod *oh);


Thanks,
  Sricharan


----
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
