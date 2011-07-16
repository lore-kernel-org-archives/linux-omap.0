From: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/4] dt: omap3: add generic board file for dt support
Date: Sun, 17 Jul 2011 01:24:27 +0530
Message-ID: <CAC63_iSqN=rX6MbzFWM6z+zf1Eybg3MOD=qQVdeNg5cyENhPjw@mail.gmail.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
	<1310592975-25773-4-git-send-email-manjugk@ti.com>
	<CACxGe6sELS=C==16TZ2pfrxJDDyqjS_qOwJUfwzwMO8hqo8Xag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0126821751923911838=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CACxGe6sELS=C==16TZ2pfrxJDDyqjS_qOwJUfwzwMO8hqo8Xag-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============0126821751923911838==
Content-Type: multipart/alternative; boundary=0015174bee6e38b2ee04a8352250

--0015174bee6e38b2ee04a8352250
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On Thu, Jul 14, 2011 at 4:45 AM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>wr=
ote:

> On Thu, Jul 14, 2011 at 7:06 AM, G, Manjunath Kondaiah <manjugk-l0cyMroinI0@public.gmane.org>
> wrote:
> >
> > The generic board file is created and derived from beagle board file.
> > The beagle board file is migrated to boot from flattened device tree an=
d
> > the cleanup of generic board file will happen in different stages.
> >
> > The changes here focus on i2c device registration through dt and upcomi=
ng
> > patches in the series will adopt i2c driver to use dt registered i2c
> > devices.
>
> Since this is a new board file instead of a modification of an
> existing one, I recommend *not* trying to completely duplicate the
> behaviour of the beagle board.  Start small with only the registration
> of the UART and i2c drivers from the device tree and build up
> functionality until it can be used for all the OMAP3 boards.
> Otherwise the patch just adds a lot of code that needs to be removed
> again.
>

agreed. Started with minimal board file with only serial and i2c.


>
> >
> > Signed-off-by: G, Manjunath Kondaiah <manjugk-l0cyMroinI0@public.gmane.org>
> > ---
> >  arch/arm/mach-omap2/Kconfig             |   12 +
> >  arch/arm/mach-omap2/Makefile            |    2 +
> >  arch/arm/mach-omap2/board-omap3-dt.c    |  623
> +++++++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/board-omap3beagle.c |   13 -
> >  4 files changed, 637 insertions(+), 13 deletions(-)
> >  create mode 100644 arch/arm/mach-omap2/board-omap3-dt.c
> >
> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > index 19d5891..174f6d1 100644
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -302,6 +302,18 @@ config MACH_OMAP_3630SDP
> >        default y
> >        select OMAP_PACKAGE_CBP
> >
> > +config MACH_OMAP3_DT
> > +       bool "Generic OMAP3 board(FDT support)"
> > +       depends on ARCH_OMAP3
> > +       select OMAP_PACKAGE_CBB
> > +       select USE_OF
> > +       select PROC_DEVICETREE
>
> Don't select PROC_DEVICETREE
>
ok

