From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] regulator: twl: mark vdd1/2 as continuous on twl4030
Date: Mon, 17 Jun 2019 18:27:43 +0200
Message-ID: <20190617182743.7f40f2ee@aktux>
References: <20190615163314.28173-1-andreas@kemnade.info>
        <20190617103111.GM5316@sirena.org.uk>
        <20190617130357.41204ff7@kemnade.info>
        <20190617114048.GN5316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190617114048.GN5316@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sboyd@kernel.org, nm@ti.com, vireshk@kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

On Mon, 17 Jun 2019 12:40:48 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Mon, Jun 17, 2019 at 01:03:57PM +0200, Andreas Kemnade wrote:
> > Mark Brown <broonie@kernel.org> wrote: =20
> > > On Sat, Jun 15, 2019 at 06:33:14PM +0200, Andreas Kemnade wrote: =20
>=20
> > > Why is this a good fix and not defining the supported voltages?  These
> > > look like fairly standard linear range regulators. =20
>=20
> > I am fixing the definition of the two regulators in the patch.
> > I am defining them as continuous.=20
> > Voltage ranges are defined in
> > arch/arm/boot/dts/twl4030.dtsi
> > Only the continuous flag is missing. =20
>=20
> > Is there anything else do you want to be defined? =20
>=20
> These regulators are not continuous regulators as far as I can see, they
> are normal linear range regulators and so should have their voltages
> enumerable like any other linear range regulator.

Citing tps65950 trm page 55:

The device contains three switch-mode power supplies (SMPS):
=E2=80=A2 VDD1: 1.2-A, buck DC/DC converter (VOUT =3D 0.6 V to 1.45 V, in s=
teps of 12.5 mV)
=E2=80=A2 VDD2: 600-mA buck DC/DC converter (VOUT =3D 0.6 V to 1.45 V, in s=
teps of 12.5 mV, and 1.5 V as a
   single programmable value)

you are right, they are not really continuous. So should I add these
68 steps they have as a voltage list?

I think they are nearly continuous, so we should IMHO rather take that
not that strict. I guess there are no really continuous regulators, all
have steps as voltage is specified in a limited resolution. So what is
the exact meaning of that flag here?

I think it is common sense to specify these regulators as continuous.
Max and min values are already in arch/arm/boot/dts/twl4030.dtsi.

Regards,
Andreas
