From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: n900 in 4.2-rc0: repeating oopses
Date: Tue, 30 Jun 2015 11:53:10 +0200
Message-ID: <20150630095310.GF27720@pali>
References: <20150416093234.GA17423@amd>
 <20150629091146.GA5103@amd>
 <20150630092404.GA19285@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150630092404.GA19285@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 30 June 2015 11:24:04 Pavel Machek wrote:
> Hi!
>=20
> > Just tried booting 4.2-rc0 on n900 (commit
> > 4a10a91756ef381bced7b88cfb9232f660b92d93) and it is broken. Previou=
s
> > -rc0 version worked. This time, there's some output on console, but
> > too fast for me to read.
> >=20
> > It seems oopses happen before mounting root. If you have serial
> > console, they should be easy to see.
>=20
> I tried again according to pali's instructions, and it is still
> broken the same way. Any other ideas? Does it work for you?
>=20
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.d=
tsi
> index 69a40cf..ff6f2bf 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -570,6 +570,7 @@
>  			interrupts =3D <49>;
>  			dmas =3D <&sdma 69>;
>  			dma-names =3D "rx";
> +			status =3D "disabled";
>  		};
> =20
>  		smartreflex_core: smartreflex@480cb000 {
>=20
> 									Pavel
>=20

Ok, then it is not problem with omap crypto and HS device...

I will try 4.2 at the end of week.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
