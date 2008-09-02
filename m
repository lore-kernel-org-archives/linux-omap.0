From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/4] ARM: OMAP2: Add support for the Gumstix Overo board
Date: Tue, 2 Sep 2008 21:58:22 +0100
Message-ID: <20080902205822.GA32575@flint.arm.linux.org.uk>
References: <1220306279-27977-1-git-send-email-sakoman@gmail.com> <1220306279-27977-2-git-send-email-sakoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44507 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbYIBU6f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 16:58:35 -0400
Content-Disposition: inline
In-Reply-To: <1220306279-27977-2-git-send-email-sakoman@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sakoman@gmail.com
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>

On Mon, Sep 01, 2008 at 02:57:56PM -0700, sakoman@gmail.com wrote:
> +		.size           =  15 * NAND_BLOCK_SIZE,

Unnecessary additional spacing after '='.

> +static struct omap_onenand_platform_data overo_onenand_data = {
> +	.parts = overo_onenand_partitions,
> +	.nr_parts = ARRAY_SIZE(overo_onenand_partitions),
> +	.dma_channel	= -1,	/* disable DMA in OMAP OneNAND driver */

Tabbing vs spacing indentation styles, please settle on one way to
do it.

> +void __init overo_flash_init(void)

Should be static?

> +{
> +	u8		cs = 0;
> +	u8		onenandcs = GPMC_CS_NUM + 1;

Do these two tabs after 'u8' help?  Everywhere else you use a single space.

> +
> +	while (cs < GPMC_CS_NUM) {
> +		u32 ret = 0;
> +		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
> +
> +		if ((ret & 0x3F) == (ONENAND_MAP >> 24))
> +			onenandcs = cs;
> +		cs++;
> +	}
> +	if (onenandcs > GPMC_CS_NUM) {
> +		printk(KERN_ERR "OneNAND: Unable to find configuration"
> +				" in GPMC\n ");

Unnecessary additional space after '\n' (which will result in the next
line output by the kernel having its level tag ignored.)

> +	if ((gpio_request(W2W_NRESET, "W2W_NRESET") == 0) &&
> +	    (gpio_direction_output(W2W_NRESET, 1) == 0)) {
> +		gpio_export(W2W_NRESET, 0);
> +		gpio_direction_output(W2W_NRESET, 0);

Since you've already just set W2W_NRESET as an output, shouldn't this
be:
		gpio_set_value(W2W_NRESET, 0);

instead?

> +		udelay(10);
> +		gpio_direction_output(W2W_NRESET, 1);

		gpio_set_value(W2W_NRESET, 1);

?  Ditto for the rest like this.

> +	} else
> +		printk(KERN_ERR "could not obtain gpio for W2W_NRESET\n");
> +
> +	if ((gpio_request(BT_NRESET, "BT_NRESET") == 0) &&
> +	    (gpio_direction_output(BT_NRESET, 1) == 0)) {
> +		gpio_export(BT_NRESET, 0);
> +		gpio_direction_output(BT_NRESET, 0);
> +		mdelay(6);
> +		gpio_direction_output(BT_NRESET, 1);
> +	} else
> +		printk(KERN_ERR "could not obtain gpio for BT_NRESET\n");
> +
> +	if ((gpio_request(USBH_CPEN, "USBH_CPEN") == 0) &&
> +	    (gpio_direction_output(USBH_CPEN, 1) == 0))
> +		gpio_export(USBH_CPEN, 0);
> +	else
> +		printk(KERN_ERR "could not obtain gpio for USBH_CPEN\n");
> +
> +	if ((gpio_request(USBH_NRESET, "USBH_NRESET") == 0) &&
> +	    (gpio_direction_output(USBH_NRESET, 1) == 0))
> +		gpio_export(USBH_NRESET, 0);
> +	else
> +		printk(KERN_ERR "could not obtain gpio for USBH_NRESET\n");
> +}
> +
> +arch_initcall(overo_i2c_init);

Is there a reason why overo_i2c_init can't be called from your
.init_machine function?

> diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
> index 438de80..f859c00 100644
> --- a/arch/arm/plat-omap/include/mach/hardware.h
> +++ b/arch/arm/plat-omap/include/mach/hardware.h
> @@ -374,6 +374,10 @@
>  #include "board-sx1.h"
>  #endif
>  
> +#ifdef CONFIG_MACH_OVERO
> +#include "board-overo.h"
> +#endif
> +

I do hate it when machine classes like to add all their platform specific
header includes into another include, meaning that whenever you touch
_any_ platform specific kernel, everything rebuilds whether it's affected
or not.

With the driver model, it just isn't necessary anymore; I would much
rather prefer to see "board-overo.h" included by files which need it,
which to me looks like being board-overo.c.

> +static int overo_panel_init(struct lcd_panel *panel,
> +				struct omapfb_device *fbdev)
> +{
> +	if ((gpio_request(LCD_ENABLE, "LCD_ENABLE") == 0) &&
> +	    (gpio_direction_output(LCD_ENABLE, 1) == 0))
> +		gpio_export(LCD_ENABLE, 0);
> +	else
> +		printk(KERN_ERR "could not obtain gpio for LCD_ENABLE\n");
> +
> +	return 0;
> +}
> +
> +static void overo_panel_cleanup(struct lcd_panel *panel)
> +{

No freeing of LCD_ENABLE?

> +}
> +
> +static int overo_panel_enable(struct lcd_panel *panel)
> +{
> +	gpio_direction_output(LCD_ENABLE, 1);

gpio_set_value() ?

> +	return 0;
> +}
> +
> +static void overo_panel_disable(struct lcd_panel *panel)
> +{
> +	gpio_direction_output(LCD_ENABLE, 0);

gpio_set_value() ?

> +static int overo_panel_probe(struct platform_device *pdev)
> +{
> +	omapfb_register_panel(&overo_panel);
> +	return 0;
> +}
> +
> +static int overo_panel_remove(struct platform_device *pdev)
> +{

No possible unregistering of the panel?

> +static int overo_panel_suspend(struct platform_device *pdev,
> +				   pm_message_t mesg)
> +{
> +	return 0;
> +}
> +
> +static int overo_panel_resume(struct platform_device *pdev)
> +{
> +	return 0;
> +}

No suspend/resume?  So these empty functions aren't required.

> +
> +struct platform_driver overo_panel_driver = {

Should be static.
