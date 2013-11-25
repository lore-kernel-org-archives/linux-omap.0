From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/5] usb: musb: call musb_port_suspend from
 musb_bus_suspend
Date: Mon, 25 Nov 2013 14:45:14 -0600
Message-ID: <20131125204514.GL18046@saruman.home>
References: <5293B144.10006@gmail.com>
 <Pine.LNX.4.44L0.1311251534260.1172-100000@iolanthe.rowland.org>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CoNbBaeZcnNUO34V"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1311251534260.1172-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--CoNbBaeZcnNUO34V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 25, 2013 at 03:41:14PM -0500, Alan Stern wrote:
> On Mon, 25 Nov 2013, Daniel Mack wrote:
>=20
> > >>> What if you have a mounted file system on a pendrive ? Should we al=
low
> > >>> suspend in that case ?
> > >>
> > >> Well, I would have expected that, but in fact, the opposite is true.
> > >> With 3.12, mounting a filesystem on a USB media and accessing it aft=
er
> > >> resume was exactly my test case, and it worked just fine with that p=
atch.
> > >=20
> > > so you had a mounted file system, suspend, resume, it was still mount=
ed?
> >=20
> > Yes, exactly.
> >=20
> > > or did it reenumerate and you remounted it ?
> >=20
> > No, it did not reenumerate, but the core did a reset on it. See the
> > following log.
>=20
> ...
> > [   32.030792] usb 1-1: reset high-speed USB device number 2 using
> > musb-hdrc <<<< !
>=20
> Like I said, you get a reset-resume.
>=20
> > > Try to do the same with transfers in flight, it's likely to corrupt y=
our
> > > file system.
>=20
> It's not so easy to suspend a system with USB mass-storage transfers in=
=20
> flight.  For one thing, userspace gets frozen before the suspend=20
> starts, so there's nothing to initiate new I/O requests (except perhaps=
=20
> for dirty-block writebacks).
>=20
> Also, the child SCSI device gets suspended before the USB device, so
> its I/O queue stops running.  In addition, the usb-storage suspend
> routine and the main I/O thread are mutually exclusive (they both grab
> the private mutex), so a suspend can't occur while a SCSI command is
> underway.

awesome, thanks for the explanation Alan :-)

--=20
balbi

--CoNbBaeZcnNUO34V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSk7baAAoJEIaOsuA1yqREZjwQAKX+N1H0bqNe6eugMGs/4Uph
n7iyr/LzN2a61MVx+75Xk8XwjIBovbS5Z9BHiwJ3RqicWmaa6u75vJNVoiXYpRec
lDObKqg3xWmZq9ecXUkiB4oK2ymkd4l//0oPP0QOoHmeHyXIbXF93R2Xc9mzOmOf
p8K7QkBroecLYgIxE0tYA0PZWBTDnVSA4sVZLnoiCqoYz4aJVPJ2PsPkG2/b5mK+
MYVm0NARY7zRrk9N0Jazq+qNsfmaRvyo8t6V9vtalVSTjLFCDczonn7UsdmNA840
Efp6CGMkJ1AAxX15x4/mHoi/7uCS/+3YUhE9+f2fKgC4vExMAAFZt9YgBdGu4p7Y
8VKgn72w2pmEVsHB08/C2LiKgNDqRoxv68Ok7SlM+rnDHTnpYAd+cCVp1Ywo/OBx
Ud/l54tD4zRONy1hxc6IcY9fFXisNPw8k51b9VnVXzMZK69GCJGG27Uy/4QFl9SZ
cvPsW/DVhaJxde1sEsjWg70rEjQ9jh16B5RCYmCW8VunsXjrQgyJBrAWXqKgXMJ1
QFhQp0RXo7Zz1J6t1tUHuS0Q8xmAn7sCb3B8hrvs/ZaBgQ08IekAAj8LThwKOl0Z
uzAODlU7km22aMDkoS0uMOgiBSejiIIk3lfPQMfZ2HdDvyjisdz0LCNxLjfpyPx0
qzLD3rhPQEBi5bykGJ76
=GSX0
-----END PGP SIGNATURE-----

--CoNbBaeZcnNUO34V--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
