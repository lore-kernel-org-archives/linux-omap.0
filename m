From: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 4/5] arm: omap2: support port power on lan95xx devices
Date: Mon, 03 Dec 2012 00:37:53 +0800
Message-ID: <50BB83E1.7020408@linaro.org>
References: <1354460467-28006-1-git-send-email-tom.leiming@gmail.com> <1354460467-28006-5-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354460467-28006-5-git-send-email-tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 02/12/12 23:01, the mail apparently from Ming Lei included:

Hi -

> This patch defines power controller for powering on/off LAN95xx
> USB hub and USB ethernet devices, and implements one match function
> to associate the power controller with related USB port device.
> The big problem of this approach is that it depends on the global
> device ADD/DEL notifier.
>
> Another idea of associating power controller with port device
> is by introducing usb port driver, and move all this port power
> control stuff from platform code to the port driver, which is just
> what I think of and looks doable. The problem of the idea is that
> port driver is per board, so maybe cause lots of platform sort of
> code to be put under drivers/usb/port/, but this approach can avoid
> global device ADD/DEL notifier.
>
> I'd like to get some feedback about which one is better or other choi=
ce,
> then I may do it in next cycle.
>
> Cc: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   arch/arm/mach-omap2/board-omap4panda.c |   99 +++++++++++++++++++++=
++++++++++-
>   1 file changed, 96 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-o=
map2/board-omap4panda.c
> index 5c8e9ce..3183832 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -32,6 +32,8 @@
>   #include <linux/usb/musb.h>
>   #include <linux/wl12xx.h>
>   #include <linux/platform_data/omap-abe-twl6040.h>
> +#include <linux/power_controller.h>
> +#include <linux/usb/port.h>
>
>   #include <asm/hardware/gic.h>
>   #include <asm/mach-types.h>
> @@ -154,6 +156,99 @@ static struct gpio panda_ehci_gpios[] __initdata=
 =3D {
>   	{ GPIO_HUB_NRESET,	GPIOF_OUT_INIT_LOW,  "hub_nreset" },
>   };
>
> +static void ehci_hub_power_on(struct power_controller *pc, struct de=
vice *dev)
> +{
> +	gpio_set_value(GPIO_HUB_NRESET, 1);
> +	gpio_set_value(GPIO_HUB_POWER, 1);
> +}

You should wait a bit after applying power to the smsc chip before=20
letting go of nReset too.  In the regulator-based implementation I sent=
=20
it's handled by delays encoded in the regulator structs.

> +static void ehci_hub_power_off(struct power_controller *pc, struct d=
evice *dev)
> +{
> +	gpio_set_value(GPIO_HUB_NRESET, 0);
> +	gpio_set_value(GPIO_HUB_POWER, 0);
> +}
> +
> +static struct usb_port_power_switch_data root_hub_port_data =3D {
> +	.hub_tier	=3D 0,
> +	.port_number =3D 1,
> +	.type =3D USB_PORT_CONNECT_TYPE_HARD_WIRED,
> +};
> +
> +static struct usb_port_power_switch_data smsc_hub_port_data =3D {
> +	.hub_tier	=3D 1,
> +	.port_number =3D 1,
> +	.type =3D USB_PORT_CONNECT_TYPE_HARD_WIRED,
> +};
> +
> +static struct power_controller pc =3D {
> +	.name =3D "omap_hub_eth_pc",
> +	.count =3D ATOMIC_INIT(0),
> +	.power_on =3D ehci_hub_power_on,
> +	.power_off =3D ehci_hub_power_off,
> +};
> +
> +static inline int omap_ehci_hub_port(struct device *dev)
> +{
> +	/* we expect dev->parent points to ehcd controller */
> +	if (dev->parent && !strcmp(dev_name(dev->parent), "ehci-omap.0"))
> +		return 1;
> +	return 0;
> +}
> +
> +static inline int dev_pc_match(struct device *dev)
> +{
> +	struct device *anc;
> +	int ret =3D 0;
> +
> +	if (likely(strcmp(dev_name(dev), "port1")))
> +		goto exit;
> +
> +	if (dev->parent && (anc =3D dev->parent->parent)) {
> +		if (omap_ehci_hub_port(anc)) {
> +			ret =3D 1;
> +			goto exit;
> +		}
> +
> +		/* is it port of lan95xx hub? */
> +		if ((anc =3D anc->parent) && omap_ehci_hub_port(anc)) {
> +			ret =3D 2;
> +			goto exit;
> +		}
> +	}
> +exit:
> +	return ret;
> +}
> +
> +/*
> + * Notifications of device registration
> + */
> +static int device_notify(struct notifier_block *nb, unsigned long ac=
tion, void *data)
> +{
> +	struct device *dev =3D data;
> +	int ret;
> +
> +	switch (action) {
> +	case DEV_NOTIFY_ADD_DEVICE:
> +		ret =3D dev_pc_match(dev);
> +		if (likely(!ret))
> +			goto exit;
> +		if (ret =3D=3D 1)
> +			dev_pc_bind(&pc, dev, &root_hub_port_data, sizeof(root_hub_port_d=
ata));
> +		else
> +			dev_pc_bind(&pc, dev, &smsc_hub_port_data, sizeof(smsc_hub_port_d=
ata));
> +		break;
> +
> +	case DEV_NOTIFY_DEL_DEVICE:
> +		break;
> +	}
> +exit:
> +	return 0;
> +}
> +
> +static struct notifier_block usb_port_nb =3D {
> +	.notifier_call =3D device_notify,
> +};
> +

Some thoughts on trying to make this functionality specific to power=20
only and ehci hub port only:

  - Quite a few boards have smsc95xx... they're all going to carry thes=
e=20
additions in the board file?  Surely you'll have to generalize the=20
pieces that perform device_path business out of the omap4panda board=20
file at least.  At that point the path matching code becomes generic=20
end-of-the-device-path matching code.

  - How could these literals like "port1" etc be nicely provided by=20
Device Tree?  In ARM-land there's pressure to eventually eliminate boar=
d=20
files completely and pass in everything from dtb.  device_asset can=20
neatly grow DT bindings in a generic way, since the footprint in the=20
board file is some regulators that already have dt bindings and some=20
device_asset structs.  Similarly there's pressure for magic code to=20
service a board (rather than SoC) to go elsewhere than the board file.

  - Shouldn't this take care of enabling and disabling the ULPI PHY=20
clock on Panda too?  There's no purpose leaving it running if the one=20
thing the ULPI PHY is connected to is depowered, and when you do power=20
it, on Panda you will reset the ULPI PHY at the same time anyway (smsc=20
reset and ULPI PHY reset are connected together on Panda).  Then you ca=
n=20
eliminate omap4_ehci_init() in the board file.

-Andy

>   static void __init omap4_ehci_init(void)
>   {
>   	int ret;
> @@ -178,12 +273,10 @@ static void __init omap4_ehci_init(void)
>
>   	gpio_export(GPIO_HUB_POWER, 0);
>   	gpio_export(GPIO_HUB_NRESET, 0);
> -	gpio_set_value(GPIO_HUB_NRESET, 1);
>
>   	usbhs_init(&usbhs_bdata);
>
> -	/* enable power to hub */
> -	gpio_set_value(GPIO_HUB_POWER, 1);
> +	dev_register_notifier(&usb_port_nb);
>   }
>
>   static struct omap_musb_board_data musb_board_data =3D {
>


--=20
Andy Green | TI Landing Team Leader
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -=20
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
