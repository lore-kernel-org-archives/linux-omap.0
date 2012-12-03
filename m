From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [RFC PATCH 4/5] arm: omap2: support port power on lan95xx devices
Date: Mon, 3 Dec 2012 12:11:54 +0800
Message-ID: <CACVXFVNvNJJHccN=jL+N9UorwRjeC0JBMXgsB1Th_jNBeqihAw@mail.gmail.com>
References: <1354460467-28006-1-git-send-email-tom.leiming@gmail.com>
	<1354460467-28006-5-git-send-email-tom.leiming@gmail.com>
	<50BB83E1.7020408@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <50BB83E1.7020408@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lan Tianyu <tianyu.lan@intel.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Oliver Neukum <oneukum@suse.de>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 3, 2012 at 12:37 AM, Andy Green <andy.green@linaro.org> wrote:
> On 02/12/12 23:01, the mail apparently from Ming Lei included:
>
> Hi -
>
>
>> This patch defines power controller for powering on/off LAN95xx
>> USB hub and USB ethernet devices, and implements one match function
>> to associate the power controller with related USB port device.
>> The big problem of this approach is that it depends on the global
>> device ADD/DEL notifier.
>>
>> Another idea of associating power controller with port device
>> is by introducing usb port driver, and move all this port power
>> control stuff from platform code to the port driver, which is just
>> what I think of and looks doable. The problem of the idea is that
>> port driver is per board, so maybe cause lots of platform sort of
>> code to be put under drivers/usb/port/, but this approach can avoid
>> global device ADD/DEL notifier.
>>
>> I'd like to get some feedback about which one is better or other choice,
>> then I may do it in next cycle.
>>
>> Cc: Andy Green <andy.green@linaro.org>
>> Cc: Roger Quadros <rogerq@ti.com>
>> Cc: Alan Stern <stern@rowland.harvard.edu>
>> Cc: Felipe Balbi <balbi@ti.com>
>> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
>> ---
>>   arch/arm/mach-omap2/board-omap4panda.c |   99
>> +++++++++++++++++++++++++++++++-
>>   1 file changed, 96 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap4panda.c
>> b/arch/arm/mach-omap2/board-omap4panda.c
>> index 5c8e9ce..3183832 100644
>> --- a/arch/arm/mach-omap2/board-omap4panda.c
>> +++ b/arch/arm/mach-omap2/board-omap4panda.c
>> @@ -32,6 +32,8 @@
>>   #include <linux/usb/musb.h>
>>   #include <linux/wl12xx.h>
>>   #include <linux/platform_data/omap-abe-twl6040.h>
>> +#include <linux/power_controller.h>
>> +#include <linux/usb/port.h>
>>
>>   #include <asm/hardware/gic.h>
>>   #include <asm/mach-types.h>
>> @@ -154,6 +156,99 @@ static struct gpio panda_ehci_gpios[] __initdata = {
>>         { GPIO_HUB_NRESET,      GPIOF_OUT_INIT_LOW,  "hub_nreset" },
>>   };
>>
>> +static void ehci_hub_power_on(struct power_controller *pc, struct device
>> *dev)
>> +{
>> +       gpio_set_value(GPIO_HUB_NRESET, 1);
>> +       gpio_set_value(GPIO_HUB_POWER, 1);
>> +}
>
>
> You should wait a bit after applying power to the smsc chip before letting
> go of nReset too.  In the regulator-based implementation I sent it's handled
> by delays encoded in the regulator structs.

It isn't a big thing about the discussion. If these code is only platform code,
we can use gpio or regulator or other thing.

