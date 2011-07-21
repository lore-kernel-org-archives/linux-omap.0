From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 2/2] omap4: board-omap4pcm049: add Phytec phyCORE-OMAP4
Date: Thu, 21 Jul 2011 00:38:34 -0700
Message-ID: <20110721073833.GD5783@atomide.com>
References: <20110718084259.GY5783@atomide.com>
 <1311075927-5562-3-git-send-email-j.weitzel@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59916 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752725Ab1GUHig (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jul 2011 03:38:36 -0400
Content-Disposition: inline
In-Reply-To: <1311075927-5562-3-git-send-email-j.weitzel@phytec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Weitzel <j.weitzel@phytec.de>
Cc: linux-omap@vger.kernel.org

* Jan Weitzel <j.weitzel@phytec.de> [110719 04:40]:
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -240,6 +240,10 @@ obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board-omap4panda.o \
>  					   board-omap4panda-common.o \
>  					   hsmmc.o \
>  					   omap_phy_internal.o
> +obj-$(CONFIG_MACH_MACH_PCM049)		+= board-pcm049.o \

                ^^^^
Extra mach above?

> +					   board-omap4panda-common.o \
> +					   hsmmc.o \
> +					   omap_phy_internal.o
>  
>  obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o \
>  					   omap_phy_internal.o \

Maybe use just board-panda-common.o here instead? And in the Makefile
it can be compiled in with something like:

obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board-panda-common.o
obj-$(CONFIG_MACH_PCM049)		+= board-panda-common.o
...

obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board-omap4panda.o
obj-$(CONFIG_MACH_PCM049)		+= board-pcm049.o
...

I already posted a patch to get rid of repeating the hsmmc.o
for each board using it.

> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/leds.h>
> +#include <linux/gpio.h>
> +#include <linux/usb/otg.h>
> +#include <linux/i2c/twl.h>
> +#include <linux/i2c/at24.h>
> +#include <linux/mfd/stmpe.h>
> +#include <linux/leds-pca9532.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regulator/fixed.h>
> +#include <linux/wl12xx.h>
> +#include <linux/smsc911x.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/omap4-common.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <video/omapdss.h>
> +
> +#include <plat/board.h>
> +#include <plat/common.h>
> +#include <plat/usb.h>
> +#include <plat/gpmc.h>
> +#include <plat/gpmc-smsc911x.h>
> +#include <plat/mmc.h>
> +#include <video/omap-panel-generic-dpi.h>
> +
> +#include "hsmmc.h"
> +#include "control.h"
> +#include "mux.h"
> +#include "common-board-devices.h"
> +#include "board-omap4panda-common.h"

Maybe check which includes are now needed with the panda-common?

> +struct omap_dss_device pcm049_dpi_device = {
> +	.type			= OMAP_DISPLAY_TYPE_DPI,
> +	.name			= "dpi",
> +	.driver_name		= "generic_dpi_panel",
> +	.data			= &omap4_dpi_panel,
> +	.phy.dpi.data_lines	= 24,
> +	.channel		= OMAP_DSS_CHANNEL_LCD2,
> +};

Usually tabs are used for aligning the structs like above..

> +static struct omap_dss_device  pcm049_dvi_device = {
> +	.name = "dvi",
> +	.driver_name = "hdmi_panel",
> +	.type = OMAP_DISPLAY_TYPE_HDMI,

.. so please align the structs with tabs for the new data too.
Please check the data structs in all your patches while at it.
Also looks like there's an extra space above before
pcm049_dvi_device.

> +static struct stmpe_platform_data pba_stm_pdata = {
> +	.blocks = STMPE_BLOCK_GPIO | STMPE_BLOCK_TOUCHSCREEN,
> +	.irq_base = TWL6030_IRQ_END,
> +	.irq_trigger = IRQF_TRIGGER_RISING,
> +	.irq_invert_polarity = true,
> +	.gpio = &pba_gpio_stm_data,
> +	.ts = &pba_ts_stm_pdata,
> +};

Here too please check the alignment.

Regards,

Tony
