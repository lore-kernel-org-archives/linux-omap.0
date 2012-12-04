From: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 4/5] arm: omap2: support port power on lan95xx devices
Date: Tue, 04 Dec 2012 12:02:23 +0800
Message-ID: <50BD75CF.60406@linaro.org>
References: <1354460467-28006-1-git-send-email-tom.leiming@gmail.com> <1354460467-28006-5-git-send-email-tom.leiming@gmail.com> <50BB83E1.7020408@linaro.org> <CACVXFVNvNJJHccN=jL+N9UorwRjeC0JBMXgsB1Th_jNBeqihAw@mail.gmail.com> <50BC3003.80608@linaro.org> <CACVXFVO-Xktswog9Zx16zo-pmx9fTh0F3BYC-3q6Zn2SPCqdGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACVXFVO-Xktswog9Zx16zo-pmx9fTh0F3BYC-3q6Zn2SPCqdGg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 04/12/12 10:39, the mail apparently from Ming Lei included:
> On Mon, Dec 3, 2012 at 12:52 PM, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> w=
rote:
>>>>> +static void ehci_hub_power_off(struct power_controller *pc, stru=
ct
>>>>> device
>>>>> *dev)
>>>>> +{
>>>>> +       gpio_set_value(GPIO_HUB_NRESET, 0);
>>>>> +       gpio_set_value(GPIO_HUB_POWER, 0);
>>>>> +}
>>>>> +
>>>>> +static struct usb_port_power_switch_data root_hub_port_data =3D =
{
>>>>> +       .hub_tier       =3D 0,
>>>>> +       .port_number =3D 1,
>>>>> +       .type =3D USB_PORT_CONNECT_TYPE_HARD_WIRED,
>>>>> +};
>>>>> +
>>>>> +static struct usb_port_power_switch_data smsc_hub_port_data =3D =
{
>>>>> +       .hub_tier       =3D 1,
>>>>> +       .port_number =3D 1,
>>>>> +       .type =3D USB_PORT_CONNECT_TYPE_HARD_WIRED,
>>>>> +};
>>>>> +
>>>>> +static struct power_controller pc =3D {
>>>>> +       .name =3D "omap_hub_eth_pc",
>>>>> +       .count =3D ATOMIC_INIT(0),
>>>>> +       .power_on =3D ehci_hub_power_on,
>>>>> +       .power_off =3D ehci_hub_power_off,
>>>>> +};
>>>>> +
>>>>> +static inline int omap_ehci_hub_port(struct device *dev)
>>>>> +{
>>>>> +       /* we expect dev->parent points to ehcd controller */
>>>>> +       if (dev->parent && !strcmp(dev_name(dev->parent),
>>>>> "ehci-omap.0"))
>>>>> +               return 1;
>>>>> +       return 0;
>>>>> +}
>>>>> +
>>>>> +static inline int dev_pc_match(struct device *dev)
>>>>> +{
>>>>> +       struct device *anc;
>>>>> +       int ret =3D 0;
>>>>> +
>>>>> +       if (likely(strcmp(dev_name(dev), "port1")))
>>>>> +               goto exit;
>>>>> +
>>>>> +       if (dev->parent && (anc =3D dev->parent->parent)) {
>>>>> +               if (omap_ehci_hub_port(anc)) {
>>>>> +                       ret =3D 1;
>>>>> +                       goto exit;
>>>>> +               }
>>>>> +
>>>>> +               /* is it port of lan95xx hub? */
>>>>> +               if ((anc =3D anc->parent) && omap_ehci_hub_port(a=
nc)) {
>>>>> +                       ret =3D 2;
>>>>> +                       goto exit;
>>>>> +               }
>>>>> +       }
>>>>> +exit:
>>>>> +       return ret;
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> + * Notifications of device registration
>>>>> + */
>>>>> +static int device_notify(struct notifier_block *nb, unsigned lon=
g
>>>>> action,
>>>>> void *data)
>>>>> +{
>>>>> +       struct device *dev =3D data;
>>>>> +       int ret;
>>>>> +
>>>>> +       switch (action) {
>>>>> +       case DEV_NOTIFY_ADD_DEVICE:
>>>>> +               ret =3D dev_pc_match(dev);
>>>>> +               if (likely(!ret))
>>>>> +                       goto exit;
>>>>> +               if (ret =3D=3D 1)
>>>>> +                       dev_pc_bind(&pc, dev, &root_hub_port_data=
,
>>>>> sizeof(root_hub_port_data));
>>>>> +               else
>>>>> +                       dev_pc_bind(&pc, dev, &smsc_hub_port_data=
,
>>>>> sizeof(smsc_hub_port_data));
>>>>> +               break;
>>>>> +
>>>>> +       case DEV_NOTIFY_DEL_DEVICE:
>>>>> +               break;
>>>>> +       }
>>>>> +exit:
>>>>> +       return 0;
>>>>> +}
>>>>> +
>>>>> +static struct notifier_block usb_port_nb =3D {
>>>>> +       .notifier_call =3D device_notify,
>>>>> +};
>>>>> +
>>>>
>>>>
>>>>
>>>> Some thoughts on trying to make this functionality specific to pow=
er only
>>>> and ehci hub port only:
>>>>
>>>>    - Quite a few boards have smsc95xx... they're all going to carr=
y these
>>>> additions in the board file?  Surely you'll have to generalize the=
 pieces
>>>
>>>
>>> All things are board dependent because we are discussing peripheral
>>> device(not builtin SoC devices), so it is proper to put it in the b=
oard
>>> file.
>>> If some boards want to share it, we can put it in a single .c file =
and
>>> let board file include it.
>>
>>
>> Where would the .c file go... SMSC is not platform, or even arch spe=
cific
>> chip (eg, iMX or MIPS or even x86 boards can have it), so not
>> arch/arm/mach-xxxx or arch/arm/plat-xxx or arch/arm.  I guess it wou=
ld go in
>> drivers/usb or drivers/net.
>
> How does drivers/usb or drivers/net know the SMSC is used on beagle o=
r
> panda? Different power control approach is used in the two boards eve=
n
> same SMSC chip is shipped in the two boards.

You mention you're going to "put it in a single .c file and let the=20
board file include it", I am just wondering where that .c file will=20
live.  It seems it would have to live down drivers/ somewhere so MIPS,=20
x86 etc that might have an SMSC chip onboard can also use it if they wa=
nt.

>> Push in ARM-Land is towards single kernels which support many platfo=
rms, a
>> good case in point is omap2plus_defconfg which wants to allow to sup=
port all
>> OMAP2/3/4/5 platforms in one kernel.  If you "include" that C file o=
ver and
>> over in board files, it's not very nice for that.  They anyway want =
to
>> eliminate board files for the single kernel binary reason, and just =
have one
>> load of config come in by dtb.
>
> I only mean it is reasonable to put the power control code into board
> file because
> each board may take different power control approach even same SMSC c=
hip
> is used. I understand DT only describes the difference of the board v=
ia device
> node, and I am not sure if the current DT is enough to convert the bo=
ard file
> into data as far as the problem is concerned.

No the approach with DT is to provide a dummy SoC "board file" with all=
=20
data provided by dtb.  This is already established, see=20
=2E/arch/arm/mach-omap2/board-generic.c for example.  You can see there=
's=20
nothing in it other than minimum dt match business.

People with new boards are getting pointed at that and told to sort it=20
out in dtb and disallowed from creating new board files.

So whatever support or helper scheme you're adding needs a story about=20
how dtb can express it (in dt language, "has bindings for it") or it=20
can't be used on new boards.  That's not a minor ding any more either.

>> So it guides you towards having static helper code once in drivers/ =
for the
>> scenarios you support... if that's where you end up smsc is less goo=
d a
>> target for a helper than to have helpers for classes of object like
>> regulator and clk, that you can combine and reuse on all sorts of ta=
rget
>> devices, which is device_asset approach.
>>
>> It also guides you to having the special platform sauce be something=
 that
>> can go into the dtb: per-board code can't.  That's why device_asset =
stuff
>> only places asset structs in the board file and is removing code fro=
m there.
>>
>>
>>>> that perform device_path business out of the omap4panda board file=
 at
>>>> least.
>>>> At that point the path matching code becomes generic
>>>> end-of-the-device-path
>>>> matching code.
>>>
>>>
>>> Looks Alan has mentioned, there might be no generic way, and any de=
vice's
>>> name change in the path may make the way fragile.
>>
>>
>> What you have provided is no less fragile if you allow "port1" and t=
he
>> ehci-omap.0 to be set from the outside.
>>
>> Unless someone NAKs it for sure already (if you're already sure you'=
re going
>> to, please do so to avoid wasting time), I'll issue a try#2 of my co=
de later
>> which demonstrates what I mean.  At least I guess it's useful for
>> comparative purposes.
>>
>>
>>>>    - How could these literals like "port1" etc be nicely provided =
by
>>>> Device
>>>> Tree?  In ARM-land there's pressure to eventually eliminate board =
files
>>>> completely and pass in everything from dtb.  device_asset can neat=
ly grow
>>>> DT
>>>> bindings in a generic way, since the footprint in the board file i=
s some
>>>
>>>
>>> IMO, it isn't necessary to expose these assets to device or users, =
from
>>> the
>>> view of device or user, which only cares two actions(poweron and po=
weroff)
>>> about the discussed problem. Also it should be better to put these =
assets
>>> into device resource list, instead of introducing them in 'struct d=
evice'.
>>
>>
>>  From the point of view of allowing it to be reused on different boa=
rds /
>> platforms / arches, you are going to have to do something better tha=
n have
>> literals in the code.
>>
>>
>>>> regulators that already have dt bindings and some device_asset str=
ucts.
>>>> Similarly there's pressure for magic code to service a board (rath=
er than
>>>> SoC) to go elsewhere than the board file.
>>>
>>>
>>> Looks you associate these assets with ehci-omap device, which might=
n't be
>>> enough, because we need to control port's power for supporting port
>>> power off mechanism. Do you have generic way to associate these ass=
ets
>>> with usb port device and let port use it generally?
>>
>>
>> Yes, you need a parent device pointer (ehci host controller in this =
case)
>> and the path rhs, but only stuff that is defined by usb stack code. =
 Needing
