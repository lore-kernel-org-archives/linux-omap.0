From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] New Nokia RX-51 power supply battery driver
Date: Wed, 21 Nov 2012 11:20:43 -0800
Message-ID: <20121121192042.GG18567@atomide.com>
References: <19040462.WFXWijAIDd@pali>
 <2562836.SjVVyiPAk1@pali>
 <20121118231239.GC29066@lizard.sbx05977.paloaca.wayport.net>
 <5320319.2WmO5VDT8j@pali>
 <20121119182002.GA2670@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121119182002.GA2670@lizard>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, Joerg Reisenweber <joerg@openmoko.org>, Ivaylo Dimitrov <freemangordon@abv.bg>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Anton Vorontsov <cbouatmailru@gmail.com> [121119 10:25]:
> On Mon, Nov 19, 2012 at 01:18:29PM +0100, Pali Roh=C3=A1r wrote:
> [...]=20
> > Ok. Here is missing patch which register this driver in Nokia N900 =
board code. Without it driver is not loaded.
>=20
> Cc'ing OMAP folks.

Looks OK to me queue with the other patches in the series:

Acked-by: Tony Lindgren <tony@atomide.com>
=20
 > From 0b60efd06a71668439bcb761c6572dd7df91dc17 Mon Sep 17 00:00:00 20=
01
> > From: =3D?UTF-8?q?Pali=3D20Roh=3DC3=3DA1r?=3D <pali.rohar@gmail.com=
>
> > Date: Mon, 19 Nov 2012 09:05:24 +0100
> > Subject: [PATCH 1/3] ARM: OMAP: rx51: Register platform device for
> >  rx51_battery driver
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=3DUTF-8
> > Content-Transfer-Encoding: 8bit
> >=20
> > Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > ---
> >  arch/arm/mach-omap2/board-rx51-peripherals.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/ar=
m/mach-omap2/board-rx51-peripherals.c
> > index 020e03c..fe1ac7e 100644
> > --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> > +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> > @@ -271,11 +271,17 @@ static struct platform_device rx51_charger_de=
vice =3D {
> >  	},
> >  };
> > =20
> > +static struct platform_device rx51_battery_device =3D {
> > +	.name		=3D "rx51-battery",
> > +	.id		=3D -1,
> > +};
> > +
> >  static void __init rx51_charger_init(void)
> >  {
> >  	WARN_ON(gpio_request_one(RX51_USB_TRANSCEIVER_RST_GPIO,
> >  		GPIOF_OUT_INIT_HIGH, "isp1704_reset"));
> > =20
> > +	platform_device_register(&rx51_battery_device);
> >  	platform_device_register(&rx51_charger_device);
> >  }
> > =20
> > --=20
> > 1.7.10.4
> >=20
> > --=20
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com
