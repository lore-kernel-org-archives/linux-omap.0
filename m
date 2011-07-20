From: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] OMAP3:I2C: Add device tree nodes for beagle board
Date: Wed, 20 Jul 2011 19:04:20 +0800
Message-ID: <20110720110419.GA6999@S2100-06.ap.freescale.net>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
 <1309426647-31587-2-git-send-email-manjugk@ti.com>
 <20110706185546.GJ4871@ponder.secretlab.ca>
 <74CDBE0F657A3D45AFBB94109FB122FF049E21C203@HQMAIL01.nvidia.com>
 <CACxGe6u8qq7FA7kFXbU5uCk6m_GA8GWLqsdjFCXN+NMJfFKxmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACxGe6u8qq7FA7kFXbU5uCk6m_GA8GWLqsdjFCXN+NMJfFKxmA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 06, 2011 at 06:12:49PM -0600, Grant Likely wrote:
> On Wed, Jul 6, 2011 at 5:26 PM, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> w=
rote:
> > Grant Likely wrote at Wednesday, July 06, 2011 12:56 PM:
> >> On Thu, Jun 30, 2011 at 03:07:23PM +0500, G, Manjunath Kondaiah wr=
ote:
> >> > Add I2C and it's child device nodes for beagle board.
> >> > The I2C1 controller child devices are not populated and it
> >> > should be handled along with OMAP clock changes.
> > ...
> >> > diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/=
dts/omap3-beagle.dts
> > ...
> >> > + =A0 i2c@48070000 {
> > ...
> >> > + =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <2600>;
> >> > + =A0 =A0 =A0 =A0 =A0 status =3D "disabled";
> >>
> >> Drop 'status' when you move this node definition to
> >> arch/arm/boot/dts/omap3.dtsi. =A0Board overlay files that include =
the
> >> omap3.dtsi should explicitly disable any devices that it does not =
use
> >> (which is opposite to what tegra currently does, but I'm going to
> >> change that).
> >
> > Purely out of idle curiosity: What's the benefit of one way over th=
e other?
>=20
> Mostly consistency.  Most of the experience we have with the flattene=
d
> device tree up to this point hasn't bothered with the 'status'
> property.  It is only when AMP and hypervisors cam online that it
> became important to use a status property, and that only when the
> kernel needs to be told that the device does indeed exist, but it mus=
t
> not be touched.  I'd like to continue that pattern for new DT users
> with the default assumption that a device is enabled unless the board
> .dts explicitly disables it.
>=20
When going this way with my i.mx53 related dts files, I feel I like the
opposite way.

i.mx53 has many number of peripherals inside, while individual board
might only use small portion there.  For example, i.mx53 has 5 uart
controller instances inside, while quick start (aka loco) board only
uses one.  With the way you suggest here, we will have the following
in imx53.dtsi.

uart0: uart@... {
	...
};

uart1: uart@... {
	...
};

uart2: uart@... {
	...
};

uart3: uart@... {
	...
};

uart4: uart@... {
	...
};

And we will have to tell the 4 we do not use on quick start board in
imx53-qs.dtsi


uart1: uart@... {
	...
	status =3D "disabled";
};

uart2: uart@... {
	...
	status =3D "disabled";
};

uart3: uart@... {
	...
	status =3D "disabled";
};

uart4: uart@... {
	...
	status =3D "disabled";
};

Besides the bothering that we have to list so many unused controllers
in individual board dts file, it's also hard to tell which controllers
are actually available on the board.  People have to look at imx53.dts
to get a full list and then exclude the ones in imx53-<board>.dts as
"disabled".

And if we go the way opposite, adding "disabled" status for everyone
in imx53.dts, we will only need to specify the peripherals that are
actually available on board with "okay" status in imx53-<board>.dts.
And it's much more clear for people to see what peripherals are
available on individual board.

So I'm going the way than you suggested.  Please let me know if you
strongly dislikes it.

--=20
Regards,
Shawn
