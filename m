From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v2] twl4030: Fix boot with twl4030 usb transceiver
 enabled
Date: Fri, 9 Oct 2009 18:14:09 +0200
Message-ID: <20091009161408.GC7523@sortiz.org>
References: <1254385536-26912-1-git-send-email-ext-roger.quadros@nokia.com>
 <b90c0690910090532y60cced09j2c805a5a04dbcbb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63985 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933772AbZJIQNe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Oct 2009 12:13:34 -0400
Content-Disposition: inline
In-Reply-To: <b90c0690910090532y60cced09j2c805a5a04dbcbb7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <quadros.roger@gmail.com>
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, felipe.balbi@nokia.com

Hi Roger,

On Fri, Oct 09, 2009 at 03:32:12PM +0300, Roger Quadros wrote:
> Hi Samuel,
>=20
> What is the status of this patch?
> Without this patch we are unable to boot on systems using musb usb co=
ntroller.
I'm applying that patch to my for-next branch. And I will also try to h=
ave
Linus pulling it too, as it seems to prevent your machines from booting=
=2E

Cheers,
Samuel.


> cheers,
> -roger.
>=20
> On Thu, Oct 1, 2009 at 11:25 AM, Roger Quadros
> <ext-roger.quadros@nokia.com> wrote:
> > The usb regulator supplies (usb1v5, usb1v8 & usb3v1) must be availa=
ble
> > before adding the twl4030_usb child, else twl4030_usb_ldo_init() wi=
ll
> > always fail thus causing boot lock-up.
> >
> > This patch fixes boot on OMAP systems using the twl4030 usb transce=
iver.
> > CONFIG_TWL4030_USB=3Dy
> >
> > Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
> > ---
> > =A0drivers/mfd/twl4030-core.c | =A0 89 ++++++++++++++++++++++------=
---------------
> > =A01 files changed, 46 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.=
c
> > index e424cf6..e832e97 100644
> > --- a/drivers/mfd/twl4030-core.c
> > +++ b/drivers/mfd/twl4030-core.c
> > @@ -480,7 +480,6 @@ static int
> > =A0add_children(struct twl4030_platform_data *pdata, unsigned long =
features)
> > =A0{
> > =A0 =A0 =A0 =A0struct device =A0 *child;
> > - =A0 =A0 =A0 struct device =A0 *usb_transceiver =3D NULL;
> >
> > =A0 =A0 =A0 =A0if (twl_has_bci() && pdata->bci && !(features & TPS_=
SUBSET)) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0child =3D add_child(3, "twl4030_bci"=
,
> > @@ -532,16 +531,61 @@ add_children(struct twl4030_platform_data *pd=
ata, unsigned long features)
> > =A0 =A0 =A0 =A0}
> >
> > =A0 =A0 =A0 =A0if (twl_has_usb() && pdata->usb) {
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 static struct regulator_consumer_supp=
ly usb1v5 =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D =A0 =A0 =A0=
 "usb1v5",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 static struct regulator_consumer_supp=
ly usb1v8 =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D =A0 =A0 =A0=
 "usb1v8",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 static struct regulator_consumer_supp=
ly usb3v1 =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D =A0 =A0 =A0=
 "usb3v1",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > +
> > + =A0 =A0 =A0 /* First add the regulators so that they can be used =
by transceiver */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (twl_has_regulator()) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this is a template=
 that gets copied */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct regulator_init=
_data usb_fixed =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .cons=
traints.valid_modes_mask =3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 REGULATOR_MODE_NORMAL
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_MODE_STANDBY,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .cons=
traints.valid_ops_mask =3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 REGULATOR_CHANGE_MODE
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_CHANGE_STATUS,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 child =3D add_regulat=
or_linked(TWL4030_REG_VUSB1V5,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &usb_fixed, &usb1v5, 1);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(child))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retur=
n PTR_ERR(child);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 child =3D add_regulat=
or_linked(TWL4030_REG_VUSB1V8,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &usb_fixed, &usb1v8, 1);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(child))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retur=
n PTR_ERR(child);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 child =3D add_regulat=
or_linked(TWL4030_REG_VUSB3V1,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &usb_fixed, &usb3v1, 1);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(child))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retur=
n PTR_ERR(child);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > +
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0child =3D add_child(0, "twl4030_usb"=
,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdat=
a->usb, sizeof(*pdata->usb),
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0true=
,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* i=
rq0 =3D USB_PRES, irq1 =3D USB */
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdat=
a->irq_base + 8 + 2, pdata->irq_base + 4);
> > +
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (IS_ERR(child))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return PTR_ERR(child=
);
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* we need to connect regulators to =
this transceiver */
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_transceiver =3D child;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (twl_has_regulator() && child) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb1v5.dev =3D child;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb1v8.dev =3D child;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb3v1.dev =3D child;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > =A0 =A0 =A0 =A0}
> >
> > =A0 =A0 =A0 =A0if (twl_has_watchdog()) {
> > @@ -580,47 +624,6 @@ add_children(struct twl4030_platform_data *pda=
ta, unsigned long features)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return PTR_ERR(child=
);
> > =A0 =A0 =A0 =A0}
> >
> > - =A0 =A0 =A0 if (twl_has_regulator() && usb_transceiver) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 static struct regulator_consumer_supp=
ly usb1v5 =3D {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D =A0 =A0 =A0=
 "usb1v5",
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 static struct regulator_consumer_supp=
ly usb1v8 =3D {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D =A0 =A0 =A0=
 "usb1v8",
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 static struct regulator_consumer_supp=
ly usb3v1 =3D {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D =A0 =A0 =A0=
 "usb3v1",
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > -
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this is a template that gets copie=
d */
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct regulator_init_data usb_fixed =
=3D {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .constraints.valid_mo=
des_mask =3D
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 R=
EGULATOR_MODE_NORMAL
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | REG=
ULATOR_MODE_STANDBY,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .constraints.valid_op=
s_mask =3D
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 R=
EGULATOR_CHANGE_MODE
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | REG=
ULATOR_CHANGE_STATUS,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > -
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb1v5.dev =3D usb_transceiver;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb1v8.dev =3D usb_transceiver;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb3v1.dev =3D usb_transceiver;
> > -
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 child =3D add_regulator_linked(TWL403=
0_REG_VUSB1V5, &usb_fixed,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &usb1=
v5, 1);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(child))
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(child)=
;
> > -
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 child =3D add_regulator_linked(TWL403=
0_REG_VUSB1V8, &usb_fixed,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &usb1=
v8, 1);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(child))
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(child)=
;
> > -
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 child =3D add_regulator_linked(TWL403=
0_REG_VUSB3V1, &usb_fixed,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &usb3=
v1, 1);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(child))
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(child)=
;
> > - =A0 =A0 =A0 }
> > -
> > =A0 =A0 =A0 =A0/* maybe add LDOs that are omitted on cost-reduced p=
arts */
> > =A0 =A0 =A0 =A0if (twl_has_regulator() && !(features & TPS_SUBSET))=
 {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0child =3D add_regulator(TWL4030_REG_=
VPLL2, pdata->vpll2);
> > --
> > 1.6.0.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-ker=
nel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> > Please read the FAQ at =A0http://www.tux.org/lkml/
> >

--=20
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
