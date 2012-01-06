From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH] irqdomain: Initialize number of IRQs for simple domains
Date: Fri, 6 Jan 2012 08:07:44 -0800
Message-ID: <20120106160744.GA7687@codeaurora.org>
References: <1325860112-22051-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1325860112-22051-1-git-send-email-thierry.reding@avionic-design.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Grant Likely <grant.likely@secretlab.ca>, Daniel Walker <dwalker@fifo99.com>, Jamie Iles <jamie@jamieiles.com>, Russell King <linux@arm.linux.org.uk>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "open list:ARM/QUALCOMM MSM..." <linux-arm-msm@vger.kernel.org>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Barry Song <baohua.song@csr.com>, Thomas Gleixner <tglx@linutronix.de>, "open list:OMAP SUPPORT" <linux-omap@vger.kernel.org>, Andrew Victor <linux@maxim.org.za>, "open list:ARM/ATMEL AT91RM9..." <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, Bryan Huntsman <bryanh@codeaurora.org>, Richard Zhao <richard.zhao>
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 06, 2012 at 03:28:25PM +0100, Thierry Reding wrote:
> diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
> index 0a11342..a50c7e2 100644
> --- a/arch/arm/mach-msm/board-msm8x60.c
> +++ b/arch/arm/mach-msm/board-msm8x60.c
> @@ -84,8 +84,11 @@ static void __init msm8x60_dt_init(void)
>  
>  	node = of_find_matching_node_by_address(NULL, msm_dt_gic_match,
>  			MSM8X60_QGIC_DIST_PHYS);
> -	if (node)
> -		irq_domain_add_simple(node, GIC_SPI_START);
> +	if (node) {
> +		struct irq_domain *domain = irq_domain_add_simple(node,
> +				GIC_SPI_START, NR_MSM_IRQS);
> +		WARN_ON(IS_ERR(domain));
> +	}
>  
>  	if (of_machine_is_compatible("qcom,msm8660-surf")) {
>  		printk(KERN_INFO "Init surf UART registers\n");

This is probably a consequence of MSM not really being "simple", but
just using that.  However, NR_MSM_IRQS is only the number of IRQs on
the MSM core.  There are also GPIO irqs, and potentially board IRQs
(the board has an I2C-based chip with a bunch of IRQ lines on it).

The only define that captures this now is 'NR_IRQS', even though we're
trying to get rid of that.

Ultimately, the correct answer will be to get the various interrupt
controllers using their own domains, but for now, this needs to be a
larger value to avoid missing a bunch of the interrupts.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
