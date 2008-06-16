From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH  1/4] McBSP support  for 34XX
Date: Mon, 16 Jun 2008 15:46:21 +0300
Message-ID: <20080616124620.GB8848@atomide.com>
References: <003b01c8cfab$6f16edb0$318918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63854 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbYFPMpr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jun 2008 08:45:47 -0400
Content-Disposition: inline
In-Reply-To: <003b01c8cfab$6f16edb0$318918ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandra shekhar <x0044955@ti.com>
Cc: linux-omap@vger.kernel.org

* Chandra shekhar <x0044955@ti.com> [080616 15:23]:
> 
> Signed-off-by: chandra shekhar <x0044955@ti.com>
> ---
>  arch/arm/configs/omap_3430sdp_defconfig |    1 
>  arch/arm/mach-omap2/mcbsp.c             |   45 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/mcbsp.c              |    2 -
>  include/asm-arm/arch-omap/mcbsp.h       |   34 ++++++++++++++++++++++--
>  4 files changed, 79 insertions(+), 3 deletions(-)
> 
> Index: linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h
> ===================================================================
> --- linux-omap-2.6.orig/include/asm-arm/arch-omap/mcbsp.h	2008-06-14 16:40:58.012054175 +0530
> +++ linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h	2008-06-14 16:51:20.795567825 +0530
> @@ -46,6 +46,9 @@
>  
>  #define OMAP34XX_MCBSP1_BASE	0x48074000
>  #define OMAP34XX_MCBSP2_BASE	0x49022000
> +#define OMAP34XX_MCBSP3_BASE	0x49024000
> +#define OMAP34XX_MCBSP4_BASE	0x49026000
> +#define OMAP34XX_MCBSP5_BASE	0x48096000
>  
>  #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP730)
>  
> @@ -97,6 +100,8 @@
>  #define OMAP_MCBSP_REG_DRR1	0x04
>  #define OMAP_MCBSP_REG_DXR2	0x08
>  #define OMAP_MCBSP_REG_DXR1	0x0C
> +#define OMAP_MCBSP_REG_DRR	0x00
> +#define OMAP_MCBSP_REG_DXR	0x08
>  #define OMAP_MCBSP_REG_SPCR2	0x10
>  #define OMAP_MCBSP_REG_SPCR1	0x14
>  #define OMAP_MCBSP_REG_RCR2	0x18
> @@ -124,8 +129,10 @@
>  #define OMAP_MCBSP_REG_RCERH	0x70
>  #define OMAP_MCBSP_REG_XCERG	0x74
>  #define OMAP_MCBSP_REG_XCERH	0x78
> +#define OMAP_MCBSP_REG_SYSCON   0x8C
> +#define OMAP_MCBSP_REG_XCCR     0xAC
> +#define OMAP_MCBSP_REG_RCCR     0xB0
>  
> -#define OMAP_MAX_MCBSP_COUNT	2
>  #define MAX_MCBSP_CLOCKS	2
>  
>  #define AUDIO_MCBSP_DATAWRITE	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR1)
> @@ -135,11 +142,18 @@
>  #define AUDIO_DMA_TX		OMAP24XX_DMA_MCBSP2_TX
>  #define AUDIO_DMA_RX		OMAP24XX_DMA_MCBSP2_RX
>  
> +#if defined CONFIG_ARCH_OMAP2420
> +#define OMAP_MAX_MCBSP_COUNT    2
> +#else
> +#define OMAP_MAX_MCBSP_COUNT	5
> +#endif
> +

This count needs to be set dynamically during init using
if (cpu_is_omap34xx()). Otherwise compiling in support for
24xx and 34xx into the same kernel will fail to boot properly.


>  #endif
>  
>  #define OMAP_MCBSP_READ(base, reg)		__raw_readw((base) + OMAP_MCBSP_REG_##reg)
>  #define OMAP_MCBSP_WRITE(base, reg, val)	__raw_writew((val), (base) + OMAP_MCBSP_REG_##reg)
>  
> +#define OMAP_MCBSP_BIT(ARG)	((0x01)<<(ARG))

Please add spaces around the << above. Also, 0x01 does not need to be
in braces.


>  
>  /************************** McBSP SPCR1 bit definitions ***********************/
>  #define RRST			0x0001
> @@ -151,6 +165,7 @@
>  #define DXENA			0x0080
>  #define CLKSTP(value)		((value)<<11)	/* bits 11:12 */
>  #define RJUST(value)		((value)<<13)	/* bits 13:14 */

Spaces around the << here too.


> +#define ALB			0x8000
>  #define DLB			0x8000
>  
>  /************************** McBSP SPCR2 bit definitions ***********************/
> @@ -228,6 +243,19 @@
>  #define XPABLK(value)		((value)<<5)	/* Bits 5:6 */
>  #define XPBBLK(value)		((value)<<7)	/* Bits 7:8 */

Here too.


