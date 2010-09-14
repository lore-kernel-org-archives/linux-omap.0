From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 2/2] OMAP2+: GPIO: move late PM out of
 interrupts-disabled idle path
Date: Tue, 14 Sep 2010 19:44:33 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F71C@dbde02.ent.ti.com>
References: <1284418958-5887-1-git-send-email-khilman@deeprootsystems.com>
 <1284418958-5887-3-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34958 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033Ab0INOOl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 10:14:41 -0400
In-Reply-To: <1284418958-5887-3-git-send-email-khilman@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Basak, Partha" <p-basak2@ti.com>, Tero Kristo <tero.kristo@nokia.com>

 

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Tuesday, September 14, 2010 4:33 AM
> To: linux-omap@vger.kernel.org
> Cc: Varadarajan, Charulatha; Basak, Partha; Tero Kristo
> Subject: [PATCH 2/2] OMAP2+: GPIO: move late PM out of 
> interrupts-disabled idle path
> 
> From: Kevin Hilman <khilman@ti.com>
> 
> Currently, we wait until late in the idle path where interrupts are
> disabled to do runtime-PM-like management for certain special-case
> devices like GPIO.
> 
> As a prerequiste to moving GPIO to the new runtime PM framework, move
> this runtime-PM-like code out of the late idle path into new device
> idle and resume functions that can be called before interrupts are
> disabled by CPUidle and/or suspend.
> 
> In addition, move all the GPIO-specific logic into the GPIO core
> instead of keeping GPIO-specific knowledge of power-states, context
> saving etc. in the PM core.
> 
> Also, call the new device-idle and -resume methods from CPUidle and
> static suspend path.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c      |    4 ++
>  arch/arm/mach-omap2/pm.h               |    2 +
>  arch/arm/mach-omap2/pm24xx.c           |    2 +-
>  arch/arm/mach-omap2/pm34xx.c           |   38 +++++++++------------
>  arch/arm/plat-omap/gpio.c              |   57 
> ++++++++++++++++++++++++--------
>  arch/arm/plat-omap/include/plat/gpio.h |    4 +--
>  6 files changed, 67 insertions(+), 40 deletions(-)

<<snip>>

>  
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 7951eef..b0467c1 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -29,6 +29,8 @@
>  #include <asm/mach/irq.h>
>  #include <plat/powerdomain.h>
>  
> +static struct powerdomain *per_pwrdm;
> +
>  /*
>   * OMAP1510 GPIO registers
>   */
> @@ -207,6 +209,9 @@ struct gpio_bank {
>  	u32 dbck_enable_mask;
>  };
>  
> +static void omap3_gpio_restore_context(void);
> +static void omap3_gpio_save_context(void);
> +
>  #define METHOD_MPUIO		0
>  #define METHOD_GPIO_1510	1
>  #define METHOD_GPIO_1610	2
> @@ -1778,6 +1783,8 @@ static int __init _omap_gpio_init(void)
>  	}
>  #endif
>  
> +	if (cpu_class_is_omap2())
> +		per_pwrdm = pwrdm_lookup("per_pwrdm");

"per_pwrdm" is not available for OMAP24xx.

>  
>  #ifdef CONFIG_ARCH_OMAP15XX
>  	if (cpu_is_omap15xx()) {
> @@ -2074,14 +2081,22 @@ static struct sys_device omap_gpio_device = {
>  
>  static int workaround_enabled;
>  
> -void omap2_gpio_prepare_for_idle(int power_state)
> +void omap2_gpio_prepare_for_idle(void)
>  {
> -	int i, c = 0;
> -	int min = 0;
> +	int i, c = 0, min = 0;
> +	int per_next_state;
> +
> +	if (!per_pwrdm)
> +		return;

"per_pwrdm" is not available for OMAP24xx. Hence
this breaks the omap2_gpio_prepare_for_idle() path for OMAP2.

In OMAP2420, all gpio banks are in wakeup domain and
in OMAP2430 GPIO banks 1-4 are in wakeup domain & GPIO5 is
in core domain.

-V Charulatha


> +
> +	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
> +	if (per_next_state >= PWRDM_POWER_INACTIVE)
> +		return;
>  
>  	if (cpu_is_omap34xx())
>  		min = 1;

<<snip>>

