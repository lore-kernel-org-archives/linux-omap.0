From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 02/21] irqchip: tegra: add DT-based support for legacy
 interrupt controller
Date: Sat, 10 Jan 2015 12:28:32 +0000
Message-ID: <180a27ca37ef60b557aa1c18d7e251b1@www.loen.fr>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-3-git-send-email-marc.zyngier@arm.com>
 <20150108150608.GA24654@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150108150608.GA24654@kahuna>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Alexandre Courbot <gnurou@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Benoit Cousson <bcousson@baylibre.com>, Stephen Warren <swarren@wwwdotorg.org>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, linux-samsung-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Santosh Shilimkar <ssantosh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>
List-Id: linux-omap@vger.kernel.org

On 2015-01-08 15:06, Nishanth Menon wrote:
> On 17:42-20150107, Marc Zyngier wrote:
>> Tegra's LIC (Legacy Interrupt Controller) has been so far only
>> supported as a weird extension of the GIC, which is not exactly
>> pretty.
>>
>> The stacked irq domain framework fits this pretty well, and allows
>> the LIC code to be turned into a standalone irqchip. In the process,
>> make the driver DT aware, something that was sorely missing from
>> the mach-tegra implementation.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>
> Saw a few checkpatch warnings as below: all of them seem minors.
>
> @@ -0,0 +1,35 @@
> +WARNING: added, moved or deleted file(s), does MAINTAINERS need 
> updating?

I'll leave to the Tegra maintainers to update this file it they want 
to.

> +#36:
> +new file mode 100644
> +WARNING: line over 80 characters
> +#169: FILE: drivers/irqchip/irq-tegra.c:129:
> ++		tegra_ictlr_info->cpu_ier[i] = readl_relaxed(ictlr + 
> ICTLR_CPU_IER);

As a matter of principle, I ignore what checkpatch says about the 
length of lines of code. I trust my eyes more than the tool.

[...]

> +WARNING: Missing a blank line after declarations
> +#196: FILE: drivers/irqchip/irq-tegra.c:156:
> ++		void __iomem *ictlr = tegra_ictlr_info->ictlr_reg_base[i];
> ++		writel_relaxed(tegra_ictlr_info->cpu_iep[i],

Done.

> +WARNING: line over 80 characters
> +#284: FILE: drivers/irqchip/irq-tegra.c:244:
> ++	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, 
> &parent_args);
> +CHECK: Please don't use multiple blank lines
> +#287: FILE: drivers/irqchip/irq-tegra.c:247:
> ++
> ++
> +WARNING: Missing a blank line after declarations
> +#296: FILE: drivers/irqchip/irq-tegra.c:256:
> ++		struct irq_data *d = irq_domain_get_irq_data(domain, virq + i);
> ++		irq_domain_reset_irq_data(d);
> `

Thanks,

         M.
-- 
Fast, cheap, reliable. Pick two.