>
> > +
> > +       help
> > +         Support for generic TI OMAP3 boards using Flattened Device
> Tree.
> > +         Say Y here to enable OMAP3 device tree support
> > +         More information at Documentation/devicetree
> > +
> >  config MACH_TI8168EVM
> >        bool "TI8168 Evaluation Module"
> >        depends on SOC_OMAPTI816X
> > diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
> > index b148077..86e66f7 100644
> > --- a/arch/arm/mach-omap2/Makefile
> > +++ b/arch/arm/mach-omap2/Makefile
> > @@ -178,6 +178,8 @@ obj-$(CONFIG_MACH_OMAP_H4)          +=3D board-h4.o
> >  obj-$(CONFIG_MACH_OMAP_2430SDP)                +=3D board-2430sdp.o \
> >                                           hsmmc.o
> >  obj-$(CONFIG_MACH_OMAP_APOLLON)                +=3D board-apollon.o
> > +obj-$(CONFIG_MACH_OMAP3_DT)            +=3D board-omap3-dt.o \
> > +                                          hsmmc.o
> >  obj-$(CONFIG_MACH_OMAP3_BEAGLE)                +=3D board-omap3beagle.=
o \
> >                                           hsmmc.o
>
> This is an odd construct.  Tony, why does each board add hsmmc to the
> oby-y variable instead of it having its own kconfig symbol?
>
> > +static void __init omap3_init(void)
> > +{
> > +       struct device_node *node;
> > +
> > +       node =3D of_find_matching_node_by_address(NULL,
> omap3_dt_intc_match,
> > +                                               OMAP34XX_IC_BASE);
> > +       if (node)
> > +               irq_domain_add_simple(node, 0);
> > +
> > +       omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> > +       omap3_beagle_init_rev();
> > +       omap3_beagle_i2c_init();
> > +       platform_add_devices(omap3_beagle_devices,
> > +                       ARRAY_SIZE(omap3_beagle_devices));
> > +       omap_display_init(&beagle_dss_data);
> > +       omap_serial_init();
> > +
> > +       omap_mux_init_gpio(170, OMAP_PIN_INPUT);
> > +       /* REVISIT leave DVI powered down until it's needed ... */
> > +       gpio_request_one(170, GPIOF_OUT_INIT_HIGH, "DVI_nPD");
> > +
> > +       usb_musb_init(NULL);
> > +       usbhs_init(&usbhs_bdata);
> > +       omap_nand_flash_init(NAND_BUSWIDTH_16,
> omap3beagle_nand_partitions,
> > +                            ARRAY_SIZE(omap3beagle_nand_partitions));
> > +
> > +       /* Ensure msecure is mux'd to be able to set the RTC. */
> > +       omap_mux_init_signal("sys_drm_msecure",
> OMAP_PIN_OFF_OUTPUT_HIGH);
> > +
> > +       /* Ensure SDRC pins are mux'd for self-refresh */
> > +       omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
> > +       omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
> > +
> > +       beagle_display_init();
> > +       beagle_opp_init();
> > +       of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
>
> Hmmm, I don't think this will work for OMAP because it will not create
> the i2c bus as an omap_device.  It will only be a plane
> platform_deevice.  You'll need to have a hook in
> of_platform_populate() to create devices the way omap3 infrastructure
> expects.
>
>
This dependency is mentioned in patch series. Since you pointed out this
issue, I would like to propose following approach for hooking up omap hwmod=
=B7
framework with dt. Though, the current approach focus only on i2c driver, i=
t
can be extended and generalized as it evolves with other board and driver
cleanup
activities. The following changes are not tested and also not compiled,  it
is
only proposal I am thinking to implement.

Let me know if you see any serious issues with the approach.

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index c1773456..104ef31 100644--- a/drivers/of/platform.c+++
b/drivers/of/platform.c@@ -457,6 +457,8 @@ void
of_platform_prepare(struct device_node *root,
        }
 }
++
 #ifdef CONFIG_ARM_AMBA
 static struct amba_device *of_amba_device_create(struct device_node *node,
                                                 const char *bus_id,@@
-537,13 +539,60 @@ static const struct of_dev_auxdata
*of_dev_lookup(const struct of_dev_auxdata *l
                                continue;
                        if (res.start !=3D lookup->phys_addr)
                                continue;-
pr_debug("%s: devname=3D%s\n", np->full_name, lookup->name);+
           printk("%s: devname=3D%s\n", np->full_name, lookup->name);
                        return lookup;
                }
        }
        return NULL;
 }
