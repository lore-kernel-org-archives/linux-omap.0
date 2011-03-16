From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: Code for v2.6.39 merge window frozen, patches archived
Date: Wed, 16 Mar 2011 15:49:12 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1103161533470.2634@esdhcp041196.research.nokia.com>
References: <20110314192538.GH7258@atomide.com> <alpine.DEB.1.10.1103151856180.880@esdhcp041196.research.nokia.com> <4D7FC70D.7050508@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:20365 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870Ab1CPNv1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Mar 2011 09:51:27 -0400
In-Reply-To: <4D7FC70D.7050508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Hi,

On Tue, 15 Mar 2011, Cousson, Benoit wrote:
> Mmm, that looks like an access to a secure timer from hwmod code on a HS 
> device. Could you comment out the timer12 entry (&omap3xxx_timer12_hwmod) in 
> the omap3 hwmod list at the end of omap_hwmod_3xxx_data.c to check that?

With timer12 entry commented out and omap_hwmod debugs enabled, it now
hangs here:

[...]

[    4.306549] OMAP GPIO hardware version 2.5
[    4.310913] omap_hwmod: gpio4: enabling
[    4.314971] omap_hwmod: gpio4: enabling clocks
[    4.320037] OMAP GPIO hardware version 2.5
[    4.324401] omap_hwmod: gpio5: enabling
[    4.328460] omap_hwmod: gpio5: enabling clocks
[    4.333526] OMAP GPIO hardware version 2.5
[    4.337921] omap_hwmod: gpio6: enabling
[    4.341949] omap_hwmod: gpio6: enabling clocks
[    4.347015] OMAP GPIO hardware version 2.5

then nothing. Also, with RX-51 the boot breaks (or at least the serial
console) when earlyprintk is enabled. The last thing seen is:

[    0.996124] omap_hwmod: mmc1: enabling
[    1.000122] omap_hwmod: mmc1: enabling clocks
[    1.004760] omap_hwmod: mmc1: resetting
[    1.008850] omap_hwmod: mmc1: resetting via OCP SOFTRESET
[    1.014526] omap_hwmod: mmc1: softreset in 0 usec
[    1.019500] omap_hwmod: mmc1: idling
[    1.023315] omap_hwmod: mmc1: disabling clocks

I can see that mmc is followed by uart enable, so it seems that won't
work well with earlyprintk enabled.

A.
