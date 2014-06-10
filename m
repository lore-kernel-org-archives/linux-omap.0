From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] irqchip: gic: always mask interrupts during suspend
Date: Wed, 11 Jun 2014 01:34:39 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1406110129270.5170@nanos>
References: <1402442098-21093-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55983 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbaFJXes (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jun 2014 19:34:48 -0400
In-Reply-To: <1402442098-21093-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Jason Cooper <jason@lakedaemon.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org

On Tue, 10 Jun 2014, Brian Norris wrote:
> Other random thought: it seems like any irqchip driver which does lazy IRQ
> masking ought to use IRQCHIP_MASK_ON_SUSPEND. So maybe the IRQ core should just
> do something like:
> 
> 	if (!chip->irq_disable)
> 		chip->flags |= IRQCHIP_MASK_ON_SUSPEND;

No. Lazy irq disable and the suspend logic are different beasts.

That's up to the platform to decide this. Just for the record: there
is a world outside of ARM...

But that brings me to a different question:

    Why are you not putting that customization into the device tree
    instead of trying to add this to some random arch/arm/mach-foo
    files?

Thanks,

	tglx
