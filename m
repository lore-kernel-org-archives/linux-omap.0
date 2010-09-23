From: "Maulik" <x0082077@ti.com>
Subject: RE: [PATCH 9/9 v3] usb : musb: Offmode fix for idle path
Date: Thu, 23 Sep 2010 11:20:34 +0530
Message-ID: <CE25F9D2A56A423C84BED8BC132A07FB@apr.dhcp.ti.com>
References: <1285201846-26599-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35901 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981Ab0IWFuk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Sep 2010 01:50:40 -0400
In-Reply-To: <1285201846-26599-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Hema HK' <hemahk@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: 'Felipe Balbi' <balbi@ti.com>, 'Tony Lindgren' <tony@atomide.com>, 'Kevin Hilman' <khilman@deeprootsystems.com>, "'Cousson, Benoit'" <b-cousson@ti.com>, 'Paul Walmsley' <paul@pwsan.com>


> -----Original Message-----
> From: Hema HK [mailto:hemahk@ti.com]
> Sent: Thursday, September 23, 2010 6:01 AM
> To: linux-omap@vger.kernel.org; linux-usb@vger.kernel.org
> Cc: Hema HK; Maulik Mankad; Felipe Balbi; Tony Lindgren; Kevin Hilman;
> Cousson, Benoit; Paul Walmsley
> Subject: [PATCH 9/9 v3] usb : musb: Offmode fix for idle path
> 
> With OMAP core-off support musb was not functional as context was getting
> lost after wakeup from core-off. And also musb was blocking the core-off
> after loading the gadget driver even with no cable connected sometimes.
> 
> Added the idle and wakeup APIs in the platform layer which will
> be called in the idle and wakeup path.
> 
> Used the pm_runtime_put_sysc API to configure the
> musb to force idle/standby modes, saving the context and disable the clk
> in
> while idling if there is no activity on the usb bus.
> 
> Used the pm_runtime_get_sync API to configure the musb to
> no idle/standby modes, enable the clock and restore the context
> after wakeup when there is no activity on the usb bus.
> 
> Signed-off-by: Hema HK <hemahk@ti.com>
> Signed-off-by: Maulik Mankad <x0082077@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> 
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c     |    1
>  arch/arm/mach-omap2/pm34xx.c          |    3
>  arch/arm/mach-omap2/usb-musb.c        |  107
> ++++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/usb.h |    2
>  drivers/usb/musb/musb_core.c          |   15 ++++
>  drivers/usb/musb/omap2430.c           |   14 ++++
>  include/linux/usb/musb.h              |    9 ++
>  7 files changed, 149 insertions(+), 2 deletions(-)
> 
> Index: linux-omap-pm/arch/arm/mach-omap2/cpuidle34xx.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/cpuidle34xx.c
> +++ linux-omap-pm/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -31,6 +31,7 @@
>  #include <plat/clockdomain.h>
>  #include <plat/control.h>
>  #include <plat/serial.h>
> +#include <plat/usb.h>
> 
>  #include "pm.h"
> 
> Index: linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/pm34xx.c
> +++ linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
> @@ -38,6 +38,7 @@
>  #include <plat/prcm.h>
>  #include <plat/gpmc.h>
>  #include <plat/dma.h>
> +#include <plat/usb.h>
> 
>  #include <asm/tlbflush.h>
> 
> @@ -324,11 +325,13 @@ static void restore_table_entry(void)
>  void omap3_device_idle(void)
>  {
>  	omap2_gpio_prepare_for_idle();
> +	musb_prepare_for_idle();
>  }
> 
>  void omap3_device_resume(void)
>  {
>  	omap2_gpio_resume_after_idle();
> +	musb_wakeup_from_idle();
>  }
> 
>  void omap_sram_idle(void)
> Index: linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/usb-musb.c
> +++ linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
> @@ -25,16 +25,21 @@
>  #include <linux/io.h>
> 
>  #include <linux/usb/musb.h>
> +#include <linux/pm_runtime.h>
> 
>  #include <mach/hardware.h>
>  #include <mach/irqs.h>
>  #include <plat/usb.h>
>  #include <plat/omap_device.h>
> +#include <plat/powerdomain.h>
> 
>  #ifdef CONFIG_USB_MUSB_SOC
>  static const char name[] = "musb_hdrc";
>  #define MAX_OMAP_MUSB_HWMOD_NAME_LEN	16
> 
> +struct omap_hwmod *oh_p;
> +static struct powerdomain *core_pwrdm;
> +
>  static struct musb_hdrc_config musb_config = {
>  	.multipoint	= 1,
>  	.dyn_fifo	= 1,
> @@ -58,6 +63,10 @@ static struct musb_hdrc_platform_data mu
>  	 * "mode", and should be passed to usb_musb_init().
>  	 */
>  	.power		= 50,			/* up to 100 mA */
> +
> +	/* OMAP supports offmode */
> +	.save_context	= 1,
> +	.restore_context	= 1,
>  };
> 
>  static u64 musb_dmamask = DMA_BIT_MASK(32);
> @@ -80,6 +89,7 @@ void __init usb_musb_init(struct omap_mu
>  	const char *oh_name = "usb_otg_hs";
>  	struct musb_hdrc_platform_data *pdata;
> 
> +	core_pwrdm = pwrdm_lookup("per_pwrdm");
>  	oh = omap_hwmod_lookup(oh_name);
> 
>  	if (!oh) {
> @@ -97,6 +107,7 @@ void __init usb_musb_init(struct omap_mu
>  	musb_plat.extvbus = board_data->extvbus;
> 
>  	pdata = &musb_plat;
> +	oh_p = oh;
> 
>  	od = omap_device_build(name, bus_id, oh, pdata,
>  			       sizeof(struct musb_hdrc_platform_data),
> @@ -115,8 +126,101 @@ void __init usb_musb_init(struct omap_mu
>  	put_device(dev);
>  }
> 
> +void musb_prepare_for_idle()
> +{
> +	int core_next_state;
> +	struct omap_hwmod *oh = oh_p;
> +	struct omap_device *od;
> +	struct platform_device *pdev;
> +	struct musb_hdrc_platform_data *pdata;
> +	struct device *dev;
> +
> +	if (!core_pwrdm)
> +		return;
> +
> +	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
> +	if (core_next_state >= PWRDM_POWER_INACTIVE)
> +		return;
> +	if (!oh)
> +		return;
> +
> +	od = oh->od;
> +	pdev = &od->pdev;
> +
> +	if (!pdev)
> +		return;
> +	dev = &pdev->dev;
> +
> +	if (dev->driver) {
> +		pdata = dev->platform_data;
> +
> +	if (pdata->is_usb_active)


Don't you need a start brace here?
Also a tab is required if this if condition is under if (dev->driver)

	
> +		if (!pdata->is_usb_active(dev)) {
> +			if (core_next_state == PWRDM_POWER_OFF) {
> +				pdata->save_context = 1;
> +				pm_runtime_put_sync(dev);
> +			} else if  (core_next_state == PWRDM_POWER_RET) {
> +				pdata->save_context = 0;
> +				pm_runtime_put_sync(dev);
> +			}
> +		}
> +	}
> +}
> +
> +void musb_wakeup_from_idle()
> +{
> +	int core_next_state;
> +	int core_prev_state;
> +	struct omap_hwmod *oh = oh_p;
> +	struct omap_device *od;
> +	struct platform_device *pdev;
> +	struct device *dev;
> +	struct musb_hdrc_platform_data *pdata;
> +
> +	if (!core_pwrdm)
> +		return;
> +
> +	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
> +
> +	if (core_next_state >= PWRDM_POWER_INACTIVE)
> +		return;
> +	 core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
> +
> +	 if (!oh)
> +		return;
> +	 od = oh->od;
> +	 pdev = &od->pdev;
> +
> +	 if (!pdev)
> +		return;
> +
> +	 dev = &pdev->dev;
> +
> +	 if (dev->driver) {
> +		pdata = dev->platform_data;
> +
> +		if (pdata->is_usb_active)

Braces needed for this if condition?

> +			if (!pdata->is_usb_active(dev)) {
> +				if (core_prev_state == PWRDM_POWER_OFF) {
> +					pdata->restore_context = 1;
> +					 pm_runtime_get_sync(dev);
> +				} else {
> +					 pdata->restore_context = 0;
> +					 pm_runtime_get_sync(dev);
> +				}
> +			 }
> +	 }
> +}

Regards,
Maulik

