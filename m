From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] cpufreq: dt: allow driver to boot automatically
Date: Tue, 16 Jun 2015 16:40:32 -0500
Message-ID: <20150616214032.GA4313@saruman.tx.rr.com>
References: <1431115050-23693-1-git-send-email-balbi@ti.com>
 <1431115050-23693-2-git-send-email-balbi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54242 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966AbbFPVnc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Jun 2015 17:43:32 -0400
Content-Disposition: inline
In-Reply-To: <1431115050-23693-2-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2015 at 02:57:30PM -0500, Felipe Balbi wrote:
> by adding the missing MODULE_ALIAS(), cpufreq-dt
> can be autoloaded by udev/systemd.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>

looks like this wasn't applied anywhere. Viresh, can you apply this
patch please ?

> ---
>  drivers/cpufreq/cpufreq-dt.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index bab67db54b7e..528a82bf5038 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -416,6 +416,7 @@ static struct platform_driver dt_cpufreq_platdrv =3D {
>  };
>  module_platform_driver(dt_cpufreq_platdrv);
> =20
> +MODULE_ALIAS("platform:cpufreq-dt");
>  MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
>  MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
>  MODULE_DESCRIPTION("Generic cpufreq driver");
> --=20
> 2.4.0.rc3
>=20

--=20
balbi

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgJfQAAoJEIaOsuA1yqRExE8P/jbnpvMZ0gWs9TYgp+02gRWO
YMUejsYQBINH3M6MV/Vb0Ns9r5FoW3I3vLMM53Tl4VlUa7dcD4+ZcOAObKsTVsDw
EcxfIchLRXDq87sEgw07PJTnpZbEmNS0r0v+TJGpv4PV9E+F96HDtG6125W7ULts
uJEJRd1RTxYDE3OtdxpcmWDu/ki4VsPPva/3NInI9X0Vmkl6ClrGsnoMdoXh1x1h
NW9vnS81TwllmSDBjj5dNueW4VOjYfDDo1Q6FjUP5cBDpE9ZjD/YaC66A3az+yAM
zFUGuuPLUJuITX8Wb5TzKtuN0NL6JVu39yVfNh4GpZm3h+RepUlB7wQ5OszJ1l5i
9TR55MUmuBskvi286Mzj3aYdnQc3/59J2TwulYifM7cbSPNRYpwzkshyswfJAIEx
szoRNL/4ZEHEJRN9p7TARN0n2ag5ouICxftyMLN4MztKUOEB4ayLZ99ySXivPKzj
CI1042q6qrqy/tmUAKQ+jRZ3aS5AqtSxt+GTozpkCS0iM4FIFJMzZtP6wJ+q4/+A
Kg31YvZ8itvmDxaLgcMEHG5oUsWUHCUZdSw5Wx3HtBP8j0b2hMuNTl9w0QeasQ10
ICZK48PEFiqlxmzlMxD34FLuwTiDVt5sCemnzBDxWi+nAgd5gbVNuCes5VrKd81G
vkiz9xsg33EF2Hy9WWL9
=jxgi
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
