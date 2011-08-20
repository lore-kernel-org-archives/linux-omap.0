From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] OMAP4: clock: re-enable previous clockdomain enable/disable
 sequence (was Re: Oops on ehci_hcd when booting 3.0.0-rc2 on panda)
Date: Sat, 20 Aug 2011 11:45:18 +0530
Message-ID: <4E4F50F6.9040900@ti.com>
References: <1307356643.23002.413.camel@cumari>	<20110606104417.GP18731@legolas.emea.dhcp.ti.com>	<20110606110218.GS18731@legolas.emea.dhcp.ti.com>	<1307358348.23002.419.camel@cumari>	<1312889168.2407.148.camel@cumari>	<CAK=WgbatbaSj=U7+SAva4Woh7uaOoCzQck5yjfLvVGLR-UCVHg@mail.gmail.com>	<4E43C41E.1080808@ti.com> <1313065224.2407.857.camel@cumari>	<CAP05o4+sBa_DO-ReoF20L=v5kbt5936_1vAGTQ10E4Lh+YXdNQ@mail.gmail.com>	<alpine.DEB.2.00.1108191647430.9948@utopia.booyaka.com>	<20110819230805.GA13317@legolas.emea.dhcp.ti.com> <alpine.DEB.2.00.1108192131170.24016@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:58897 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751462Ab1HTGP3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 20 Aug 2011 02:15:29 -0400
In-Reply-To: <alpine.DEB.2.00.1108192131170.24016@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Kevin Hilman <khilman@ti.com>, Luciano Coelho <coelho@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-usb@vger.kernel.org, "Munegowda, Keshava" <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sameo@linux.intel.com

> From: Paul Walmsley<paul@pwsan.com>
> Date: Fri, 19 Aug 2011 16:59:56 -0600
> Subject: [PATCH] OMAP4: clock: re-enable previous clockdomain enable/=
disable
>   sequence
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> After commit 665d001338b494d6d62810aa99b4c0fa1a0884b9 ("OMAP2+: hwmod=
:
> Follow the recommended PRCM module enable sequence"), device drivers
> for OMAP IP blocks that do not use runtime PM can cause oopses or
> kernel instability[1][2].
>
> This is because those non-runtime PM drivers do not use the hwmod
> code, which implements the correct IP block enable and disable
> sequence.
>
> Several options for dealing with this problem have been proposed:
>
> 1. Add a new field to the OMAP struct clk to mark clocks that are
>     currently used by non-runtime PM drivers.  Modify the clock code =
to
>     use the old clockdomain sequence for these marked clocks.  As
>     drivers are converted to use runtime PM, remove the annotation fr=
om
>     the clocks.
>
> 2. Similar to #1, but associate the flag with the struct omap_clk
>     instead.
>
> 3. Add IDLEST wait support to the OMAP4 clock code, similar to the wa=
y
>     it is implemented for OMAP2/3, and enable it in each struct clk
>     currently used by non-runtime PM drivers.  As drivers are convert=
ed
>     to use runtime PM, remove the annotation from the clocks.
>
> 4. Do nothing; leave the problem to those responsible for the
>     unconverted drivers.
>
> 5. Re-enable clock-based clockdomain control in the OMAP4 clock code.
>     This would revert back to the behavior of Linux 3.0, simply with =
a
>     slightly longer module enable/disable latency.
>
> Unfortunately, no approach seemed particularly good.  Options 1
> through 3 seemed unwise due to the following reasons:
>
> A. The OMAP struct clks are intended primarily to describe hardware
>     clock nodes, and the intention is that no driver-specific data
>     should be stored there (applies to #1)
>
> B. The resulting patch would have been quite large for the -rc series
>     (applies to #1, #2, #3)
>
> C. The patch would have been a new, yet temporary hack; and similar f=
ixes
>     have drawn negative comments in the recent past (see for example =
[3])
>
> Option 4 is undesirable because commit
> 665d001338b494d6d62810aa99b4c0fa1a0884b9 ("OMAP2+: hwmod: Follow the
> recommended PRCM module enable sequence") has resulted in a less
> stable kernel; and kernel stability is more important than OMAP4 powe=
r
> management.
>
> Option 5 is the approach taken in this patch.  This seemed to be the
> least intrusive approach for 3.1-rc.
>
> The approach in this patch was originally proposed by Ohad Ben-Cohen
> <ohad@wizery.com>.  I'm simply writing the commit message and passing
> it along.
>
> ...
>
> Thanks to Luciano Coelho<coelho@ti.com>  for reporting the problem.
> Thanks to Ohad Ben-Cohen<ohad@wizery.com>  for tracking the problem
> down, generating a temporary workaround, and proposing a patch to dea=
l
> with the problem.  Thanks to Rajendra Nayak<rnayak@ti.com>  for
> proposing another patch to deal with the problem.  Thanks to Felipe
> Balbi<balbi@ti.com>  for comments.
>
> 1. Coelho, Luciano<coelho@ti.com>.  _Re: Oops on ehci_hcd when
>     booting 3.0.0-rc2 on panda_.  Tue, 09 Aug 2011 14:26:08 +0300.
>     Posted to the<linux-omap@vger.kernel.org>  mailing list.  Availab=
le
>     from (among others)
>     http://www.spinics.net/linux/lists/linux-omap/msg55213.html
>
> 2. Munegowda, Keshava<keshava_mgowda@ti.com>. _Re: Oops on ehci_hcd
>     when booting 3.0.0-rc2 on panda_.  Thu, 11 Aug 2011 13:51:05 +053=
0.
>     Posted to the<linux-omap@vger.kernel.org>  mailing list.  Availab=
le
>     from (among others)
>     http://www.spinics.net/linux/lists/linux-omap/msg55371.html
>
> 3. King, Russell<linux@arm.linux.org.uk>.  _Re: [PATCH 5/8] OMAP4:
>     PM: TEMP: Prevent l3init from idling/force sleep_.  Thu, 23 Jun
>     2011 16:22:49 +0100.  Posted to the<linux-omap@vger.kernel.org>
>     mailing list.  Available from (among others)
>     http://www.mail-archive.com/linux-omap@vger.kernel.org/msg51392.h=
tml
>
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> Cc: Luciano Coelho<coelho@ti.com>
> Cc: Ohad Ben-Cohen<ohad@wizery.com>
> Cc: Rajendra Nayak<rnayak@ti.com>
> Cc: Beno=EEt Cousson<b-cousson@ti.com>
> ---
Thanks for the change log.
Here is my ack if you need one.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
santosh



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
