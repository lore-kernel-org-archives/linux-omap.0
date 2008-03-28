From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7] twl4030 changes
Date: Fri, 28 Mar 2008 12:17:41 +0200
Message-ID: <20080328101741.GP24896@atomide.com>
References: <20080328074900.GD24896@atomide.com> <3917c3ef86c0fa62087f0c46bafe533a@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64205 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491AbYC1KRr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 06:17:47 -0400
Content-Disposition: inline
In-Reply-To: <3917c3ef86c0fa62087f0c46bafe533a@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [080328 12:16]:
> 
> 
> On Fri, 28 Mar 2008 09:49:00 +0200, Tony Lindgren <tony@atomide.com> wrote:
> > * Felipe Balbi <felipe.balbi@nokia.com> [080327 19:20]:
> >> Hi Tony,
> >>
> >> I'm resending this series cuz I changed a bit patch #5 to set
> >> session bit on musb_platform_set_mode so musb core will really
> >> go to a_host mode when we echo sysfs.
> >>
> >> Without this small change the sysfs interface will work only with
> >> a few devices, most likely usb sticks.
> >>
> >> Below is a shortlog and diffstat of the changes.
> > 
> > Pushing this series today.
> 
> Hi tony,
> 
> You missed the attached patch: Let board specific codee handle clock
> initialization

Oops, sorry pushing.

Tony

