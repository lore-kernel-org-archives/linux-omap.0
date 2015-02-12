From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] irqchip: gic: Don't complain in gic_get_cpumask() if UP
 system
Date: Wed, 11 Feb 2015 21:51:50 -0600
Message-ID: <20150212035150.GB29500@kahuna>
References: <1422665010-5854-1-git-send-email-sboyd@codeaurora.org>
 <20150131070939.GA4068@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150131070939.GA4068@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>, Stefan Agner <stefan@agner.ch>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On 01:09-20150131, Felipe Balbi wrote:
> +linux-omap
> 
> On Fri, Jan 30, 2015 at 04:43:30PM -0800, Stephen Boyd wrote:
> > In a uniprocessor implementation the interrupt processor targets
> > registers are read-as-zero/write-ignored (RAZ/WI). Unfortunately
> > gic_get_cpumask() will print a critical message saying
> > 
> >  GIC CPU mask not found - kernel will fail to boot.
> > 
> > if these registers all read as zero, but there won't actually be
> > a problem on uniprocessor systems and the kernel will boot just
> > fine. Skip this check if we're running a UP kernel or if we
> > detect that the hardware only supports a single processor.
> > 
> 
> Nice, I'll test this on AM437x on Monday but certainly looks promising:
> 
> Acked-by: Felipe Balbi <balbi@ti.com>
> 
> 
> > Acked-by: Nicolas Pitre <nico@linaro.org>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > Cc: Stefan Agner <stefan@agner.ch>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  drivers/irqchip/irq-gic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> > index d617ee5a3d8a..1b70e0de0f6e 100644
> > --- a/drivers/irqchip/irq-gic.c
> > +++ b/drivers/irqchip/irq-gic.c
> > @@ -346,7 +346,7 @@ static u8 gic_get_cpumask(struct gic_chip_data *gic)
> >  			break;
> >  	}
> >  
> > -	if (!mask)
> > +	if (!mask && num_possible_cpus() > 1)
> >  		pr_crit("GIC CPU mask not found - kernel will fail to boot.\n");
> >  
> >  	return mask;
> > -- 
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > a Linux Foundation Collaborative Project
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -- 
> balbi

Acked-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
