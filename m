From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] irqdomain: Initialize number of IRQs for simple domains
Date: Sat, 7 Jan 2012 13:58:20 +0800
Message-ID: <20120107055817.GG4790@S2101-09.ap.freescale.net>
References: <1325860112-22051-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1325860112-22051-1-git-send-email-thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Daniel Walker <dwalker-zu3NM2574RrQT0dZR+AlfA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "open list:ARM/QUALCOMM MSM..." <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "open list:OMAP SUPPORT" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Victor <linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org>, "open list:ARM/ATMEL AT91RM9..." <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Thierry,

On Fri, Jan 06, 2012 at 03:28:25PM +0100, Thierry Reding wrote:
> The irq_domain_add() function needs the number of interrupts in the
> domain to properly initialize them. In addition the allocated domain
> is now returned by the irq_domain_{add,generate}_simple() helpers.
> 
> Signed-off-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
> ---
...
>  arch/arm/mach-imx/imx51-dt.c          |   13 +++++++++++--
>  arch/arm/mach-imx/imx53-dt.c          |   13 +++++++++++--
>  arch/arm/mach-imx/mach-imx6q.c        |    4 +++-
...
>  arch/arm/plat-mxc/include/mach/irqs.h |    1 +
>  arch/arm/plat-mxc/tzic.c              |    2 --

Thanks for patching imx.  It looks good to me, except a couple minor
comments below.

...

> diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
> index e6bad17..72bf94c 100644
> --- a/arch/arm/mach-imx/imx51-dt.c
> +++ b/arch/arm/mach-imx/imx51-dt.c
> @@ -47,7 +47,12 @@ static const struct of_dev_auxdata imx51_auxdata_lookup[] __initconst = {
>  static int __init imx51_tzic_add_irq_domain(struct device_node *np,
>  				struct device_node *interrupt_parent)
>  {
> -	irq_domain_add_simple(np, 0);
> +	struct irq_domain *domain;
> +
> +	domain = irq_domain_add_simple(np, 0, TZIC_NUM_IRQS);
> +	if (IS_ERR(domain))
> +		return PTR_ERR(domain);
> +
>  	return 0;
>  }
>  
> @@ -55,9 +60,13 @@ static int __init imx51_gpio_add_irq_domain(struct device_node *np,
>  				struct device_node *interrupt_parent)
>  {
>  	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
> +	struct irq_domain *domain;
>  
>  	gpio_irq_base -= 32;
> -	irq_domain_add_simple(np, gpio_irq_base);
> +
> +	domain = irq_domain_add_simple(np, gpio_irq_base, 32);
> +	if (IS_ERR(domain))
> +		return PTR_ERR(domain);
>  
>  	return 0;
>  }
> diff --git a/arch/arm/mach-imx/imx53-dt.c b/arch/arm/mach-imx/imx53-dt.c
> index 05ebb3e..ccae620 100644
> --- a/arch/arm/mach-imx/imx53-dt.c
> +++ b/arch/arm/mach-imx/imx53-dt.c
> @@ -51,7 +51,12 @@ static const struct of_dev_auxdata imx53_auxdata_lookup[] __initconst = {
>  static int __init imx53_tzic_add_irq_domain(struct device_node *np,
>  				struct device_node *interrupt_parent)
>  {
> -	irq_domain_add_simple(np, 0);
> +	struct irq_domain *domain;
> +
> +	domain = irq_domain_add_simple(np, 0, TZIC_NUM_IRQS);
> +	if (IS_ERR(domain))
> +		return PTR_ERR(domain);
> +
>  	return 0;
>  }
>  
> @@ -59,9 +64,13 @@ static int __init imx53_gpio_add_irq_domain(struct device_node *np,
>  				struct device_node *interrupt_parent)
>  {
>  	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
> +	struct irq_domain *domain;
>  
>  	gpio_irq_base -= 32;
> -	irq_domain_add_simple(np, gpio_irq_base);
> +
> +	domain = irq_domain_add_simple(np, gpio_irq_base, 32);
> +	if (IS_ERR(domain))
> +		return PTR_ERR(domain);
>  
>  	return 0;
>  }
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index c257281..9ed7812 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -95,9 +95,11 @@ static int __init imx6q_gpio_add_irq_domain(struct device_node *np,
>  				struct device_node *interrupt_parent)
>  {
>  	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
> +	struct irq_domain *domain;
>  
>  	gpio_irq_base -= 32;
> -	irq_domain_add_simple(np, gpio_irq_base);
> +	domain = irq_domain_add_simple(np, gpio_irq_base, 32);
> +	WARN_ON(IS_ERR(domain));

Why do we handle the error in a different pattern that is used for
all above?

>  
>  	return 0;
>  }

...

> diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
> index fd9efb0..2fda5aa 100644
> --- a/arch/arm/plat-mxc/include/mach/irqs.h
> +++ b/arch/arm/plat-mxc/include/mach/irqs.h
> @@ -54,6 +54,7 @@
>  /* REVISIT: Add IPU irqs on IMX51 */
>  
>  #define NR_IRQS			(MXC_IPU_IRQ_START + MX3_IPU_IRQS)
> +#define TZIC_NUM_IRQS		128
>  
>  extern int imx_irq_set_priority(unsigned char irq, unsigned char prio);
>  
I just made a small change on top of yours.  Can you please consider
to amend it to your patch if it looks sane to you?

diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index 2fda5aa..70376e0 100644
--- a/arch/arm/plat-mxc/include/mach/irqs.h
+++ b/arch/arm/plat-mxc/include/mach/irqs.h
@@ -13,19 +13,20 @@

 #include <asm-generic/gpio.h>

+#define GIC_NUM_IRQS           160
+#define TZIC_NUM_IRQS          128
+#define AVIC_NUM_IRQS          64
+
 /*
- * SoCs with GIC interrupt controller have 160 IRQs, those with TZIC
- * have 128 IRQs, and those with AVIC have 64.
- *
  * To support single image, the biggest number should be defined on
  * top of the list.
  */
 #if defined CONFIG_ARM_GIC
-#define MXC_INTERNAL_IRQS      160
+#define MXC_INTERNAL_IRQS      GIC_NUM_IRQS
 #elif defined CONFIG_MXC_TZIC
-#define MXC_INTERNAL_IRQS      128
+#define MXC_INTERNAL_IRQS      TZIC_NUM_IRQS
 #else
-#define MXC_INTERNAL_IRQS      64
+#define MXC_INTERNAL_IRQS      AVIC_NUM_IRQS
 #endif

 #define MXC_GPIO_IRQ_START     MXC_INTERNAL_IRQS
@@ -54,7 +55,6 @@
 /* REVISIT: Add IPU irqs on IMX51 */

 #define NR_IRQS                        (MXC_IPU_IRQ_START + MX3_IPU_IRQS)
-#define TZIC_NUM_IRQS          128

 extern int imx_irq_set_priority(unsigned char irq, unsigned char prio);

-- 
Regards,
Shawn
