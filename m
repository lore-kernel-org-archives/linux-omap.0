From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/3] USB: OMAP: add omap-otg
Date: Fri, 14 Jun 2013 04:27:42 +0300
Message-ID: <20130614012742.GA20258@arwen.pp.htv.fi>
References: <1370817606-1008-1-git-send-email-aaro.koskinen@iki.fi>
 <1370817606-1008-3-git-send-email-aaro.koskinen@iki.fi>
 <20130612151326.GE15056@arwen.pp.htv.fi>
 <20130613223711.GD18360@blackmetal.musicnaut.iki.fi>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130613223711.GD18360-R3WNPi76c83LsdW6vOPryG4HOFkwEHDbMR2xtNvyitY@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 14, 2013 at 01:37:11AM +0300, Aaro Koskinen wrote:
> Hi,
>=20
> On Wed, Jun 12, 2013 at 06:13:26PM +0300, Felipe Balbi wrote:
> > On Mon, Jun 10, 2013 at 01:40:05AM +0300, Aaro Koskinen wrote:
> > > +void omap_otg_set_mode(enum omap_otg_mode mode)
> > > +{
> > > +	if (!otg_dev) {
> > > +		WARN(1, "%s: controller not present\n", __func__);
> > > +		return;
> > > +	}
> > > +	mutex_lock(&otg_dev->serialize);
> > > +	switch (mode) {
> > > +	case OMAP_OTG_MODE_DEVICE:
> > > +		/*
> > > +		 * Set B-session valid.
> > > +		 */
> > > +		omap_otg_ctrl(OMAP_OTG_ID | OMAP_OTG_BSESSVLD);
> > > +		break;
> > > +	case OMAP_OTG_MODE_HOST:
> > > +		/*
> > > +		 * Set A-session valid.
> > > +		 */
> > > +		omap_otg_ctrl(OMAP_OTG_ASESSVLD);
> > > +		break;
> > > +	case OMAP_OTG_MODE_DISCONNECT:
> > > +		/*
> > > +		 * Set B-session end to indicate no VBUS.
> > > +		 */
> > > +		omap_otg_ctrl(OMAP_OTG_ID | OMAP_OTG_BSESSEND);
> > > +		break;
> > > +	default:
> > > +		WARN(1, "%s: unknown mode: %d\n", __func__, mode);
> > > +	}
> > > +	mutex_unlock(&otg_dev->serialize);
> > > +}
> > > +EXPORT_SYMBOL_GPL(omap_otg_set_mode);
> >=20
> > looks like this should provide a extcon interface for its users.
>=20
> Is there any examples available? Anyway, I'll look into this.

In extcon tree there are some patches from Kishon adding that to
dwc3-omap.c :-)

--=20
balbi

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRunGOAAoJEIaOsuA1yqRE8F4P/3p80PWEYlr2bopwGTJOUk5H
3jwezNOVJiEs6apGVpEgd41+w9SJifrwOuqn9dgbjvDhUhFrkvw0XE3DxLq6yZet
xG8Uh8YfloxnsVOcKiZwGZXgwVccgfhBwEMusjwqWvVdV88VlH2Cf/49Ki1+J9cl
9rJQI3EEUqEK1x+ZQ5d4U6ykMFkYyS5dSlky59hkf7fv0ktlXqKLuTlCmJoh7/hK
d500aHbva6ySX6Fz1zecL8v2+o0UcZZcDBYygSbuNZi5tMinLlcwARCd5L+6O30Y
YgpigLJJB4OG1O/o6A1v4+cMsnMJBt7VzjYRV7+xZUfMlo7QiTJe0aWTohxeMeh9
z2dsKGtVOU2mRI8ATr6P/hiVedftKpeTQEX1iyGCZDafq+nzV5S2GazRs+CFHylF
yoaz5ZFSd2zWUrwylYJqLDeCG9fV9KLSXVBr5GgbGGyhHLkkhTJnmkmpoO1WiukR
GerzuivVWM5F+mXPEl50AviFwMNisd8RlZzNG3bUrPX4AXjPKvjY50qN3jFAoE20
XnIdatp1rWWDKzXpiUYme4/hNaDSx9VCP3WlMvt2VeCSY2pLqUKP8JeH9dPYNZEF
UkQGCg/4pXN7VN5cqX5LqP28g32vp6S1qjIc4w65mCmR2mWm5fhRWQwUxjV1nGpo
v5IJHqlITkZi0yXoksYR
=Za04
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
