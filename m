From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 14/18] omap: Overo: Add support for second ethernet port
Date: Wed, 19 May 2010 11:27:27 -0700
Message-ID: <20100519182727.GG5818@atomide.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
 <20100505193315.21568.55530.stgit@baageli.muru.com>
 <AANLkTinxHaxG89pUhD7nmMjQSF-p-FB1FWj_w-de9y1r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60870 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113Ab0ESS1b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 14:27:31 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinxHaxG89pUhD7nmMjQSF-p-FB1FWj_w-de9y1r@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Steve Sakoman <sakoman@gmail.com> [100518 06:36]:
> On Wed, May 5, 2010 at 12:33 PM, Tony Lindgren <tony@atomide.com> wro=
te:
> > From: Steve Sakoman <steve@sakoman.com>
> >
> > Some Overo add-on boards include a second ethernet port. =C2=A0This=
 patch
> > adds support for that second port.
> >
> > Signed-off-by: Steve Sakoman <steve@sakoman.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> > =C2=A0arch/arm/mach-omap2/board-overo.c | =C2=A0 14 +++++++++++++-
> > =C2=A01 files changed, 13 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap=
2/board-overo.c
> > index 8848c7c..79ac414 100644
> > --- a/arch/arm/mach-omap2/board-overo.c
> > +++ b/arch/arm/mach-omap2/board-overo.c
> > @@ -63,6 +63,8 @@
> >
> > =C2=A0#define OVERO_SMSC911X_CS =C2=A0 =C2=A0 =C2=A05
> > =C2=A0#define OVERO_SMSC911X_GPIO =C2=A0 =C2=A0176
> > +#define OVERO_SMSC911X2_CS =C2=A0 =C2=A0 4
> > +#define OVERO_SMSC911X2_GPIO =C2=A0 65
> >
> > =C2=A0#if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0defined(CONFIG_TOUCHSCREEN_ADS7846_MODUL=
E)
> > @@ -137,6 +139,16 @@ static struct resource overo_smsc911x_resource=
s[] =3D {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> > =C2=A0};
> >
> > +static struct resource overo_smsc911x2_resources[] =3D {
> > + =C2=A0 =C2=A0 =C2=A0 {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =3D=
 "smsc911x2-memory",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0=3D=
 IORESOURCE_MEM,
> > + =C2=A0 =C2=A0 =C2=A0 },
> > + =C2=A0 =C2=A0 =C2=A0 {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0=3D=
 IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
> > + =C2=A0 =C2=A0 =C2=A0 },
> > +};
> > +
> > =C2=A0static struct smsc911x_platform_config overo_smsc911x_config =
=3D {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.irq_polarity =C2=A0 =3D SMSC911X_IRQ_PO=
LARITY_ACTIVE_LOW,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.irq_type =C2=A0 =C2=A0 =C2=A0 =3D SMSC9=
11X_IRQ_TYPE_OPEN_DRAIN,
> > @@ -146,7 +158,7 @@ static struct smsc911x_platform_config overo_sm=
sc911x_config =3D {
> >
> > =C2=A0static struct platform_device overo_smsc911x_device =3D {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D "smsc911x",
> > - =C2=A0 =C2=A0 =C2=A0 .id =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D -1,
> > + =C2=A0 =C2=A0 =C2=A0 .id =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D 0,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.num_resources =C2=A0=3D ARRAY_SIZE(over=
o_smsc911x_resources),
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.resource =C2=A0 =C2=A0 =C2=A0 =3D overo=
_smsc911x_resources,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.dev =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D {
> >
> > --
>=20
> I just noticed that somehow a good portion of my original patch got
> dropped in this version!

It seems to be a patchwork issue, note how some of that got into the co=
mmit
message:

https://patchwork.kernel.org/patch/91277/

Might be worth investigating further, there's the mbox link there, mayb=
e
that contains some clues.
=20
> Original:
>=20
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26350.html
>=20
> How would you like to handle getting the missing chuncks?

Can you please post your fix as a reply to this thread? I've already
merged the original patch into omap-for-linus, this is too late to
start messing with that.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
