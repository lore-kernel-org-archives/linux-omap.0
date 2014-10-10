From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 02/12] rtc: omap: fix missing wakealarm attribute
Date: Fri, 10 Oct 2014 12:55:49 -0500
Message-ID: <20141010175549.GN31348@saruman>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-3-git-send-email-johan@kernel.org>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7589852051545802336=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1412881594-25678-3-git-send-email-johan@kernel.org>
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
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Colin Foe-Parker <colin.foeparker@logicpd.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, j-keerthy@ti.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, t-kristo@ti.com, Lokesh Vutla <lokeshvutla@ti.com>, linux-arm-kernel@lists.infradead.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, stable <stable@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-omap@vger.kernel.org

--===============7589852051545802336==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/DkgDsqJFFamjKX0"
Content-Disposition: inline

--/DkgDsqJFFamjKX0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2014 at 09:06:24PM +0200, Johan Hovold wrote:
> The platform device must be registered as wakeup capable before
> registering the class device, or the wakealarm attribute will not be
> created.
>=20
> Also make sure to unregister the wakeup source on probe errors.
>=20
> Fixes: 1d2e2b65d098 ("rtc: omap: restore back (hard-code) wakeup support")
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Reviewed-by: Felipe Balbi <balbi@ti.com>

>  drivers/rtc/rtc-omap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index f842c216f2dd..828cb9983cc2 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -416,6 +416,8 @@ static int __init omap_rtc_probe(struct platform_devi=
ce *pdev)
>  		rtc_writel(KICK1_VALUE, OMAP_RTC_KICK1_REG);
>  	}
> =20
> +	device_init_wakeup(&pdev->dev, true);
> +
>  	rtc =3D devm_rtc_device_register(&pdev->dev, pdev->name,
>  			&omap_rtc_ops, THIS_MODULE);
>  	if (IS_ERR(rtc)) {
> @@ -484,8 +486,6 @@ static int __init omap_rtc_probe(struct platform_devi=
ce *pdev)
>  	 *    is write-only, and always reads as zero...)
>  	 */
> =20
> -	device_init_wakeup(&pdev->dev, true);
> -
>  	if (new_ctrl & (u8) OMAP_RTC_CTRL_SPLIT)
>  		pr_info("%s: split power mode\n", pdev->name);
> =20
> @@ -495,6 +495,7 @@ static int __init omap_rtc_probe(struct platform_devi=
ce *pdev)
>  	return 0;
> =20
>  fail0:
> +	device_init_wakeup(&pdev->dev, false);
>  	if (id_entry->driver_data & OMAP_RTC_HAS_KICKER)
>  		rtc_writel(0, OMAP_RTC_KICK0_REG);
>  	pm_runtime_put_sync(&pdev->dev);
> --=20
> 2.0.4
>=20

--=20
balbi

--/DkgDsqJFFamjKX0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUOB2lAAoJEIaOsuA1yqREcSUQALM7XKGHjrAuZ+dQQyg+EQ9k
Qi/ALbqbQwJd9ZdsUCM2WH4EKCtdlyRBFR0YWft8Ehzf5KETZ/eV+9liG6ZjQg/+
UZfhFxnP0ne90eiSyEq27cCJWiP+VmBfgyvvGwYYdnVBPW1vlYLIVZtIoCzFhHH4
grGA9N0Dnr+Vo7+ROFxc/hCRICBZgKA2auKiIHiHdVWtLcbFxG2ZSQBovn8+IKlW
AuVOvpQGbwXlidmRN5RZPy8Sz4G8bsA1uZj1XJ377Bw9KQAMO37O1Yn9IQakYkAG
ER4y1n6etbluhObE7l96xlNtOiX87nNohL2CJnRHjkcf+JYSmKMfeB+89AX85znK
8zJMTRkchwjlt53BsKyNbjajO5fVuUUSX9+MdIJIf25PJSOFKkntfdoYsLoIMLbO
e2NdZ8wHaBGCOM7ahF/WWdg97pq3UvthmQXZT2Hw2D4JFw9pT0hgi9EIAgxyaekP
GrnX6geOXg1Tgw3hFgYwlchAEgyS4I/SFwfvGERS9AXmhWTvn21OYoZzP5Om0SNk
7cqAdt75P8Dj+7Ce/Zweol4QebJclJ+PvfC4kRzkU+JpMqRmIt6P807WAwTSrXPm
taEFL6ULnxdm6K3wMTO+92oA+yrdr9vU8Vian7QUvQEM9zyEKkfKcwHVtfv5NLm4
PJm1xSdhlyTRRjRgRt/c
=9uki
-----END PGP SIGNATURE-----

--/DkgDsqJFFamjKX0--


--===============7589852051545802336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7589852051545802336==--
