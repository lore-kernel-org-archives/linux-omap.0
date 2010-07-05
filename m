From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: Devkit8000: Use DIE id to initialize dm9000 MAC
 address
Date: Mon, 5 Jul 2010 12:44:36 +0300
Message-ID: <20100705094432.GO15951@atomide.com>
References: <1278308819-9531-1-git-send-email-kanru@0xlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50087 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929Ab0GEJot (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 05:44:49 -0400
Content-Disposition: inline
In-Reply-To: <1278308819-9531-1-git-send-email-kanru@0xlab.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kan-Ru Chen <kanru@0xlab.org>
Cc: linux-omap@vger.kernel.org, Thomas Weber <weber@corscience.de>

* Kan-Ru Chen <kanru@0xlab.org> [100705 09:27]:
> The devkit8000 debug boards often come with empty EEPROM thus without
> valid ethernet MAC address. The DIE id to MAC formula is copied from
> u-boot.
> 
> Signed-off-by: Kan-Ru Chen <kanru@0xlab.org>
> ---
>  arch/arm/mach-omap2/board-devkit8000.c |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
> index a2a8afe..807ceee 100644
> --- a/arch/arm/mach-omap2/board-devkit8000.c
> +++ b/arch/arm/mach-omap2/board-devkit8000.c
> @@ -45,6 +45,7 @@
>  #include <plat/usb.h>
>  #include <plat/timer-gp.h>
>  #include <plat/display.h>
> +#include <plat/io.h>
>  
>  #include <plat/mcspi.h>
>  #include <linux/input/matrix_keypad.h>
> @@ -66,6 +67,10 @@
>  #define OMAP_DM9000_GPIO_IRQ	25
>  #define OMAP3_DEVKIT_TS_GPIO	27
>  
> +#define DIE_ID_REG_BASE	(L4_34XX_PHYS + 0xA000)
> +#define DIE_ID_REG_0		0x218
> +#define DIE_ID_REG_1		0x21C
> +
>  struct flash_partitions {
>         struct mtd_partition *parts;
>         int nr_parts;
> @@ -603,6 +608,9 @@ static struct platform_device omap_dm9000_dev = {
>  
>  static void __init omap_dm9000_init(void)
>  {
> +	unsigned char *eth_addr = omap_dm9000_platdata.dev_addr;
> +	unsigned int die_id_0;
> +
>  	if (gpio_request(OMAP_DM9000_GPIO_IRQ, "dm9000 irq") < 0) {
>  		printk(KERN_ERR "Failed to request GPIO%d for dm9000 IRQ\n",
>  			OMAP_DM9000_GPIO_IRQ);
> @@ -610,6 +618,15 @@ static void __init omap_dm9000_init(void)
>  		}
>  
>  	gpio_direction_input(OMAP_DM9000_GPIO_IRQ);
> +
> +	/* init the mac address using DIE id */
> +	die_id_0 = omap_readl(DIE_ID_REG_BASE + DIE_ID_REG_0);

We should not add omap_readl/writel to any new code, those are slowly
going away.

> +	eth_addr[0] = 0x02; /* locally administered */
> +	eth_addr[1] = omap_readl(DIE_ID_REG_BASE + DIE_ID_REG_1) & 0xff;
> +	eth_addr[2] = (die_id_0 & 0xff000000) >> 24;
> +	eth_addr[3] = (die_id_0 & 0x00ff0000) >> 16;
> +	eth_addr[4] = (die_id_0 & 0x0000ff00) >> 8;
> +	eth_addr[5] = (die_id_0 & 0x000000ff);
>  }
>  
>  static struct platform_device *devkit8000_devices[] __initdata = {

How about adding a function for getting this from mach-omap2/id.c?
Other boards might want to use it too.

Regards,

Tony
