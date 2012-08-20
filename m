From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 4/5] ARM: OMAP4: Add L2 Cache Controller in Device Tree
Date: Mon, 20 Aug 2012 18:59:32 +0300
Message-ID: <20120820155930.GD8786@arwen.pp.htv.fi>
References: <1344855623-14879-1-git-send-email-santosh.shilimkar@ti.com>
 <1344855623-14879-5-git-send-email-santosh.shilimkar@ti.com>
 <503240EF.4050805@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:48811 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752860Ab2HTQEA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Aug 2012 12:04:00 -0400
Received: by lbok6 with SMTP id k6so3163243lbo.9
        for <linux-omap@vger.kernel.org>; Mon, 20 Aug 2012 09:03:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <503240EF.4050805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.or, tony@atomide.com


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2012 at 03:51:43PM +0200, Benoit Cousson wrote:
> > +		compatible =3D "arm,pl310-cache";
> > +		reg =3D <0x48242000 0x1000>;
> > +		cache-unified;
> > +		cache-level =3D <2>;
> > +	};
> > +
>=20
> In theory, the L2 cache should be referenced from the CPUs.
>=20
> Here is the way it is done for mpc8541cdc.dts for example:
>=20
> 	cpus {
> 		#address-cells =3D <1>;
> 		#size-cells =3D <0>;
>=20
> 		PowerPC,8541@0 {
> 			device_type =3D "cpu";
> 			reg =3D <0x0>;
> 			d-cache-line-size =3D <32>;	// 32 bytes
> 			i-cache-line-size =3D <32>;	// 32 bytes
> 			d-cache-size =3D <0x8000>;		// L1, 32K
> 			i-cache-size =3D <0x8000>;		// L1, 32K
> 			timebase-frequency =3D <0>;	//  33 MHz, from uboot
> 			bus-frequency =3D <0>;	// 166 MHz
> 			clock-frequency =3D <0>;	// 825 MHz, from uboot
> 			next-level-cache =3D <&L2>;
> 		};
> 	};
>=20
> ...
>=20
> 		L2: l2-cache-controller@20000 {
> 			compatible =3D "fsl,mpc8541-l2-cache-controller";
> 			reg =3D <0x20000 0x1000>;
> 			cache-line-size =3D <32>;	// 32 bytes
> 			cache-size =3D <0x40000>;	// L2, 256K
> 			interrupt-parent =3D <&mpic>;
> 			interrupts =3D <16 2>;
> 		};

that's actually outside of the cpus {} block.

--=20
balbi

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQMl7iAAoJEIaOsuA1yqREQAUQAKbwcbDKKbGh7nVYDoOdXbME
czWlfYEFlo20GWzllMNFSWzgZRFfwVAX18iV91zj1NbnkdLGbWe9oYkTonaAtnxj
Y5ET3nua7XKPRYVESnS+G/XYLAYzlKFtdU3h4pVgHNKaJUeescmpfyZF5/oVcAtU
dTawxDDtm03tRuSv9QHUrP0GyvO0Q/smkhdJkgRT210VPDXo77QhQ5DeE8UDPU+b
6ArH9wdQ5qKuApfqlvYKxoGrPfkdCbspg8QIdPynd6ovU4jTdwqVFdyXUrdKeVT7
YWkQ3I/d3S0EhPj9POq26CAJ/IH7QsfIyrPnyKRip4S2CASQpI1kNNdSZWudeh9O
sxxePcOCC5rp7REvfbkZU7V2/I76p5tNrgwD6Z4Pwum/SsuyZJpGLAin6Y2VWVeD
YSY4rEaidtUoJgAWd+3ycPSDvseobhlhyW/Og2+A9D3TsfXofaPyhKTflO7uEM4A
THn0ukqBc6IXruBALjtH+4u5b5vro2ev+hU9FcOlwAXyfbuZhfPGfj6rWrCdP74L
2t3mDbjIODeDX0VTrS+IjnPagI7sqiBIyDMEQWP1dwIw8YaX0fZaWnkDg4P7WjbC
AESOilh6/U4+e9hHHRZ9QE+ImjIaQI2FS+dq7udKuTb+PzuflhWSmI20wmfxLzIu
izpWTPUqc8ntnPZQ8zE4
=S7lT
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--