+static struct omap_device *of_omap_i2c_device_create(struct
device_node *node,+
const char *bus_id,+
void *platform_data,+
struct device *parent)+{+       struct platform_device *pdev;+
struct i2c_board_info *i2c_board_info;+       u8 id;++
printk("Creating omap i2c device %s\n", node->full_name);++       if
(!of_device_is_available(node))+               return NULL;++       id
=3D simple_strtol(bus_id, NULL, 0);+       pdev =3D kzalloc(sizeof(*pdev),
GFP_KERNEL);+       pdev->dev.of_node =3D of_node_get(node);+       if
(!pdev->dev.of_node) {+               speed =3D 100;+       } else {+
           u32 prop;+               if
(!of_property_read_u32(pdev->dev.of_node, "clock-frequency",+
                                                             &prop))+
                     speed =3D prop/100;+               else+
           speed =3D 100;+       }+       printk("%s :
speed->%d\n",__func__, speed);++       for_each_child_of_node(bus,
child) {+               u32 prop;++               printk("   create
child: %s\n", child->full_name);+               i2c_board_info =3D
kzalloc(sizeof(*i2c_board_info), GFP_KERNEL);+               if
(!of_property_read_u32(pdev->dev.of_node, "reg",+
                                         &prop))+
i2c_board_info->addr =3D prop;+               if
(!of_property_read_u32(pdev->dev.of_node, "interrupts",+
                                                &prop))+
i2c_board_info->irq =3D prop;+
i2c_board_info->platform_data =3D platform_data;+
strncpy(i2c_board_info->type, child->name,+
           sizeof(i2c_board_info->type));+       }+
omap_register_i2c_bus(id, speed, i2c_board_info, 1);+}+
 /**
  * of_platform_bus_create() - Create a device for a node and its children.
  * @bus: device node of the bus to instantiate@@ -593,6 +642,11 @@
static int of_platform_bus_create(struct device_node *bus,
                return 0;
        }
+       if (of_device_is_compatible(bus, "ti,omap3-i2c")) {+
    of_omap_i2c_device_create(bus, bus_id, platform_data, parent);+
           return 0;+       }+
        dev =3D of_platform_device_create_pdata(bus, bus_id,
platform_data, parent);
        if (!dev || !of_match_node(matches, bus))
                return 0;


-M

--0015174bee6e38b2ee04a8352250
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Grant,<br><br><div class=3D"gmail_quote">On Thu, Jul 14, 2011 at 4:45 AM=
, Grant Likely <span dir=3D"ltr">&lt;<a href=3D"mailto:grant.likely@secretl=
ab.ca">grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex;">
<div class=3D"im">On Thu, Jul 14, 2011 at 7:06 AM, G, Manjunath Kondaiah &l=
t;<a href=3D"mailto:manjugk-l0cyMroinI0@public.gmane.org">manjugk-l0cyMroinI0@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; The generic board file is created and derived from beagle board file.<=
br>
&gt; The beagle board file is migrated to boot from flattened device tree a=
nd<br>
&gt; the cleanup of generic board file will happen in different stages.<br>
&gt;<br>
&gt; The changes here focus on i2c device registration through dt and upcom=
ing<br>
&gt; patches in the series will adopt i2c driver to use dt registered i2c<b=
r>
&gt; devices.<br>
<br>
</div>Since this is a new board file instead of a modification of an<br>
existing one, I recommend *not* trying to completely duplicate the<br>
behaviour of the beagle board. =A0Start small with only the registration<br=
>
of the UART and i2c drivers from the device tree and build up<br>
functionality until it can be used for all the OMAP3 boards.<br>
Otherwise the patch just adds a lot of code that needs to be removed<br>
again.<br></blockquote><div>=A0</div><div>agreed. Started with minimal boar=
d file with only serial and i2c.<br>=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204=
, 204); padding-left: 1ex;">

<div class=3D"im"><br>
&gt;<br>
&gt; Signed-off-by: G, Manjunath Kondaiah &lt;<a href=3D"mailto:manjugk@ti.=
com">manjugk-l0cyMroinI0@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt; =A0arch/arm/mach-omap2/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 | =A0 12 +<br>
&gt; =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +<br=
>
&gt; =A0arch/arm/mach-omap2/board-omap3-dt.c =A0 =A0| =A0623 ++++++++++++++=
+++++++++++++++++<br>
&gt; =A0arch/arm/mach-omap2/board-omap3beagle.c | =A0 13 -<br>
&gt; =A04 files changed, 637 insertions(+), 13 deletions(-)<br>
&gt; =A0create mode 100644 arch/arm/mach-omap2/board-omap3-dt.c<br>
&gt;<br>
&gt; diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig=
<br>
&gt; index 19d5891..174f6d1 100644<br>
&gt; --- a/arch/arm/mach-omap2/Kconfig<br>
&gt; +++ b/arch/arm/mach-omap2/Kconfig<br>
&gt; @@ -302,6 +302,18 @@ config MACH_OMAP_3630SDP<br>
&gt; =A0 =A0 =A0 =A0default y<br>
&gt; =A0 =A0 =A0 =A0select OMAP_PACKAGE_CBP<br>
&gt;<br>
&gt; +config MACH_OMAP3_DT<br>
&gt; + =A0 =A0 =A0 bool &quot;Generic OMAP3 board(FDT support)&quot;<br>
&gt; + =A0 =A0 =A0 depends on ARCH_OMAP3<br>
&gt; + =A0 =A0 =A0 select OMAP_PACKAGE_CBB<br>
&gt; + =A0 =A0 =A0 select USE_OF<br>
&gt; + =A0 =A0 =A0 select PROC_DEVICETREE<br>
<br>
</div>Don&#39;t select PROC_DEVICETREE<br></blockquote><div>ok <br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-=
left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im"><br>
&gt; +<br>
&gt; + =A0 =A0 =A0 help<br>
&gt; + =A0 =A0 =A0 =A0 Support for generic TI OMAP3 boards using Flattened =
Device Tree.<br>
&gt; + =A0 =A0 =A0 =A0 Say Y here to enable OMAP3 device tree support<br>
&gt; + =A0 =A0 =A0 =A0 More information at Documentation/devicetree<br>
&gt; +<br>
&gt; =A0config MACH_TI8168EVM<br>
&gt; =A0 =A0 =A0 =A0bool &quot;TI8168 Evaluation Module&quot;<br>
&gt; =A0 =A0 =A0 =A0depends on SOC_OMAPTI816X<br>
&gt; diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefi=
le<br>
&gt; index b148077..86e66f7 100644<br>
&gt; --- a/arch/arm/mach-omap2/Makefile<br>
&gt; +++ b/arch/arm/mach-omap2/Makefile<br>
&gt; @@ -178,6 +178,8 @@ obj-$(CONFIG_MACH_OMAP_H4) =A0 =A0 =A0 =A0 =A0+=3D=
 board-h4.o<br>
&gt; =A0obj-$(CONFIG_MACH_OMAP_2430SDP) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 board-2430sdp.o \<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 hsmmc.o<br>
&gt; =A0obj-$(CONFIG_MACH_OMAP_APOLLON) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 board-apollon.o<br>
&gt; +obj-$(CONFIG_MACH_OMAP3_DT) =A0 =A0 =A0 =A0 =A0 =A0+=3D board-omap3-d=
t.o \<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0hsmmc.o<br>
&gt; =A0obj-$(CONFIG_MACH_OMAP3_BEAGLE) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 board-omap3beagle.o \<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 hsmmc.o<br>
<br>
</div>This is an odd construct. =A0Tony, why does each board add hsmmc to t=
he<br>
oby-y variable instead of it having its own kconfig symbol?<br>
<div><div></div><div class=3D"h5"><br>
&gt; +static void __init omap3_init(void)<br>
&gt; +{<br>
&gt; + =A0 =A0 =A0 struct device_node *node;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 node =3D of_find_matching_node_by_address(NULL, omap3_dt=
_intc_match,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 OMAP34XX_IC_BASE);<br>
&gt; + =A0 =A0 =A0 if (node)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_domain_add_simple(node, 0);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);<br>
&gt; + =A0 =A0 =A0 omap3_beagle_init_rev();<br>
&gt; + =A0 =A0 =A0 omap3_beagle_i2c_init();<br>
&gt; + =A0 =A0 =A0 platform_add_devices(omap3_beagle_devices,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(omap3_beagle_=
devices));<br>
&gt; + =A0 =A0 =A0 omap_display_init(&amp;beagle_dss_data);<br>
&gt; + =A0 =A0 =A0 omap_serial_init();<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 omap_mux_init_gpio(170, OMAP_PIN_INPUT);<br>
&gt; + =A0 =A0 =A0 /* REVISIT leave DVI powered down until it&#39;s needed =
... */<br>
&gt; + =A0 =A0 =A0 gpio_request_one(170, GPIOF_OUT_INIT_HIGH, &quot;DVI_nPD=
&quot;);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 usb_musb_init(NULL);<br>
&gt; + =A0 =A0 =A0 usbhs_init(&amp;usbhs_bdata);<br>
&gt; + =A0 =A0 =A0 omap_nand_flash_init(NAND_BUSWIDTH_16, omap3beagle_nand_=
partitions,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(om=
ap3beagle_nand_partitions));<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 /* Ensure msecure is mux&#39;d to be able to set the RTC=
. */<br>
&gt; + =A0 =A0 =A0 omap_mux_init_signal(&quot;sys_drm_msecure&quot;, OMAP_P=
IN_OFF_OUTPUT_HIGH);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 /* Ensure SDRC pins are mux&#39;d for self-refresh */<br=
>
&gt; + =A0 =A0 =A0 omap_mux_init_signal(&quot;sdrc_cke0&quot;, OMAP_PIN_OUT=
PUT);<br>
&gt; + =A0 =A0 =A0 omap_mux_init_signal(&quot;sdrc_cke1&quot;, OMAP_PIN_OUT=
PUT);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 beagle_display_init();<br>
&gt; + =A0 =A0 =A0 beagle_opp_init();<br>
&gt; + =A0 =A0 =A0 of_platform_populate(NULL, omap_dt_match_table, NULL, NU=
LL);<br>
<br>
</div></div>Hmmm, I don&#39;t think this will work for OMAP because it will=
 not create<br>
the i2c bus as an omap_device. =A0It will only be a plane<br>
platform_deevice. =A0You&#39;ll need to have a hook in<br>
of_platform_populate() to create devices the way omap3 infrastructure<br>
expects.<br>
<div class=3D"im"><br></div></blockquote><div><br>This dependency is mentio=
ned in patch series. Since you pointed out this<br>issue, I would like to p=
ropose following approach for hooking up omap hwmod=B7<br>framework with dt=
. Though, the current approach focus only on i2c driver, it<br>
can be extended and generalized as it evolves with other board and driver c=
leanup<br>activities. The following changes are not tested and also not com=
piled,=A0 it is<br>only proposal I am thinking to implement. <br><br>Let me=
 know if you see any serious issues with the approach.<br>

<pre><span class=3D"Type"></span>
<span class=3D"Type">diff --git a/drivers/of/platform.c b/drivers/of/platfo=
rm.c</span>
index c1773456..104ef31 100644
<span class=3D"Type">--- a/drivers/of/platform.c</span>
<span class=3D"Type">+++ b/drivers/of/platform.c</span>
<span class=3D"Statement">@@ -457,6 +457,8 @@</span><span class=3D"PreProc"=
> void of_platform_prepare(struct device_node *root,</span>
        }
 }

