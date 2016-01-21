From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: n900: Include adp1653 device
Date: Thu, 21 Jan 2016 09:29:10 +0000
Message-ID: <20160121092909.GH5783@n2100.arm.linux.org.uk>
References: <1451086812-3729-1-git-send-email-pali.rohar@gmail.com>
 <20160121091241.GS7192@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160121091241.GS7192@pali>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The merge window is open, which is when development code that was merge=
d
in good time prior to the merge window is sent upstream to Linus.  Linu=
x
maintainers may choose not to merge new code into their tree to avoid
disrupting the utility of linux-next until the merge window has closed.

linux-next is an integration tree to help find merge conflicts, it
exists to assist with the merge windows, not as a general test ground.
Thus, linux-next must only contain code for either the current open
merge window, or if the merge window is closed, the next merge window.

On Thu, Jan 21, 2016 at 10:12:41AM +0100, Pali Roh=E1r wrote:
> On Saturday 26 December 2015 00:40:12 Pali Roh=E1r wrote:
> > This patch adds adp1653 device into n900 DT structure. DT support i=
n
> > adp1653 driver is there since v4.2-rc1 version.
> >=20
> > Signed-off-by: Pali Roh=E1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/omap3-n900.dts |   15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/o=
map3-n900.dts
> > index 5f5e0f3..ba93642 100644
> > --- a/arch/arm/boot/dts/omap3-n900.dts
> > +++ b/arch/arm/boot/dts/omap3-n900.dts
> > @@ -522,6 +522,21 @@
> >  		amstaos,cover-comp-gain =3D <16>;
> >  	};
> > =20
> > +	adp1653: led-controller@30 {
> > +		compatible =3D "adi,adp1653";
> > +		reg =3D <0x30>;
> > +		enable-gpios =3D <&gpio3 24 GPIO_ACTIVE_HIGH>; /* 88 */
> > +
> > +		flash {
> > +			flash-timeout-us =3D <500000>;
> > +			flash-max-microamp =3D <320000>;
> > +			led-max-microamp =3D <50000>;
> > +		};
> > +		indicator {
> > +			led-max-microamp =3D <17500>;
> > +		};
> > +	};
> > +
> >  	lp5523: lp5523@32 {
> >  		compatible =3D "national,lp5523";
> >  		reg =3D <0x32>;
>=20
> PING, who can take this patch?
>=20
> I still do not see it in linus tree nor in others like arm-soc...
>=20
> --=20
> Pali Roh=E1r
> pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

--=20
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
=46TTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
