From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH V3 7/7] ARM: DRA: Enable Crossbar IP support for DRA7XX
Date: Tue, 12 Nov 2013 11:11:04 +0530
Message-ID: <5281BF70.4050708@ti.com>
References: <1383657257-3458-1-git-send-email-r.sricharan@ti.com>
 <1383657257-3458-8-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1383657257-3458-8-git-send-email-r.sricharan@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sricharan R <r.sricharan@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, linux-doc@vger.kernel.org, tony@atomide.com, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, marc.zyngier@arm.com, galak@codeaurora.org, grant.likely@linaro.org, santosh.shilimkar@ti.com, tglx@linutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 05 November 2013 06:44 PM, Sricharan R wrote:
> Enable the crossbar IP support for DRA7xx soc.
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig        |    1 +
>  arch/arm/mach-omap2/omap4-common.c |    4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index b5fb5f7..2086c65 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -141,6 +141,7 @@ config SOC_DRA7XX
>  	select ARM_GIC
>  	select HAVE_SMP
>  	select COMMON_CLK
> +	select IRQ_CROSSBAR
>  
>  comment "OMAP Core Type"
>  	depends on ARCH_OMAP2
> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index 5791143..274cbfa 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/export.h>
>  #include <linux/irqchip/arm-gic.h>
> +#include <linux/irqchip/irq-crossbar.h>
>  #include <linux/of_address.h>
>  #include <linux/reboot.h>
>  
> @@ -282,9 +283,12 @@ void __init omap_gic_of_init(void)
>  
>  skip_errata_init:
>  	omap_wakeupgen_init();
> +	if (soc_is_dra7xx())
> +		crossbar_init();

Its good if this is called irqcrossbar_init() to avoid confusion
with the dma crossbar which also exists in dra7 devices.

>  	irqchip_init();
>  }
>  
> +
>  #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
>  static int omap4_twl6030_hsmmc_late_init(struct device *dev)
>  {
> 
