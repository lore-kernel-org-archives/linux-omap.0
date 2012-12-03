From: Andy Green <andy.green@linaro.org>
Subject: Re: [RFC PATCH 4/5] arm: omap2: support port power on lan95xx devices
Date: Mon, 03 Dec 2012 12:52:19 +0800
Message-ID: <50BC3003.80608@linaro.org>
References: <1354460467-28006-1-git-send-email-tom.leiming@gmail.com> <1354460467-28006-5-git-send-email-tom.leiming@gmail.com> <50BB83E1.7020408@linaro.org> <CACVXFVNvNJJHccN=jL+N9UorwRjeC0JBMXgsB1Th_jNBeqihAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CACVXFVNvNJJHccN=jL+N9UorwRjeC0JBMXgsB1Th_jNBeqihAw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lan Tianyu <tianyu.lan@intel.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Oliver Neukum <oneukum@suse.de>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

On 03/12/12 12:11, the mail apparently from Ming Lei included:
> On Mon, Dec 3, 2012 at 12:37 AM, Andy Green <andy.green@linaro.org> w=
rote:
>> On 02/12/12 23:01, the mail apparently from Ming Lei included:
>>
>> Hi -
>>
>>
>>> This patch defines power controller for powering on/off LAN95xx
>>> USB hub and USB ethernet devices, and implements one match function
>>> to associate the power controller with related USB port device.
>>> The big problem of this approach is that it depends on the global
>>> device ADD/DEL notifier.
>>>
>>> Another idea of associating power controller with port device
>>> is by introducing usb port driver, and move all this port power
>>> control stuff from platform code to the port driver, which is just
>>> what I think of and looks doable. The problem of the idea is that
>>> port driver is per board, so maybe cause lots of platform sort of
>>> code to be put under drivers/usb/port/, but this approach can avoid
>>> global device ADD/DEL notifier.
>>>
>>> I'd like to get some feedback about which one is better or other ch=
oice,
>>> then I may do it in next cycle.
>>>
>>> Cc: Andy Green <andy.green@linaro.org>
>>> Cc: Roger Quadros <rogerq@ti.com>
>>> Cc: Alan Stern <stern@rowland.harvard.edu>
>>> Cc: Felipe Balbi <balbi@ti.com>
>>> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
>>> ---
>>>    arch/arm/mach-omap2/board-omap4panda.c |   99
>>> +++++++++++++++++++++++++++++++-
>>>    1 file changed, 96 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/board-omap4panda.c
>>> b/arch/arm/mach-omap2/board-omap4panda.c
>>> index 5c8e9ce..3183832 100644
>>> --- a/arch/arm/mach-omap2/board-omap4panda.c
>>> +++ b/arch/arm/mach-omap2/board-omap4panda.c
>>> @@ -32,6 +32,8 @@
>>>    #include <linux/usb/musb.h>
>>>    #include <linux/wl12xx.h>
>>>    #include <linux/platform_data/omap-abe-twl6040.h>
>>> +#include <linux/power_controller.h>
>>> +#include <linux/usb/port.h>
>>>
>>>    #include <asm/hardware/gic.h>
>>>    #include <asm/mach-types.h>
>>> @@ -154,6 +156,99 @@ static struct gpio panda_ehci_gpios[] __initda=
ta =3D {
>>>          { GPIO_HUB_NRESET,      GPIOF_OUT_INIT_LOW,  "hub_nreset" =
},
>>>    };
>>>
>>> +static void ehci_hub_power_on(struct power_controller *pc, struct =
device
>>> *dev)
>>> +{
>>> +       gpio_set_value(GPIO_HUB_NRESET, 1);
>>> +       gpio_set_value(GPIO_HUB_POWER, 1);
>>> +}
>>
>>
>> You should wait a bit after applying power to the smsc chip before l=
etting
>> go of nReset too.  In the regulator-based implementation I sent it's=
 handled
>> by delays encoded in the regulator structs.
>
> It isn't a big thing about the discussion. If these code is only plat=
form code,
> we can use gpio or regulator or other thing.

