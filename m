From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: USB problem on beagleboard clone
Date: Fri, 14 Sep 2012 16:07:56 +0300
Message-ID: <20120914130755.GA21130@arwen.pp.htv.fi>
References: <5448984682E7954C9BFF27F747A9C6CA56E2C8@dolphin.TIGRIS.local>
 <5448984682E7954C9BFF27F747A9C6CA56E2CA@dolphin.TIGRIS.local>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5448984682E7954C9BFF27F747A9C6CA56E2CA-pd0mJjIfunmL041gAgtUOYT4S9po1h25@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maximilian Schwerin <Maximilian.Schwerin-Uf0zVKHSUsGzQB+pC5nmwQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 14, 2012 at 02:57:49PM +0200, Maximilian Schwerin wrote:
> Sorry :-( With log now.
>=20
> > -----Urspr=FCngliche Nachricht-----
> > Von: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org=20
> > [mailto:linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] Im Auftrag von=20
> > Maximilian Schwerin
> > Gesendet: Freitag, 14. September 2012 14:26
> > An: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Betreff: USB problem on beagleboard clone (PGP: Plain, Signed)
> >=20
> > Hi all,
> >=20
> > we've designed two beagle board clones (two different=20
> > layouts) for a customer. After quite some time without any=20
> > problems they are now seeing USB problems on some of the=20
> > boards. I have so far not been able to reproduce the problem...
> >=20
> > The USB port of the OMAP the problems appear on is connected=20
> > through a TPS65950 to a LAN9514 USB Hub + Ethernet Chip.=20
> > Attached is the kernel output. I'm not even sure if this is=20
> > related to our board, or if this might be a misbehaving device?!
> >=20
> > If someone has an idea what this could be and what I could do=20
> > to fix or at least further debug the problem please speak up.

I have never seen that error before on any of the boards I have. One
question though, if the port is always Host, why are you using the OTG
subsystem instead of the actual Host Subsystem which has an EHCI
controller ?

--=20
balbi

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQUywrAAoJEIaOsuA1yqREdSkP/R/97+oTbZnR/CCZPLAWmean
oLEKJehtTXrRBp5b2aL9e8wD2pDPnRSe5nq1Zrkw5b6zYAdhcQzXSXWw6L5RbHrn
E5Qn1Glfuyl6qfPBJAHyV91oTpTmV+MP22u26s549lpYNMdRvdG57Fbb1Yr+ftIK
ax4JmmVqaokM3A8mqNIpmXJE+xZjUhRwz95G+RUN6y+aUnZZYLg09JznuPZdst4u
/mIWS9ei91jE4bhbZpl5b5KqwpYw/1CeY8C8LoVWIf0VIj+07214pdFf07zKWkjp
OFjMMiHSVf+fKxwmTEEQqoI+FpuUczcrzhEgH1fXQDpyXsUMRgExtzSNRwYHWeR+
xoqVKyK6xUzI7wa/QrWTShJ3WxaP0Q6o/G1396IGfMtcycp+T4YGsfkHLK+nyUdA
ptmkRtkjW79Z/FE5Gjd9deyzO9lkTHajB/LDzATv5TVHx86ulWdwKkUJ4xBcGQru
z+FiLSrY0HU3qUftXZkoFmtsfRnw3jylkOBPhl0ERfvk392LVjdh+zy3IU6ulHwy
yBJt7WC3k52/khBR2b2Yf+lgdxbJtSnZKbJKy8UxzzYOvuaA1OWJQfOpQBjorCW5
nsrDsCvP8NGnYSi12Am+bWirSAdeXuHNMe5dISNdQzgBjPZzet5WOO2eiOdzDBIZ
BSGOYqlG2lqEpCHKwhPX
=F8zg
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
