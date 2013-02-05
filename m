From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 10/13] ARM: dts: OMAP4: Add HS USB Host IP nodes
Date: Tue, 5 Feb 2013 09:41:41 +0200
Message-ID: <20130205074141.GB32118@arwen.pp.htv.fi>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
 <1359993540-20780-11-git-send-email-rogerq@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41876 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256Ab3BEHl4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Feb 2013 02:41:56 -0500
Content-Disposition: inline
In-Reply-To: <1359993540-20780-11-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, balbi@ti.com, stern@rowland.harvard.edu, linux@arm.linux.org.uk, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, paul@pwsan.com

--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2013 at 05:58:57PM +0200, Roger Quadros wrote:
> Adds device nodes for HS USB Host module, TLL module,
> OHCI and EHCI controllers.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/boot/dts/omap4.dtsi |   30 ++++++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 739bb79..3429280 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -529,5 +529,35 @@
>  			ti,hwmods =3D "timer11";
>  			ti,timer-pwm;
>  		};
> +
> +		usbhstll: usbhstll@0x4a062000 {
> +			compatible =3D "ti,usbhs-tll";
> +			reg =3D <0x4a062000 0x1000>;
> +			interrupts =3D <0 78 0x4>;
> +			ti,hwmods =3D "usb_tll_hs";
> +		};
> +
> +		usbhshost: usbhshost@0x4a064000 {
> +			compatible =3D "ti,usbhs-host";
> +			reg =3D <0x4a064000 0x800>;
> +			ti,hwmods =3D "usb_host_hs";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			ranges;
> +
> +			usbhsohci: ohci@0x4a064800 {

usbhsohci is a bit misleading :-)

How about we stick to ohci and ehci for these nodes ? :-)

--=20
balbi

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRELe1AAoJEIaOsuA1yqREozsP/juc5bdxWU10vTLKXYB3VAkF
xoiYrXrBA9olJCpFvUceAwjIMR2WXlxj4fgNv1nf2z290brfbqcpvnRFaQQOjT5l
jzJfRcs+TzjoJEQ4qjYjjLOrtI8cwT4h/9VZRzWSGcZEAAy+epiz1UlHEldjNBU1
2htrPQhgh2XRnmCg1U0mOkB2XxarbxZC+5QiFhaZY9l5jKoOgkgfrXdN50SEwO7c
gRCSnkUNKqOwacv7+Oz+p2cCU50iIEVCs2VmiHwqZOy680je7XD+zZqwSlR/+8oD
JHHrcAaBqRkUNQc+NkCvEw6/u0gJnxumwtIEl8+csGUQAiuMpE0W8GhNYV0sF3+8
DuqYRws07Zf/aO1tzWAiBPdW8AklgzMEr6EBdKgT+GkqTo/M0FXD3ALcs/k6C7Fh
eR7s1+8+Y5JJo2lnI/3Of4l/+Qy39G6tAqZq1h8qtoH5T1oCKoy3pIhuOrYNogKl
xoP4ZNvlpaddOeFn35d6CB7FUSDXdNnH56Wtno7plixGSQt93PMN/XcgbqqXP7Xq
WwUYgqJFPL32RO41SgRVwk2tYv6mwv3Yk/3zu4jzrrN3B7qhf/+0X4HFm+c0dzOL
kzJBvx8vaHrPT5qFYfE3JWhdCcD+NZX/qinNkSoErqTRa1eNvUFpljGEu422PYLn
ZTS3AyAZjxCw8imHeKxP
=sQa/
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
