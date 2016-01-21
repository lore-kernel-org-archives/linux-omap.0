From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: dts: n900: Include adp1653 device
Date: Thu, 21 Jan 2016 10:50:04 +0100
Message-ID: <20160121095004.GW7192@pali>
References: <1451086812-3729-1-git-send-email-pali.rohar@gmail.com>
 <20160121091241.GS7192@pali>
 <20160121092909.GH5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160121092909.GH5783@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Ok, but for whole month I do not see any response that somebody take
this patch into some queue or tree. Which could means that patch was
either ignored or is living somewhere and could be lost.

On Thursday 21 January 2016 09:29:10 Russell King - ARM Linux wrote:
> The merge window is open, which is when development code that was mer=
ged
> in good time prior to the merge window is sent upstream to Linus.  Li=
nux
> maintainers may choose not to merge new code into their tree to avoid
> disrupting the utility of linux-next until the merge window has close=
d.
>=20
> linux-next is an integration tree to help find merge conflicts, it
> exists to assist with the merge windows, not as a general test ground=
=2E
> Thus, linux-next must only contain code for either the current open
> merge window, or if the merge window is closed, the next merge window=
=2E
>=20
> On Thu, Jan 21, 2016 at 10:12:41AM +0100, Pali Roh=C3=A1r wrote:
> > On Saturday 26 December 2015 00:40:12 Pali Roh=C3=A1r wrote:
> > > This patch adds adp1653 device into n900 DT structure. DT support=
 in
> > > adp1653 driver is there since v4.2-rc1 version.
> > >=20
> > > Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/omap3-n900.dts |   15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >=20
> > > diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts=
/omap3-n900.dts
> > > index 5f5e0f3..ba93642 100644
> > > --- a/arch/arm/boot/dts/omap3-n900.dts
> > > +++ b/arch/arm/boot/dts/omap3-n900.dts
> > > @@ -522,6 +522,21 @@
> > >  		amstaos,cover-comp-gain =3D <16>;
> > >  	};
> > > =20
> > > +	adp1653: led-controller@30 {
> > > +		compatible =3D "adi,adp1653";
> > > +		reg =3D <0x30>;
> > > +		enable-gpios =3D <&gpio3 24 GPIO_ACTIVE_HIGH>; /* 88 */
> > > +
> > > +		flash {
> > > +			flash-timeout-us =3D <500000>;
> > > +			flash-max-microamp =3D <320000>;
> > > +			led-max-microamp =3D <50000>;
> > > +		};
> > > +		indicator {
> > > +			led-max-microamp =3D <17500>;
> > > +		};
> > > +	};
> > > +
> > >  	lp5523: lp5523@32 {
> > >  		compatible =3D "national,lp5523";
> > >  		reg =3D <0x32>;
> >=20
> > PING, who can take this patch?
> >=20
> > I still do not see it in linus tree nor in others like arm-soc...
> >=20
> > --=20
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
