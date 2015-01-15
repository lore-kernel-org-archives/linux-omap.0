From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: Regression with legacy IRQ numbers caused by 9a1091ef0017
Date: Thu, 15 Jan 2015 14:43:35 +0000
Message-ID: <87wq4ogl48.fsf@approximate.cambridge.arm.com>
References: <20150114221407.GS2419@atomide.com>
	<8761c8i2hq.fsf@approximate.cambridge.arm.com>
	<2776397.iNGHcrIBZz@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:34791 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbbAOOnu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2015 09:43:50 -0500
In-Reply-To: <2776397.iNGHcrIBZz@wuerfel> (Arnd Bergmann's message of "Thu, 15
	Jan 2015 14:27:56 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Felipe Balbi <balbi@ti.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Jan 15 2015 at  2:27:56 pm GMT, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 15 January 2015 13:42:57 Marc Zyngier wrote:
>> Of course, this is in no way a proper fix, but I suppose the OMAP DT is
>> still missing a few bits...
>
> I must be missing something here, but all the interrupts are listed
> correctly in the DT, so what is the omap_hwmod_irq_info actually
> achieving on omap4 and omap5?
>
> Would it work if we just remove the incorrect copy of the resource
> and use the one that comes from DT?

By the look of it, omap_hwmod_irq_info serves multiple purposes:
- low level configuration (pads, probably more stuff)
- interrupt description for some drivers, using resources.

It should be fairly easy to do the latter, but the former looks more
tricky (it would push the pad configuration down to the drivers, which
is avoided at the moment).

Probably there is a workable strategy, but my knowledge about OMAP is
close to *nothing*...

	M.
-- 
Jazz is not dead. It just smells funny.
