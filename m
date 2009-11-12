From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: FW: [PATCH] omap3evm: Migrate to smsc911x ethernet driver.
Date: Thu, 12 Nov 2009 16:27:27 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C8416@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36540 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752608AbZKLK50 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 05:57:26 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nACAvTTe027184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2009 04:57:31 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nACAvThG015218
	for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2009 16:27:29 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Pushed this patch to psp-group:build7 ...

Regards,
Anuj Aggarwal


-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Govindarajan, Sriramakrishnan
Sent: Wednesday, November 11, 2009 1:43 PM
To: linux-omap@vger.kernel.org
Subject: RE: [PATCH] omap3evm: Migrate to smsc911x ethernet driver.

Tony,
Are there comments with respect to this patch. Will this be merged in the next window?
Regards
Sriram

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Govindarajan, Sriramakrishnan
> Sent: Wednesday, October 28, 2009 7:19 PM
> To: linux-omap@vger.kernel.org
> Cc: Govindarajan, Sriramakrishnan
> Subject: [PATCH] omap3evm: Migrate to smsc911x ethernet driver.
> 
> Migrate to smsc911x ethernet driver instead of smc911x driver.
> The smsc911x ethernet driver supports NAPI and performs better
> under heavy traffic. With the smc911x driver we were witnessing
> very high iowait time for high IO load over NFS.
> 
> Signed-off-by: Sriramakrishnan <srk@ti.com>
> ---
> This patch is generated against tip of for-next branch.
> 
>  arch/arm/configs/omap3_evm_defconfig |    4 +-
>  arch/arm/mach-omap2/board-omap3evm.c |   36
> +++++++++++++++++++++++++--------
>  2 files changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/configs/omap3_evm_defconfig
> b/arch/arm/configs/omap3_evm_defconfig
> index d5ff477..50afc67 100644
> --- a/arch/arm/configs/omap3_evm_defconfig
> +++ b/arch/arm/configs/omap3_evm_defconfig
> @@ -617,8 +617,8 @@ CONFIG_MII=y
>  # CONFIG_DM9000 is not set
>  # CONFIG_ENC28J60 is not set
>  # CONFIG_ETHOC is not set
> -CONFIG_SMC911X=y
> -# CONFIG_SMSC911X is not set
> +# CONFIG_SMC911X is not set
> +CONFIG_SMSC911X=y
>  # CONFIG_DNET is not set
>  # CONFIG_IBM_NEW_EMAC_ZMII is not set
>  # CONFIG_IBM_NEW_EMAC_RGMII is not set
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> omap2/board-omap3evm.c
> index 5d2310e..9bcdaf7 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -21,11 +21,13 @@
>  #include <linux/gpio.h>
>  #include <linux/input.h>
>  #include <linux/leds.h>
> +#include <linux/interrupt.h>
> 
>  #include <linux/spi/spi.h>
>  #include <linux/spi/ads7846.h>
>  #include <linux/i2c/twl4030.h>
>  #include <linux/usb/otg.h>
> +#include <linux/smsc911x.h>
> 
>  #include <linux/regulator/machine.h>
> 
> @@ -51,7 +53,8 @@
>  #define OMAP3EVM_ETHR_GPIO_IRQ	176
>  #define OMAP3EVM_SMC911X_CS	5
> 
> -static struct resource omap3evm_smc911x_resources[] = {
> +#if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
> +static struct resource omap3evm_smsc911x_resources[] = {
>  	[0] =	{
>  		.start	= OMAP3EVM_ETHR_START,
>  		.end	= (OMAP3EVM_ETHR_START + OMAP3EVM_ETHR_SIZE - 1),
> @@ -60,18 +63,28 @@ static struct resource
> omap3evm_smc911x_resources[] = {
>  	[1] =	{
>  		.start	= OMAP_GPIO_IRQ(OMAP3EVM_ETHR_GPIO_IRQ),
>  		.end	= OMAP_GPIO_IRQ(OMAP3EVM_ETHR_GPIO_IRQ),
> -		.flags	= IORESOURCE_IRQ,
> +		.flags	= (IORESOURCE_IRQ | IRQF_TRIGGER_LOW),
>  	},
>  };
> 
> -static struct platform_device omap3evm_smc911x_device = {
> -	.name		= "smc911x",
> +static struct smsc911x_platform_config smsc911x_config = {
> +	.phy_interface  = PHY_INTERFACE_MODE_MII,
> +	.irq_polarity   = SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
> +	.irq_type       = SMSC911X_IRQ_TYPE_OPEN_DRAIN,
> +	.flags          = (SMSC911X_USE_32BIT |
> SMSC911X_SAVE_MAC_ADDRESS),
> +};
> +
> +static struct platform_device omap3evm_smsc911x_device = {
> +	.name		= "smsc911x",
>  	.id		= -1,
> -	.num_resources	= ARRAY_SIZE(omap3evm_smc911x_resources),
> -	.resource	= &omap3evm_smc911x_resources[0],
> +	.num_resources	= ARRAY_SIZE(omap3evm_smsc911x_resources),
> +	.resource	= &omap3evm_smsc911x_resources[0],
> +	.dev		= {
> +		.platform_data = &smsc911x_config,
> +	},
>  };
> 
> -static inline void __init omap3evm_init_smc911x(void)
> +static inline void __init omap3evm_init_smsc911x(void)
>  {
>  	int eth_cs;
>  	struct clk *l3ck;
> @@ -92,8 +105,14 @@ static inline void __init
> omap3evm_init_smc911x(void)
>  	}
> 
>  	gpio_direction_input(OMAP3EVM_ETHR_GPIO_IRQ);
> +
> +	platform_device_register(&omap3evm_smsc911x_device);
>  }
> 
> +#else
> +static inline void __init omap3evm_init_smsc911x(void) { return; }
> +#endif
> +
>  static struct regulator_consumer_supply omap3evm_vmmc1_supply = {
>  	.supply			= "vmmc",
>  };
> @@ -335,12 +354,10 @@ static void __init omap3_evm_init_irq(void)
>  	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL);
>  	omap_init_irq();
>  	omap_gpio_init();
> -	omap3evm_init_smc911x();
>  }
> 
>  static struct platform_device *omap3_evm_devices[] __initdata = {
>  	&omap3_evm_lcd_device,
> -	&omap3evm_smc911x_device,
>  };
> 
>  static void __init omap3_evm_init(void)
> @@ -359,6 +376,7 @@ static void __init omap3_evm_init(void)
>  #endif
>  	usb_musb_init();
>  	ads7846_dev_init();
> +	omap3evm_init_smsc911x();
>  }
> 
>  static void __init omap3_evm_map_io(void)

[Hiremath, Vaibhav] I validated this patch on OMAP3EVM and it is working for me. At-least I could able to mount NFS and work without any issue, which was failing before with SMC911x. For me, earlier I was not able to mount NFS filesystem at all. 

Verified-by: Vaibhav Hiremath <hvaibhav@ti.com>

Thanks,
Vaibhav

> --
> 1.6.2.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

