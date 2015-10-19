From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] irqchip: omap-intc: fix spurious irq handling
Date: Mon, 19 Oct 2015 12:13:26 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1510191209110.4212@nanos>
References: <3d433cfeeb93366cadbb1668ebeac2e8006b0fd5.1445247844.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3d433cfeeb93366cadbb1668ebeac2e8006b0fd5.1445247844.git.nsekhar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, John Ogness <john.ogness@linutronix.de>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 19 Oct 2015, Sekhar Nori wrote:
> +	/*
> +	 * A spurious IRQ can result if interrupt that triggered the
> +	 * sorting is no longer active during the sorting (10 INTC
> +	 * functional clock cycles after interrupt assertion). Or a
> +	 * change in interrupt mask affected the result during sorting
> +	 * time. There is no special handling required except ignoring
> +	 * the SIR register value just read and retrying.
> +	 * See section 6.2.5 of AM335x TRM Literature Number: SPRUH73K
> +	 */
> +	if ((irqnr & SPURIOUSIRQ_MASK) == SPURIOUSIRQ_MASK) {
> +		pr_debug_ratelimited("%s: spurious irq!\n", __func__);

I'd prefer that this is a pr_once() and the spurious interrupt counter
is incremented. That's far more useful as it gives you real
information about the frequency of the issue.

Thanks,

	tglx
