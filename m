From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 03/23] drm: omapdrm: dss: reset dsi module during
 initialization
Date: Tue, 10 May 2016 15:07:06 +0300
Message-ID: <5731CEEA.4070506@ti.com>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <1457455195-1938-4-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1695948504=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1457455195-1938-4-git-send-email-sre@kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============1695948504==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KTaa39t7Pvc4VkIODHg4McQSXbPD0TKfT"

--KTaa39t7Pvc4VkIODHg4McQSXbPD0TKfT
Content-Type: multipart/mixed; boundary="d6LsvHDEnlP3JebfR9xwXMw8VnH8x6JIf"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <5731CEEA.4070506@ti.com>
Subject: Re: [PATCH 03/23] drm: omapdrm: dss: reset dsi module during
 initialization
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <1457455195-1938-4-git-send-email-sre@kernel.org>
In-Reply-To: <1457455195-1938-4-git-send-email-sre@kernel.org>

--d6LsvHDEnlP3JebfR9xwXMw8VnH8x6JIf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/03/16 18:39, Sebastian Reichel wrote:
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
>=20
> The Nokia N950's bootloader leaves the DSI module
> in a non-working state. Work around this by resetting
> the DSI module before using it.
>=20
> Signed-off-By: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Reviewed-By: Sebastian Reichel <sre@kernel.org>
> Tested-By: Sebastian Reichel <sre@kernel.org>
> ---
>  drivers/gpu/drm/omapdrm/dss/dsi.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdr=
m/dss/dsi.c
> index 43be4b2a7b05..363a61e6aca7 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -5274,6 +5274,28 @@ static int dsi_init_pll_data(struct platform_dev=
ice *dsidev)
>  	return 0;
>  }
> =20
> +static int _dsi_wait_reset(struct platform_device *dsidev)
> +{
> +	int t =3D 0;
> +
> +	while (REG_GET(dsidev, DSI_SYSSTATUS, 0, 0) =3D=3D 0) {
> +		 if (++t > 5) {
> +		DSSERR("soft reset failed\n");
> +			return -ENODEV;
> +		 }
> +		 udelay(1);
> +	}
> +
> +	return 0;
> +}
> +
> +static int _dsi_reset(struct platform_device *dsidev)
> +{
> +	/* Soft reset */
> +	dsi_write_reg(dsidev, DSI_SYSCONFIG, 0x2);
> +	return _dsi_wait_reset(dsidev);
> +}
> +
>  /* DSI1 HW IP initialisation */
>  static int dsi_bind(struct device *dev, struct device *master, void *d=
ata)
>  {
> @@ -5432,6 +5454,8 @@ static int dsi_bind(struct device *dev, struct de=
vice *master, void *data)
>  	if (r)
>  		goto err_runtime_get;
> =20
> +	_dsi_reset(dsidev);
> +
>  	rev =3D dsi_read_reg(dsidev, DSI_REVISION);
>  	dev_dbg(&dsidev->dev, "OMAP DSI rev %d.%d\n",
>  	       FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
>=20

This is good as a prototype, but unfortunately we're not supposed to
reset the IP from the driver. I haven't followed if there's a proper
reset framework yet available, but if not, I think we should do the
reset at the platform code at boot time.

Which actually makes me wonder... We should be doing that reset already
there, in mach-omap2/display.c. I wonder why that's not working...

 Tomi


--d6LsvHDEnlP3JebfR9xwXMw8VnH8x6JIf--

--KTaa39t7Pvc4VkIODHg4McQSXbPD0TKfT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMc7rAAoJEPo9qoy8lh71wsAQAKZq23qthgRGkYaLkryDXPgT
H789J2g6nqEfQOrPKZ4E02XwmI3MFQbARO7ie7/NsP7PNenB68rhpeU17281994S
nf0grb0QKjdse2mfSkDn5GRqKrBOMIctshrwABm01+7ysRHUok0oleIybrSpbNkv
aqjo5NWxC+4V22UMUybf6IX1IqKIntsKcYuOe4A9sz1MyMhr3PPgeJXjk4+FXd2R
/Jmn8Uk0EbhjxvRoe4y76xUYuJcb9VXc+1/cxwiXgOq2fAwtaviJw7Dcj50W75I3
qhDkaYQXSeObwlJQJc34EgdvrJRlaMqiUlsHaJIkzOlw0vlNVx/JEa1e5YpxlaKI
9Ysj+coGXPui6gUlW/rw0tyedbkOGy0RO6lFt+sr3h/QL4m1kW8qlTvTMJhQMrJL
MOyeQgTmi7kBH8QFXK6mDRcTfdZrcWMb4ez5isYNgEZACEvU4d6tySL43gk5uSze
7zPi8WmQr9yZrS7Ifg2dWUc3mZkVvP7yk61/xkl+yL9OUdk3S51eo7vU9xiVFxc/
UoI81nWLhPLNcL5wgHYigPOhN8RTxe9SEwik2t+sgbQb4RwYH2c1o0UUHXFRob6M
FR1SnFHJfaAkAutiALtMLMhRCdhR8M4MbE7LrWrf9ZxpsTQmwkby95tn+CI1kTv7
9kFaoybLIkOVjj1QRfXZ
=HlO5
-----END PGP SIGNATURE-----

--KTaa39t7Pvc4VkIODHg4McQSXbPD0TKfT--

--===============1695948504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1695948504==--
