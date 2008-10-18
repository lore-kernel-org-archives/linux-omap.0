From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] omap: Add basic support for Pandora handheld console
Date: Sat, 18 Oct 2008 22:55:29 +0300
Message-ID: <20081018195518.GQ31842@frodo>
References: <1224357743-23060-1-git-send-email-notasas@gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:35413 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbYJRTzp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Oct 2008 15:55:45 -0400
Content-Disposition: inline
In-Reply-To: <1224357743-23060-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org

On Sat, Oct 18, 2008 at 10:22:23PM +0300, Grazvydas Ignotas wrote:
> +static struct mtd_partition omap3pandora_nand_partitions[] = {
> +	{
> +		.name           = "xloader",
> +		.offset         = 0,			/* Offset = 0x00000 */
> +		.size           = 4 * NAND_BLOCK_SIZE,
> +		.mask_flags     = MTD_WRITEABLE
> +	},
> +	{

}, { looks better

> +		.name           = "uboot",
> +		.offset         = MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
> +		.size           = 14 * NAND_BLOCK_SIZE,
> +	},
> +	{
> +		.name           = "uboot environment",
> +		.offset         = MTDPART_OFS_APPEND,	/* Offset = 0x240000 */
> +		.size           = 2 * NAND_BLOCK_SIZE,
> +	},
> +	{
> +		.name           = "linux",
> +		.offset         = MTDPART_OFS_APPEND,	/* Offset = 0x280000 */
> +		.size           = 32 * NAND_BLOCK_SIZE,
> +	},
> +	{
> +		.name           = "rootfs",
> +		.offset         = MTDPART_OFS_APPEND,	/* Offset = 0x680000 */
> +		.size           = MTDPART_SIZ_FULL,
> +	},
> +};
> +
> +static struct omap_nand_platform_data omap3pandora_nand_data = {
> +	.parts = omap3pandora_nand_partitions,
> +	.nr_parts = ARRAY_SIZE(omap3pandora_nand_partitions),
> +	.dma_channel = -1,	/* disable DMA in OMAP NAND driver */

tabify these:

.parts		= omap3pandora_nand_partitions,

etc

> +};
> +
> +static struct resource omap3pandora_nand_resource = {
> +	.flags		= IORESOURCE_MEM,
> +};

this should be:

static struct resource omap3pandora_nand_resource[] = {
	{
		.flags	= IORESOURCE_MEM,
	},
};

> +
> +static struct platform_device omap3pandora_nand_device = {
> +	.name		= "omap2-nand",
> +	.id		= -1,
> +	.dev		= {
> +		.platform_data	= &omap3pandora_nand_data,
> +	},
> +	.num_resources	= 1,

and this should be:

ARRAY_SIZE(omap3pandora_nand_resource);

> +	.resource	= &omap3pandora_nand_resource,

and this won't need & operator

> +};
> +
> +

one blank line is enough :-)

> +static void __init omap3pandora_flash_init(void)
> +{
> +	u8 cs = 0;
> +	u8 nandcs = GPMC_CS_NUM + 1;
> +
> +	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
> +
> +	/* find out the chip-select on which NAND exists */
> +	while (cs < GPMC_CS_NUM) {
> +		u32 ret = 0;
> +		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> +
> +		if ((ret & 0xC00) == 0x800) {
> +			printk(KERN_INFO "Found NAND on CS%d\n", cs);
> +			if (nandcs > GPMC_CS_NUM)
> +				nandcs = cs;
> +		}
> +		cs++;
> +	}
> +
> +	if (nandcs > GPMC_CS_NUM) {
> +		printk(KERN_INFO "NAND: Unable to find configuration "
> +				 "in GPMC\n ");
> +		return;
> +	}
> +
> +	if (nandcs < GPMC_CS_NUM) {
> +		omap3pandora_nand_data.cs = nandcs;
> +		omap3pandora_nand_data.gpmc_cs_baseaddr = (void *)
> +			(gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
> +		omap3pandora_nand_data.gpmc_baseaddr = (void *) (gpmc_base_add);
> +
> +		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
> +		if (platform_device_register(&omap3pandora_nand_device) < 0)
> +			printk(KERN_ERR "Unable to register NAND device\n");
> +	}
> +}

please add a blank line here.

> +static struct omap_uart_config omap3pandora_uart_config __initdata = {
> +	.enabled_uarts	= (1 << 2), /* UART3 */
> +};

please add a blank line here.

> +static struct twl4030_gpio_platform_data omap3pandora_gpio_data = {
> +	.gpio_base	= OMAP_MAX_GPIO_LINES,
> +	.irq_base	= TWL4030_GPIO_IRQ_BASE,
> +	.irq_end	= TWL4030_GPIO_IRQ_END,
> +};

<snip>

> +static void __init omap3pandora_init(void)
> +{
> +	omap3pandora_i2c_init();
> +	platform_add_devices(omap3pandora_devices, ARRAY_SIZE(omap3pandora_devices));
> +	omap_board_config = omap3pandora_config;
> +	omap_board_config_size = ARRAY_SIZE(omap3pandora_config);
> +	omap_serial_init();
> +	hsmmc_init();
> +	usb_musb_init();
> +	usb_ehci_init();

Are you guys really using both ??

do you have an otg port on pandora ??

-- 
balbi
