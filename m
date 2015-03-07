From: Sebastian Reichel <sre@debian.org>
Subject: Re: twl4030_charger: need changes to get probed?
Date: Sat, 7 Mar 2015 22:01:02 +0100
Message-ID: <20150307210102.GL5233@earth>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150224043352.4243.11227.stgit@notabene.brown>
 <20150302210926.GP13270@amd>
 <20150305173350.50502b95@notabene.brown>
 <20150306212417.GA24169@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7308350101735917696=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150306212417.GA24169@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: ivo.g.dimitrov.75@gmail.com, Samuel Ortiz <sameo@linux.intel.com>, khilman@kernel.org, NeilBrown <neilb@suse.de>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, aaro.koskinen@iki.fi, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>, tony@atomide.com, pali.rohar@gmail.com, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--===============7308350101735917696==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gwtGiOGliFx8mAnm"
Content-Disposition: inline


--gwtGiOGliFx8mAnm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 06, 2015 at 10:24:17PM +0100, Pavel Machek wrote:
> According to n900 dts, twl4030-bci (aka charger) should be
> included.

its part of twl, but not used on N900 afaik.

> (But it does not seem to do anything useful on n900. I was hoping for
> measurement of input voltage, but .. no.)

check for rx51-battery.

> Any ideas why the patch below is needed?

platform_driver_probe() does not support deferred probing.

Neil, can you take this patch into your series for the next round?

-- Sebastian

> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>=20
> diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_char=
ger.c
> index d35b83e..96bbbe9 100644
> --- a/drivers/power/twl4030_charger.c
> +++ b/drivers/power/twl4030_charger.c
> @@ -714,6 +722,7 @@ static const struct of_device_id twl_bci_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, twl_bci_of_match);
> =20
>  static struct platform_driver twl4030_bci_driver =3D {
> +	.probe =3D twl4030_bci_probe,
>  	.driver	=3D {
>  		.name	=3D "twl4030_bci",
>  		.of_match_table =3D of_match_ptr(twl_bci_of_match),
> @@ -721,7 +730,7 @@ static struct platform_driver twl4030_bci_driver =3D {
>  	.remove	=3D __exit_p(twl4030_bci_remove),
>  };
> =20
> -module_platform_driver_probe(twl4030_bci_driver, twl4030_bci_probe);
> +module_platform_driver(twl4030_bci_driver);
> =20
>  MODULE_AUTHOR("Gra=C5=BEvydas Ignotas");
>  MODULE_DESCRIPTION("TWL4030 Battery Charger Interface driver");

--gwtGiOGliFx8mAnm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU+2cGAAoJENju1/PIO/qaVOsP/2wyPYC0c9tG3I5zF6ubbMmX
z+Ekws2pOmZXAhzgFaotJS7N0Hu7fPbhD/uZtq2QuO00ekNsi/ouzsKYrtwGq/6E
cbRbITLP2000t18zrFp2nODMfMsTamfXQwpcr+BQcCkq69Zhp1lTlBFGhxwnWbq4
h30eHE13JYAjSuqawkUapRTm6P3jTF1A+b4q8EdmFeN0Iexo4tyhMetTSv/wEBrO
qXtDo05F1c0MIhztDa71AKa9mhKTjawPUM/rB+BlPj/txwdcav0nZHfziWZeKNuG
kHGkYnQ5GP4o+/wVZG3itQhfIo1J5IoJvwVGREPGoRGWJZ2A9tnIZhTAuIWhI1Ac
Cz/mfT3KXOHF7h3zmzzH8c1SMfnhZtKKz0ahlnxGLqttpCPoe3cEvYjfZxCOuKuO
mu3Aa0APBMWA8aZg5CMVAk0YXGdEof/moqv0Y8r1czJdak37qkMKrMBDuKS1z96D
AxVjSPBqRmkccKhtGzM6dGFvK5H0xGxySesT598hKwbc5Unp1JHUPRXFLAxUEwgW
hPhv5W1+HRh/Cdmnt0bWxh7kKy+4wfLmtedM4136IufiFwBxMJNtrzKsQJ+Y/LiK
XJX52cTbv/BOH4MgHI4D2J23i4JGMM6VnWG4RCRLpJ0WoUA0K7PaMu7o+KEhpQ4A
iy7+v6MWxlsH1qUXtZA+
=SEXr
-----END PGP SIGNATURE-----

--gwtGiOGliFx8mAnm--


--===============7308350101735917696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7308350101735917696==--
