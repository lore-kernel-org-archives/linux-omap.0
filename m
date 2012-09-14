From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: USB problem on beagleboard clone
Date: Fri, 14 Sep 2012 16:19:13 +0300
Message-ID: <20120914131911.GD21130@arwen.pp.htv.fi>
References: <20120914130755.GA21130@arwen.pp.htv.fi>
 <5448984682E7954C9BFF27F747A9C6CA56E2CB@dolphin.TIGRIS.local>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="76DTJ5CE0DCVQemd"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5448984682E7954C9BFF27F747A9C6CA56E2CB-pd0mJjIfunmL041gAgtUOYT4S9po1h25@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maximilian Schwerin <Maximilian.Schwerin-Uf0zVKHSUsGzQB+pC5nmwQ@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 14, 2012 at 03:21:47PM +0200, Maximilian Schwerin wrote:
> Hi,
>=20
> > -----Urspr=FCngliche Nachricht-----
> > Von: Felipe Balbi [mailto:balbi-l0cyMroinI0@public.gmane.org]=20
> > Gesendet: Freitag, 14. September 2012 15:08
> > An: Maximilian Schwerin
> > Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Betreff: Re: USB problem on beagleboard clone (PGP: Plain,=20
> > Unable to verify signature)
> >=20
> > Hi,
> >=20
> > On Fri, Sep 14, 2012 at 02:57:49PM +0200, Maximilian Schwerin wrote:
> > > Sorry :-( With log now.
> > >=20
> > > > -----Urspr=FCngliche Nachricht-----
> > > > Von: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org=20
> > > > [mailto:linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] Im Auftrag von=20
> > > > Maximilian Schwerin
> > > > Gesendet: Freitag, 14. September 2012 14:26
> > > > An: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > > Betreff: USB problem on beagleboard clone (PGP: Plain, Signed)
> > > >=20
> > > > Hi all,
> > > >=20
> > > > we've designed two beagle board clones (two different=20
> > > > layouts) for a customer. After quite some time without any=20
> > > > problems they are now seeing USB problems on some of the=20
> > > > boards. I have so far not been able to reproduce the problem...
> > > >=20
> > > > The USB port of the OMAP the problems appear on is connected=20
> > > > through a TPS65950 to a LAN9514 USB Hub + Ethernet Chip.=20
> > > > Attached is the kernel output. I'm not even sure if this is=20
> > > > related to our board, or if this might be a misbehaving device?!
> > > >=20
> > > > If someone has an idea what this could be and what I could do=20
> > > > to fix or at least further debug the problem please speak up.
> >=20
> > I have never seen that error before on any of the boards I have. One
> > question though, if the port is always Host, why are you using the OTG
> > subsystem instead of the actual Host Subsystem which has an EHCI
> > controller ?
> >=20
> > --=20
> > balbi
> >=20
>=20
> I'm still on 3.3 but am planing to go to a newer version. We used the
> OTG port so we would not need another chip on a rather small board.

And which chip are you talking about ? You already have LAN9514 on your
board anyway...

--=20
balbi

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQUy7PAAoJEIaOsuA1yqREX+kQAI+rX9RAlAZfgnortabUmnEf
9D1kW5pwTIO8/qxP7w2jnmY82yezPhmo8xl0kuQk6GPrSIL7WKaefDo10wLsRSk3
ao/FiqDSk6P1curnE+uyzl48Vh1As5DXEJO65bEx7Cn2B/usrx/7pYT337oz98nU
Hk6228lGy3flz+ZRm5xFhap84otVUM7F+C+dUgtQ6qn0qgcxo1wgW/G90up2zpWR
3WrV5l99Bix6G3VRFX8PGrpuod0dVpq0zpuSDNjqWm98MqWjkwbkp69dq/ZrVNDI
FF1Cjpakr4vYa/07B4vvbBsBOH1ffhPGroqU++DbW76FuXkkisiHe/ki1ORSIT9g
rncw8bznoYnBKD1e2kOZJwwB1ChNtC/lNDwGRRy2LOdhZYPqpxihLE9iYyR0aIfd
RFRc0q4iz/4ENOZAR0E1USMdAFSkvq85060nPkOLrKeEHh07ClDZ8G9RKVQ9Z9Ti
7dPED4qN6LcdSIsxV6uLARwW4+CmR+8KHtjdusPD2zt7grLFi9OAzQjeLtTdysmG
G8N7xdjbOI5249lprZ/jiul7+dYKJIryBaD4c1mCHpOWAWkeJSm0Wzckx6BL7nfJ
b9h3q+SBxSa/mzZz/4ZmpjbJjs+WpjNX0cHRKBzAjMF3DvWTaW3azb1pv4PpCELw
Xl4zQejBocyS+FS6XG92
=osiI
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
