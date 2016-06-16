From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 4/5] mfd: tps65217: Add power button as subdevice
Date: Thu, 16 Jun 2016 11:36:22 +0100
Message-ID: <20160616103622.GS4948@dell>
References: <20160614132927.3309-1-m.niestroj@grinn-global.com>
 <20160614132927.3309-5-m.niestroj@grinn-global.com>
 <20160615141242.GK4948@dell>
 <61c57049-04e3-434c-6293-58a9297c73c9@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <61c57049-04e3-434c-6293-58a9297c73c9@grinn-global.com>
Sender: linux-pm-owner@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 15 Jun 2016, Marcin Niestroj wrote:

> Hi,
>=20
> On 15.06.2016 16:12, Lee Jones wrote:
> >On Tue, 14 Jun 2016, Marcin Niestroj wrote:
> >
> >>Add tps65217 power buttor subdevice with assigned IRQ resources.
> >>
> >>Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> >>---
> >>depends on patch 1 in series
> >>
> >> drivers/mfd/tps65217.c | 10 ++++++++++
> >> 1 file changed, 10 insertions(+)
> >
> >Applied, thanks.
>=20
> Did you also apply patch 1? As I stated above, this patch depends on
> patch 1.

Nope.  It looks like you still have changes to make.

What does it rely on?  The IRQ define?

> >>diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> >>index d49f94e..68cf431 100644
> >>--- a/drivers/mfd/tps65217.c
> >>+++ b/drivers/mfd/tps65217.c
> >>@@ -38,6 +38,10 @@ static struct resource charger_resources[] =3D {
> >> 	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_USB, "USB"),
> >> };
> >>
> >>+static struct resource pb_resources[] =3D {
> >>+	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_PB, "PB"),
> >>+};
> >>+
> >> struct tps65217_irq {
> >> 	int mask;
> >> 	int interrupt;
> >>@@ -122,6 +126,12 @@ static struct mfd_cell tps65217s[] =3D {
> >> 		.resources =3D charger_resources,
> >> 		.of_compatible =3D "ti,tps65217-charger",
> >> 	},
> >>+	{
> >>+		.name =3D "tps65217-pwrbutton",
> >>+		.num_resources =3D ARRAY_SIZE(pb_resources),
> >>+		.resources =3D pb_resources,
> >>+		.of_compatible =3D "ti,tps65217-pwrbutton",
> >>+	},
> >> };
> >>
> >> static irqreturn_t tps65217_irq_thread(int irq, void *data)
> >
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
