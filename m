From: "Maximilian Schwerin" <Maximilian.Schwerin-Uf0zVKHSUsGzQB+pC5nmwQ@public.gmane.org>
Subject: AW: USB problem on beagleboard clone
Date: Fri, 14 Sep 2012 15:38:56 +0200
Message-ID: <5448984682E7954C9BFF27F747A9C6CA56E2CD@dolphin.TIGRIS.local>
References: <20120914131911.GD21130@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-iEoYgnAqlIPCTRNcjt0U"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120914131911.GD21130-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-iEoYgnAqlIPCTRNcjt0U
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> -----Urspr=FCngliche Nachricht-----
> Von: Felipe Balbi [mailto:balbi-l0cyMroinI0@public.gmane.org]=20
> Gesendet: Freitag, 14. September 2012 15:19
> An: Maximilian Schwerin
> Cc: balbi-l0cyMroinI0@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;=20
> linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Betreff: Re: USB problem on beagleboard clone (PGP: Plain,=20
> Unable to verify signature)
>=20
> On Fri, Sep 14, 2012 at 03:21:47PM +0200, Maximilian Schwerin wrote:
> > Hi,
> >=20
> > > -----Urspr=FCngliche Nachricht-----
> > > Von: Felipe Balbi [mailto:balbi-l0cyMroinI0@public.gmane.org]=20
> > > Gesendet: Freitag, 14. September 2012 15:08
> > > An: Maximilian Schwerin
> > > Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > Betreff: Re: USB problem on beagleboard clone (PGP: Plain,=20
> > > Unable to verify signature)
> > >=20
> > > Hi,
> > >=20
> > > On Fri, Sep 14, 2012 at 02:57:49PM +0200, Maximilian=20
> Schwerin wrote:
> > > > Sorry :-( With log now.
> > > >=20
> > > > > -----Urspr=FCngliche Nachricht-----
> > > > > Von: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org=20
> > > > > [mailto:linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] Im Auftrag von=20
> > > > > Maximilian Schwerin
> > > > > Gesendet: Freitag, 14. September 2012 14:26
> > > > > An: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > > > Betreff: USB problem on beagleboard clone (PGP: Plain, Signed)
> > > > >=20
> > > > > Hi all,
> > > > >=20
> > > > > we've designed two beagle board clones (two different=20
> > > > > layouts) for a customer. After quite some time without any=20
> > > > > problems they are now seeing USB problems on some of the=20
> > > > > boards. I have so far not been able to reproduce the=20
> problem...
> > > > >=20
> > > > > The USB port of the OMAP the problems appear on is connected=20
> > > > > through a TPS65950 to a LAN9514 USB Hub + Ethernet Chip.=20
> > > > > Attached is the kernel output. I'm not even sure if this is=20
> > > > > related to our board, or if this might be a=20
> misbehaving device?!
> > > > >=20
> > > > > If someone has an idea what this could be and what I could do=20
> > > > > to fix or at least further debug the problem please speak up.
> > >=20
> > > I have never seen that error before on any of the boards=20
> I have. One
> > > question though, if the port is always Host, why are you=20
> using the OTG
> > > subsystem instead of the actual Host Subsystem which has an EHCI
> > > controller ?
> > >=20
> > > --=20
> > > balbi
> > >=20
> >=20
> > I'm still on 3.3 but am planing to go to a newer version.=20
> We used the
> > OTG port so we would not need another chip on a rather small board.
>=20
> And which chip are you talking about ? You already have=20
> LAN9514 on your
> board anyway...
>=20
> --=20
> balbi
>=20

How would I connect the OMAP to the LAN9514 without a PHY?

m.

--=-iEoYgnAqlIPCTRNcjt0U
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAlBTM5IACgkQ6nqkzTWctv5mgwCcDQ+kYUFXx7Yh9/YaeegHZWJk
CTkAoKzq3KZ05Kfbb5zv+wTE3+wufoUx
=CHac
-----END PGP SIGNATURE-----

--=-iEoYgnAqlIPCTRNcjt0U--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
