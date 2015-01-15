From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Regression with legacy IRQ numbers caused by 9a1091ef0017
Date: Thu, 15 Jan 2015 15:27:56 +0100
Message-ID: <2776397.iNGHcrIBZz@wuerfel>
References: <20150114221407.GS2419@atomide.com> <8761c8i2hq.fsf@approximate.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:56899 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381AbbAOO2T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2015 09:28:19 -0500
In-Reply-To: <8761c8i2hq.fsf@approximate.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Marc Zyngier <marc.zyngier@arm.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Felipe Balbi <balbi@ti.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 15 January 2015 13:42:57 Marc Zyngier wrote:
> Of course, this is in no way a proper fix, but I suppose the OMAP DT is
> still missing a few bits...

I must be missing something here, but all the interrupts are listed
correctly in the DT, so what is the omap_hwmod_irq_info actually
achieving on omap4 and omap5?

Would it work if we just remove the incorrect copy of the resource
and use the one that comes from DT?

	Arnd
