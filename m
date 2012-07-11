From: Kevin Hilman <khilman@ti.com>
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with RTC?
Date: Wed, 11 Jul 2012 10:07:06 -0700
Message-ID: <87pq82kz0l.fsf@ti.com>
References: <WC20120705150314.450045@terrafix.co.uk> <87zk77p3s5.fsf@ti.com>
	<WC20120711105003.8400AC@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:50582 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932142Ab2GKRHO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Jul 2012 13:07:14 -0400
Received: by pbbro2 with SMTP id ro2so2563553pbb.13
        for <linux-omap@vger.kernel.org>; Wed, 11 Jul 2012 10:07:05 -0700 (PDT)
In-Reply-To: <WC20120711105003.8400AC@terrafix.co.uk> (Joe Woodward's message
	of "Wed, 11 Jul 2012 11:50:03 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Joe Woodward" <jw@terrafix.co.uk> writes:

> -----Original Message-----
> From: Kevin Hilman <khilman@ti.com>
> To: "Joe Woodward" <jw@terrafix.co.uk>
> Cc: "linux-omap\@vger.kernel.org" <linux-omap@vger.kernel.org>
> Date: Tue, 10 Jul 2012 16:58:18 -0700
> Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built wit=
h RTC?
>
>> "Joe Woodward" <jw@terrafix.co.uk> writes:
>>=20
>> > I've got 3.5-rc5 with the following patches applied to get system
>> suspend working on OMAP3:
>> >   - fix the DSS: OMAPDSS: Use PM notifiers for system suspend
>> >   - fix the 32KHz clock: ARM: OMAP2+: hwmod code/clockdomain data:
>> fix 32K sync timer
>> >
>> > This has been built with the omap2plus_defconfig.
>> >
>> > However, If I disable the RTC (i.e.
>> CONFIG_RTC_CLASS/CONFIG_RTC_DRV_TWL4030) and rebuild then when
>> suspending the device never wakes up.
>> >
>> > That is, I can't get any wakeups to happen (either through the
>> console, or GPIO buttons) hence I'm assuming the kernel has crashed.=
=2E.
>> >
>> > Any ideas?
>> >
>> > As far as I know there is no dependency on the RTC in 3.4, and wit=
h
>> the RTC compiled in I never see a problem on 3.5-rc5.
>>=20
>> There is definitely a bug in the EHCI driver in v3.5 that cause a ha=
ng
>> in suspend, but the RTC connection is very strange.
>>=20
>> I was not able to reproduce this.
>>=20
>> Can you try the same with my current 'pm' branch[1].  I've got a
>> handful
>> of additional fixes there for various other problems where both MMC =
and
>> EHCI are preventing sucessful suspend with the default
>> omap2plus_defconfig.  (note the EHCI fix is simply diabling it in th=
e
>> defconfig.)
>>=20
>> Kevin
>>=20
>
> Hi Kevin,
>
> Thanks for looking in to this.

And thanks for your detailed bug reports.

> I've taken a copy of the PM branch with tag "pm-20120710" and built w=
ith omap2plus_defconfig.
>
> But I get several warnings during boot, and suspend works - but almos=
t nothing enters the target states:
>
> Warnings include:
> [    0.000000] clockdomain: mpu_clkdm: powerdomain =C2=AC=C3=B5`=C3=80=
8=C2=BAs=C3=80 does not exist

This one is suspicious.

> [    2.311004] omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
> [    2.317382] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engin=
e channel 62
> [    2.325256] omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
> [    2.331512] omap_hsmmc omap_hsmmc.1: unable to obtain RX DMA engin=
e channel 48

These are normal because DMA engine is not compiled in with
omap2plus_defconfig.  MMC wont' work unless you build in DMA engine, bu=
t
that doesn't matter for trying to figure out your problem.

> [    2.447784] platform omap_hsmmc.0: omap_device_late_idle: enabled =
but no driver.  Idling
> [    2.456359] platform omap_hsmmc.1: omap_device_late_idle: enabled =
but no driver.  Idling

This is expected because of the failed MMC probe.

> # echo mem > /sys/power/state
> [  107.398956] PM: Syncing filesystems ... done.
> [  107.413757] Freezing user space processes ... (elapsed 0.02 second=
s) done.
> [  107.443481] Freezing remaining freezable tasks ... (elapsed 0.02 s=
econds) done.
> [  107.474700] Suspending console(s) (use no_console_suspend to debug=
)
> [  107.493560] PM: suspend of devices complete after 9.246 msecs
> [  107.496063] PM: late suspend of devices complete after 2.502 msecs
> [  107.500427] PM: noirq suspend of devices complete after 4.302 msec=
s
> [  107.500488] Disabling non-boot CPUs ...
> [  108.446838] Powerdomain (iva2_pwrdm) didn't enter target state 1
> [  108.446868] Powerdomain (dss_pwrdm) didn't enter target state 1
> [  108.446868] Powerdomain (per_pwrdm) didn't enter target state 1
> [  108.446868] Powerdomain (core_pwrdm) didn't enter target state 1
> [  108.446899] Powerdomain (usbhost_pwrdm) didn't enter target state =
1
> [  108.446899] Could not enter target state in pm_suspend
> [  108.448852] PM: noirq resume of devices complete after 1.769 msecs
> [  108.451873] PM: early resume of devices complete after 1.556 msecs
> [  108.459716] PM: resume of devices complete after 7.690 msecs
> [  108.541748] Restarting tasks ... done.
> sh: write error: Operation not permitted
>
> This is all on an Overo AirSTORM (3703-based) plugged in to a GUMSTIX=
 PALO43 dev board.

Hmm, interesting, I don't see this on my 3730-based Over FireSTORM.

But, after "converting" mine into an AirStorm[1], I see the same errors
as you're seeing.  We're obviously doing something wrong when IVA and/o=
r
SGX are not present, so I will look into it.

Thanks for testing,

Kevin


[1]
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 40373db..c8e5a6c 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -237,8 +237,8 @@ void __init omap3xxx_check_features(void)
 	status =3D omap_ctrl_readl(OMAP3_CONTROL_OMAP_STATUS);
=20
 	OMAP3_CHECK_FEATURE(status, L2CACHE);
-	OMAP3_CHECK_FEATURE(status, IVA);
-	OMAP3_CHECK_FEATURE(status, SGX);
+	/* OMAP3_CHECK_FEATURE(status, IVA); */
+	/* OMAP3_CHECK_FEATURE(status, SGX); */
 	OMAP3_CHECK_FEATURE(status, NEON);
 	OMAP3_CHECK_FEATURE(status, ISP);
 	if (cpu_is_omap3630())
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
