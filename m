From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH v3 4/7] mfd: omap: control: usb-phy:
 introduce the ctrl-module usb driver
Date: Thu, 28 Jun 2012 07:58:21 +0300
Message-ID: <20120628045821.GD2471@besouro>
References: <4FEB4B4C.9040501@dev.rtsoft.ru>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4FEB4B4C.9040501@dev.rtsoft.ru>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: balbi@ti.com, kishon@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello,

On Wed, Jun 27, 2012 at 10:05:00PM +0400, Konstantin Baydarov wrote:
> Created a new platform driver for the platform device created by the
> control module mfd core, wrt usb. This driver has API's to power on/off
> the phy and the API's to write to musb mailbox.
> 
> Changes since previous version:
> - Bandgap and usb phy: drivers are now independent from control module driver, they use
> their own functions to acess scm registers.
> - Parent SCM platform device IOMEM resources is used to get the base address of SCM window.
> - SCM Dependency was removed from Kconfig.
> - Bandgap and usb phy: Added private spinlocks for bandgap and usb drivers.
> 
> (p.s. the mailbox for musb in omap4 is present in system control
> module)
> 
> [kishon@ti.com: wrote the original API's related to USB functions]
> Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
>  drivers/usb/otg/Kconfig           |   12 +++
>  drivers/usb/otg/Makefile          |    1 +
>  drivers/usb/otg/omap4-usb-phy.c   |  170 +++++++++++++++++++++++++++++++++++++
>  include/linux/usb/omap4_usb_phy.h |   53 ++++++++++++
>  4 files changed, 236 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/usb/otg/omap4-usb-phy.c
>  create mode 100644 include/linux/usb/omap4_usb_phy.h
> 
> diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
> index 5c87db0..0ed691b 100644
> --- a/drivers/usb/otg/Kconfig
> +++ b/drivers/usb/otg/Kconfig
> @@ -78,6 +78,18 @@ config TWL6030_USB
>  	  are hooked to this driver through platform_data structure.
>  	  The definition of internal PHY APIs are in the mach-omap2 layer.
>  
> +config OMAP4_USB_PHY
> +	tristate "Texas Instruments OMAP4+ USB pin control driver"
> +	help
> +	  If you say yes here you get support for the Texas Instruments
> +	  OMAP4+ USB pin control driver. The register set is part of system
> +	  control module.
> +
> +	  USB phy in OMAP configures control module register for powering on
> +	  the phy, configuring VBUSVALID, AVALID, IDDIG and SESSEND. For
> +	  performing the above mentioned configuration, API's are added in
> +	  by this children of the control module driver.
> +
>  config NOP_USB_XCEIV
>  	tristate "NOP USB Transceiver Driver"
>  	select USB_OTG_UTILS
> diff --git a/drivers/usb/otg/Makefile b/drivers/usb/otg/Makefile
> index 41aa509..60c8c83 100644
> --- a/drivers/usb/otg/Makefile
> +++ b/drivers/usb/otg/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_USB_GPIO_VBUS)	+= gpio_vbus.o
>  obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
>  obj-$(CONFIG_TWL4030_USB)	+= twl4030-usb.o
>  obj-$(CONFIG_TWL6030_USB)	+= twl6030-usb.o
> +obj-$(CONFIG_OMAP4_USB_PHY)	+= omap4-usb-phy.o
>  obj-$(CONFIG_NOP_USB_XCEIV)	+= nop-usb-xceiv.o
>  obj-$(CONFIG_USB_ULPI)		+= ulpi.o
>  obj-$(CONFIG_USB_ULPI_VIEWPORT)	+= ulpi_viewport.o
> diff --git a/drivers/usb/otg/omap4-usb-phy.c b/drivers/usb/otg/omap4-usb-phy.c
> new file mode 100644
> index 0000000..cbea2ea
> --- /dev/null
> +++ b/drivers/usb/otg/omap4-usb-phy.c
> @@ -0,0 +1,170 @@
> +/*
> + * OMAP4 system control module driver, USB control children
> + *
> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * Contact:
> + *    Kishon Vijay Abraham I <kishon@ti.com>
> + *    Eduardo Valentin <eduardo.valentin@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/gpio.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/usb/omap4_usb_phy.h>
> +
> +void __iomem *omap_usb_phy_base;
> +spinlock_t omap_usb_phy_lock;
> +
> +static int omap_usb_phy_readl(u32 reg, u32 *val)
> +{
> +	if (!omap_usb_phy_base)
> +		return -EINVAL;
> +
> +	*val = __raw_readl(omap_usb_phy_base + reg);
> +	return 0;
> +}
> +
> +/*
> + * TODO: Get rid from omap_usb_phy_writel() return value -
> + * It's useless.

if you do that remember to keep a WARN_ON in case the base address is not set.

> + */
> +static int omap_usb_phy_writel(u32 val, u32 reg)
> +{
> +	unsigned long flags;
> +
> +	if (!omap_usb_phy_base)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&omap_usb_phy_lock, flags);
> +	__raw_writel(val, omap_usb_phy_base + reg);
> +	spin_unlock_irqrestore(&omap_usb_phy_lock, flags);

I think it is better to lock per operation than per write.