>> a parent pointer is OK because this stuff only has meaning for hardw=
ired
>> assets on the platform, so the parent device will always be known as=
 a
>> platform_device at boot time anyway.
>
> parent device pointer may work on the panda problem, but may not work
> on other case if one hardwired device is powered by another power dom=
ain.
>
> So it is not a general solution on usb port power off.

I am talking about, well, "ancestor" pointer only to filter descendant=20
children.  Not for any power control directly.

It gets us away from caring about what the device path looked like prio=
r=20
to that host controller, and since we have confidence it's exactly the=20
host controller we intended by knowing its platform_device, we can=20
ignore everything between than at the right-hand side path fragment=20
identifying the child.  So it's a strong way to reduce fragility on the=
=20
device_path stuff.

>> The code I'll provide will work the same in sdio or other bus case, =
just use
>> mmc host controller pointer and the sdio device name the same way.
>>
>>
>>>>    - Shouldn't this take care of enabling and disabling the ULPI P=
HY clock
>>>> on
>>>> Panda too?  There's no purpose leaving it running if the one thing=
 the
>>>> ULPI
>>>> PHY is connected to is depowered, and when you do power it, on Pan=
da you
>>>> will reset the ULPI PHY at the same time anyway (smsc reset and UL=
PI PHY
>>>> reset are connected together on Panda).  Then you can eliminate
>>>> omap4_ehci_init() in the board file.
>>>
>>>
>>> OK, we can include the ULPI PHY clock things easily in ->power_on()=
 and
>>> ->power_off() of 'power controller'
>>
>>
>> Yes if the ARM people will accept establishing more code in board fi=
les that
>> doesn't have a DT story.
>
> As I explained above, it is reasonable to put the power control code =
in board
> file, but current DT could convert these board file into device node?

DT has lots of bindings now, you can describe regulators and things in=20
there fully.  The point is whatever scheme is workable for this must be=
=20
able to get soaked up using DT too to be acceptable.  Taking the=20
approach you're going to drop literal strings in code in the board file=
,=20
or throw code at the board file at all, will no longer fly.

I have not provided a DT solution for my approach yet either, but I hav=
e=20
taken care that the only footprint in the boardfile version of it are=20
*structs*.  That means translating them to dtb content by adding a=20
binding for the asset stuff for example, will be a clean task.

That's also why back at the beginning of this discussion I gave dts=20
version of the regulator structs I was introducing in that patch... it'=
s=20
proof that the boardfile footprint of that scheme is ready to go into d=
tb.

-Andy

--=20
Andy Green | TI Landing Team Leader
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -=20
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
