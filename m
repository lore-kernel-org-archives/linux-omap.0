From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP: Work around hardcoded interrupts
Date: Sat, 17 Jan 2015 09:40:28 -0800
Message-ID: <20150117174028.GU18552@atomide.com>
References: <1421490068-20385-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:44211 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbbAQRoS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Jan 2015 12:44:18 -0500
Content-Disposition: inline
In-Reply-To: <1421490068-20385-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Felipe Balbi <balbi@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Yingjoe Chen <yingjoe.chen@mediatek.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Marc Zyngier <marc.zyngier@arm.com> [150117 02:24]:
> Commit 9a1091ef0017 (irqchip: gic: Support hierarchy irq domain)
> changed the GIC driver to use a non-legacy IRQ domain on DT
> platforms. This patch assumes that DT-driven systems are getting
> all of their interrupts from device tree.
> 
> Turns out that OMAP has quite a few hidden gems, and still uses
> hardcoded interrupts despite having fairly complete DTs.
> 
> This patch attempts to work around these by offering a translation
> method that can be called directly from the hwmod code, if present.
> The same hack is sprinkled over PRCM and TWL.
> 
> It isn't pretty, but it seems to do the job without having to add
> more hacks to the interrupt controller code.
> 
> Tested on OMAP4 (Panda-ES) and OMAP5 (UEVM5432).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> >From v1:
> - OMAP4 can either get the PRM interrupt from hwmod or from device tree.
>   In the latter case, remove the xlate_irq method.

OK looks good to me. Let's wait for Nishanth to run his tests
one more time.

BTW, looks like we already have the omap4 prm interrupt in the
omap4.dtsi file but removing the legacy code would add the
"old DT with newer kernel" issues to the mixture.. So best
leave that for later clean up patches and keep this fix as is.

Regards,

Tony
