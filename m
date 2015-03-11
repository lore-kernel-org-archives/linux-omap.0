From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
Date: Wed, 11 Mar 2015 12:37:36 -0700
Message-ID: <20150311193736.GF5264@atomide.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
 <1426022847-30912-4-git-send-email-marek@goldelico.com>
 <20150311152414.GX5264@atomide.com>
 <844740CD-C95B-4411-A2C8-4906F58DBEE8@goldelico.com>
 <20150311164442.GA5264@atomide.com>
 <F7BA143D-5CF9-42E3-AFA8-B83B149EF77E@goldelico.com>
 <20150311174316.GD5264@atomide.com>
 <20150311193654.GA3126@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150311193654.GA3126@earth>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Benoit Cousson <bcousson@baylibre.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [150311 12:37]:
> Hi,
>=20
> On Wed, Mar 11, 2015 at 10:43:17AM -0700, Tony Lindgren wrote:
> > No no, "capacity-uah" is what we should use, but you need an ack fr=
om
> > the battery and device tree people that this is OK. Let's not add
> > "ti,capacity-uah=E2=80=9D as that can obviously be a generic proper=
ty.
>=20
> I'm okay with capacity-uah.

OK great.
=20
> > > [...]
> >=20
> > Oh if they are battery spicific, then ideally we'd have generic bat=
ery
> > voltage to capacity maps property rather than a custom ti specific
> > property.
> >=20
> > To avoid extra hassles later on, maybe you could submit a generic
> > binding patch only documenting it to the battery people and the dev=
ice
> > tree people? That will make it easier to maintain this driver in th=
e
> > long run.
>=20
> Actually the proper way would be to differentiate between the
> battery and the measurement chip / adc and that should be
> implemented in the long run. The kernel's power supply framework
> is not yet ready for it, though.
>=20
> Example DT:
>=20
> battery {
>     battery-specific-data;
> };
>=20
> fuel-gauge {
>     measures =3D <&battery>;
> };
>=20
> charger {
>     charges =3D <&battery>;
> };
>=20
> Since infrastructure for generic bindings is missing, I think its
> best to have the vendor properties for now and map this to generic
> properties, once they have been specified.

OK, sounds good to me. I'm fine with the $subject patch as it is then:

Acked-by: Tony Lindgren <tony@atomide.com>

Tony
