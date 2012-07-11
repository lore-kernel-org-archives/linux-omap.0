From: Kevin Hilman <khilman@ti.com>
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with RTC?
Date: Wed, 11 Jul 2012 11:38:59 -0700
Message-ID: <87k3yakurg.fsf@ti.com>
References: <WC20120705150314.450045@terrafix.co.uk> <87zk77p3s5.fsf@ti.com>
	<WC20120711105003.8400AC@terrafix.co.uk> <87pq82kz0l.fsf@ti.com>
	<20120711175105.GA358@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:51042 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755108Ab2GKSjA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Jul 2012 14:39:00 -0400
Received: by yenl8 with SMTP id l8so2207248yen.27
        for <linux-omap@vger.kernel.org>; Wed, 11 Jul 2012 11:38:59 -0700 (PDT)
In-Reply-To: <20120711175105.GA358@animalcreek.com> (Mark A. Greer's message
	of "Wed, 11 Jul 2012 10:51:05 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Mark A. Greer" <mgreer@animalcreek.com> writes:

> On Wed, Jul 11, 2012 at 10:07:06AM -0700, Kevin Hilman wrote:
>> "Joe Woodward" <jw@terrafix.co.uk> writes:
>>=20
>> > -----Original Message-----
>> > From: Kevin Hilman <khilman@ti.com>
>> > To: "Joe Woodward" <jw@terrafix.co.uk>
>> > Cc: "linux-omap\@vger.kernel.org" <linux-omap@vger.kernel.org>
>> > Date: Tue, 10 Jul 2012 16:58:18 -0700
>> > Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built =
with RTC?
>> >
>> >> "Joe Woodward" <jw@terrafix.co.uk> writes:
>> >>=20
>> >> > I've got 3.5-rc5 with the following patches applied to get syst=
em
>> >> suspend working on OMAP3:
>> >> >   - fix the DSS: OMAPDSS: Use PM notifiers for system suspend
>> >> >   - fix the 32KHz clock: ARM: OMAP2+: hwmod code/clockdomain da=
ta:
>> >> fix 32K sync timer
>> >> >
>> >> > This has been built with the omap2plus_defconfig.
>> >> >
>> >> > However, If I disable the RTC (i.e.
>> >> CONFIG_RTC_CLASS/CONFIG_RTC_DRV_TWL4030) and rebuild then when
>> >> suspending the device never wakes up.
>> >> >
>> >> > That is, I can't get any wakeups to happen (either through the
>> >> console, or GPIO buttons) hence I'm assuming the kernel has crash=
ed...
>> >> >
>> >> > Any ideas?
>> >> >
>> >> > As far as I know there is no dependency on the RTC in 3.4, and =
with
>> >> the RTC compiled in I never see a problem on 3.5-rc5.
>> >>=20
>> >> There is definitely a bug in the EHCI driver in v3.5 that cause a=
 hang
>> >> in suspend, but the RTC connection is very strange.
>> >>=20
>> >> I was not able to reproduce this.
>> >>=20
>> >> Can you try the same with my current 'pm' branch[1].  I've got a
>> >> handful
>> >> of additional fixes there for various other problems where both M=
MC and
>> >> EHCI are preventing sucessful suspend with the default
>> >> omap2plus_defconfig.  (note the EHCI fix is simply diabling it in=
 the
>> >> defconfig.)
>> >>=20
>> >> Kevin
>> >>=20
>> >
>> > Hi Kevin,
>> >
>> > Thanks for looking in to this.
>>=20
>> And thanks for your detailed bug reports.
>>=20
>> > I've taken a copy of the PM branch with tag "pm-20120710" and buil=
t with omap2plus_defconfig.
>> >
>> > But I get several warnings during boot, and suspend works - but al=
most nothing enters the target states:
>> >
>> > Warnings include:
>> > [    0.000000] clockdomain: mpu_clkdm: powerdomain =C2=AC=C3=B5`=C3=
=808=C2=BAs=C3=80 does not exist
>>=20
>> This one is suspicious.
>>=20
>> > [    2.311004] omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
>> > [    2.317382] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA en=
gine channel 62
>> > [    2.325256] omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
>> > [    2.331512] omap_hsmmc omap_hsmmc.1: unable to obtain RX DMA en=
gine channel 48
>>=20
>> These are normal because DMA engine is not compiled in with
>> omap2plus_defconfig.  MMC wont' work unless you build in DMA engine,=
 but
>> that doesn't matter for trying to figure out your problem.
>>=20
>> > [    2.447784] platform omap_hsmmc.0: omap_device_late_idle: enabl=
ed but no driver.  Idling
>> > [    2.456359] platform omap_hsmmc.1: omap_device_late_idle: enabl=
ed but no driver.  Idling
>>=20
>> This is expected because of the failed MMC probe.
>>=20
>> > # echo mem > /sys/power/state
>> > [  107.398956] PM: Syncing filesystems ... done.
>> > [  107.413757] Freezing user space processes ... (elapsed 0.02 sec=
onds) done.
>> > [  107.443481] Freezing remaining freezable tasks ... (elapsed 0.0=
2 seconds) done.
>> > [  107.474700] Suspending console(s) (use no_console_suspend to de=
bug)
>> > [  107.493560] PM: suspend of devices complete after 9.246 msecs
>> > [  107.496063] PM: late suspend of devices complete after 2.502 ms=
ecs
>> > [  107.500427] PM: noirq suspend of devices complete after 4.302 m=
secs
>> > [  107.500488] Disabling non-boot CPUs ...
>> > [  108.446838] Powerdomain (iva2_pwrdm) didn't enter target state =
1
>> > [  108.446868] Powerdomain (dss_pwrdm) didn't enter target state 1
>> > [  108.446868] Powerdomain (per_pwrdm) didn't enter target state 1
>> > [  108.446868] Powerdomain (core_pwrdm) didn't enter target state =
1
>> > [  108.446899] Powerdomain (usbhost_pwrdm) didn't enter target sta=
te 1
>> > [  108.446899] Could not enter target state in pm_suspend
>> > [  108.448852] PM: noirq resume of devices complete after 1.769 ms=
ecs
>> > [  108.451873] PM: early resume of devices complete after 1.556 ms=
ecs
>> > [  108.459716] PM: resume of devices complete after 7.690 msecs
>> > [  108.541748] Restarting tasks ... done.
>> > sh: write error: Operation not permitted
>> >
>> > This is all on an Overo AirSTORM (3703-based) plugged in to a GUMS=
TIX PALO43 dev board.
>>=20
>> Hmm, interesting, I don't see this on my 3730-based Over FireSTORM.
>>=20
>> But, after "converting" mine into an AirStorm[1], I see the same err=
ors
>> as you're seeing.  We're obviously doing something wrong when IVA an=
d/or
>> SGX are not present, so I will look into it.
>
> There is a small chance that this patch will help:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-April/0937=
10.html
>

Thanks for the idea, but that patch is already merged in the branch
we're testing.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
