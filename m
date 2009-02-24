From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH E 11/14] OMAP clock: track child clocks
Date: Tue, 24 Feb 2009 06:35:37 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162037AF5CFFF@dlee02.ent.ti.com>
References: <20090128192551.29333.82943.stgit@localhost.localdomain>
 <20090128192756.29333.41541.stgit@localhost.localdomain>
 <20090129151401.GC18233@n2100.arm.linux.org.uk>
 <20090129220608.GJ18233@n2100.arm.linux.org.uk>
 <20090219121932.GL6407@n2100.arm.linux.org.uk>
 <13B9B4C6EF24D648824FF11BE896716203772C3680@dlee02.ent.ti.com>
 <20090223160349.GB27688@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53407 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720AbZBXMg2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2009 07:36:28 -0500
In-Reply-To: <20090223160349.GB27688@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>


> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Monday, February 23, 2009 10:04 AM
> To: Woodruff, Richard

> Ack?

Ack.

> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index 08baa18..b2d9e1f 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -144,12 +144,14 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
>               return ret;
>
>       spin_lock_irqsave(&clockfw_lock, flags);
> -     if (arch_clock->clk_set_parent)
> -             ret = arch_clock->clk_set_parent(clk, parent);
> -     if (ret == 0) {
> -             if (clk->recalc)
> -                     clk->rate = clk->recalc(clk);
> -             propagate_rate(clk);
> +     if (clk->usecount == 0) {
> +             if (arch_clock->clk_set_parent)
> +                     ret = arch_clock->clk_set_parent(clk, parent);
> +             if (ret == 0) {
> +                     if (clk->recalc)
> +                             clk->rate = clk->recalc(clk);
> +                     propagate_rate(clk);
> +             }
>       }
>       spin_unlock_irqrestore(&clockfw_lock, flags);
>

