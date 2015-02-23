From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 0/7] irqchip: Move OMAP{4,5}/DRA7 to use stacked
 domains
Date: Mon, 23 Feb 2015 15:02:05 -0800
Message-ID: <20150223230205.GJ32521@atomide.com>
References: <1424713459-6824-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta1.delivery1.ore.mailhop.org ([54.191.214.3]:53673 "EHLO
	pmta1.delivery1.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751959AbbBWXGU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Feb 2015 18:06:20 -0500
Received: from smtp2.ore.mailhop.org (172.31.36.112) by pmta1.delivery1.ore.mailhop.org id htep6o20r84g for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2015 23:06:19 +0000 (envelope-from <tony@atomide.com>)
Content-Disposition: inline
In-Reply-To: <1424713459-6824-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Marc Zyngier <marc.zyngier@arm.com> [150223 09:48]:
> This series is extracted from [4], which is trying to remove all
> traces of gic_arch_extn from the tree. As some maintainers are more
> responsive than others (understatement of the year...), I've decided
> to split it per sub-arch, and get it moving, at least partially.
> 
> This series addresses OMAP{4,5} by converting the WUGEN to stacked
> domains. The DRA7 crossbar gets the same treatment.
> 
> It is worth realizing that:
> 
> - I haven't been able to test this as much as I would have wanted to
>   (it's only been tested on omap4 and omap5).
> 
> - This actively *breaks* existing setups. Once you boot a new kernel
>   with an old DT, suspend/resume *will* be broken. Old kernels on a
>   new DT won't even boot! You've been warned. This really outline the
>   necessity of actually describing the HW in device trees...

Could we parse still the old binding and produce warning for the
case when a new kernel is booted with the old DT? That would make
it easier for people to debug what's going on.

Regards,

Tony