> +/*********************** McBSP XCCR bit definitions *************************/
> +#define DILB			OMAP_MCBSP_BIT(5)
> +#define XDMAEN			OMAP_MCBSP_BIT(3)
> +#define XDISABLE		OMAP_MCBSP_BIT(0)
> +
> +/********************** McBSP RCCR bit definitions *************************/
> +#define RDMAEN			OMAP_MCBSP_BIT(3)
> +#define RDISABLE		OMAP_MCBSP_BIT(0)
> +
> +/********************** McBSP SYSCONFIG bit definitions ********************/
> +#define SOFTRST			OMAP_MCBSP_BIT(1)
> +
> +/********************** MACRO DEFINITIONS *********************************/
>  
>  /* we don't do multichannel for now */
>  struct omap_mcbsp_reg_cfg {
> @@ -260,6 +288,8 @@ typedef enum {
>  	OMAP_MCBSP1 = 0,
>  	OMAP_MCBSP2,
>  	OMAP_MCBSP3,
> +	OMAP_MCBSP4,
> +	OMAP_MCBSP5
>  } omap_mcbsp_id;
>  
>  typedef int __bitwise omap_mcbsp_io_type_t;
> @@ -352,6 +382,7 @@ struct omap_mcbsp {
>  	struct omap_mcbsp_platform_data *pdata;
>  	struct clk *clk;
>  };
> +extern struct omap_mcbsp mcbsp[OMAP_MAX_MCBSP_COUNT];
>  
>  int omap_mcbsp_init(void);
>  void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
> @@ -369,7 +400,6 @@ int omap_mcbsp_recv_buffer(unsigned int 
>  int omap_mcbsp_spi_master_xmit_word_poll(unsigned int id, u32 word);
>  int omap_mcbsp_spi_master_recv_word_poll(unsigned int id, u32 * word);
>  
> -
>  /* SPI specific API */
>  void omap_mcbsp_set_spi_mode(unsigned int id, const struct omap_mcbsp_spi_cfg * spi_cfg);
>  
> Index: linux-omap-2.6/arch/arm/mach-omap2/mcbsp.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/mcbsp.c	2008-06-14 16:40:58.012054175 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/mcbsp.c	2008-06-14 16:41:38.126799140 +0530
> @@ -89,6 +89,30 @@ static struct mcbsp_internal_clk omap_mc
>  			.disable	= omap_mcbsp_clk_disable,
>  		},
>  	},
> +	{
> +		.clk = {
> +			.name 		= "mcbsp_clk",
> +			.id		= 3,
> +			.enable		= omap_mcbsp_clk_enable,
> +			.disable	= omap_mcbsp_clk_disable,
> +		},
> +	},
> +	{
> +		.clk = {
> +			.name 		= "mcbsp_clk",
> +			.id		= 4,
> +			.enable		= omap_mcbsp_clk_enable,
> +			.disable	= omap_mcbsp_clk_disable,
> +		},
> +	},
> +	{
> +		.clk = {
> +			.name 		= "mcbsp_clk",
> +			.id		= 5,
> +			.enable		= omap_mcbsp_clk_enable,
> +			.disable	= omap_mcbsp_clk_disable,
> +		},
> +	},
>  };
>  
>  #define omap_mcbsp_clks_size	ARRAY_SIZE(omap_mcbsp_clks)
> @@ -178,6 +202,27 @@ static struct omap_mcbsp_platform_data o
>  		.ops		= &omap2_mcbsp_ops,
>  		.clk_name	= "mcbsp_clk",
>  	},
> +	{
> +		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP3_BASE),
> +		.dma_rx_sync	= OMAP24XX_DMA_MCBSP3_RX,
> +		.dma_tx_sync	= OMAP24XX_DMA_MCBSP3_TX,
> +		.ops		= &omap2_mcbsp_ops,
> +		.clk_name	= "mcbsp_clk",
> +	},
> +	{
> +		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP4_BASE),
> +		.dma_rx_sync	= OMAP24XX_DMA_MCBSP4_RX,
> +		.dma_tx_sync	= OMAP24XX_DMA_MCBSP4_TX,
> +		.ops		= &omap2_mcbsp_ops,
> +		.clk_name	= "mcbsp_clk",
> +	},
> +	{
> +		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP5_BASE),
> +		.dma_rx_sync	= OMAP24XX_DMA_MCBSP5_RX,
> +		.dma_tx_sync	= OMAP24XX_DMA_MCBSP5_TX,
> +		.ops		= &omap2_mcbsp_ops,
> +		.clk_name	= "mcbsp_clk",
> +	},
>  };

Can you please change the above to use OMAP2_IO_ADDRESS() instead of
IO_ADDRESS()? That way we don't need to patch it again for multi-omap
in the future :)


>  #define OMAP34XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap34xx_mcbsp_pdata)
>  #else
> Index: linux-omap-2.6/arch/arm/configs/omap_3430sdp_defconfig
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/configs/omap_3430sdp_defconfig	2008-06-14 16:40:58.012054175 +0530
> +++ linux-omap-2.6/arch/arm/configs/omap_3430sdp_defconfig	2008-06-14 16:41:38.127799108 +0530
> @@ -522,6 +522,7 @@ CONFIG_MISC_DEVICES=y
>  # CONFIG_EEPROM_93CX6 is not set
>  # CONFIG_OMAP_STI is not set
>  # CONFIG_ENCLOSURE_SERVICES is not set
> +CONFIG_OMAP_MCBSP=y
>  CONFIG_HAVE_IDE=y
>  # CONFIG_IDE is not set
>  
> Index: linux-omap-2.6/arch/arm/plat-omap/mcbsp.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/mcbsp.c	2008-06-14 16:40:58.012054175 +0530
> +++ linux-omap-2.6/arch/arm/plat-omap/mcbsp.c	2008-06-14 16:41:38.127799108 +0530
> @@ -28,7 +28,7 @@
>  #include <asm/arch/dma.h>
>  #include <asm/arch/mcbsp.h>
>  
> -static struct omap_mcbsp mcbsp[OMAP_MAX_MCBSP_COUNT];
> +struct omap_mcbsp mcbsp[OMAP_MAX_MCBSP_COUNT];

Can you please change it to kzalloc the needed number of ports? You
might want to do that as a separate patch first before adding support
for 34xx.

Regards,

Tony


>  
>  #define omap_mcbsp_check_valid_id(id)	(mcbsp[id].pdata && \
>  					mcbsp[id].pdata->ops && \
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
