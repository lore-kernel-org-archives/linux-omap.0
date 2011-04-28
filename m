From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [linux-pm] [RFC PATCH] PM: Introduce generic DVFS framework with
 device-specific OPPs
Date: Thu, 28 Apr 2011 15:12:13 +0900
Message-ID: <BANLkTi=Be3DrAUoPmgHpjhAVmN-Pi5Au7g@mail.gmail.com>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
	<201104261309.47629.rjw@sisk.pl>
	<BANLkTi=tBYT4NpayaoAA1+f1uaj9QyT+Yw@mail.gmail.com>
	<BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com>
	<BANLkTin4rrniJpOheLH=JE0jq7vFpdDbrA@mail.gmail.com>
	<BANLkTi=WWASxk3Fz83324k40Lbq+ccAPeA@mail.gmail.com>
	<BANLkTikEtTDp3Cpj0D5z34wA0_G_DWwKFg@mail.gmail.com>
	<alpine.LFD.2.02.1104272104390.3323@ionos>
	<BANLkTinWD0ktYKzR_jnQSE76AuW+Z1PSLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58584 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510Ab1D1GMP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Apr 2011 02:12:15 -0400
Received: by bwz15 with SMTP id 15so2019483bwz.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 23:12:13 -0700 (PDT)
In-Reply-To: <BANLkTinWD0ktYKzR_jnQSE76AuW+Z1PSLw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Menon, Nishanth" <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, linux-omap <linux-omap@vger.kernel.org>

On Thu, Apr 28, 2011 at 5:48 AM, Colin Cross <ccross@google.com> wrote:
> On Wed, Apr 27, 2011 at 12:26 PM, Thomas Gleixner <tglx@linutronix.de=
> wrote:
>> Forget OMAP implementation details for a while, sit back and look at
>> the big picture.
>
> Here's my proposal for DVFS:
> - DVFS is implemented in drivers/clk/dvfs.c, and is called by the
> common clock implementation to adjust the voltages, if necessary, on
> regular clk_* calls.
> - Platform code provides mappings in the form (clk, regulator, max
> frequency, min voltage) to the dvfs code.
> - Everything that is in OPP today gets converted to helper functions
> inside the dvfs implementation, and is never called from SoC code
> (except to pass tables at init), or from drivers.
> - OPP can be recreated in the future as a upper level policy manager
> for clocks that need to move together, if that is ever necessary. =C2=
=A0It
> would not know anything about voltages.
> - A few common policy implementations need to be added to the common
> clock implementation, like temperature limits.

I hope that my previous reply answered this.

>
> For Tegra:
> - DVFS continues to be accessed by calling clk_* functions
>
> For OMAP:
> - DVFS is triggered by hwmod through clk_* functions. =C2=A0Any cross=
-arch
> driver can continue to call clk_* functions.
>
> OPP currently has opp_enable and opp_disable functions. =C2=A0I don't
> understand why these are needed, they are only used at init time to
> determine available voltages, which could be handled by never passing
> unavailable voltages to the dvfs implementation.

We need them in runtime.

A device "a" may want to guarantee that a device "b" to be at least
"200MHz" or faster while it does some operations. Then, "a" will
opp_disable("b", 100MHz and others); and opp_enable("b", them) later
on. We have similar issues with multimedia blocks (MFC, Camera, FB,
GPU) and CPU/Memory Bus. Ondemand governor of CPUFREQ has some delay
on catching up a workload (1.5x the sampling rate in average, <2.0x
the sampling rate in worst cases), which may incur flickering/tearing
issues with multimedia streams. On the other hand, a general thermal
monitor or battery manager might want to limit energy usage by
disabling top performance clocks if it is too hot or the battery level
is low.

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
