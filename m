From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 2/4] usb: musb: trivial cleanup
Date: Tue, 20 Dec 2011 13:56:22 +0200
Message-ID: <20111220115620.GK31842@legolas.emea.dhcp.ti.com>
References: <1324325871-15137-1-git-send-email-felipe.contreras@nokia.com>
 <1324325871-15137-3-git-send-email-felipe.contreras@nokia.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M0YLxmUXciMpOLPE"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1324325871-15137-3-git-send-email-felipe.contreras-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Contreras <felipe.contreras-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--M0YLxmUXciMpOLPE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2011 at 10:17:49PM +0200, Felipe Contreras wrote:
> From: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> enabled && driver || !enabled can be simplified to !enabled || driver.
>=20
> Signed-off-by: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

applied, thanks

--=20
balbi

--M0YLxmUXciMpOLPE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJO8HfkAAoJEIaOsuA1yqRE4kUQAI22cpxMnsowmFLhVo04MrFn
mgfXfl8agW2QcjVqKUz/29y1d/HFEsN1eWNSEcoxXock1OIxqAiSjw0+8hW+6uPn
8N5B1wtJQlyQpjBLjS6bjhi7Xm5I+ogV5ZauvGa3Zky4bMIXsA518Pmr4oUiswAh
NUB0IS4wMrbXP3FbokzVjyzgH5B/OcsPKpqIxtTdCA0v4S7O+iV/+N4t306EL7WU
AXMg9tWf+H11DHYVCeuQTFvVlnSQEqmYnctj2lVnv47madP5LS7oMYAD45LvDpIB
rHovl/x14iuk3uEEFVjQg86iX4Ei4xxHlxnKXRS3FsGzL87HxDbOm2fOQf/jLHkB
0Vpdg9XQOy4w/FMYHsMPcozfTEzg36UNO6C1pMA9593XH4tFae97lvrQMar0n+3H
BEu+nfkV9CNyvotY2DslPgfI14gscvg0WjgewsVCt6qwAv2Hx9wqYQUDjxaw7O81
NQFwGPByzdSjl6bfpFoyaDPTITRVofYbR9bKZKsuMs6qtUDK0Vo6bRIDeZdeLQcW
R8Za68IaEZCRr2lSJ7/rIdkJY1fmk4MTXWFjLF+hQ7MkPHTEOdbw/4MjmT5LZq7d
NJv3oClLfcFkBfIOotFtcDLDmxXiT+pzvgTngYhkpdwxWzC4owFwBIAwKip1K4bL
k/RkdTnTuAkRo0isRMNA
=LrEb
-----END PGP SIGNATURE-----

--M0YLxmUXciMpOLPE--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
