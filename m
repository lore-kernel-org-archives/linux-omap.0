From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: USB problem on beagleboard clone
Date: Fri, 14 Sep 2012 19:23:05 +0300
Message-ID: <20120914162303.GF21689@arwen.pp.htv.fi>
References: <20120914131911.GD21130@arwen.pp.htv.fi>
 <5448984682E7954C9BFF27F747A9C6CA56E2CD@dolphin.TIGRIS.local>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eNMatiwYGLtwo1cJ"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5448984682E7954C9BFF27F747A9C6CA56E2CD-pd0mJjIfunmL041gAgtUOYT4S9po1h25@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maximilian Schwerin <Maximilian.Schwerin-Uf0zVKHSUsGzQB+pC5nmwQ@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--eNMatiwYGLtwo1cJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 14, 2012 at 03:38:56PM +0200, Maximilian Schwerin wrote:
> > > > I have never seen that error before on any of the boards=20
> > I have. One
> > > > question though, if the port is always Host, why are you=20
> > using the OTG
> > > > subsystem instead of the actual Host Subsystem which has an EHCI
> > > > controller ?
> > > >=20
> > > > --=20
> > > > balbi
> > > >=20
> > >=20
> > > I'm still on 3.3 but am planing to go to a newer version.=20
> > We used the
> > > OTG port so we would not need another chip on a rather small board.
> >=20
> > And which chip are you talking about ? You already have=20
> > LAN9514 on your
> > board anyway...
> >=20
> > --=20
> > balbi
> >=20
>=20
> How would I connect the OMAP to the LAN9514 without a PHY?

Fair enough.. for whatever reason I assumed you had external PHY with
MUSB. But seems like you're using the internal PHY...

Anyway, please check with my tree (see MAINTAINERS file), either master
branch or musb branch and let me know if you have the same behavior.

--=20
balbi

--eNMatiwYGLtwo1cJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQU1nnAAoJEIaOsuA1yqREGysP/2jP5A2AvOaGYUG8YCbRuDLr
fYSTJ4tKQ+w+6ScAyYP20S8zeKNZMaj3s+GXcTLFoYp0LCodnOZzoSYiAubIXx1I
65lmr/eDzCq7B2bn5G45e8AmEQUhYpngAYI1+Xy0FgEEvJqZimEKAxgvE0y98n9C
4BYoYFz1Ya9kza8cKA8tFRkKHhG3tky5lodOWu4rs09/KBZniz0O77n3hLELhamP
BFlXuQYnGvqZPOPHxptcSz8me6n4NEsegVbu+ZJUqSMh1WcOzSn6ECenuSjhwScv
cLjFynMroOYUn4Spd21wZX7yd7uigbb0PIjfwvrIvAUct8E6X6yBOidDAhnpUKU3
8xYdkHrLxSjGNaG3WuobCidqCR0OVc9Ebp1PMuXQ+0bnFCf2vhooWmATlLzHE2M1
Ml4YJV+mqL03MlrrYLUboQMnDAaopF5H0tTgAb4ZsrBWL2nrdV9G53nwWObI+0IG
q2oT2ti6H5o/2kFogWX8ox0fkAxWUPhPmJbh/x++jCpDrZHCwMPMBgNvtiHYO91/
MMaWROglzLmI1HB4UAaBU0+mVO87NrjosRSUUyFWIP3salKBGuQ6vkd91dNX1uVc
FejN9FP9Nxz+y8OUbcTkL38xO3mp37WuGvkUaeYo8TlUBv/0szP8a/bK+w7fuivh
bi/UKl3qNYBpuCpCo93A
=4FYi
-----END PGP SIGNATURE-----

--eNMatiwYGLtwo1cJ--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
