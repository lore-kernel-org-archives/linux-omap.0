From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 1/1] OMAP3: PM: Fix OTG autoidle workaround
Date: Fri, 18 Dec 2009 15:10:06 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031DC20A71@dbde02.ent.ti.com>
References: <20091218080832.GA2858@esdhcp037198.research.nokia.com>,<1261126710-25459-1-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40946 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbZLRJll convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 04:41:41 -0500
In-Reply-To: <1261126710-25459-1-git-send-email-eduardo.valentin@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: Kristo Tero <Tero.Kristo@nokia.com>, Balbi Felipe <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> From: Eduardo Valentin <eduardo.valentin@nokia.com>
> 
> This patch fix the OTG autoidle workaround so now
> usb gadget modules can be properly loaded.
> 
> Besides it also adds a cpu check, because this hardware
> but is present only in OMAP34xx chips.
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c   |    3 ++-
>  arch/arm/mach-omap2/usb-musb.c |    9 ++++++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index c301261..db75975 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -505,7 +505,8 @@ void omap_sram_idle(void)
>                          * Errata 1.164 fix : OTG autoidle can prevent
>                          * sleep
>                          */
> -                       usb_musb_disable_autoidle();
> +                       if (cpu_is_omap34xx())

If you're doing this, could you please make it cpu_is_omap3430() only?

3630 is not affected. But cpu_is_omap34xx() will return true on 3630
as well.

- Anand

> +                               usb_musb_disable_autoidle();
>                 }
>                 omap_uart_resume_idle(0);
>                 omap_uart_resume_idle(1);
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
> index bb3cee4..cbd4e45 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -81,7 +81,14 @@ static void __init usb_musb_pm_init(void)
> 
>  void usb_musb_disable_autoidle(void)
>  {
> -       __raw_writel(0, otg_base + OTG_SYSCONFIG);
> +       if (otg_clk) {
> +               unsigned long reg;
> +
> +               clk_enable(otg_clk);
> +               reg = __raw_readl(otg_base + OTG_SYSCONFIG);
> +               __raw_writel(reg & ~1, otg_base + OTG_SYSCONFIG);
> +               clk_disable(otg_clk);
> +       }
>  }
> 
>  #ifdef CONFIG_USB_MUSB_SOC
> --
> 1.6.5.7.g9ecb2
> 
> 