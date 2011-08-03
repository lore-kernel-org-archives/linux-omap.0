From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] Revert "i2c-omap: fix static suspend vs. runtime suspend"
Date: Thu, 4 Aug 2011 01:38:02 +0300
Message-ID: <20110803223802.GC4036@legolas.emea.dhcp.ti.com>
References: <1312394379-21516-1-git-send-email-khilman@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1312394379-21516-1-git-send-email-khilman-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 03, 2011 at 10:59:39AM -0700, Kevin Hilman wrote:
> This reverts commit adf6e07922255937c8bfeea777d19502b4c9a2be.
>=20
> Remove system PM methods which can race with runtime PM methods.
>=20
> Also, as of v3.1, the PM domain level code for OMAP handles device
> power state transistions automatically for devices, so calling them
> from

=66rom where ? I didn't quite get this ;-)

--=20
balbi

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOOc3KAAoJEAv8Txj19kN1dWYH/3yFfSXeVt/Sh62+DcxfOt0Q
+NLMkWUcMDcNHOM4SzeXxdyhGMX35fNGLygn3fdUYlV0QKdR02w+Ssal+XxuTLBg
pcwfkQUn/fXRrrttxQ+p2luyO63C6eVcb4XTkGd+EGzOIQ1QKQYoEmicenx8hBYQ
RI0jHGt2ZNbh1oKQyGJX2YwszMMnHoZjYfpZhKoJI9nQqpdaNPhmzf944m30TV2m
CmfQNhhsqHMy9dFqmXM8YD2CVR4l72InwQznhaf6VNLWJIVLr3nTuVcGItefTMGX
uSgJnMP/2nHndRDu7cn2aa6wS4iBtO2mW9s84kC80c478Vm9bgR0vUQAiz+6wpw=
=LafJ
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
