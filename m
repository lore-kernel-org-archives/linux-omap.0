From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH 3/4] dt: omap3: add generic board file for dt support
Date: Sun, 17 Jul 2011 01:37:40 +0530
Message-ID: <CAC63_iTf696D6Q_EzFeUUp5R38pYNEJBkmKviEu6-yuF0y=bNA@mail.gmail.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
	<1310592975-25773-4-git-send-email-manjugk@ti.com>
	<CACxGe6sELS=C==16TZ2pfrxJDDyqjS_qOwJUfwzwMO8hqo8Xag@mail.gmail.com>
	<CAC63_iSqN=rX6MbzFWM6z+zf1Eybg3MOD=qQVdeNg5cyENhPjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:37461 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754877Ab1GPUHn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 16 Jul 2011 16:07:43 -0400
Received: by fxd23 with SMTP id 23so2825817fxd.12
        for <linux-omap@vger.kernel.org>; Sat, 16 Jul 2011 13:07:40 -0700 (PDT)
In-Reply-To: <CAC63_iSqN=rX6MbzFWM6z+zf1Eybg3MOD=qQVdeNg5cyENhPjw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ben-linux@fluff.org

ps: posting again since my mailer has triggered the mail in html format=
 hence
it does not reach some mailing lists.

Hi Grant,

>
On Thu, Jul 14, 2011 at 4:45 AM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
>>
>> On Thu, Jul 14, 2011 at 7:06 AM, G, Manjunath Kondaiah <manjugk@ti.c=
om> wrote:
>> >
>> > The generic board file is created and derived from beagle board fi=
le.
>> > The beagle board file is migrated to boot from flattened device tr=
ee and
>> > the cleanup of generic board file will happen in different stages.
>> >
>> > The changes here focus on i2c device registration through dt and u=
pcoming
>> > patches in the series will adopt i2c driver to use dt registered i=
2c
>> > devices.
>>
>> Since this is a new board file instead of a modification of an
>> existing one, I recommend *not* trying to completely duplicate the
>> behaviour of the beagle board.  Start small with only the registrati=
on
>> of the UART and i2c drivers from the device tree and build up
>> functionality until it can be used for all the OMAP3 boards.
>> Otherwise the patch just adds a lot of code that needs to be removed
>> again.
>

agreed. Started with minimal board file with only serial and i2c.

>>
>> >
>> > Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
>> > ---
>> >  arch/arm/mach-omap2/Kconfig             |   12 +
>> >  arch/arm/mach-omap2/Makefile            |    2 +
>> >  arch/arm/mach-omap2/board-omap3-dt.c    |  623 ++++++++++++++++++=
+++++++++++++
>> >  arch/arm/mach-omap2/board-omap3beagle.c |   13 -
>> >  4 files changed, 637 insertions(+), 13 deletions(-)
>> >  create mode 100644 arch/arm/mach-omap2/board-omap3-dt.c
>> >
>> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kco=
nfig
>> > index 19d5891..174f6d1 100644
>> > --- a/arch/arm/mach-omap2/Kconfig
>> > +++ b/arch/arm/mach-omap2/Kconfig
>> > @@ -302,6 +302,18 @@ config MACH_OMAP_3630SDP
>> >        default y
>> >        select OMAP_PACKAGE_CBP
>> >
>> > +config MACH_OMAP3_DT
>> > +       bool "Generic OMAP3 board(FDT support)"
>> > +       depends on ARCH_OMAP3
>> > +       select OMAP_PACKAGE_CBB
>> > +       select USE_OF
>> > +       select PROC_DEVICETREE
>>
>> Don't select PROC_DEVICETREE
>
ok
>>
>> > +
>> > +       help
>> > +         Support for generic TI OMAP3 boards using Flattened Devi=
ce Tree.
>> > +         Say Y here to enable OMAP3 device tree support
>> > +         More information at Documentation/devicetree
>> > +
>> >  config MACH_TI8168EVM
>> >        bool "TI8168 Evaluation Module"
>> >        depends on SOC_OMAPTI816X
>> > diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Ma=
kefile
>> > index b148077..86e66f7 100644
>> > --- a/arch/arm/mach-omap2/Makefile
>> > +++ b/arch/arm/mach-omap2/Makefile
>> > @@ -178,6 +178,8 @@ obj-$(CONFIG_MACH_OMAP_H4)          +=3D board=
-h4.o
>> >  obj-$(CONFIG_MACH_OMAP_2430SDP)                +=3D board-2430sdp=
=2Eo \
>> >                                           hsmmc.o
>> >  obj-$(CONFIG_MACH_OMAP_APOLLON)                +=3D board-apollon=
=2Eo
>> > +obj-$(CONFIG_MACH_OMAP3_DT)            +=3D board-omap3-dt.o \
>> > +                                          hsmmc.o
>> >  obj-$(CONFIG_MACH_OMAP3_BEAGLE)                +=3D board-omap3be=
agle.o \
>> >                                           hsmmc.o
>>
>> This is an odd construct.  Tony, why does each board add hsmmc to th=
e
>> oby-y variable instead of it having its own kconfig symbol?
>>
>> > +static void __init omap3_init(void)
>> > +{
>> > +       struct device_node *node;
>> > +
>> > +       node =3D of_find_matching_node_by_address(NULL, omap3_dt_i=
ntc_match,
>> > +                                               OMAP34XX_IC_BASE);
>> > +       if (node)
>> > +               irq_domain_add_simple(node, 0);
>> > +
>> > +       omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>> > +       omap3_beagle_init_rev();
>> > +       omap3_beagle_i2c_init();
>> > +       platform_add_devices(omap3_beagle_devices,
>> > +                       ARRAY_SIZE(omap3_beagle_devices));
>> > +       omap_display_init(&beagle_dss_data);
>> > +       omap_serial_init();
>> > +
>> > +       omap_mux_init_gpio(170, OMAP_PIN_INPUT);
>> > +       /* REVISIT leave DVI powered down until it's needed ... */
>> > +       gpio_request_one(170, GPIOF_OUT_INIT_HIGH, "DVI_nPD");
>> > +
>> > +       usb_musb_init(NULL);
>> > +       usbhs_init(&usbhs_bdata);
>> > +       omap_nand_flash_init(NAND_BUSWIDTH_16, omap3beagle_nand_pa=
rtitions,
>> > +                            ARRAY_SIZE(omap3beagle_nand_partition=
s));
>> > +
>> > +       /* Ensure msecure is mux'd to be able to set the RTC. */
>> > +       omap_mux_init_signal("sys_drm_msecure", OMAP_PIN_OFF_OUTPU=
T_HIGH);
>> > +
>> > +       /* Ensure SDRC pins are mux'd for self-refresh */
>> > +       omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
>> > +       omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
>> > +
>> > +       beagle_display_init();
>> > +       beagle_opp_init();
>> > +       of_platform_populate(NULL, omap_dt_match_table, NULL, NULL=
);
>>
>> Hmmm, I don't think this will work for OMAP because it will not crea=
te
>> the i2c bus as an omap_device.  It will only be a plane
>> platform_deevice.  You'll need to have a hook in
>> of_platform_populate() to create devices the way omap3 infrastructur=
e
>> expects.
>>
>
This dependency is mentioned in patch series. Since you pointed out thi=
s
issue, I would like to propose following approach for hooking up omap h=
wmod=B7
framework with dt. Though, the current approach focus only on i2c drive=
r, it
can be extended and generalized as it evolves with other board and
driver cleanup
activities. The following changes are not tested and also not compiled,=
  it is
only proposal I am thinking to implement.

Let me know if you see any serious issues with the approach.

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index c1773456..104ef31 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -457,6 +457,8 @@ void of_platform_prepare(struct device_node *root,
        }
 }

