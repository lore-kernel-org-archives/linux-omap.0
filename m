From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4 14/21] ARM: imx6: convert GPC to stacked domains
Date: Tue, 20 Jan 2015 19:19:01 +0800
Message-ID: <20150120111900.GB2766@dragon>
References: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
 <1421660655-21394-15-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:53565 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451AbbATLTy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2015 06:19:54 -0500
Received: by mail-pa0-f54.google.com with SMTP id eu11so10712468pac.13
        for <linux-omap@vger.kernel.org>; Tue, 20 Jan 2015 03:19:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1421660655-21394-15-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Stefan Agner <stefan@agner.ch>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

On Mon, Jan 19, 2015 at 09:44:08AM +0000, Marc Zyngier wrote:
> IMX6 has been (ab)using the gic_arch_extn to provide
> wakeup from suspend, and it makes a lot of sense to convert
> this code to use stacked domains instead.
> 
> This patch does just this, updating the DT files to actually
> reflect what the HW provides.
> 
> BIG FAT WARNING: because the DTs were so far lying by not
> exposing the fact that the GPC block is actually the first
> interrupt controller in the chain, kernels with this patch
> applied wont have any suspend-resume facility when booted
> with old DTs, and old kernels with updated DTs won't even boot.
> 
> Tested-by: Stefan Agner <stefan@agner.ch>
> Acked-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