> 
> -- 
> Best Regards,
> 
> Felipe Balbi
> http://felipebalbi.com
> me@felipebalbi.com
> From ad7a01e97dadbde2ef6c43b46182272ccc201683 Mon Sep 17 00:00:00 2001
> From: Felipe Balbi <felipe.balbi@nokia.com>
> Date: Tue, 18 Mar 2008 20:26:30 +0200
> Subject: [PATCH 1/2] USB: MUSB: Let board specific code handle clock initialization
> 
> Instead of clk_get() in omap2430.c driver, we can let
> musb_core.c do it by setting the clock id in
> musb_platform_data structure.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/mach-omap2/board-2430sdp-usb.c |   27 +++++++++++++++++++++++++++
>  arch/arm/mach-omap2/board-3430sdp-usb.c |   29 +++++++++++++++++++++++++++--
>  drivers/usb/musb/omap2430.c             |    8 --------
>  3 files changed, 54 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-2430sdp-usb.c b/arch/arm/mach-omap2/board-2430sdp-usb.c
> index 908a0c0..7f4e017 100644
> --- a/arch/arm/mach-omap2/board-2430sdp-usb.c
> +++ b/arch/arm/mach-omap2/board-2430sdp-usb.c
> @@ -13,9 +13,11 @@
>  #include <linux/errno.h>
>  #include <linux/delay.h>
>  #include <linux/platform_device.h>
> +#include <linux/clk.h>
>  #include <linux/usb/musb.h>
>  
>  #include <asm/arch/hardware.h>
> +#include <asm/arch/pm.h>
>  #include <asm/arch/usb.h>
>  
>  static struct resource musb_resources[] = {
> @@ -34,6 +36,29 @@ static struct resource musb_resources[] = {
>  	},
>  };
>  
> +static int usbhs_ick_on;
> +
> +static int musb_set_clock(struct clk *clk, int state)
> +{
> +       if (state) {
> +               if (usbhs_ick_on > 0)
> +                       return -ENODEV;
> +
> +               omap2_block_sleep();
> +               clk_enable(clk);
> +               usbhs_ick_on = 1;
> +       } else {
> +               if (usbhs_ick_on == 0)
> +                       return -ENODEV;
> +
> +               clk_disable(clk);
> +               usbhs_ick_on = 0;
> +               omap2_allow_sleep();
> +       }
> +
> +       return 0;
> +}
> +
>  static struct musb_hdrc_platform_data musb_plat = {
>  #ifdef CONFIG_USB_MUSB_OTG
>  	.mode		= MUSB_OTG,
> @@ -43,6 +68,8 @@ static struct musb_hdrc_platform_data musb_plat = {
>  	.mode		= MUSB_PERIPHERAL,
>  #endif
>  	.multipoint	= 1,
> +	.clock		= "usbhs_ick",
> +	.set_clock	= musb_set_clock,
>  };
>  
>  static u64 musb_dmamask = ~(u32)0;
> diff --git a/arch/arm/mach-omap2/board-3430sdp-usb.c b/arch/arm/mach-omap2/board-3430sdp-usb.c
> index 77088b4..81c9af7 100644
> --- a/arch/arm/mach-omap2/board-3430sdp-usb.c
> +++ b/arch/arm/mach-omap2/board-3430sdp-usb.c
> @@ -16,11 +16,13 @@
>  #include <linux/errno.h>
>  #include <linux/delay.h>
>  #include <linux/platform_device.h>
> +#include <linux/clk.h>
>  #include <asm/io.h>
>  #include <asm/arch/mux.h>
>  #include <linux/usb/musb.h>
>  
>  #include <asm/arch/hardware.h>
> +#include <asm/arch/pm.h>
>  #include <asm/arch/usb.h>
>  
>  #ifdef CONFIG_USB_MUSB_SOC
> @@ -40,6 +42,29 @@ static struct resource musb_resources[] = {
>  	},
>  };
>  
> +static int hsotgusb_ick_on;
> +
> +static int musb_set_clock(struct clk *clk, int state)
> +{
> +	if (state) {
> +		if (hsotgusb_ick_on > 0)
> +			return -ENODEV;
> +
> +		omap2_block_sleep();
> +		clk_enable(clk);
> +		hsotgusb_ick_on = 1;
> +	} else {
> +		if (hsotgusb_ick_on == 0)
> +			return -ENODEV;
> +
> +		clk_disable(clk);
> +		hsotgusb_ick_on = 0;
> +		omap2_allow_sleep();
> +	}
> +
> +	return 0;
> +}
> +
>  static struct musb_hdrc_platform_data musb_plat = {
>  #ifdef CONFIG_USB_MUSB_OTG
>  	.mode		= MUSB_OTG,
> @@ -49,8 +74,8 @@ static struct musb_hdrc_platform_data musb_plat = {
>  	.mode		= MUSB_PERIPHERAL,
>  #endif
>  	.multipoint	= 1,
> -	.clock		= NULL,
> -	.set_clock	= NULL,
> +	.clock		= "hsotgusb_ick",
> +	.set_clock	= musb_set_clock,
>  };
>  
>  static u64 musb_dmamask = ~(u32)0;
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index caae81b..364d746 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -219,13 +219,7 @@ int __init musb_platform_init(struct musb *musb)
>  
>  #if defined(CONFIG_ARCH_OMAP2430)
>  	omap_cfg_reg(AE5_2430_USB0HS_STP);
> -	/* get the clock */
> -	musb->clock = clk_get((struct device *)musb->controller, "usbhs_ick");
> -#else
> -	musb->clock = clk_get((struct device *)musb->controller, "hsotgusb_ick");
>  #endif
> -	if(IS_ERR(musb->clock))
> -		return PTR_ERR(musb->clock);
>  
>  	musb->xceiv = *xceiv;
>  	musb_platform_resume(musb);
> @@ -261,13 +255,11 @@ int musb_platform_suspend(struct musb *musb)
>  	OTG_SYSCONFIG_REG |= AUTOIDLE;		/* enable auto idle */
>  
>  	musb->xceiv.set_suspend(&musb->xceiv, 1);
> -	clk_disable(musb->clock);
>  	return 0;
>  }
>  
>  int musb_platform_resume(struct musb *musb)
>  {
> -	clk_enable(musb->clock);
>  	musb->xceiv.set_suspend(&musb->xceiv, 0);
>  
>  	OTG_FORCESTDBY_REG &= ~ENABLEFORCE; /* disable MSTANDBY */
> -- 
> 1.5.5.rc1.12.g660b9
> 

