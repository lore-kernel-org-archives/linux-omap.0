From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] net: can: c_can: Fix default pinmux glitch at init
Date: Tue, 7 Jul 2015 16:33:51 +0200
Message-ID: <559BE34F.8080508@pengutronix.de>
References: <1436279277-3386-1-git-send-email-rogerq@ti.com>
 <1436279277-3386-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="uO06oFfE0uhTcICIJDRgqc2Jlq7aX6QdX"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436279277-3386-2-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, wg@grandegger.com, tony@atomide.com
Cc: jay.schroeder@garmin.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uO06oFfE0uhTcICIJDRgqc2Jlq7aX6QdX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/07/2015 04:27 PM, Roger Quadros wrote:
> From: "J.D. Schroeder" <jay.schroeder@garmin.com>
>=20
> The previous change 3973c526ae9c (net: can: c_can: Disable pins when CA=
N interface
> is down) causes a slight glitch on the pinctrl settings when used. Sinc=
e
> commit ab78029 (drivers/pinctrl: grab default handles from device core)=
,
> the device core will automatically set the default pins. This causes
> the pins to be momentarily set to the default and then to the sleep
> state in register_c_can_dev(). By adding an optional "enable" state,
> boards can set the default pin state to be disabled and avoid the
> glitch when the switch from default to sleep first occurs. If the
> "enable" state is not available c_can_pinctrl_select_state() falls
> back to using the "default" pinctrl state.
>=20
> [Roger Q] - Forward port to v4.2
>=20
> Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/net/can/c_can/c_can.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_ca=
n.c
> index 041525d..66e98e7 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -605,7 +605,18 @@ static int c_can_start(struct net_device *dev)
>  	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> =20
>  	/* activate pins */
> -	pinctrl_pm_select_default_state(dev->dev.parent);
> +#ifdef CONFIG_PINCTRL

Please remove the ifdef, AFAICS there are static inline noop functions
if CONFIG_PINCTRL switched off.

> +	if (priv->device->pins) {
> +		struct pinctrl_state *s;
> +
> +		/* Attempt to use "active" if available else use "default" */
> +		s =3D pinctrl_lookup_state(priv->device->pins->p, "active");
> +		if (!IS_ERR(s))
> +			pinctrl_select_state(priv->device->pins->p, s);
> +		else
> +			pinctrl_pm_select_default_state(dev->dev.parent);
> +	}
> +#endif
>  	return 0;
>  }
> =20
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--uO06oFfE0uhTcICIJDRgqc2Jlq7aX6QdX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVm+NPAAoJEP5prqPJtc/HXDIIAKL8VqKTBITTogJYoeL7fEy0
ggJKjxKi5FoEaHgzpPALzz3jIcmhP4BaJir0oTvnqZa2+4D7+cMX0EeuciJB05w/
1XRHItVIPYnk7qMRI2QAmIMpzAptdi3sLLwIMU84XZN5nbNWov0QEuBrQTSLfR/H
A2+cRc6aXPE8dRDDsTI6aR9zU/+mmewCn6OhXPVw98zNmjRWR8JvIufwwS6xdzE/
a/8tCenJl/34HbmrmqBB4VcxKLmUZhqZPdMXFzGgEYnPXP4MUBDeAK/nSWtHgAoE
ttfhNnF5gyUcPIy+3rqFyj67J7cyAyKBfGbaxfh/ARUNe2ELR73HNtjyNNKCczM=
=P2QU
-----END PGP SIGNATURE-----

--uO06oFfE0uhTcICIJDRgqc2Jlq7aX6QdX--
