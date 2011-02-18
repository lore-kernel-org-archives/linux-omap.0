From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH 00/11] OMAP2+: clock: add clockfw autoidle for iclks, OMAP2xxx
Date: Fri, 18 Feb 2011 11:05:47 +0530
Message-ID: <cf17c43dfb21a50236058918ae984a65@mail.gmail.com>
References: <20110216065030.22089.61217.stgit@twilight.localdomain>
 <43af56d25809fa616f0e17d7e641ebc0@mail.gmail.com> <alpine.DEB.2.00.1102161551400.29817@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:54808 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750841Ab1BRFfu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 00:35:50 -0500
Received: by mail-fx0-f45.google.com with SMTP id 12so3627560fxm.18
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 21:35:48 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1102161551400.29817@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Thursday, February 17, 2011 4:35 AM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH 00/11] OMAP2+: clock: add clockfw autoidle for
iclks, OMAP2xxx
>
> On Wed, 16 Feb 2011, Rajendra Nayak wrote:
>
> > Boot-tested on 3430sdp/4430sdp, with CONFIG_PM and with !CONFIG_PM.
> > suspend-offmode tested on 3430sdp and suspend-retmode on 4430sdp (with
> > some out-of-tree patches)
>
> Thanks, will add Tested-by:s.
>
> > Dynamic idle testing on 3430sdp showed me some very jerky debug
console
> > the moment a 'echo 1 > /debug/pm_debug/sleep_while_idle' is done. This
> > however seems to be the case even on 2.6.38-rc4 and not related to the
> > current patch series.
>
> Does enabling CONFIG_OMAP2_DSS resolve the problem you're seeing?

Maybe, will try it out. Thanks for the tip.

>
> > Will debug further, but seems to some 3430sdp specific issue, since
you
> > did not see it on Beagleboard and seems it is not seen on OMAP3 zoom's
> > either. Just out of curiosity, what dynamic-idle state where you able
to
> > achieve on Beagle?
>
> Full chip off.  I use omap2plus_defconfig, sometimes with
CONFIG_OMAP2_DSS
> depending on personal mood and what's being tested.  I boot to a shell
and
> run the commands at the end of this message (some of which are probably
> superfluous).

Ok, thanks.

>
>
> - Paul
>
>
> echo 1 > /debug/pm_debug/sleep_while_idle
> echo 1 > /debug/pm_debug/enable_off_mode
> echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout
> echo enabled >
/sys/devices/platform/omap/omap_uart.0/tty/ttyO0/power/wakeup
> echo enabled >
/sys/devices/platform/omap/omap_uart.1/tty/ttyO1/power/wakeup
> echo enabled >
/sys/devices/platform/omap/omap_uart.2/tty/ttyO2/power/wakeup
>
