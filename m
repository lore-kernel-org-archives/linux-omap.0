From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RESEND] irqchip: omap-intc: improve IRQ handler
Date: Mon, 20 Jul 2015 22:44:08 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1507202241550.18576@nanos>
References: <1437410759-4945-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437410759-4945-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 20 Jul 2015, Felipe Balbi wrote:
> +	irqnr = intc_readl(INTC_SIR);
> +	irqnr &= ACTIVEIRQ_MASK;
> +	WARN(!irqnr, "Spurious IRQ ?\n");

Shouldn't that be WARN_ONCE?

Thanks,

	tglx
