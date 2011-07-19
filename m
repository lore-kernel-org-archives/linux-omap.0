From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/4] dt: omap3: add generic board file for dt support
Date: Tue, 19 Jul 2011 15:36:49 -0600
Message-ID: <20110719213649.GP6848@ponder.secretlab.ca>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
 <1310592975-25773-4-git-send-email-manjugk@ti.com>
 <CACxGe6sELS=C==16TZ2pfrxJDDyqjS_qOwJUfwzwMO8hqo8Xag@mail.gmail.com>
 <CAC63_iSqN=rX6MbzFWM6z+zf1Eybg3MOD=qQVdeNg5cyENhPjw@mail.gmail.com>
 <CAC63_iTf696D6Q_EzFeUUp5R38pYNEJBkmKviEu6-yuF0y=bNA@mail.gmail.com>
 <CACxGe6uzyxf35WDg6COnPVt3dhQv1H80L1svALxp4naySx2BcA@mail.gmail.com>
 <CAP6yH7eSmdU16r5iC2MwvU3RwOBXaJNygMUXG=HSMiWUKnor-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36650 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab1GSVgw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jul 2011 17:36:52 -0400
Received: by pzk3 with SMTP id 3so5472163pzk.5
        for <linux-omap@vger.kernel.org>; Tue, 19 Jul 2011 14:36:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAP6yH7eSmdU16r5iC2MwvU3RwOBXaJNygMUXG=HSMiWUKnor-w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org

On Mon, Jul 18, 2011 at 03:45:57PM +0530, G, Manjunath Kondaiah wrote:
> Hi Grant,
>=20
> On 17 July 2011 10:43, Grant Likely <grant.likely@secretlab.ca> wrote=
:
> > Hi Manjunath,
> >
> > Comments below. =A0I left in a lot of context for the new folks tha=
t
> > I've cc'd (Tony and Kevin).
> >
> > On Sat, Jul 16, 2011 at 2:07 PM, G, Manjunath Kondaiah <manjugk@ti.=
com> wrote:
> >> On Thu, Jul 14, 2011 at 4:45 AM, Grant Likely <grant.likely@secret=
lab.ca> wrote:
> >>>> > +static void __init omap3_init(void)
> >>>> > +{
> >>>> > + =A0 =A0 =A0 struct device_node *node;
> >>>> > +
> [...]
> >> +static struct omap_device *of_omap_i2c_device_create(struct devic=
e_node *node,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *bus_id,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *platform_data,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device *parent)
> >> +{
> >> + =A0 =A0 =A0 struct platform_device *pdev;
> >> + =A0 =A0 =A0 struct i2c_board_info *i2c_board_info;
> >> + =A0 =A0 =A0 u8 id;
> >> +
> >> + =A0 =A0 =A0 printk("Creating omap i2c device %s\n", node->full_n=
ame);
> >> +
> >> + =A0 =A0 =A0 if (!of_device_is_available(node))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> >> +
> >> + =A0 =A0 =A0 id =3D simple_strtol(bus_id, NULL, 0);
> >> + =A0 =A0 =A0 pdev =3D kzalloc(sizeof(*pdev), GFP_KERNEL);
> >> + =A0 =A0 =A0 pdev->dev.of_node =3D of_node_get(node);
> >> + =A0 =A0 =A0 if (!pdev->dev.of_node) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 speed =3D 100;
> >> + =A0 =A0 =A0 } else {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 prop;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!of_property_read_u32(pdev->dev.=
of_node, "clock-frequency",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 &prop))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 speed =3D prop/100;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 speed =3D 100;
> >> + =A0 =A0 =A0 }
> >> + =A0 =A0 =A0 printk("%s : speed->%d\n",__func__, speed);
> >> +
> >> + =A0 =A0 =A0 for_each_child_of_node(bus, child) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 prop;
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(" =A0 create child: %s\n", ch=
ild->full_name);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_board_info =3D kzalloc(sizeof(*i=
2c_board_info), GFP_KERNEL);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!of_property_read_u32(pdev->dev.=
of_node, "reg",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &prop))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_board_info->addr =3D prop;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!of_property_read_u32(pdev->dev.=
of_node, "interrupts",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &prop))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_board_info->irq =3D prop;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_board_info->platform_data =3D pl=
atform_data;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strncpy(i2c_board_info->type, child-=
>name,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 sizeof(i2c_board_info->type));
> >> + =A0 =A0 =A0 }
> >> + =A0 =A0 =A0 omap_register_i2c_bus(id, speed, i2c_board_info, 1);
> >
> > While this does in a sense work, and creates an omap_device for the
> > i2c bus that does get probed, it ends up encoding an awful lot of
> > device specific details into the generic devicetree support code. =A0=
The
> > i2c bus driver itself must be responsible for decoding the speed an=
d
> > child nodes, and in fact it can easily be modified to do so (I've
>=20
> Decoding speed in i2c driver seems to be fine. But the i2c child node=
s are
> board specific. We might bring board specific handling code into i2c =
driver
> with this approach.

It shouldn't.  They're just i2c devices, and the child nodes will
always follow the i2c device binding.

> BTW, I have observed that, if we create i2c device node in omapx-soc.=
dtsi
> file and the define i2c bus clock-frequency in beagle.dts, the clock-=
frequency
> is not available in driver probe. Is this expected behavior?

No, it sounds like something isn't getting set up correctly.  Send me
your current beagle.dts and omap3-soc.dtsi files.

g.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
