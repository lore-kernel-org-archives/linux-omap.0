From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Thu, 21 Aug 2008 14:43:34 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620364E2BAEC@dlee02.ent.ti.com>
References: <13B9B4C6EF24D648824FF11BE896716203621E71D9@dlee02.ent.ti.com>
	<20080821.104149.169747270.Hiroshi.DOYU@nokia.com>
	<13B9B4C6EF24D648824FF11BE89671620364E2B470@dlee02.ent.ti.com>
 <20080821.191137.256717219.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47013 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbYHUTuS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2008 15:50:18 -0400
In-Reply-To: <20080821.191137.256717219.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "soni.trilok@gmail.com" <soni.trilok@gmail.com>, "Pasam, Vijay" <vpasam@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "siarhei.siamashka@nokia.com" <siarhei.siamashka@nokia.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

Hi Hiroshi,

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]

<snip>

> I think that, in this virtual clock, frequency changing will be done
> in the totally different path(just in a normal clock tree). This
> virtual clock resides in an independent clock tree and supposed to be
> used aggressively just to turn on/off clocks(enable/disable), which
> drivers use, for saving power consumption. So the relationship between
> "clk" and "vclk" may be similar to "struct device" and "struct class"
> in the linux driver-model, which means that, the former is based on
> H/W connection and the latter is based on functionality. Of course
> there is a possibility that other clk methods can be overwritten, but
> it's has to be used for different purpose than a normal clock does,
> not to break the H/W clock tree consistency.

Ok. I 'think' I better understand your idea.  Thanks for the description.

To me it seems like it could be slightly confusing to maintain 2 clock structures.  One for v and one for p.  In the end it is probably not very hard to lean.

It would reduce some amount of code in the more complex subsystems/drivers resulting in a cleaner driver.

The interface used in drivers with the clock frame work is pretty simple so it might seem more about clean up then reducing complexity in the driver.

Do you feel a lot of drivers will benefit or it will expand to auto handle resources better?  If it is just 1 or 2 drivers then it might be the new code in clock framework and platform will add some complexity which is higher than what was removed from the driver.  If lots of drivers use it then it would be positive.

<snip>

> Probably original "virt_prcm_set" might have a wider solution,
> though....

No not really.  It just provided a way to group dependent clocks.  These clocks were so tightly coupled it was better to treat them as one.

It does have some nice properties for OMAP2 which can be exploited.  For instance the underlying pclock speeds in a vclock set are fixed by ratio.  So doing a clock set on the vclock will allow switching between one of the supported ratio sets.  Doing a clock set on the pclock(dpll) will allow you to change the base speed which the ratio is applied.

Regards,
Richard W.

