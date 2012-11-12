From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
Date: Mon, 12 Nov 2012 06:42:46 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB70EAA@DBDE01.ent.ti.com>
References: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il>
 <509AD478.1050904@ti.com> <509B666F.6080507@compulab.co.il>
 <509BDAF5.1010703@ti.com>
 <79CD15C6BA57404B839C016229A409A83EB68589@DBDE01.ent.ti.com>
 <509BEE6D.9000902@ti.com>
 <79CD15C6BA57404B839C016229A409A83EB68654@DBDE01.ent.ti.com>
 <509BF2DD.2090308@ti.com>
 <79CD15C6BA57404B839C016229A409A83EB686AC@DBDE01.ent.ti.com>
 <509C5495.1010109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56046 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854Ab2KLGmy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Nov 2012 01:42:54 -0500
In-Reply-To: <509C5495.1010109@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On Fri, Nov 09, 2012 at 06:25:49, Hunter, Jon wrote:
> 
> On 11/08/2012 12:06 PM, Hiremath, Vaibhav wrote:
> > On Thu, Nov 08, 2012 at 23:28:53, Hunter, Jon wrote:
> >>
> >> On 11/08/2012 11:47 AM, Hiremath, Vaibhav wrote:
> >>> On Thu, Nov 08, 2012 at 23:09:57, Hunter, Jon wrote:
> >>
> >> [snip]
> >>
> >>>> I think you are missing the point here. For OMAP devices we have two
> >>>> main external clock sources which are the 32kHz clock and the sys_clk
> >>>> (can be a range of frequencies from 12-38.4MHz for OMAP4). The point is
> >>>> for OMAP these clock sources are always present and AFAIK there is no
> >>>> h/w configuration that allows you not to have the 32kHz clock source.
> >>>> PRCM needs it and I think for OMAP1 the reset logic needs it (if memory
> >>>> serves).
> >>>>
> >>>> Igor was mentioning a h/w scenario where the 32kHz source is not
> >>>> present. However, I am not sure which devices support this and is
> >>>> applicable too.
> >>>>
> >>>> So we are not discussing the 32k-sync-timer here. We are discussing
> >>>> whether there are any device configurations where a 32k clock source
> >>>> would not be available for the gptimer.
> >>>>
> >>>
> >>> Exactly that is the point I am trying to make here,
> >>>
> >>> In case of AM33xx, it is certainly possible to build the system without 
> >>> this 32Khz clock. 
> >>>
> >>> Interesting point here is, this 32KHz clock is external clock coming from 
> >>> crystal connected to in-built RTC module.
> >>
> >> Thanks. Looking at the AM3358 data manual it states ...
> >>
> >> "The OSC1 oscillator provides a 32.768-kHz reference clock to the
> >> real-time clock (RTC) and is connected to the RTC_XTALIN and RTC_XTALOUT
> >> terminals. OSC1 is disabled by default after power is applied. This
> >> clock input is optional and may not be required if the RTC is configured
> >> to receive a clock from the internal 32k RC oscillator (CLK_RC32K) or
> >> peripheral PLL (CLK_32KHZ) which receives a reference clock from the
> >> OSC0 input."
> >>
> >> So what is clear to me that an external 32k clock source is optional.
> >> However, it still appears that you will always have an internal 32k
> >> source and so regardless of the h/w configuration, a gptimer will always
> >> have an 32k clock available on the AM335x devices. Is that correct?
> >>
> > 
> > Internal RC oscillator is not accurate at all, so not guaranteed to give 
> > accurate 32.768Hz clock. The oscillation band is from 16Khz to 64Khz.
> > 
> > So it may not be useful as a system clocks, right?
> 
> By the way, according to the AM3358 data manual (paragraph above), even
> if there is no external 32k clock source and if you don't use the
> internal 32k oscillator, you can still generate a 32k clock from the PER
> PLL (CLK_32KHZ). So therefore, there should always be a 32k clock source
> available for the gptimer. Is that correct?

Yes that's correct, but it is from PER domain, so duging suspend time, it 
will be disabled. This can not be treated as a persistent clock.


> 
> At the end of the day, I am just trying to understand if any OMAP/AM
> device supports a h/w configuration where there is no 32k clock source
> available for the gptimer.
> 

I know and completely understand. We need to come up with solution which 
works on all platforms.

Thanks,
Vaibhav
