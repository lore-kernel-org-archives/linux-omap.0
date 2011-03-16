From: Tony Lindgren <tony@atomide.com>
Subject: Re: Code for v2.6.39 merge window frozen, patches archived
Date: Wed, 16 Mar 2011 08:32:23 -0700
Message-ID: <20110316153223.GQ7258@atomide.com>
References: <20110314192538.GH7258@atomide.com>
 <alpine.DEB.1.10.1103151856180.880@esdhcp041196.research.nokia.com>
 <4D7FC70D.7050508@ti.com>
 <alpine.DEB.1.10.1103161533470.2634@esdhcp041196.research.nokia.com>
 <4D80CA2F.8060300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29822 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab1CPPcx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Mar 2011 11:32:53 -0400
Content-Disposition: inline
In-Reply-To: <4D80CA2F.8060300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

* Cousson, Benoit <b-cousson@ti.com> [110316 07:31]:
> Hi Aaro,
> 
> On 3/16/2011 2:49 PM, Aaro Koskinen wrote:
> >Hi,
> >
> >On Tue, 15 Mar 2011, Cousson, Benoit wrote:
> >>Mmm, that looks like an access to a secure timer from hwmod code on a HS
> >>device. Could you comment out the timer12 entry (&omap3xxx_timer12_hwmod) in
> >>the omap3 hwmod list at the end of omap_hwmod_3xxx_data.c to check that?
> >
> >With timer12 entry commented out and omap_hwmod debugs enabled, it now
> >hangs here:
> 
> Do you need that timer BTW?
> 
> >
> >[...]
> >
> >[    4.306549] OMAP GPIO hardware version 2.5
> >[    4.310913] omap_hwmod: gpio4: enabling
> >[    4.314971] omap_hwmod: gpio4: enabling clocks
> >[    4.320037] OMAP GPIO hardware version 2.5
> >[    4.324401] omap_hwmod: gpio5: enabling
> >[    4.328460] omap_hwmod: gpio5: enabling clocks
> >[    4.333526] OMAP GPIO hardware version 2.5
> >[    4.337921] omap_hwmod: gpio6: enabling
> >[    4.341949] omap_hwmod: gpio6: enabling clocks
> >[    4.347015] OMAP GPIO hardware version 2.5
> 
> GPIO are now initialized during postcore_initcall, so it is hard to
> know what will happen after that:-(
> 
> Could you try with initcall_debug in your command line?

FYI, my rx51 boots fine with omap2plus defconfig, also with
earlyprintk. Sounds like it's some HS omap issue on both
your boards.

I think you have ttyO in your CONFIG_CMDLINE if you're
using omap2plus_defconfig. Then for rm680 you'll probably
need also:

CONFIG_CMDLINE_FORCE=y

Regards,

Tony
