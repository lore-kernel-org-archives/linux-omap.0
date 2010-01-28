From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/5] gic: prevent gic from crossing NR_IRQ
Date: Thu, 28 Jan 2010 13:19:07 +0000
Message-ID: <1264684747.7064.61.camel@pc1117.cambridge.arm.com>
References: <20100127224309.GD29665@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755867Ab0A1NTN@vger.kernel.org>
In-Reply-To: <20100127224309.GD29665@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: adharmap@codeaurora.org, linux-arm-kernel@lists.infradead.org, Ingo Molnar <mingo@elte.hu>, Yinghai Lu <yinghai@kernel.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Kalle Valo <kalle.valo@iki.fi>, Jean Pihet <jpihet@mvista.com>, Linus Walleij <linus.walleij@stericsson.com>, Colin Tuckley <colin.tuckley@arm.com>, Philby John <pjohn@in.mvista.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Alessandro Rubini <rubini@unipv.it>, Andrea Gallo <andrea.gallo@stericsson.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Abhijeet Dharmapurikar <adharmap@quicinc.com>
List-Id: linux-omap@vger.kernel.org

On Wed, 2010-01-27 at 22:43 +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 27, 2010 at 11:32:25AM -0800, adharmap@codeaurora.org wrote:
> > From: Abhijeet Dharmapurikar <adharmap@quicinc.com>
> >
> > The gic code tries to initialize interrupts beyond NR_IRQ. Prevent
> > code from doing that.
> 
> NAK.  This is completely the wrong approach.
> 
>         /*
>          * Find out how many interrupts are supported.
>          */
>         max_irq = readl(base + GIC_DIST_CTR) & 0x1f;
>         max_irq = (max_irq + 1) * 32;
> 
>         /*
>          * The GIC only supports up to 1020 interrupt sources.
>          * Limit this to either the architected maximum, or the
>          * platform maximum.
>          */
>         if (max_irq > max(1020, NR_IRQS))
>                 max_irq = max(1020, NR_IRQS);
> ...
>         for (i = irq_start; i < gic_data[gic_nr].irq_offset + max_irq; i++) {
> 
> This function is broken if irq_start != 0, and needs fixing - max_irq
> needs to be limited to the _minimum_ of 1020 or NR_IRQS - irq_start.

Actually I think in this case max_irq should be left to whatever the
hardware reads (but not more than 1020) since further down in this
function we configure the IRQs for the GIC and we also want to disable
those beyond NR_IRQS.

The "for" loop for set_irq_chip() should go to the minimum of max_irqs
and NR_IRQS.

-- 
Catalin
