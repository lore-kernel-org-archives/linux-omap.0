From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Thu, 21 Aug 2008 07:34:56 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620364E2B470@dlee02.ent.ti.com>
References: <20080819062422.GD17276@atomide.com>
	<20080820.131042.200608197.Hiroshi.DOYU@nokia.com>
	<13B9B4C6EF24D648824FF11BE896716203621E71D9@dlee02.ent.ti.com>
 <20080821.104149.169747270.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:37631 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbYHUMfJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2008 08:35:09 -0400
In-Reply-To: <20080821.104149.169747270.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "soni.trilok@gmail.com" <soni.trilok@gmail.com>, "Pasam, Vijay" <vpasam@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "siarhei.siamashka@nokia.com" <siarhei.siamashka@nokia.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>


> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
...
> > A few quick comments:
> >
> > - First off, I do like the idea of virtual clocks for grouping.  I
> > did do this for OMAP2 for completely internal and dependent root
> > clocks.  I also thought it might be nice to extend clock frame work
> > to allow external clock registration (say for a codec chip).  In our
> > local tree I did even add it.  One main issue was the internal clock
> > structure is supposed to be opaque and you need to set internals to
> > add a clock node.
>
> Can I find your OMAP2 implementation in omapzoom for virtual clock?

Guess not.  The flag for OMAP2 is still there in linux-omap clock.h for virt_prcm_set but the implementation of it evolved to just using custom recalc/rate/round functions.  Today the flag just would tell a user something is funny about the clock but no rules are enforced.

Actually in looking at this does bring up another very relevant question.

For a combined clock especially like the IVA-system, how do you do set_rate/round_rate/get_rate/set_parent so it is meaningful?

For virt_prcm_set the MPU clock rate is used as in index.  For OMAP2 for most cases there are very strict rules about speed ratio's. As such if you know the speed for 1 clock you can set the group.  mpu_rate isn't perfect but it is good enough.

You need operations for more than enable/disable.

How do you set parent to your timer in your example?  How do you query individual other clocks rate?

If you need to do actions on individuals in the group you still need to grab handles for all of them.  This puts you back where you started before exploring the idea.

Regards,
Richard W.

