From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 14/14] ARM: OMAP2+: gpmc: writeprotect helper
Date: Tue, 12 Jun 2012 13:42:27 -0500
Message-ID: <4FD78D93.9080906@ti.com>
References: <cover.1339419492.git.afzal@ti.com> <85c5dc5fa3203cc60a12d4b2350e45da07d7f5fd.1339419492.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37052 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab2FLSm3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jun 2012 14:42:29 -0400
In-Reply-To: <85c5dc5fa3203cc60a12d4b2350e45da07d7f5fd.1339419492.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


On 06/11/2012 09:27 AM, Afzal Mohammed wrote:
> GPMC has a writeprotect pin that can be connected to
> peripherals. If any CS wants to enable writeprotect,
> writeprotect will be enabled, once CS configurations
> are finished.

I am still wondering if we should warn against multiple devices using
the wait pin. I see that if could be valid to have multiple memory
devices of the same type using the WP pin spanning multiple CS. However,
in that case would/should the memory devices be registered as a single
child? If so then we could still impose a policy of only one child
device using the WP.

Jon

> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 98b52c3..eec011a 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -159,6 +159,7 @@ struct gpmc_peripheral {
>  static struct gpmc_peripheral gpmc_peripheral[GPMC_CS_NUM];
>  static unsigned gpmc_num_peripheral;
>  static unsigned gpmc_waitpin_map;
> +static bool gpmc_writeprotect;
>  
>  static struct gpmc_client_irq gpmc_client_irq[GPMC_NR_IRQ];
>  static struct irq_chip gpmc_irq_chip;
> @@ -976,6 +977,9 @@ static void gpmc_setup_cs_config(unsigned cs, unsigned conf)
>  	else if (conf & GPMC_CONFIG1_PAGE_LEN_16)
>  		l |= GPMC_CONFIG1_PAGE_LEN_16;
>  
> +	if (conf & GPMC_CONFIG_WRITEPROTECT)
> +		gpmc_writeprotect = true;
> +
>  	conf &= (GPMC_CONFIG1_MUXADDDATA |
>  			GPMC_CONFIG1_WRITETYPE_SYNC |
>  			GPMC_CONFIG1_WRITEMULTIPLE_SUPP |
> @@ -1462,6 +1466,19 @@ int gpmc_cs_reconfigure(char *name, int id, struct gpmc_cs_data *c)
>  }
>  EXPORT_SYMBOL_GPL(gpmc_cs_reconfigure);
>  
> +static inline void gpmc_setup_writeprotect(void)
> +{
> +	u32 l;
> +
> +	l = gpmc_read_reg(GPMC_CONFIG);
> +	if (gpmc_writeprotect == true) {
> +		l &= ~GPMC_CONFIG_WRITEPROTECT;
> +		dev_info(gpmc_dev, "write protect enabled\n");
> +	} else
> +		l |= GPMC_CONFIG_WRITEPROTECT;
> +	gpmc_write_reg(GPMC_CONFIG, l);
> +}
> +
>  static __devinit int gpmc_probe(struct platform_device *pdev)
>  {
>  	u32 l;
> @@ -1521,6 +1538,8 @@ static __devinit int gpmc_probe(struct platform_device *pdev)
>  			dev_err(gpmc_dev, "device creation on %s failed\n",
>  								g_per->name);
>  
> +	gpmc_setup_writeprotect();
> +
>  	return 0;
>  }
>  
> @@ -1531,6 +1550,7 @@ static __exit int gpmc_remove(struct platform_device *pdev)
>  	for (; gpmc_num_peripheral; g_per++, gpmc_num_peripheral--)
>  		platform_device_unregister(g_per->pdev);
>  
> +	gpmc_writeprotect = false;
>  	gpmc_waitpin_map = 0;
>  	gpmc_free_irq();
>  	gpmc_mem_exit();
