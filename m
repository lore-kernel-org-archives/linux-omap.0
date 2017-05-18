From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] usb: host: ohci-omap3: Print warning to get people
 to use ohci-platform
Date: Thu, 18 May 2017 19:21:57 +0200
Message-ID: <20170518172157.huhmkllpub3bujyv@earth>
References: <20170517225922.17723-1-tony@atomide.com>
 <20170517225922.17723-4-tony@atomide.com>
 <20170518091502.f3q6opnoey7aw2aw@earth>
 <20170518140857.GA10472@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jzvkhdmqdkmptzkg"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170518140857.GA10472-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--jzvkhdmqdkmptzkg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 18, 2017 at 07:08:58AM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170518 02:18]:
> > On Wed, May 17, 2017 at 03:59:21PM -0700, Tony Lindgren wrote:
> > > We can't just remove ohci-omap3 as that could make some people's
> > > systems unusable for keyboard and mouse. Let's print a warning for
> > > now, and then remove the driver in a year or so.
> >
> > I guess you could drop the driver and modify the Kconfig entry,
> > so that it selects USB_OHCI_HCD_PLATFORM? I just checked and
> > there are already a few examples of this in the USB host Kconfig :)
>=20
> Right but there's still nothing telling people to load ohci-platform
> instead of ohci-omap3 if we just remove ohci-omap3 without any warnings.

Shouldn't the driver be loaded automatically due to the DT
compatible value?

> I don't think there's any need to rush to remove ohci-omap3.

Just looked like it can be dropped with trivial changes.

-- Sebastian

--jzvkhdmqdkmptzkg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkd2DIACgkQ2O7X88g7
+prBaQ//UVq9EYYA2Raqg4nsDTLXpw+yzMri5j6WHOok4OKuhBl9LokvnxxosCKl
PXzZz2FTFT/mpjawnCBXfgZy5P4X1tqzSa1sJj3BuhrgOawevRxsxpCdLTnE32bI
b8tdPlDhxiDgcvtAGD3uI0hPdI0h7BLVVwlTGKOGixzjYlU+9/BX6yowV1iXStt4
wFwA8H2ljT5eB7kEGEc9k9ZTkPQuKEvAcIblDY+uA12pj7a05utkFw4KNrdFhQaW
MAhdVinV6M1O8EkUZfFRUlMdEBqB45xVp4o0p6c31o9enuRLO5W1wAPTk3N8U9md
pkgEUmKd0e0Ak2oD/MGTyRtUWT8Y0oVRpVPPTjWtHL/36t1+dthhpYvaUgci+v5m
mYu5DVXfvbnBzOI7tap4f7RnIE2vgnBKzoHYApeUwBMtq8Wdl07RWUH5O4ehevHE
tuqsiBRVfBo17Jaii5FJdnuX6gWJJodVvSWOEjwErHF2lxT00S9SPuY7GXYEnoBL
AsOiYfQdPuNfNZNfWeTIT8fAfdEEhXFz84aTgGSMh2F/9zWBGtSCIqdnrapC5ojW
pTGoyExPM0+Fd+RqkHccGwEKSLgXjChdvdSza3wY93ruoES/B9kMHloJX96i/TBL
uXuG5XHs+gjVkT1AYuHXhyqLmMzC2CPeWN1mBS6S4VqnGnnKxKY=
=t15q
-----END PGP SIGNATURE-----

--jzvkhdmqdkmptzkg--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
