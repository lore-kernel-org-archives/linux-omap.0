From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 05/12] rtc: omap: remove redundant debug message
Date: Fri, 10 Oct 2014 12:59:58 -0500
Message-ID: <20141010175958.GQ31348@saruman>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-6-git-send-email-johan@kernel.org>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1734742897639371190=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1412881594-25678-6-git-send-email-johan@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Johan Hovold <johan@kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Colin Foe-Parker <colin.foeparker@logicpd.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, j-keerthy@ti.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, t-kristo@ti.com, Lokesh Vutla <lokeshvutla@ti.com>, linux-arm-kernel@lists.infradead.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-omap@vger.kernel.org

--===============1734742897639371190==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p8mP+8RrBGerSNjm"
Content-Disposition: inline

--p8mP+8RrBGerSNjm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2014 at 09:06:27PM +0200, Johan Hovold wrote:
> Remove redundant debug message.
>=20
> The corresponding error has already been logged by rtc core.
>=20
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/rtc/rtc-omap.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index d1b5562a148b..e50ffd7063f5 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -485,11 +485,9 @@ static int __init omap_rtc_probe(struct platform_dev=
ice *pdev)
> =20
>  	rtc =3D devm_rtc_device_register(&pdev->dev, pdev->name,
>  			&omap_rtc_ops, THIS_MODULE);
> -	if (IS_ERR(rtc)) {
> -		pr_debug("%s: can't register RTC device, err %ld\n",
> -			pdev->name, PTR_ERR(rtc));
> +	if (IS_ERR(rtc))
>  		goto fail0;
> -	}
> +
>  	platform_set_drvdata(pdev, rtc);
> =20
>  	return 0;
> --=20
> 2.0.4
>=20

--=20
balbi

--p8mP+8RrBGerSNjm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUOB6eAAoJEIaOsuA1yqREY+IP/RNJqrCSHs6kaFnheVi0cyrz
a082SQ/y/A7pAreJ73hwfXx+pu5GGMQsqErFFTfrxB++hYL/eXTC0oDu9iZYyT2v
MTZHFTLCYUCRcww1qm7s5JExxEUPF9sfQcd3mnxfEqLjLQMAhSqF2RcIRglk2HBi
/uIhZ6clC8pdAormZksGDGQCG1vAmKLGVvh8aEAJqCglX++vCxgXVh5JF0l9f3vD
20NgkWUs0haw1hVH9cw3Ds/i/DylIyLIRQdrdDthqIUmT6eQSq/5tl+wptBwZWdF
/fR8ynFFzj/ACiq3MloMt2dUiGxXOWH0acYxchTNV4XUjGKr2oUPnL5NiPGMVpu8
IrEEY6Rm0PghUqviqvCTStHhd7LvcasVLLK6X9vziDZkfwlZ/8S9heOCB73surQD
pQ4oki5HhFKkq4vpeeBc2FpI6Wf0enDTv1p7dG02+z/50x5pDp+1Odi/4HTcJDjI
mfAG9yeU0YvcW/6Eo1LZ+jTnq5kYX4VQUqLJB3wEpjw/H7XJI8iJiIRv4Gdaa4Lm
voFq/K8VIrhhMXogaOMhCdPaHwlJEAQ5bgUH28K9W0NwFT73e3t1gAZgZlDuertT
XkudJxqcHls9rbKI3UPQwEyPJ/vBXvwX2bzsZcrwwbZvuRTN3uWu6Mkp50Ue+cpQ
rXNwnflMOudYuuSrigt/
=jXL+
-----END PGP SIGNATURE-----

--p8mP+8RrBGerSNjm--


--===============1734742897639371190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1734742897639371190==--