+
+
 #ifdef CONFIG_ARM_AMBA
 static struct amba_device *of_amba_device_create(struct device_node *n=
ode,
                                                 const char *bus_id,
@@ -537,13 +539,60 @@ static const struct of_dev_auxdata
*of_dev_lookup(const struct of_dev_auxdata *l
                                continue;
                        if (res.start !=3D lookup->phys_addr)
                                continue;
-                       pr_debug("%s: devname=3D%s\n", np->full_name,
lookup->name);
+                       printk("%s: devname=3D%s\n", np->full_name, loo=
kup->name);
                        return lookup;
                }
        }
        return NULL;
 }

+static struct omap_device *of_omap_i2c_device_create(struct device_nod=
e *node,
+                                                const char *bus_id,
+                                                void *platform_data,
+                                                struct device *parent)
+{
+       struct platform_device *pdev;
+       struct i2c_board_info *i2c_board_info;
+       u8 id;
+
+       printk("Creating omap i2c device %s\n", node->full_name);
+
+       if (!of_device_is_available(node))
+               return NULL;
+
+       id =3D simple_strtol(bus_id, NULL, 0);
+       pdev =3D kzalloc(sizeof(*pdev), GFP_KERNEL);
+       pdev->dev.of_node =3D of_node_get(node);
+       if (!pdev->dev.of_node) {
+               speed =3D 100;
+       } else {
+               u32 prop;
+               if (!of_property_read_u32(pdev->dev.of_node, "clock-fre=
quency",
+                                                                      =
 &prop))
+                       speed =3D prop/100;
+               else
+                       speed =3D 100;
+       }
+       printk("%s : speed->%d\n",__func__, speed);
+
+       for_each_child_of_node(bus, child) {
+               u32 prop;
+
+               printk("   create child: %s\n", child->full_name);
+               i2c_board_info =3D kzalloc(sizeof(*i2c_board_info), GFP=
_KERNEL);
+               if (!of_property_read_u32(pdev->dev.of_node, "reg",
+                                                               &prop))
+               i2c_board_info->addr =3D prop;
+               if (!of_property_read_u32(pdev->dev.of_node, "interrupt=
s",
+                                                               &prop))
+               i2c_board_info->irq =3D prop;
+               i2c_board_info->platform_data =3D platform_data;
+               strncpy(i2c_board_info->type, child->name,
+                                       sizeof(i2c_board_info->type));
+       }
+       omap_register_i2c_bus(id, speed, i2c_board_info, 1);
+}
+
 /**
  * of_platform_bus_create() - Create a device for a node and its child=
ren.
  * @bus: device node of the bus to instantiate
@@ -593,6 +642,11 @@ static int of_platform_bus_create(struct device_no=
de *bus,
                return 0;
        }

+       if (of_device_is_compatible(bus, "ti,omap3-i2c")) {
+               of_omap_i2c_device_create(bus, bus_id, platform_data, p=
arent);
+               return 0;
+       }
+
        dev =3D of_platform_device_create_pdata(bus, bus_id,
platform_data, parent);
        if (!dev || !of_match_node(matches, bus))
                return 0;

-M
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
