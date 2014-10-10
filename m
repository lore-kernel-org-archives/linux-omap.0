From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 01/12] rtc: omap: fix clock-source configuration
Date: Fri, 10 Oct 2014 12:55:26 -0500
Message-ID: <20141010175515.GM31348@saruman>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-2-git-send-email-johan@kernel.org>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5593348176658136409=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1412881594-25678-2-git-send-email-johan@kernel.org>
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

--===============5593348176658136409==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hXth9cGL35Nvpk4x"
Content-Disposition: inline

--hXth9cGL35Nvpk4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2014 at 09:06:23PM +0200, Johan Hovold wrote:
> Make sure not to reset the clock-source configuration when enabling the
> 32kHz clock mux.
>=20
> Until the clock source can be configured through device tree we must not
> overwrite settings made by the bootloader (e.g. clock-source selection).
>=20
> Fixes: cd914bba03d8 ("drivers/rtc/rtc-omap.c: add support for enabling
> 32khz clock")
> Cc: stable <stable@vger.kernel.org>
>=20
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/rtc/rtc-omap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 21142e6574a9..f842c216f2dd 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -431,8 +431,10 @@ static int __init omap_rtc_probe(struct platform_dev=
ice *pdev)
>  	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
> =20
>  	/* enable RTC functional clock */
> -	if (id_entry->driver_data & OMAP_RTC_HAS_32KCLK_EN)
> -		rtc_writel(OMAP_RTC_OSC_32KCLK_EN, OMAP_RTC_OSC_REG);
> +	if (id_entry->driver_data & OMAP_RTC_HAS_32KCLK_EN) {
> +		reg =3D rtc_read(OMAP_RTC_OSC_REG);
> +		rtc_writel(reg | OMAP_RTC_OSC_32KCLK_EN, OMAP_RTC_OSC_REG);
> +	}
> =20
>  	/* clear old status */
>  	reg =3D rtc_read(OMAP_RTC_STATUS_REG);
> --=20
> 2.0.4
>=20

--=20
balbi

--hXth9cGL35Nvpk4x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUOB2OAAoJEIaOsuA1yqRElE8P/2meYd7iu2b3E4RxjaSOSmpA
BK3hp/sq43m5JRvx3pzNozKoNhXwo1PFUgL0WZxzeBFduVKhUApoVgsr1+JZTrN/
BuoyOP5BIIOvmi9VbsVB3E8rHD9bjQZHDSbwPQqfi0yw0DXbBJGFjpaGEK53RnZf
9I8tqzkByzxLFnLm42iMWUphsKY3IGhwMmy0epPLP2LhU6r+cvUO5FBYo71qOVOb
LKF6buHPfil+gqk8bcHx1DTe5SulXnTeANKVMxJn1pTFYwWxQdktcR3pPj18IDoy
nxxyI+ZX+YFuCYVZad/eQw/rEq2PnHi/gXcYFzAwh1YhaK71AV9yEV1SppUNVdfO
i7ENfBRLX6cr+KKyZ7hyiu0qrf82RQYIEWU2GCX6QOmvFcHSfoKXaoHd9ffwnGUm
KelHzveM7ym97Jj+t8XWSA0mzFl4XlnuYYepzEImgyuZGBznaNoXWeyacasOKtgq
LxpQMHqVfeElYP1k/QP7F20A+gVrpydgSdYBQjv4d2sg5jG8lEVgiZ3dPiXWx0zO
NdOTwhwTi2VeGoPXO3+EvT+tZfd1HwI4y5UJFF8qTtZH6jJxBrHXz63z07J05lw6
DvyNIQlxOH5z28T8YeG9Xf9d1eVlI1MJqVqCWPLwWtmgO3dw/0SzNdZs6WwmW5ei
6ciPAl8dK84FYDaQZ5gO
=SwEh
-----END PGP SIGNATURE-----

--hXth9cGL35Nvpk4x--


--===============5593348176658136409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5593348176658136409==--
