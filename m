From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 6/6] phy: twl4030-usb: add extcon to report cable connections.
Date: Mon, 11 May 2015 19:08:41 +0530
Message-ID: <5550B0E1.7090506@ti.com>
References: <20150416075945.23307.24424.stgit@notabene.brown> <20150416080304.23307.44749.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150416080304.23307.44749.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neil@brown.name>
Cc: NeilBrown <neilb@suse.de>, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com
List-Id: linux-omap@vger.kernel.org

+extcon MAINTAINERS

Hi,

On Thursday 16 April 2015 01:33 PM, NeilBrown wrote:
> From: NeilBrown <neilb@suse.de>

commit msg pls.
>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>   drivers/phy/phy-twl4030-usb.c |   67 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 67 insertions(+)
>
> diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
> index 1d6f3e70193e..c42153d43ec2 100644
> --- a/drivers/phy/phy-twl4030-usb.c
> +++ b/drivers/phy/phy-twl4030-usb.c
> @@ -40,6 +40,7 @@
>   #include <linux/regulator/consumer.h>
>   #include <linux/err.h>
>   #include <linux/slab.h>
> +#include <linux/extcon.h>
>
>   /* Register defines */
>
> @@ -173,6 +174,9 @@ struct twl4030_usb {
>   	enum omap_musb_vbus_id_status linkstat;
>   	bool			vbus_supplied;
>
> +	/* cable connection */
> +	struct extcon_dev	edev;
> +
>   	struct delayed_work	id_workaround_work;
>   };
>
> @@ -592,6 +596,54 @@ static ssize_t twl4030_usb_id_show(struct device *dev,
>   }
>   static DEVICE_ATTR(id, 0444, twl4030_usb_id_show, NULL);
>
> +static const char *usb_cables[] = {
> +	"USB", /* id is floating */
> +	"Charger-downstream", /* id is floating and D+ shorted to D- */
> +	"USB-Host", /* id is ground */
> +	"USB-ACA", /* "Accessory Charger Adapter" id is something else */
> +	NULL
> +};
> +enum {
> +	TWL_CABLE_USB,
> +	TWL_CABLE_CHARGER,	/* Not used - twl4030 can detect charger,
> +				 * but driver cannot yet */
> +	TWL_CABLE_OTG,
> +	TWL_CABLE_ACA,
> +};
> +static u32 all_exclusive[] =  {0xFFFFFFFF, 0};
> +
> +static void twl4030_usb_report_cable(struct twl4030_usb *twl)
> +{
> +	enum twl4030_id_status sts;
> +
> +	if (!cable_present(twl->linkstat)) {
> +		extcon_set_state(&twl->edev, 0);
> +		return;
> +	}
> +
> +	sts = twl4030_get_id(twl);
> +
> +	switch (sts) {
> +	case TWL4030_FLOATING: /* USB downstream */
> +		extcon_update_state(&twl->edev,
> +				    1<<TWL_CABLE_USB,
> +				    1<<TWL_CABLE_USB);
> +		break;
> +	case TWL4030_GROUND: /* USB host */
> +		extcon_update_state(&twl->edev,
> +				    1<<TWL_CABLE_OTG,
> +				    1<<TWL_CABLE_OTG);
> +		break;
> +	default: /* Some resistor */
> +		extcon_update_state(&twl->edev,
> +				    1<<TWL_CABLE_ACA,
> +				    1<<TWL_CABLE_ACA);
> +		/* An ACA should set port to 'host' mode */
> +		twl->linkstat = OMAP_MUSB_ID_GROUND;
> +		break;
> +	}
> +}
> +
>   static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
>   {
>   	struct twl4030_usb *twl = _twl;
> @@ -628,6 +680,7 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
>   			pm_runtime_put_autosuspend(twl->dev);
>   		}
>   		omap_musb_mailbox(status);
> +		twl4030_usb_report_cable(twl);
>   	}
>
>   	/* don't schedule during sleep - irq works right then */
> @@ -766,6 +819,20 @@ static int twl4030_usb_probe(struct platform_device *pdev)
>   	}
>   	usb_add_phy_dev(&twl->phy);
>
> +	twl->edev.name = devm_kasprintf(twl->dev, GFP_KERNEL, "%s-usb",
> +					dev_name(twl->dev->parent));
> +	twl->edev.supported_cable = usb_cables;
> +	twl->edev.mutually_exclusive = all_exclusive;
> +	twl->edev.print_name = NULL; /* why would you change this? */
> +	twl->edev.print_state = NULL; /* probably want to change this */

Not sure about those two callbacks. Chanwoo?

Thanks
Kishon
