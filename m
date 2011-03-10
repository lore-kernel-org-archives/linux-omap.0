From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Nokia n810 LCD (MIPID/blizzard) on 2.6.38
Date: Wed, 9 Mar 2011 18:18:56 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103091807050.15132@utopia.booyaka.com>
References: <1298925943.16391.19.camel@marge>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60139 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab1CJBS6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 20:18:58 -0500
In-Reply-To: <1298925943.16391.19.camel@marge>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: linux-omap <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Varadarajan Charulatha <charu@ti.com>

Greetings Michael,

On Mon, 28 Feb 2011, Michael Buesch wrote:

> The n810 LCD does not work on the 2.6.38(-rc6) kernel
> due to changes in the OMAP GPIO-hwmod code.
> 
> The hwmod code performs a soft-reset on the GPIO
> module. The first GPIO module carries the MIPID
> "nreset" line, which is toggled due to the hwmod soft reset.
> This resets Blizzard and breaks it, because
> it assumes the LCD was left in the state that the
> bootloader initialized it to:

...

> My temporary workaround to this issue is to disable
> soft reset for the first GPIO module:

...

> I'm wondering if a better fix suitable for the mainline
> kernel inclusion could be found.
> Any ideas?

Perhaps this patch will do:

   http://marc.info/?l=linux-omap&m=129971920806386&w=2

Afterwards, it should be possible to look up the GPIO1 hwmod in 
mach-omap2/board-n8x0.c after the call to 
omap2_init_common_infrastructure(), and then to call 
omap_hwmod_no_setup_reset() on it.  Perhaps you might wish to try it?

...

Thanks for maintaining your N810 pages, they have proven quite useful over 
the years,

MfG,

- Paul