> +	return 0;
> +}
> +
> +/**
> + * omap4_usb_phy_power - power on/off the phy using control module reg
> + * @dev: struct device *
> + * @on: 0 or 1, based on powering on or off the PHY
> + *
> + * omap_usb2 can call this API to power on or off the PHY.
> + */
> +int omap4_usb_phy_power(struct device *dev, int on)
> +{
> +	u32 val;
> +	int ret;
> +
> +	if (on) {
> +		ret = omap_usb_phy_readl(CONTROL_DEV_CONF, &val);
> +		if (!ret && (val & PHY_PD)) {
> +			ret = omap_usb_phy_writel(~PHY_PD,
> +						  CONTROL_DEV_CONF);
> +			/* XXX: add proper documentation for this delay */
> +			mdelay(200);
> +		}
> +	} else
> +		ret = omap_usb_phy_writel(PHY_PD, CONTROL_DEV_CONF);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(omap4_usb_phy_power);
> +
> +/**
> + * omap4_usb_phy_mailbox - write to usb otg mailbox
> + * @dev: struct device *
> + * @val: the value to be written to the mailbox
> + *
> + * On detection of a device (ID pin is grounded), the phy should call this API
> + * to set AVALID, VBUSVALID and ID pin is grounded.
> + *
> + * When OMAP is connected to a host (OMAP in device mode), the phy should call
> + * this API to set AVALID, VBUSVALID and ID pin in high impedance.
> + *
> + * The phy should call this API, if OMAP is disconnected from host or device.
> + */
> +int omap4_usb_phy_mailbox(struct device *dev, u32 val)
> +{
> +	return omap_usb_phy_writel(val, CONTROL_USBOTGHS_CONTROL);
> +}
> +EXPORT_SYMBOL_GPL(omap4_usb_phy_mailbox);
> +
> +static int __devinit omap_usb_phy_probe(struct platform_device *pdev)
> +{
> +	struct resource *io_res;
> +	struct platform_device *pparent;
> +
> +	if (!pdev->dev.parent) {
> +		dev_err(&pdev->dev, "No parent device!\n");
> +		return -ENOMEM;
> +	}
> +
> +	pparent = to_platform_device(pdev->dev.parent);
> +
> +	io_res = platform_get_resource(pparent, IORESOURCE_MEM, 0);

Can someone please explain me what do we gain by doing this at children code?

> +	if (!io_res)
> +		return -ENOENT;
> +
> +	omap_usb_phy_base = ioremap(io_res->start, resource_size(io_res));
> +	if (!omap_usb_phy_base)
> +		return -ENOMEM;
> +
> +	/* Initialize register lock */
> +	spin_lock_init(&omap_usb_phy_lock);
> +
> +	return 0;
> +}
> +
> +static int __devexit omap_usb_phy_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static const struct of_device_id of_omap_usb_phy_match[] = {
> +	{ .compatible = "ti,omap4-usb-phy", },
> +	{ },
> +};
> +
> +static struct platform_driver omap_usb_phy_driver = {
> +	.probe = omap_usb_phy_probe,
> +	.remove = __devexit_p(omap_usb_phy_remove),
> +	.driver = {
> +			.name	= "omap4-usb-phy",
> +			.owner	= THIS_MODULE,
> +			.of_match_table	= of_omap_usb_phy_match,
> +	},
> +};
> +
> +static int __init omap_usb_phy_init(void)
> +{
> +	return platform_driver_register(&omap_usb_phy_driver);
> +}
> +postcore_initcall(omap_usb_phy_init);
> +
> +static void __exit omap_usb_phy_exit(void)
> +{
> +	platform_driver_unregister(&omap_usb_phy_driver);
> +}
> +module_exit(omap_usb_phy_exit);
> +
> +MODULE_DESCRIPTION("OMAP4+ USB-phy driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform: omap4-usb-phy");
> +MODULE_AUTHOR("Texas Instrument Inc.");
> diff --git a/include/linux/usb/omap4_usb_phy.h b/include/linux/usb/omap4_usb_phy.h
> new file mode 100644
> index 0000000..b6a4701
> --- /dev/null
> +++ b/include/linux/usb/omap4_usb_phy.h
> @@ -0,0 +1,53 @@
> +/*
> + * OMAP4 USB-phy
> + *
> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * Contact:
> + *    Kishon Vijay Abraham I <kishon@ti.com>
> + *    Eduardo Valentin <eduardo.valentin@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#ifndef __OMAP4_USB_PHY_H
> +#define __OMAP4_USB_PHY_H
> +
> +#define	PHY_PD				0x1
> +#define	AVALID				BIT(0)
> +#define	BVALID				BIT(1)
> +#define	VBUSVALID			BIT(2)
> +#define	SESSEND				BIT(3)
> +#define	IDDIG				BIT(4)
> +#define	CONTROL_DEV_CONF		0x00000300
> +#define	CONTROL_USBOTGHS_CONTROL	0x0000033C
> +
> +/* USB-PHY helpers */
> +#if (defined(CONFIG_OMAP4_USB_PHY)) || (defined(CONFIG_OMAP4_USB_PHY_MODULE))
> +extern int omap4_usb_phy_mailbox(struct device *dev, u32 val);
> +extern int omap4_usb_phy_power(struct device *dev, int on);
> +#else
> +static inline int omap4_usb_phy_mailbox(struct device *dev, u32 val)
> +{
> +	return 0;
> +}
> +static inline int omap4_usb_phy_power(struct device *dev, int on)
> +{
> +	return 0;
> +}
> +#endif
> +
> +#endif
> -- 
> 1.7.7.6
> 
> 