Well, you need a delay there FYI.  It's just a nit.

>>> +static void ehci_hub_power_off(struct power_controller *pc, struct=
 device
>>> *dev)
>>> +{
>>> +       gpio_set_value(GPIO_HUB_NRESET, 0);
>>> +       gpio_set_value(GPIO_HUB_POWER, 0);
>>> +}
>>> +
>>> +static struct usb_port_power_switch_data root_hub_port_data =3D {
>>> +       .hub_tier       =3D 0,
>>> +       .port_number =3D 1,
>>> +       .type =3D USB_PORT_CONNECT_TYPE_HARD_WIRED,
>>> +};
>>> +
>>> +static struct usb_port_power_switch_data smsc_hub_port_data =3D {
>>> +       .hub_tier       =3D 1,
>>> +       .port_number =3D 1,
>>> +       .type =3D USB_PORT_CONNECT_TYPE_HARD_WIRED,
>>> +};
>>> +
>>> +static struct power_controller pc =3D {
>>> +       .name =3D "omap_hub_eth_pc",
>>> +       .count =3D ATOMIC_INIT(0),
>>> +       .power_on =3D ehci_hub_power_on,
>>> +       .power_off =3D ehci_hub_power_off,
>>> +};
>>> +
>>> +static inline int omap_ehci_hub_port(struct device *dev)
>>> +{
>>> +       /* we expect dev->parent points to ehcd controller */
>>> +       if (dev->parent && !strcmp(dev_name(dev->parent), "ehci-oma=
p.0"))
>>> +               return 1;
>>> +       return 0;
>>> +}
>>> +
>>> +static inline int dev_pc_match(struct device *dev)
>>> +{
>>> +       struct device *anc;
>>> +       int ret =3D 0;
>>> +
>>> +       if (likely(strcmp(dev_name(dev), "port1")))
>>> +               goto exit;
>>> +
>>> +       if (dev->parent && (anc =3D dev->parent->parent)) {
>>> +               if (omap_ehci_hub_port(anc)) {
>>> +                       ret =3D 1;
>>> +                       goto exit;
>>> +               }
>>> +
>>> +               /* is it port of lan95xx hub? */
>>> +               if ((anc =3D anc->parent) && omap_ehci_hub_port(anc=
)) {
>>> +                       ret =3D 2;
>>> +                       goto exit;
>>> +               }
>>> +       }
>>> +exit:
>>> +       return ret;
>>> +}
>>> +
>>> +/*
>>> + * Notifications of device registration
>>> + */
>>> +static int device_notify(struct notifier_block *nb, unsigned long =
action,
>>> void *data)
>>> +{
>>> +       struct device *dev =3D data;
>>> +       int ret;
>>> +
>>> +       switch (action) {
>>> +       case DEV_NOTIFY_ADD_DEVICE:
>>> +               ret =3D dev_pc_match(dev);
>>> +               if (likely(!ret))
>>> +                       goto exit;
>>> +               if (ret =3D=3D 1)
>>> +                       dev_pc_bind(&pc, dev, &root_hub_port_data,
>>> sizeof(root_hub_port_data));
>>> +               else
>>> +                       dev_pc_bind(&pc, dev, &smsc_hub_port_data,
>>> sizeof(smsc_hub_port_data));
>>> +               break;
>>> +
>>> +       case DEV_NOTIFY_DEL_DEVICE:
>>> +               break;
>>> +       }
>>> +exit:
>>> +       return 0;
>>> +}
>>> +
>>> +static struct notifier_block usb_port_nb =3D {
>>> +       .notifier_call =3D device_notify,
>>> +};
>>> +
>>
>>
>> Some thoughts on trying to make this functionality specific to power=
 only
>> and ehci hub port only:
>>
>>   - Quite a few boards have smsc95xx... they're all going to carry t=
hese
>> additions in the board file?  Surely you'll have to generalize the p=
ieces
>
> All things are board dependent because we are discussing peripheral
> device(not builtin SoC devices), so it is proper to put it in the boa=
rd file.
> If some boards want to share it, we can put it in a single .c file an=
d
> let board file include it.

Where would the .c file go... SMSC is not platform, or even arch=20
specific chip (eg, iMX or MIPS or even x86 boards can have it), so not=20
arch/arm/mach-xxxx or arch/arm/plat-xxx or arch/arm.  I guess it would=20
go in drivers/usb or drivers/net.

Push in ARM-Land is towards single kernels which support many platforms=
,=20
a good case in point is omap2plus_defconfg which wants to allow to=20
support all OMAP2/3/4/5 platforms in one kernel.  If you "include" that=
=20
C file over and over in board files, it's not very nice for that.  They=
=20
anyway want to eliminate board files for the single kernel binary=20
reason, and just have one load of config come in by dtb.

So it guides you towards having static helper code once in drivers/ for=
=20
the scenarios you support... if that's where you end up smsc is less=20
good a target for a helper than to have helpers for classes of object=20
like regulator and clk, that you can combine and reuse on all sorts of=20
target devices, which is device_asset approach.

It also guides you to having the special platform sauce be something=20
that can go into the dtb: per-board code can't.  That's why device_asse=
t=20
stuff only places asset structs in the board file and is removing code=20
from there.

>> that perform device_path business out of the omap4panda board file a=
t least.
>> At that point the path matching code becomes generic end-of-the-devi=
ce-path
>> matching code.
>
> Looks Alan has mentioned, there might be no generic way, and any devi=
ce's
> name change in the path may make the way fragile.

What you have provided is no less fragile if you allow "port1" and the=20
ehci-omap.0 to be set from the outside.

Unless someone NAKs it for sure already (if you're already sure you're=20
going to, please do so to avoid wasting time), I'll issue a try#2 of my=
=20
code later which demonstrates what I mean.  At least I guess it's usefu=
l=20
for comparative purposes.

>>   - How could these literals like "port1" etc be nicely provided by =
Device
>> Tree?  In ARM-land there's pressure to eventually eliminate board fi=
les
>> completely and pass in everything from dtb.  device_asset can neatly=
 grow DT
>> bindings in a generic way, since the footprint in the board file is =
some
>
> IMO, it isn't necessary to expose these assets to device or users, fr=
om the
> view of device or user, which only cares two actions(poweron and powe=
roff)
> about the discussed problem. Also it should be better to put these as=
sets
> into device resource list, instead of introducing them in 'struct dev=
ice'.

 From the point of view of allowing it to be reused on different boards=
=20
/ platforms / arches, you are going to have to do something better than=
=20
have literals in the code.

>> regulators that already have dt bindings and some device_asset struc=
ts.
>> Similarly there's pressure for magic code to service a board (rather=
 than
>> SoC) to go elsewhere than the board file.
>
> Looks you associate these assets with ehci-omap device, which mightn'=
t be
> enough, because we need to control port's power for supporting port
> power off mechanism. Do you have generic way to associate these asset=
s
> with usb port device and let port use it generally?

Yes, you need a parent device pointer (ehci host controller in this=20
case) and the path rhs, but only stuff that is defined by usb stack=20
code.  Needing a parent pointer is OK because this stuff only has=20
meaning for hardwired assets on the platform, so the parent device will=
=20
always be known as a platform_device at boot time anyway.

The code I'll provide will work the same in sdio or other bus case, jus=
t=20
use mmc host controller pointer and the sdio device name the same way.

>>   - Shouldn't this take care of enabling and disabling the ULPI PHY =
clock on
>> Panda too?  There's no purpose leaving it running if the one thing t=
he ULPI
>> PHY is connected to is depowered, and when you do power it, on Panda=
 you
>> will reset the ULPI PHY at the same time anyway (smsc reset and ULPI=
 PHY
>> reset are connected together on Panda).  Then you can eliminate
>> omap4_ehci_init() in the board file.
>
> OK, we can include the ULPI PHY clock things easily in ->power_on() a=
nd
> ->power_off() of 'power controller'

Yes if the ARM people will accept establishing more code in board files=
=20
that doesn't have a DT story.

-Andy

--=20
Andy Green | TI Landing Team Leader
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -=20
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
