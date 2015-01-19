From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP: Work around hardcoded interrupts
Date: Mon, 19 Jan 2015 12:12:54 -0800
Message-ID: <20150119201253.GF18552@atomide.com>
References: <1421490068-20385-1-git-send-email-marc.zyngier@arm.com>
 <20150119201404.GA18738@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33145 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751517AbbASURH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2015 15:17:07 -0500
Content-Disposition: inline
In-Reply-To: <20150119201404.GA18738@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Benoit Cousson <bcousson@baylibre.com>, Santosh Shilimkar <ssantosh@kernel.org>, Felipe Balbi <balbi@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Yingjoe Chen <yingjoe.chen@mediatek.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [150119 12:17]:
> On 10:21-20150117, Marc Zyngier wrote:
> > Commit 9a1091ef0017 (irqchip: gic: Support hierarchy irq domain)
> should have been
> Commit 9a1091ef0017 ("irqchip: gic: Support hierarchy irq domain")
> 
> > changed the GIC driver to use a non-legacy IRQ domain on DT
> > platforms. This patch assumes that DT-driven systems are getting
> > all of their interrupts from device tree.
> > 
> > Turns out that OMAP has quite a few hidden gems, and still uses
> > hardcoded interrupts despite having fairly complete DTs.
> > 
> > This patch attempts to work around these by offering a translation
> > method that can be called directly from the hwmod code, if present.
> > The same hack is sprinkled over PRCM and TWL.
> > 
> > It isn't pretty, but it seems to do the job without having to add
> > more hacks to the interrupt controller code.
> > 
> > Tested on OMAP4 (Panda-ES) and OMAP5 (UEVM5432).
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Other than that, This looks good to me.
> Acked-by: Nishanth Menon <nm@ti.com>

OK thanks applying into omap-for-v3.19/fixes and will send out a
pull request later on today after some make randconfig builds.

Regards,

Tony
