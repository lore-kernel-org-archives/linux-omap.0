From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] ARM: dts: AM33XX: Add usbss node
Date: Tue, 6 Nov 2012 16:29:50 +0200
Message-ID: <20121106142950.GA3056@arwen.pp.htv.fi>
References: <1352212178-8472-1-git-send-email-afzal@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55447 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377Ab2KFOgJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 09:36:09 -0500
Content-Disposition: inline
In-Reply-To: <1352212178-8472-1-git-send-email-afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Rob Herring <rob.herring@calxeda.com>, Vaibhav Hiremath <hvaibhav@ti.com>, AnilKumar Ch <anilkumar@ti.com>, Ravi Babu <ravibabu@ti.com>, Santhapuri Damodar <damodar.santhapuri@ti.com>, Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 06, 2012 at 07:59:38PM +0530, Afzal Mohammed wrote:
> From: Ajay Kumar Gupta <ajay.gupta@ti.com>
>=20
> Device tree node for usbss on AM33XX. There are two musb
> controllers on am33xx platform so have port0-mode and
> port1-mode data.
>=20
> [afzal@ti.com: reg & interrupt property addition]
>=20
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> Signed-off-by: Santhapuri, Damodar <damodar.santhapuri@ti.com>
> Signed-off-by: Ravi Babu <ravibabu@ti.com>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>

to my eyes, this looks ok.

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>=20
> v2: node named as "usb"
>=20
> Depends on "usb: musb: dsps: dt binding - add resources, example"
> (https://patchwork.kernel.org/patch/1704691/)
>=20
>  arch/arm/boot/dts/am33xx.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 5dfd682..20a3f29 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -321,5 +321,22 @@
>  			ti,hwmods =3D "spi1";
>  			status =3D "disabled";
>  		};
> +
> +		usb@47400000 {
> +			compatible =3D "ti,musb-am33xx";
> +			reg =3D <0x47400000 0x1000	/* usbss */
> +			       0x47401000 0x800		/* musb instance 0 */
> +			       0x47401800 0x800>;	/* musb instance 1 */
> +			interrupts =3D <17		/* usbss */
> +				      18		/* musb instance 0 */
> +				      19>;		/* musb instance 1 */
> +			multipoint =3D <1>;
> +			num-eps =3D <16>;
> +			ram-bits =3D <12>;
> +			port0-mode =3D <3>;
> +			port1-mode =3D <3>;
> +			power =3D <250>;
> +			ti,hwmods =3D "usb_otg_hs";
> +		};
>  	};
>  };
> --=20
> 1.7.12
>=20

--=20
balbi

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmR7eAAoJEIaOsuA1yqREyo8QAIWAaQipdRuVOlMmpPT2WfhW
CXSuufMu4CbTLv9IHpAgr3b7IC9chiSKQxHAduoUwF7ewe4ydu5QB3rUCZu2yDC5
FzGK6pLlyzO31Z7E2RFQgK5h/sRtxGJeLQiL6QLKlINz9r7iJMznaktCXMbQ+rFD
b2IH74lAQ66dvUkEmGPu5leOf67gV8XZFEi8XbcvYwZruY0kmIeqcuSS85F+cYjA
5+bFRsOQtPCLNJhpAChKm2n/tv5NH7jfFCKVsliEE68gaAr+mg/kcAQbMG5kmBPw
wQL1LATCbO6/efXmnJSFAGahQOMIh0l+yBWrdYhxJ5C29r80bL8if8dT5ORiULV8
q2hLrZbAE4tNAheprMJLyozjrjTeHq67Ze8XIYLKZ+wmhYTZg+d3noXjhZKVoF0x
Lq46ih+52UWK6ggMFas+zC7iKrcO5ydlQzkzTBrmoRNv7u9ciTsXY6QqBjytIFmt
Vrpf7lx0jG9G9326ZeFy7iumVxL0vknfb5yTyZBQe9AZTflNGbBEJSHmBFy/JNYx
5trrGgVgvq69SrLOUiXCcZ4zJDGAJK+wircvIXWNYgPuXgJF6IlxoWG/pE+9kwJ9
hfUo1Pb3oWDm0/800fWqErUS/tAziNUJiCqmx6n59KbjdWBXZ/iztF8gGL5XmQkM
BLRfM310cdcRvbsViRAn
=uzYp
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
