From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with RTC?
Date: Wed, 11 Jul 2012 21:01:57 +0530
Message-ID: <CANrkHUZnCtvGs8u2pA3SYvpBU-UXakHQEx_RmOAh6vinTq2HBw@mail.gmail.com>
References: <WC20120705150314.450045@terrafix.co.uk>
	<87zk77p3s5.fsf@ti.com>
	<WC20120711105003.8400AC@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:50146 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755463Ab2GKPcA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Jul 2012 11:32:00 -0400
Received: by lbbgg6 with SMTP id gg6so2517284lbb.22
        for <linux-omap@vger.kernel.org>; Wed, 11 Jul 2012 08:31:57 -0700 (PDT)
In-Reply-To: <WC20120711105003.8400AC@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Kevin Hilman <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Jul 11, 2012 at 4:20 PM, Joe Woodward <jw@terrafix.co.uk> wrote=
:
> -----Original Message-----
> From: Kevin Hilman <khilman@ti.com>
> To: "Joe Woodward" <jw@terrafix.co.uk>
> Cc: "linux-omap\@vger.kernel.org" <linux-omap@vger.kernel.org>
> Date: Tue, 10 Jul 2012 16:58:18 -0700
> Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built wit=
h RTC?
>
>> "Joe Woodward" <jw@terrafix.co.uk> writes:
>>
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
>>
>> There is definitely a bug in the EHCI driver in v3.5 that cause a ha=
ng
>> in suspend, but the RTC connection is very strange.
>>
>> I was not able to reproduce this.
>>
>> Can you try the same with my current 'pm' branch[1].  I've got a
>> handful
>> of additional fixes there for various other problems where both MMC =
and
>> EHCI are preventing sucessful suspend with the default
>> omap2plus_defconfig.  (note the EHCI fix is simply diabling it in th=
e
>> defconfig.)
>>
>> Kevin
>>
>
> Hi Kevin,
>
> Thanks for looking in to this.
>
> I've taken a copy of the PM branch with tag "pm-20120710" and built w=
ith omap2plus_defconfig.
>
> But I get several warnings during boot, and suspend works - but almos=
t nothing enters the target states:
>
> Warnings include:
> [    0.000000] clockdomain: mpu_clkdm: powerdomain =AC=F5`=C08=BAs=C0=
 does not exist
>
> [    2.311004] omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
> [    2.317382] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engin=
e channel 62
> [    2.325256] omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
> [    2.331512] omap_hsmmc omap_hsmmc.1: unable to obtain RX DMA engin=
e channel 48
>
Hi Joe,

This warning should go away with CONFIG_DMA_OMAP, CONFIG_DMA_ENGINE ena=
bled

> [    2.447784] platform omap_hsmmc.0: omap_device_late_idle: enabled =
but no driver.  Idling
> [    2.456359] platform omap_hsmmc.1: omap_device_late_idle: enabled =
but no driver.  Idling
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
