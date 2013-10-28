From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/6] ARM: OMAP2+: Remove board-4430sdp.c
Date: Mon, 28 Oct 2013 15:32:21 +0200
Message-ID: <526E6765.3030403@ti.com>
References: <20130517191304.468.73487.stgit@localhost> <20130517191751.468.89202.stgit@localhost> <20130520095447.GR21614@n2100.arm.linux.org.uk> <20130706131057.GU21614@n2100.arm.linux.org.uk> <20130706133627.GV21614@n2100.arm.linux.org.uk> <20130708093410.GT5523@atomide.com> <20130708142103.GX21614@n2100.arm.linux.org.uk> <51ECFDFD.60102@ti.com> <CAAwP0s2pGM6RRhkzhZ+_8BsCKP0posFrn7buTwUzLWWC5apE2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="BoV6e6qLgouISsfsRWE7Ee42LVSem7UBb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33347 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037Ab3J1NdB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Oct 2013 09:33:01 -0400
In-Reply-To: <CAAwP0s2pGM6RRhkzhZ+_8BsCKP0posFrn7buTwUzLWWC5apE2A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, arm@kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

--BoV6e6qLgouISsfsRWE7Ee42LVSem7UBb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 27/10/13 15:26, Javier Martinez Canillas wrote:

> When booting with DT the omapfb's probe is deferred several times but
> it always fails on dpi_connect() due not being able to get the
> VDDS_DSI regulator:

The problem with DT boot is that the VDDS_DSI is not linked to the DPI
device. For omap4, we have a few hacks to go around this (see dsi.c,
dsi_regulator_init()).

> So I tried adding this to my DT with no luck.
>=20
> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts
> b/arch/arm/boot/dts/omap3-igep0020.dts
> index 17a6fc1..eaae935 100644
> --- a/arch/arm/boot/dts/omap3-igep0020.dts
> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
> @@ -256,3 +256,8 @@
>  &usbhsehci {
>         phys =3D <&hsusb1_phy>;
>  };
> +
> +&vpll2 {
> +        supply-dev =3D "omapdss_dpi.0";
> +        supply =3D "vdds_dsi";
> +};

I didn't see "supply-dev" defined in dt bindings documentation, is that
supposed to work? If it should work, then the problem could be solved
with the above. Otherwise I guess we must add more hacks to omapdss
driver, to all places where it uses regulator_get...

 Tomi



--BoV6e6qLgouISsfsRWE7Ee42LVSem7UBb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSbmdmAAoJEPo9qoy8lh713K4P/1CwpZ3wixqMC8E+cCT3/xCc
z6+DPHCGqmrA5cuRJ380cQwjrOraRmzq/LrJVcv7kn/O6+gmq/SfaEQ4Hl90sYS3
hgP4y17LQ5tg8Q+GBXRIaQub+MjUJjPC/EaKNx3DshG23U3NcRPtdtCaA16EWXWB
ChjeCtYhc1tkHjoXi2ymX0oNiEAsj5UyPRHiMx7xKbQuxfzqClhiNo/tsfE9karL
j2GJXCD3rkk26+3k1c/9cLbCUF6H2tPleuF9Lu/N1RhqfzBfXGwK3EW++BFzeRfN
GGdKbFJXh70D0lfciJ2DFFS2Vy/MgnQmneSgZKO1zH7LBv2NadVGx3tABHwZSIrY
0QoVrjSQmQVV/x3wjzIXI1LSykoZJYcEEACn9T+H7QagafCaQ6AeH1stZzDdURye
8eY8aYgUz3Zz8qHxCQjhBe1fZ2Sc6fL7zXR9Te1ZNRK8XXkR3vU4AfW8lYy9/aWG
zhL24fcErixFfhtZjV48GasOSw9Lh15E6GUeDY6BGttiFyAFf/a7jwosAoz2U0Ym
batAm24lxUzroa/5X6BlBjfeHhLHS4VqMI6pW5f6JyNWjbD20SQhtK1ourbD8LV3
P3xf2vIvoys80iL7Pizr7Cwpp2u5ROn3TsgqVYYehbQbSgmmuUkEDqVgYoafnjd+
5+nvosTktB1EmXseDmbF
=aGcz
-----END PGP SIGNATURE-----

--BoV6e6qLgouISsfsRWE7Ee42LVSem7UBb--