<span class=3D"Identifier">+</span>
<span class=3D"Identifier">+</span>
 #ifdef CONFIG_ARM_AMBA
 static struct amba_device *of_amba_device_create(struct device_node *node,
                                                 const char *bus_id,
<span class=3D"Statement">@@ -537,13 +539,60 @@</span><span class=3D"PrePro=
c"> static const struct of_dev_auxdata *of_dev_lookup(const struct of_dev_a=
uxdata *l</span>
                                continue;
                        if (res.start !=3D lookup-&gt;phys_addr)
                                continue;
<span class=3D"Special">-                       pr_debug(&quot;%s: devname=
=3D%s\n&quot;, np-&gt;full_name, lookup-&gt;name);</span>
<span class=3D"Identifier">+                       printk(&quot;%s: devname=
=3D%s\n&quot;, np-&gt;full_name, lookup-&gt;name);</span>
                        return lookup;
                }
        }
        return NULL;
 }

<span class=3D"Identifier">+static struct omap_device *of_omap_i2c_device_c=
reate(struct device_node *node,</span>
<span class=3D"Identifier">+                                               =
 const char *bus_id,</span>
<span class=3D"Identifier">+                                               =
 void *platform_data,</span>
<span class=3D"Identifier">+                                               =
 struct device *parent)</span>
