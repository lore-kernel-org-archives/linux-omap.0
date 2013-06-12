From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/3] USB: OMAP: add omap-otg
Date: Wed, 12 Jun 2013 18:13:26 +0300
Message-ID: <20130612151326.GE15056@arwen.pp.htv.fi>
References: <1370817606-1008-1-git-send-email-aaro.koskinen@iki.fi>
 <1370817606-1008-3-git-send-email-aaro.koskinen@iki.fi>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1370817606-1008-3-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 10, 2013 at 01:40:05AM +0300, Aaro Koskinen wrote:
> +void omap_otg_set_mode(enum omap_otg_mode mode)
> +{
> +	if (!otg_dev) {
> +		WARN(1, "%s: controller not present\n", __func__);
> +		return;
> +	}
> +	mutex_lock(&otg_dev->serialize);
> +	switch (mode) {
> +	case OMAP_OTG_MODE_DEVICE:
> +		/*
> +		 * Set B-session valid.
> +		 */
> +		omap_otg_ctrl(OMAP_OTG_ID | OMAP_OTG_BSESSVLD);
> +		break;
> +	case OMAP_OTG_MODE_HOST:
> +		/*
> +		 * Set A-session valid.
> +		 */
> +		omap_otg_ctrl(OMAP_OTG_ASESSVLD);
> +		break;
> +	case OMAP_OTG_MODE_DISCONNECT:
> +		/*
> +		 * Set B-session end to indicate no VBUS.
> +		 */
> +		omap_otg_ctrl(OMAP_OTG_ID | OMAP_OTG_BSESSEND);
> +		break;
> +	default:
> +		WARN(1, "%s: unknown mode: %d\n", __func__, mode);
> +	}
> +	mutex_unlock(&otg_dev->serialize);
> +}
> +EXPORT_SYMBOL_GPL(omap_otg_set_mode);

looks like this should provide a extcon interface for its users.

--=20
balbi

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRuJAWAAoJEIaOsuA1yqREOtYQAK07Sb+zX+RbMkk6VP0dBA6v
vlzApPHhp0ZXdmxxbZv3w93/3fezkTtpN0QZX2FVarww4yk3TbByqZNbcrDVytIA
lSSbwUsf9DNCpvyHa65/gyk+sL1E0FNrNT5sFbGbYClYA2NqpQh+1bmMpBAp66CS
MYwLHcJbF9LBeloU0BQFrEpu0lsuZJT3zM3ol2jF4+jnGyQPs7ZmyjinbC6j4e/v
s0BSz0YfNBipRpqs+LQ2G59mP+9EO9IHluADXh5CwPy8y/1xC8L4Bu7W8Y21Fac/
xPHaTSyO3Fivf+1M9Dw/kGiDx1eJAW0BxXUkWQU9osjBkFsHhiXRjMSzidxpV8/y
amLTeV6aV+Qi8Tn/9V1who4o6npshOSqkob6prF6nP0xyBtqnJk00bvdXlFpeSXT
cU0AQUvGXohr1lIxvKyV8fc0Fo4dcRVE5JQcYr+KnzpK04RHkbpO8WGApdWRH9+W
hMFuGIcizezochUibXKb2X4hKt5TqRTcMKptyTixogC971ScMUTbIZvn+mySXDq4
uEOk5ckgkqWfYolzZpQkmb5pjkVAfgE4n42of+1wWUpgnv7SAneORvEH85s97u4N
Fg+CwKA4JuTpT45u8s4A4SNxzmQ8wCIHyl3NhY8lN9iNQ/qfpd6pUp7VSXNcMig8
1zO8KKVp1iF5O667M2A+
=GEWP
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
