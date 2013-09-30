From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] usb: musb: am35x: use SIMPLE_DEV_PM_OPS
Date: Mon, 30 Sep 2013 11:25:57 -0500
Message-ID: <20130930162556.GD23534@radagast>
References: <1379850421-7966-1-git-send-email-zonque@gmail.com>
 <20130923212009.GK309@radagast>
 <524137C4.1000104@gmail.com>
 <20130925134811.GH10746@radagast>
 <5245D2AE.6030400@gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54734 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754512Ab3I3Q0E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Sep 2013 12:26:04 -0400
Content-Disposition: inline
In-Reply-To: <5245D2AE.6030400@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: balbi@ti.com, linux-ubs@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org

--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 27, 2013 at 08:47:10PM +0200, Daniel Mack wrote:
> On 25.09.2013 15:48, Felipe Balbi wrote:
> > On Tue, Sep 24, 2013 at 08:57:08AM +0200, Daniel Mack wrote:
> >> On 23.09.2013 23:20, Felipe Balbi wrote:
> >>> On Sun, Sep 22, 2013 at 01:46:58PM +0200, Daniel Mack wrote:
> >>
> >>>> -static struct dev_pm_ops am35x_pm_ops =3D {
> >>>> -	.suspend	=3D am35x_suspend,
> >>>> -	.resume		=3D am35x_resume,
> >>>> -};
> >>>> +static SIMPLE_DEV_PM_OPS(am35x_pm_ops, am35x_suspend, am35x_resume);
> >>>
> >>> you could as well remove the DEV_PM_OPS trickery. Ditto for all other
> >>> patches
> >>
> >> Yes, I noticed that too. That's why I sent out a v2 of the series :)
> >=20
> > Awesome :-) Thanks dude
>=20
> So are you happy with this v2?
> It's just a cosmetic cleanup after all ...

I can't see v2 anywhere... The only version I have is the one with
DEV_PM_OPS still in it.

--=20
balbi

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSSaYUAAoJEIaOsuA1yqREV9EQAKsIhqvSX6m87z5SeDZ7s1yr
2LyxevqEU4A/twWW2EnTKJjY3WWvB7V+ahhqi78ZCuNfCeGsMYZuLY85L/UmG6v1
IyQUebaczvRmTv5+4oYyW00j2+LxR0NZfbWgnxbHZLobUXqXp40Xgq7H719gA/jw
2W5ArL2ByLkGkwNJpMje6WS9YVoHkXQcCgObSOsoJAo6UxTWG/JPhp/j4iLOyN7x
XfeCkvtkL9tY/bh2gIysdiKgvhgh9ACP+W49+DB0Kg20gOxbi88YHJs4efbNpncv
6lFC7zI5Xk8c/e+mht2j8ZeRHTJd2rUu9XB7plewLt8lHZTZX30vzz0eYAAmP39b
mG6hVTAoOBOx/ggvd1RNdCh2hGPeUlBguOmSvoW8mVjNbeAwkpPNkazwvd0MfVWi
bJvsJy140VIPnbhn9evGXS/JyrnHlU3C2ZNqNlzir54LJzbQGn2aDf4YM2XGUMKx
9NkRQHwss86rhZfffsdtQhBCqxMyjEo0txZIX5lsd2EGErDPCNzmPgyfViZANPWm
617XSRpPC5jsAxGieflPOXROqWgstZ4OObS2Ot1BIz9SLzznmBNbz3j4XN13ahKv
04J3c/95IdfU2kV0tBNPxBkOXQ0J2zGaQbwQwfuYQTOe28ZAyJyzzA46cFKgZ+ev
/ZatTdrdRIquVcMT4QML
=Qvqp
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--
