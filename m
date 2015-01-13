From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 14/21] ARM: imx6: convert GPC to stacked domains
Date: Tue, 13 Jan 2015 07:09:20 +0100
Message-ID: <CACRpkdYHnBtP39xpEkjdibpijGip0Y3+YLvEA8KUGfentKbZ9A@mail.gmail.com>
References: <1421087187-26988-1-git-send-email-marc.zyngier@arm.com>
	<1421087187-26988-15-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1421087187-26988-15-git-send-email-marc.zyngier@arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Stefan Agner <stefan@agner.ch>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 12, 2015 at 7:26 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:

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

(...)

> +static int imx_gpc_domain_alloc(struct irq_domain *domain,
> +                                 unsigned int virq,

Nutcase nitpick on this nice patch series: every time I see "virq" my
OCD triggers, as I think the "v" in "virq" stand for virtual. These irqs
are no more virtual than any other Linux irq numbers, hwirq is
more to the point.

I just refer to these as "irq" (sans "v") in any code I write.

Yours,
Linus Walleij