<span class=3D"Identifier">+{</span>
<span class=3D"Identifier">+       struct platform_device *pdev;</span>
<span class=3D"Identifier">+       struct i2c_board_info *i2c_board_info;</=
span>
<span class=3D"Identifier">+       u8 id;</span>
<span class=3D"Identifier">+</span>
<span class=3D"Identifier">+       printk(&quot;Creating omap i2c device %s=
\n&quot;, node-&gt;full_name);</span>
<span class=3D"Identifier">+</span>
<span class=3D"Identifier">+       if (!of_device_is_available(node))</span=
>
<span class=3D"Identifier">+               return NULL;</span>
<span class=3D"Identifier">+</span>
<span class=3D"Identifier">+       id =3D simple_strtol(bus_id, NULL, 0);</=
span>
<span class=3D"Identifier">+       pdev =3D kzalloc(sizeof(*pdev), GFP_KERN=
EL);</span>
<span class=3D"Identifier">+       pdev-&gt;dev.of_node =3D of_node_get(nod=
e);</span>
<span class=3D"Identifier">+       if (!pdev-&gt;dev.of_node) {</span>
<span class=3D"Identifier">+               speed =3D 100;</span>
<span class=3D"Identifier">+       } else {</span>
<span class=3D"Identifier">+               u32 prop;</span>
<span class=3D"Identifier">+               if (!of_property_read_u32(pdev-&=
gt;dev.of_node, &quot;clock-frequency&quot;,</span>
<span class=3D"Identifier">+                                               =
                        &amp;prop))</span>
<span class=3D"Identifier">+                       speed =3D prop/100;</spa=
n>
<span class=3D"Identifier">+               else</span>
<span class=3D"Identifier">+                       speed =3D 100;</span>
<span class=3D"Identifier">+       }</span>
<span class=3D"Identifier">+       printk(&quot;%s : speed-&gt;%d\n&quot;,_=
_func__, speed);</span>
<span class=3D"Identifier">+</span>
<span class=3D"Identifier">+       for_each_child_of_node(bus, child) {</sp=
an>
<span class=3D"Identifier">+               u32 prop;</span>
<span class=3D"Identifier">+</span>
<span class=3D"Identifier">+               printk(&quot;   create child: %s=
\n&quot;, child-&gt;full_name);</span>
<span class=3D"Identifier">+               i2c_board_info =3D kzalloc(sizeo=
f(*i2c_board_info), GFP_KERNEL);</span>
<span class=3D"Identifier">+               if (!of_property_read_u32(pdev-&=
gt;dev.of_node, &quot;reg&quot;,</span>
<span class=3D"Identifier">+                                               =
                &amp;prop))</span>
<span class=3D"Identifier">+               i2c_board_info-&gt;addr =3D prop=
;</span>
<span class=3D"Identifier">+               if (!of_property_read_u32(pdev-&=
gt;dev.of_node, &quot;interrupts&quot;,</span>
<span class=3D"Identifier">+                                               =
                &amp;prop))</span>
<span class=3D"Identifier">+               i2c_board_info-&gt;irq =3D prop;=
</span>
<span class=3D"Identifier">+               i2c_board_info-&gt;platform_data=
 =3D platform_data;</span>
<span class=3D"Identifier">+               strncpy(i2c_board_info-&gt;type,=
 child-&gt;name,</span>
<span class=3D"Identifier">+                                       sizeof(i=
2c_board_info-&gt;type));</span>
<span class=3D"Identifier">+       }</span>
<span class=3D"Identifier">+       omap_register_i2c_bus(id, speed, i2c_boa=
rd_info, 1);</span>
<span class=3D"Identifier">+}</span>
<span class=3D"Identifier">+</span>
 /**
  * of_platform_bus_create() - Create a device for a node and its children.
  * @bus: device node of the bus to instantiate
<span class=3D"Statement">@@ -593,6 +642,11 @@</span><span class=3D"PreProc=
"> static int of_platform_bus_create(struct device_node *bus,</span>
                return 0;
        }

<span class=3D"Identifier">+       if (of_device_is_compatible(bus, &quot;t=
i,omap3-i2c&quot;)) {</span>
<span class=3D"Identifier">+               of_omap_i2c_device_create(bus, b=
us_id, platform_data, parent);</span>
<span class=3D"Identifier">+               return 0;</span>
<span class=3D"Identifier">+       }</span>
<span class=3D"Identifier">+</span>
        dev =3D of_platform_device_create_pdata(bus, bus_id, platform_data,=
 parent);
        if (!dev || !of_match_node(matches, bus))
                return 0;
</pre><br>
</div></div>-M<br>

--0015174bee6e38b2ee04a8352250--

--===============0126821751923911838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============0126821751923911838==--
