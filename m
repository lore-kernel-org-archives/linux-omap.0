From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [linux-pm] [RFC PATCH] PM: Introduce generic DVFS framework with
 device-specific OPPs
Date: Thu, 28 Apr 2011 15:50:02 +0900
Message-ID: <BANLkTimzWyvcBV2ymxaMf=HmRhGYBboB1w@mail.gmail.com>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
	<201104261309.47629.rjw@sisk.pl>
	<BANLkTi=tBYT4NpayaoAA1+f1uaj9QyT+Yw@mail.gmail.com>
	<BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com>
	<BANLkTin4rrniJpOheLH=JE0jq7vFpdDbrA@mail.gmail.com>
	<BANLkTi=WWASxk3Fz83324k40Lbq+ccAPeA@mail.gmail.com>
	<BANLkTikEtTDp3Cpj0D5z34wA0_G_DWwKFg@mail.gmail.com>
	<alpine.LFD.2.02.1104272104390.3323@ionos>
	<BANLkTinWD0ktYKzR_jnQSE76AuW+Z1PSLw@mail.gmail.com>
	<BANLkTi=Be3DrAUoPmgHpjhAVmN-Pi5Au7g@mail.gmail.com>
	<BANLkTiniJUgTTDh7SF8yNMeSMa+JYM21wA@mail.gmail.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61558 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619Ab1D1GuE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Apr 2011 02:50:04 -0400
Received: by bwz15 with SMTP id 15so2039002bwz.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 23:50:03 -0700 (PDT)
In-Reply-To: <BANLkTiniJUgTTDh7SF8yNMeSMa+JYM21wA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>, linux-pm@lists.linux-foundation.org

On Thu, Apr 28, 2011 at 3:44 PM, Colin Cross <ccross@google.com> wrote:
> On Wed, Apr 27, 2011 at 11:12 PM, MyungJoo Ham <myungjoo.ham@samsung.=
com> wrote:
>> On Thu, Apr 28, 2011 at 5:48 AM, Colin Cross <ccross@google.com> wro=
te:
>>> OPP currently has opp_enable and opp_disable functions. =C2=A0I don=
't
>>> understand why these are needed, they are only used at init time to
>>> determine available voltages, which could be handled by never passi=
ng
>>> unavailable voltages to the dvfs implementation.
>>
>> We need them in runtime.
>>
>> A device "a" may want to guarantee that a device "b" to be at least
>> "200MHz" or faster while it does some operations. Then, "a" will
>> opp_disable("b", 100MHz and others); and opp_enable("b", them) later
>> on. We have similar issues with multimedia blocks (MFC, Camera, FB,
>> GPU) and CPU/Memory Bus. Ondemand governor of CPUFREQ has some delay
>> on catching up a workload (1.5x the sampling rate in average, <2.0x
>> the sampling rate in worst cases), which may incur flickering/tearin=
g
>> issues with multimedia streams. On the other hand, a general thermal
>> monitor or battery manager might want to limit energy usage by
>> disabling top performance clocks if it is too hot or the battery lev=
el
>> is low.
>
> That sounds like a very strange api, when what you really mean is
> clk_set_min_rate or clk_set_max_rate.

Essentially, that's what needed.
However, with clk_set_min/max_rate, don't we need to let another
device to be consumer of other devices' clocks? Not just introducing a
device to other devices?

> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>



--=20
MyungJoo Ham (=ED=95=A8=EB=AA=85=EC=A3=BC), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
