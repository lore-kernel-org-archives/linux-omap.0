From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/35] arm: omap: move intc to drivers/irqchip/
Date: Mon, 15 Sep 2014 08:31:46 -0700
Message-ID: <20140915153145.GC2762@atomide.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
 <20140914051858.GF21986@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59740 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752717AbaIOPcE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Sep 2014 11:32:04 -0400
Content-Disposition: inline
In-Reply-To: <20140914051858.GF21986@titan.lakedaemon.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, bcousson@baylibre.com, linux@arm.linux.org.uk, khilman@deeprootsystems.com, tglx@linutronix.de, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

* Jason Cooper <jason@lakedaemon.net> [140913 22:19]:
> On Mon, Jul 28, 2014 at 04:15:48PM -0500, Felipe Balbi wrote:
> 
> For patches 32-35, please fix the subject line to:
> 
>   irqchip: omap-intc: C...
> 
> With that changed, patches 30-35 are:
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>

Great, thanks Jason for looking through them.

Felipe, can you please repost the missing patches with Jason's
changes and leaving out patch 30/35 to avoid board-*.c file
churn?

The branch to use for rebasing is omap-for-v3.18/intc-v2
that already contains the arch/arm/mach-omap2 related changes.

Regards,

Tony
