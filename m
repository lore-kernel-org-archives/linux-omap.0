From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/4] drivers/usb/host/ohci-omap3.c: test the
 just-initialized value
Date: Tue, 23 Aug 2011 13:01:26 +0300
Message-ID: <20110823100125.GK1341@legolas.emea.dhcp.ti.com>
References: <1314021636-11528-3-git-send-email-julia@diku.dk>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOhpupldhMlYbdva"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1314021636-11528-3-git-send-email-julia-dAYI7NvHqcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--BOhpupldhMlYbdva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2011 at 04:00:35PM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>
>=20
> Test the just-initialized value rather than some other one.
>=20
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
>=20
> // <smpl>
> @r@
> identifier x,y,f!=3D{PTR_ERR,ERR_PTR,ERR_CAST};
> statement S;
> @@
>=20
> x =3D f(...);
> (
> if (\(x =3D=3D NULL\|IS_ERR(x)\)) S
> |
> *if (\(y =3D=3D NULL\|IS_ERR(y)\))
>  { ... when !=3D x
>    return ...; }
> )
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>

applied, thanks

--=20
balbi

--BOhpupldhMlYbdva
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOU3p1AAoJEAv8Txj19kN1n8MH/26i5SzDVWJ+fRyd3U8iH7HB
E/6GL4MabZyNuhNdgHSCUQrxBSyUQFv3PuI0lj7kvYGDxJrihlSzs/JtHw5MenWe
dtYWLQ1gmbG8kGaaHKtJNEYkdnyhITLqGYjH4cD9n+KSqcgp/WEzCoiNVD9o2w4+
s3nn2ALF1lp5k3fdB3yzbIjJhKIZBDFLIz5hLjE6OTTAy/d1vfa/hZbIbNQ6Q/C2
fR/RW8vBVO79fUpKTNt1UXtvoTjinQWnHDuWz6/caKaJDPubflg4op/NSoH2OGkv
7DdWNTwFLTp9dAnssg5ARslE1YUp2MNqwo5k3PhNODG6zDmWHz058yKmpYXz93s=
=1mSl
-----END PGP SIGNATURE-----

--BOhpupldhMlYbdva--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
