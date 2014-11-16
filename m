From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] adp1653: Add device tree bindings for LED controller
Date: Sun, 16 Nov 2014 11:15:48 +0100
Message-ID: <20141116101548.GB32483@amd>
References: <20141116075928.GA9763@amd>
 <546877EF.8010906@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <546877EF.8010906@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg, bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, sakari.ailus@iki.fi, devicetree@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun 2014-11-16 11:09:51, Andreas F=E4rber wrote:
> Hi Pavel,
>=20
> Am 16.11.2014 um 08:59 schrieb Pavel Machek:
> > For device tree people: Yes, I know I'll have to create file in
> > documentation, but does the binding below look acceptable?
> [...]
> > diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/o=
map3-n900.dts
> > index 739fcf2..ed0bfc1 100644
> > --- a/arch/arm/boot/dts/omap3-n900.dts
> > +++ b/arch/arm/boot/dts/omap3-n900.dts
> > @@ -553,6 +561,18 @@
> > =20
> >  		ti,usb-charger-detection =3D <&isp1704>;
> >  	};
> > +
> > +	adp1653: adp1653@30 {
>=20
> This should probably be led-controller@30 (a generic description not
> specific to the model). The label name is fine.

Thanks.

> > +		gpios =3D <&gpio3 24 GPIO_ACTIVE_HIGH>; /* Want 88 */
>=20
> At least to me, the meaning of "Want 88" is not clear - drop or clari=
fy?

I changed it to /* 88 */ to match rest of code.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
