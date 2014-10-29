From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Thu, 30 Oct 2014 00:07:28 +0100
Message-ID: <20141029230727.GA6381@earth.universe>
References: <20141027200008.GR2560@atomide.com>
 <20141027230138.GB7805@drone.musicnaut.iki.fi>
 <20141028221243.GU2542@atomide.com>
 <5450EEE7.8070801@ti.com>
 <20141029185957.GA3723@earth.universe>
 <20141029193915.GB2542@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:45295 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757065AbaJ2XHd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Oct 2014 19:07:33 -0400
Content-Disposition: inline
In-Reply-To: <20141029193915.GB2542@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 29, 2014 at 12:39:16PM -0700, Tony Lindgren wrote:
> 8< -----------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Mon, 27 Oct 2014 13:05:54 -0700
> Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
>=20
> We're moving omaps to use device tree based booting and already have
> omap2, omap4, omap5, am335x and am437x booting in device tree only
> mode.
>=20
> Only omap3 still has legacy booting still around and we really want
> to make that device tree only. So let's add a warning about deprecated
> legacy booting so we get people to upgrade their boards to use device
> tree based booting and find out about any remaining issues.
>=20
> Note that for most boards we already have the .dts file and those can
> be booted with without changing the bootloader using the appended
> DTB mode.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -917,6 +917,10 @@ static int __init omap_device_late_idle(struct devic=
e *dev, void *data)
>  static int __init omap_device_late_init(void)
>  {
>  	bus_for_each_dev(&platform_bus_type, NULL, NULL, omap_device_late_idle);
> +
> +	WARN(!of_have_populated_dt(),
> +		"legacy booting deprecated, please update to boot with .dts\n");
> +
>  	return 0;
>  }
>  omap_late_initcall_sync(omap_device_late_init);

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUUXMvAAoJENju1/PIO/qat90P/jhjBrZj5rWD+rtu61y6q2qv
wpRDVVvOcz6I/yisZ6kLMaoMIGbD0XWCzCBNc2DDGcsLwS9A/O6Qaj+ivMGZVBPx
HaflbEFNc16pbt00RzdJwW4ekX4DC5HptBkz67ARyS2a+b/Ndana6MAXaeXTj6Rc
ym01jgbzsknUjCefqNBq5vyZqTU1Kv33c5W11QXmc772sLNF8ABozzqSDi4HOgVB
THo5eeW5apY5TBuoh4Zyq9FPOKZP45nFJJkiWcvJVEEcPjr4gW+Y5bCG5/1qHlQ7
TbNam7+dsp20zx9pQ61P+O2IFHnG2G0eDZqvlDFqrjQ/9olphwg9Jc7c0FjceFo7
NW2/6f/DGurd8I2f5fSAMJFAX6At6VKPrpNJbmU0Nv2YjPMy/v5h5aUYmMhRUc+z
aQVZ547LgDZeeigPeQ5iWUsmHtgZG0NOcV9Q7clgnl6SRY0d2UkoJDI8OaeyCREg
h/nvJ7Wk1vrCyf2GGFbm1MrnkDRcnZmAK8Dd2dz4y4+H/f93Mjym119nsUL0a/Xx
KdopqT3f3wrAHLb0hzTi4JSWQvLY+li/82M6uveL8anUrLG3Cn3PtH0G0t0YqQlA
TNgiUvqwsjXDIQV6oHaPVDPIKl6fODJ1oc9gICCdJHx8zcvFaN/Rv2bPSj0dHgRv
IvCq9ZLJ+6/YB+QcunNM
=aBA5
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