>
>
>> +static void ehci_hub_power_off(struct power_controller *pc, struct device
>> *dev)
>> +{
>> +       gpio_set_value(GPIO_HUB_NRESET, 0);
>> +       gpio_set_value(GPIO_HUB_POWER, 0);
>> +}
>> +
>> +static struct usb_port_power_switch_data root_hub_port_data = {
>> +       .hub_tier       = 0,
>> +       .port_number = 1,
>> +       .type = USB_PORT_CONNECT_TYPE_HARD_WIRED,
>> +};
>> +
>> +static struct usb_port_power_switch_data smsc_hub_port_data = {
>> +       .hub_tier       = 1,
>> +       .port_number = 1,
>> +       .type = USB_PORT_CONNECT_TYPE_HARD_WIRED,
>> +};
>> +
>> +static struct power_controller pc = {
>> +       .name = "omap_hub_eth_pc",
>> +       .count = ATOMIC_INIT(0),
>> +       .power_on = ehci_hub_power_on,
>> +       .power_off = ehci_hub_power_off,
>> +};
>> +
>> +static inline int omap_ehci_hub_port(struct device *dev)
>> +{
>> +       /* we expect dev->parent points to ehcd controller */
>> +       if (dev->parent && !strcmp(dev_name(dev->parent), "ehci-omap.0"))
>> +               return 1;
>> +       return 0;
>> +}
>> +
>> +static inline int dev_pc_match(struct device *dev)
>> +{
>> +       struct device *anc;
>> +       int ret = 0;
>> +
>> +       if (likely(strcmp(dev_name(dev), "port1")))
>> +               goto exit;
>> +
>> +       if (dev->parent && (anc = dev->parent->parent)) {
>> +               if (omap_ehci_hub_port(anc)) {
>> +                       ret = 1;
>> +                       goto exit;
>> +               }
>> +
>> +               /* is it port of lan95xx hub? */
>> +               if ((anc = anc->parent) && omap_ehci_hub_port(anc)) {
>> +                       ret = 2;
>> +                       goto exit;
>> +               }
>> +       }
>> +exit:
>> +       return ret;
>> +}
>> +
>> +/*
>> + * Notifications of device registration
>> + */
>> +static int device_notify(struct notifier_block *nb, unsigned long action,
>> void *data)
>> +{
>> +       struct device *dev = data;
>> +       int ret;
>> +
>> +       switch (action) {
>> +       case DEV_NOTIFY_ADD_DEVICE:
>> +               ret = dev_pc_match(dev);
>> +               if (likely(!ret))
>> +                       goto exit;
>> +               if (ret == 1)
>> +                       dev_pc_bind(&pc, dev, &root_hub_port_data,
>> sizeof(root_hub_port_data));
>> +               else
>> +                       dev_pc_bind(&pc, dev, &smsc_hub_port_data,
>> sizeof(smsc_hub_port_data));
>> +               break;
>> +
>> +       case DEV_NOTIFY_DEL_DEVICE:
>> +               break;
>> +       }
>> +exit:
>> +       return 0;
>> +}
>> +
>> +static struct notifier_block usb_port_nb = {
>> +       .notifier_call = device_notify,
>> +};
>> +
>
>
> Some thoughts on trying to make this functionality specific to power only
> and ehci hub port only:
>
>  - Quite a few boards have smsc95xx... they're all going to carry these
> additions in the board file?  Surely you'll have to generalize the pieces

All things are board dependent because we are discussing peripheral
device(not builtin SoC devices), so it is proper to put it in the board file.
If some boards want to share it, we can put it in a single .c file and
let board file include it.

> that perform device_path business out of the omap4panda board file at least.
> At that point the path matching code becomes generic end-of-the-device-path
> matching code.

Looks Alan has mentioned, there might be no generic way, and any device's
name change in the path may make the way fragile.

>
>  - How could these literals like "port1" etc be nicely provided by Device
> Tree?  In ARM-land there's pressure to eventually eliminate board files
> completely and pass in everything from dtb.  device_asset can neatly grow DT
> bindings in a generic way, since the footprint in the board file is some

IMO, it isn't necessary to expose these assets to device or users, from the
view of device or user, which only cares two actions(poweron and poweroff)
about the discussed problem. Also it should be better to put these assets
into device resource list, instead of introducing them in 'struct device'.

> regulators that already have dt bindings and some device_asset structs.
> Similarly there's pressure for magic code to service a board (rather than
> SoC) to go elsewhere than the board file.

Looks you associate these assets with ehci-omap device, which mightn't be
enough, because we need to control port's power for supporting port
power off mechanism. Do you have generic way to associate these assets
with usb port device and let port use it generally?

>
>  - Shouldn't this take care of enabling and disabling the ULPI PHY clock on
> Panda too?  There's no purpose leaving it running if the one thing the ULPI
> PHY is connected to is depowered, and when you do power it, on Panda you
> will reset the ULPI PHY at the same time anyway (smsc reset and ULPI PHY
> reset are connected together on Panda).  Then you can eliminate
> omap4_ehci_init() in the board file.

OK, we can include the ULPI PHY clock things easily in ->power_on() and
->power_off() of 'power controller'


Thanks,
-- 
Ming Lei
