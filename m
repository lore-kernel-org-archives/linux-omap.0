From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/5] usb: musb: call musb_port_suspend from
 musb_bus_suspend
Date: Mon, 25 Nov 2013 14:49:31 -0600
Message-ID: <20131125204931.GN18046@saruman.home>
References: <1385408393-19707-1-git-send-email-zonque@gmail.com>
 <1385408393-19707-3-git-send-email-zonque@gmail.com>
 <20131125194629.GA18046@saruman.home>
 <5293ABDE.4080404@gmail.com>
 <20131125200121.GE18046@saruman.home>
 <5293B754.9050406@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZXg5XZblsOcYBG3r"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5293B754.9050406-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--ZXg5XZblsOcYBG3r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2013 at 09:47:16PM +0100, Daniel Mack wrote:
> On 11/25/2013 09:01 PM, Felipe Balbi wrote:
> > On Mon, Nov 25, 2013 at 08:58:22PM +0100, Daniel Mack wrote:
>=20
> >> In 3.13, something about the parition table reading seems to be broken
> >> currently, I'll have a closer look.
> >=20
> > cool
>=20
> Ah, and forget about this one. I didn't look close enough. There's no
> such issue in 3.13. Sorry for the noise.

no problem :-)

--=20
balbi

--ZXg5XZblsOcYBG3r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSk7fbAAoJEIaOsuA1yqREHJ0QAJ3GNi4+EzsD3INOt0sVc81Z
2XzddtLi9LjQrA8fuGQKVqqUx74wjGA6ltm1APAtwdQGUx5y3w9KJv6YCMCdNJvV
wpSnqC/RarYdQfXch4WbMVLcnr/1/Qq3Jp9qKTvUV+irw8B/YtvuR6v1MrVJR3Bj
FeESZInslK25jhNjQ0d+NvfiQToG2U85ajKrK9uNwZ8v1zAs11w4LcqefdDXX4jv
3ObkzVrwu5TBOkIhLyaCKE+Y4dn1E3bsgxi8y6+ISTvgDwSkZEJarF5l1L5xksGP
wg327aaLxRkgMFAhC91jQECj4yCju+9Q0eUHqMhrl64YOonByit4TjpTh1uBR/li
RvG1aSKhlpOPsELzVnCHq2uJP0wiVBQ/PTq9j4MB4RnKYhFGit2qsu5pFk6Hg8Vj
HRHDQKgSIQzCOBcWVKDpNDdC67B5Mh/DksJUs2D2P/EXkP+E6QKSDfL1RIO2lVWI
++CKcOnaLDuc0dacpaTiPCpR0R+rwwrDlIhe6L/JMTi8y+4L6HTD4uLTVxrfLEmM
9fUo100Hfgnf4Feuyi2hXLizJ/XLZctnyKKINlC8K0YsGoK/HDbdmPWyk7elnnKc
8PpbC2WLHZAt07mVeb5XARbjjhIaa3t8QLvvAw+9hyGn21REUcWR2zb0QDwLv+yF
Dg2YIQPEGOg71U18lJwc
=+4cV
-----END PGP SIGNATURE-----

--ZXg5XZblsOcYBG3r--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
