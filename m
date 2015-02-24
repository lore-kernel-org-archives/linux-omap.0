From: santosh shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH v5 0/7] irqchip: Move OMAP{4,5}/DRA7 to use stacked domains
Date: Tue, 24 Feb 2015 13:39:37 -0800
Message-ID: <54ECEF99.6080204@oracle.com>
References: <1424713459-6824-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:21276 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbbBXVk1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2015 16:40:27 -0500
In-Reply-To: <1424713459-6824-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 2/23/2015 9:44 AM, Marc Zyngier wrote:
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
>    (it's only been tested on omap4 and omap5).
>
> - This actively *breaks* existing setups. Once you boot a new kernel
>    with an old DT, suspend/resume *will* be broken. Old kernels on a
>    new DT won't even boot! You've been warned. This really outline the
>    necessity of actually describing the HW in device trees...
>
> Based on 4.0-rc1.
>
> * From v4: [4]
> - Extracted from the full series
> - Rebased on 4.0-rc1
>
> * From v3 [3]:
> - Rebased on top of the patch working around hardcoded IRQ on OMAP4/5 [4]
> - Fixed more iMX6 DTs (Stephan)
> - Fixed Exynos4/5 DTs
>
> * From v2 [2]:
> - Addressed numerous comments from Thierry
> - Merged bug fixes from Nishanth
> - Merged bug fix from Stefan
>
> * From v1 [1]:
> - Rebased on 3.19-rc3
> - Fixed a number of additional platforms
> - Added crossbar conversion to stacked domains
> - Merged bug fixes from Nishanth
>
> [4]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/317531.html
> [3]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315385.html
> [2]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/314041.html
> [1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/307338.html
>
> Marc Zyngier (7):
>    genirq: Add irqchip_set_wake_parent
>    irqchip: crossbar: convert dra7 crossbar to stacked domains
>    DT: update ti,irq-crossbar binding
>    irqchip: GIC: get rid of routable domain
>    DT: arm,gic: kill arm,routable-irqs
>    DT: omap4/5: add binding for the wake-up generator
>    ARM: omap: convert wakeupgen to stacked domains
>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
