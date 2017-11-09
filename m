From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 5/7] clocksource: dmtimer: Populate the timer ops to
 the pdata
Date: Thu, 9 Nov 2017 17:28:06 +0100
Message-ID: <20171109162806.xyzrqxnldailqzai@earth>
References: <1510144108-29563-1-git-send-email-j-keerthy@ti.com>
 <1510144108-29563-6-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eyd3wge5g46sggxo"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1510144108-29563-6-git-send-email-j-keerthy@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com, khilman@kernel.org, daniel.lezcano@linaro.org, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--eyd3wge5g46sggxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 08, 2017 at 05:58:26PM +0530, Keerthy wrote:
> Add the timer ops to the platform data
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>=20
> No code changes in this v2 version. Only enhanced patch
> statistics for renames.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  drivers/clocksource/dmtimer.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/drivers/clocksource/dmtimer.c b/drivers/clocksource/dmtimer.c
> index afe1dc9..1cbd954 100644
> --- a/drivers/clocksource/dmtimer.c
> +++ b/drivers/clocksource/dmtimer.c
> @@ -922,8 +922,33 @@ static int omap_dm_timer_remove(struct platform_devi=
ce *pdev)
>  	return ret;
>  }
> =20
> +static struct omap_dm_timer_ops dmtimer_ops =3D {
> +	.request_by_node =3D omap_dm_timer_request_by_node,
> +	.request_specific =3D omap_dm_timer_request_specific,
> +	.request =3D omap_dm_timer_request,
> +	.set_source =3D omap_dm_timer_set_source,
> +	.get_irq =3D omap_dm_timer_get_irq,
> +	.set_int_enable =3D omap_dm_timer_set_int_enable,
> +	.set_int_disable =3D omap_dm_timer_set_int_disable,
> +	.free =3D omap_dm_timer_free,
> +	.enable =3D omap_dm_timer_enable,
> +	.disable =3D omap_dm_timer_disable,
> +	.get_fclk =3D omap_dm_timer_get_fclk,
> +	.start =3D omap_dm_timer_start,
> +	.stop =3D omap_dm_timer_stop,
> +	.set_load =3D omap_dm_timer_set_load,
> +	.set_match =3D omap_dm_timer_set_match,
> +	.set_pwm =3D omap_dm_timer_set_pwm,
> +	.set_prescaler =3D omap_dm_timer_set_prescaler,
> +	.read_counter =3D omap_dm_timer_read_counter,
> +	.write_counter =3D omap_dm_timer_write_counter,
> +	.read_status =3D omap_dm_timer_read_status,
> +	.write_status =3D omap_dm_timer_write_status,
> +};
> +
>  static const struct dmtimer_platform_data omap3plus_pdata =3D {
>  	.timer_errata =3D OMAP_TIMER_ERRATA_I103_I767,
> +	.timer_ops =3D &dmtimer_ops,
>  };
> =20
>  static const struct of_device_id omap_timer_match[] =3D {
> --=20
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--eyd3wge5g46sggxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloEghYACgkQ2O7X88g7
+pqeyhAAoi4UGYDitlSLWQTJ024jeHlVCCaqN+2D4/EYbzP0RGePXu5TH3oVnYum
QNFhTCeVtA6L6UcQPgCu2zjpOfM9bB/2LzHn7J0OOzuiG2XUxCV5NYA0cFIcDLy/
5vMJWid0CyJddCkwfZf+96KpVem6vIoLP11BQzz+CUR+vaWvqf9VJ0JpXzX65GZl
lkPeats4qohRTBJxDUBRJyMV0TZKiijGOA5NB4jGRzcaccSlkU3uooYOBryQxKoA
IDA1WUvdzVQNL2sYzRzDC9su67NKbuAQeMohVSUUoK4kt7f34bKndqJAwTtqIPBk
LzB6K4M9ewRe1zSoSwE5ahr5XOzQFpt9/XXU/N67Xg+5KORhENOTDtOzd8aMguAb
LMDDkwFsBmJM4+1xMWN+7VAP/DgZXLdICx4/ndU9ljnYAOHZoPssb3knVvyZLjnS
1oNJY0t9iLwmy2313XFFv2rJFTou+GnBRQLmiG6vTaDGTmP58dUZNIF3Ap+vDv20
HmuUWmiQptkskJJI05lqw6LTUQjVHFJJ3X5aNbe7nE3p7fML7kAncsLVGDbnHr2u
UORiBjw8YrkU8/faQ88u5dVywvkxH5w8KKoniIgpCg+p6WuLqpJAGfFZLhyfEAAQ
R5eJgpfpkHO2logPc8aSeEHOYOBNeZf9439SknyS0G8pq+qeiBY=
=8yfL
-----END PGP SIGNATURE-----

--eyd3wge5g46sggxo--
