From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] ARM: OMAP3: cm-t35: add EHCI support
Date: Fri, 23 Oct 2009 12:56:39 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A5114B8@dbde02.ent.ti.com>
References: <4AD58887.9010004@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33998 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbZJWH0l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 03:26:41 -0400
In-Reply-To: <4AD58887.9010004@compulab.co.il>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> This patch adds support for EHCI on CM-T35.
> It depends on basic CM-T35 board support ([1]) and EHCI updates
> in the linux-omap tree.
> 
> [1] http://thread.gmane.org/gmane.linux.ports.arm.omap/24938
> ---
> 
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
>  arch/arm/mach-omap2/board-cm-t35.c |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
> index 94c1f35..1465892 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -352,6 +352,17 @@ static struct twl4030_hsmmc_info mmc[] = {
>  	{}	/* Terminator */
>  };
> 
> +static struct ehci_hcd_omap_platform_data ehci_pdata = {
> +	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
> +	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
> +	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
> +

I haven't been following l-o for a while - I just got back.
Is there a link to some documentation for this board (I'm just
curious about the EHCI connections)?

Are you using Port1 and Port2 both? What PHY is connected to
the ports?

> +	.phy_reset  = true,
> +	.reset_gpio_port[0]  = -EINVAL,
> +	.reset_gpio_port[1]  = -EINVAL,
> +	.reset_gpio_port[2]  = -EINVAL

You set these reset gpios below.
I guess you don't need to initialize them here.

- Anand

> +};
> +
>  static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
>  				 unsigned ngpio)
>  {
> @@ -377,6 +388,12 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
>  	cm_t35_vmmc1_supply.dev = mmc[0].dev;
>  	cm_t35_vsim_supply.dev = mmc[0].dev;
> 
> +	/* setup USB with proper PHY reset GPIOs */
> +	ehci_pdata.reset_gpio_port[0] = gpio + 6;
> +	ehci_pdata.reset_gpio_port[1] = gpio + 7;
> +
> +	usb_ehci_init(&ehci_pdata);
> +
>  	return 0;
>  }
> 
> -- 
> 1.6.0.6
> 
> 
> -- 
> Sincerely yours,
> Mike.
> 
> 
