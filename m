From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/4] dt: omap3: add generic board file for dt support
Date: Sat, 16 Jul 2011 23:13:17 -0600
Message-ID: <CACxGe6uzyxf35WDg6COnPVt3dhQv1H80L1svALxp4naySx2BcA@mail.gmail.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
 <1310592975-25773-4-git-send-email-manjugk@ti.com> <CACxGe6sELS=C==16TZ2pfrxJDDyqjS_qOwJUfwzwMO8hqo8Xag@mail.gmail.com>
 <CAC63_iSqN=rX6MbzFWM6z+zf1Eybg3MOD=qQVdeNg5cyENhPjw@mail.gmail.com> <CAC63_iTf696D6Q_EzFeUUp5R38pYNEJBkmKviEu6-yuF0y=bNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45687 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab1GQFNi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 17 Jul 2011 01:13:38 -0400
Received: by gwaa18 with SMTP id a18so977250gwa.19
        for <linux-omap@vger.kernel.org>; Sat, 16 Jul 2011 22:13:37 -0700 (PDT)
In-Reply-To: <CAC63_iTf696D6Q_EzFeUUp5R38pYNEJBkmKviEu6-yuF0y=bNA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ben-linux@fluff.org

Hi Manjunath,

Comments below.  I left in a lot of context for the new folks that
I've cc'd (Tony and Kevin).

On Sat, Jul 16, 2011 at 2:07 PM, G, Manjunath Kondaiah <manjugk@ti.com>=
 wrote:
> On Thu, Jul 14, 2011 at 4:45 AM, Grant Likely <grant.likely@secretlab=
=2Eca> wrote:
>>> > +static void __init omap3_init(void)
>>> > +{
>>> > + =A0 =A0 =A0 struct device_node *node;
>>> > +
>>> > + =A0 =A0 =A0 node =3D of_find_matching_node_by_address(NULL, oma=
p3_dt_intc_match,
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP34XX_IC_BASE);
>>> > + =A0 =A0 =A0 if (node)
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_domain_add_simple(node, 0);
>>> > +
>>> > + =A0 =A0 =A0 omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>>> > + =A0 =A0 =A0 omap3_beagle_init_rev();
>>> > + =A0 =A0 =A0 omap3_beagle_i2c_init();
>>> > + =A0 =A0 =A0 platform_add_devices(omap3_beagle_devices,
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(omap3_be=
agle_devices));
>>> > + =A0 =A0 =A0 omap_display_init(&beagle_dss_data);
>>> > + =A0 =A0 =A0 omap_serial_init();
>>> > +
>>> > + =A0 =A0 =A0 omap_mux_init_gpio(170, OMAP_PIN_INPUT);
>>> > + =A0 =A0 =A0 /* REVISIT leave DVI powered down until it's needed=
 ... */
>>> > + =A0 =A0 =A0 gpio_request_one(170, GPIOF_OUT_INIT_HIGH, "DVI_nPD=
");
>>> > +
>>> > + =A0 =A0 =A0 usb_musb_init(NULL);
>>> > + =A0 =A0 =A0 usbhs_init(&usbhs_bdata);
>>> > + =A0 =A0 =A0 omap_nand_flash_init(NAND_BUSWIDTH_16, omap3beagle_=
nand_partitions,
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SI=
ZE(omap3beagle_nand_partitions));
>>> > +
>>> > + =A0 =A0 =A0 /* Ensure msecure is mux'd to be able to set the RT=
C. */
>>> > + =A0 =A0 =A0 omap_mux_init_signal("sys_drm_msecure", OMAP_PIN_OF=
=46_OUTPUT_HIGH);
>>> > +
>>> > + =A0 =A0 =A0 /* Ensure SDRC pins are mux'd for self-refresh */
>>> > + =A0 =A0 =A0 omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
>>> > + =A0 =A0 =A0 omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
>>> > +
>>> > + =A0 =A0 =A0 beagle_display_init();
>>> > + =A0 =A0 =A0 beagle_opp_init();
>>> > + =A0 =A0 =A0 of_platform_populate(NULL, omap_dt_match_table, NUL=
L, NULL);
>>>
>>> Hmmm, I don't think this will work for OMAP because it will not cre=
ate
>>> the i2c bus as an omap_device. =A0It will only be a plane
>>> platform_deevice. =A0You'll need to have a hook in
>>> of_platform_populate() to create devices the way omap3 infrastructu=
re
>>> expects.
>>>
>>
> This dependency is mentioned in patch series. Since you pointed out t=
his
> issue, I would like to propose following approach for hooking up omap=
 hwmod=B7
> framework with dt. Though, the current approach focus only on i2c dri=
ver, it
> can be extended and generalized as it evolves with other board and
> driver cleanup
> activities. The following changes are not tested and also not compile=
d, =A0it is
> only proposal I am thinking to implement.
>
> Let me know if you see any serious issues with the approach.
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index c1773456..104ef31 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -457,6 +457,8 @@ void of_platform_prepare(struct device_node *root=
,
> =A0 =A0 =A0 =A0}
> =A0}
>
> +
> +
> =A0#ifdef CONFIG_ARM_AMBA
> =A0static struct amba_device *of_amba_device_create(struct device_nod=
e *node,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 const char *bus_id,
> @@ -537,13 +539,60 @@ static const struct of_dev_auxdata
> *of_dev_lookup(const struct of_dev_auxdata *l
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0contin=
ue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (res.start !=3D loo=
kup->phys_addr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0contin=
ue;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: devname=3D=
%s\n", np->full_name,
> lookup->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("%s: devname=3D%=
s\n", np->full_name, lookup->name);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return lookup;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return NULL;
> =A0}
>
> +static struct omap_device *of_omap_i2c_device_create(struct device_n=
ode *node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *bus_id,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *platform_data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device *parent)
> +{
> + =A0 =A0 =A0 struct platform_device *pdev;
> + =A0 =A0 =A0 struct i2c_board_info *i2c_board_info;
> + =A0 =A0 =A0 u8 id;
> +
> + =A0 =A0 =A0 printk("Creating omap i2c device %s\n", node->full_name=
);
> +
> + =A0 =A0 =A0 if (!of_device_is_available(node))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 id =3D simple_strtol(bus_id, NULL, 0);
> + =A0 =A0 =A0 pdev =3D kzalloc(sizeof(*pdev), GFP_KERNEL);
> + =A0 =A0 =A0 pdev->dev.of_node =3D of_node_get(node);
> + =A0 =A0 =A0 if (!pdev->dev.of_node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 speed =3D 100;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 prop;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!of_property_read_u32(pdev->dev.of_=
node, "clock-frequency",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 &prop))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 speed =3D prop/100;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 speed =3D 100;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 printk("%s : speed->%d\n",__func__, speed);
> +
> + =A0 =A0 =A0 for_each_child_of_node(bus, child) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 prop;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(" =A0 create child: %s\n", child=
->full_name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_board_info =3D kzalloc(sizeof(*i2c_=
board_info), GFP_KERNEL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!of_property_read_u32(pdev->dev.of_=
node, "reg",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &prop))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_board_info->addr =3D prop;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!of_property_read_u32(pdev->dev.of_=
node, "interrupts",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &prop))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_board_info->irq =3D prop;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_board_info->platform_data =3D platf=
orm_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strncpy(i2c_board_info->type, child->na=
me,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 sizeof(i2c_board_info->type));
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 omap_register_i2c_bus(id, speed, i2c_board_info, 1);

While this does in a sense work, and creates an omap_device for the
i2c bus that does get probed, it ends up encoding an awful lot of
device specific details into the generic devicetree support code.  The
i2c bus driver itself must be responsible for decoding the speed and
child nodes, and in fact it can easily be modified to do so (I've
already demonstrated how to do so).  The real problem is making sure
the platform_device is created in a way that attaches the correct
hwmod data. For this context, the current omap_register_i2c_bus()
isn't a useful method for doing so.

So what is to be done?  omap_register_i2c_bus() does three things;
1) register an i2c board info for the bus with i2c_register_board_info(=
),
2) fill platform_data for the device, and
3) use omap_i2c_add_bus to create the platform_device with attached hwm=
od.

Of these three, 1 & 2 must not be done when using the DT. Only
omap_i2c_add_bus() does something useful, but that is still specific
to the i2c device.

omap_i2c_add_bus() splits to omap{1,2}_add_bus().

omap1_i2c_add_bus() sets up pinmux and calls platform_device register.
 pinmux setup needs to be factored out anyway for generic DT platform
device registration, which just leaves platform_device creation which
is already handled by of_platform_populate().

omap2_i2c_add_bus() does the same thing, except it also looks up the
hwmod data (*oh) and uses it to call omap_device_build().
omap_device_build() or something equivalent needs to be called for
every omap device in the system, which is to create platform_devices
with hwmod attached.  Now we're starting to hit generic code.  :-)

The way I see it, you've got two options:

1) modify the of_platform_bus_create() to call some kind of
of_platform_bus_create_omap() for devices that match "ti,omap3-device"
or something.

2) Leave of_platform_bus_create(), and instead us a notifier to attach
hwmod data to normal platform devices.  omap_device_build() is
actually pretty simple.  It allocated a device, it attaches
platform_data and hwmod pointers to the device and registers it.
omap_device_register() is just a wrapper around
platform_device_register().

My preference is definitely #2, but there is a wrinkle in this
approach.  Unfortunately omap_devices are not simply plain
platform_devices with extra data attached, an omap_device actually
embeds the platform_device inside it, which cannot be attached after
the fact.  I think I had talked with Kevin (cc'd) about eliminating
the embedding, but I cannot remember clearly on this point.  As long
as platform_device remains embedded inside struct omap_device, #2
won't work.

In either case, looking up the correct hwmod data should be easy for
any device provided the omap code maintains a lookup table of
compatible strings and base addresses of devices (much like auxdata).
In fact, I'd be okay with extending auxdata to include OMAP fields if
that would be easiest since the whole point of auxdata is to ease the
transition to DT support.  When a matching device is created, the
hwmod pointer can easily be attached.  This should work transparently
for all omap devices, not just the i2c bus.

> +}
> +
> =A0/**
> =A0* of_platform_bus_create() - Create a device for a node and its ch=
ildren.
> =A0* @bus: device node of the bus to instantiate
> @@ -593,6 +642,11 @@ static int of_platform_bus_create(struct device_=
node *bus,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (of_device_is_compatible(bus, "ti,omap3-i2c")) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_omap_i2c_device_create(bus, bus_id, =
platform_data, parent);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0dev =3D of_platform_device_create_pdata(bus, bus_id,
> platform_data, parent);
> =A0 =A0 =A0 =A0if (!dev || !of_match_node(matches, bus))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> -M
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
