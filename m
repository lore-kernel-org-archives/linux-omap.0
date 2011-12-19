From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/3] usb: musb: fix pm_runtime mismatches
Date: Mon, 19 Dec 2011 10:11:38 +0200
Message-ID: <20111219081137.GF3146@legolas.emea.dhcp.ti.com>
References: <1323990310-11905-1-git-send-email-felipe.contreras@gmail.com>
 <1323990310-11905-2-git-send-email-felipe.contreras@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aYDVKSzuImP48n7V"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1323990310-11905-2-git-send-email-felipe.contreras@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Kosina <trivial@kernel.org>
List-Id: linux-omap@vger.kernel.org


--aYDVKSzuImP48n7V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 16, 2011 at 01:05:08AM +0200, Felipe Contreras wrote:
> Properly call pm_runtime_put() afer pm_runttime_get() on errors.
>=20
> Untested.

sorry, but I'm not applying untested patches. I need someone to give a
Tested-by.

--=20
balbi

--aYDVKSzuImP48n7V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJO7vG5AAoJEIaOsuA1yqRE+VYP+QGsGk2Hp2mjuBhA43cvFu8R
y5eZ/X8ylW3JRl9JzDdUDBOW0JEbPx2qPwYpNdZDWtfdakDLLBQIg+bgKH21ubA/
tQ3eXwY0g25accjcWb/0ii4uSdz9P6DAGLmfLtbI/kBfeYOZtoIJbk6Ekw5GaG4g
LrvVXjgvWyLS5ddZyw+jRcaZSSzUfLxAKBGAv0+EYwFvomPYdUUjchzS4OAQMiKq
joHSiSLPcnfi2jMb2annBIGcstN1VyDorBeNq71Rz79nOnFq8P3YZAuWNnS+1Fxu
0IfXY5s4RKhABcKrYWlbFetwyj4tHUEjEqYCk3L7iKK+q0j2FTW91HrNQO8kNT55
fAjsQL+l8yT+qXMw0KmCEZek21C+yji3tVVnN6ymDV1U5F7b9T051BS+RkLgJnjF
ddfbaVGKFvO5q/XqBEqn7PjS/k2WaZ4pH0TO8s+1CIcSgefOFjV9Up+JP7uUBYuP
j2rhMKmdEErOchhZF0Kw/onCzeZGSgOmo/cpEfuduNZ46S1vn6Kw6ZOvVbavE0xU
CIUo9KDyRdfY9xbcbvTE1Dkq+e98OTNXtPfngfJl+Kz8dZckBmkVT/7D2vexkvoJ
V3/bQxUPNzmj9cBTKahs6tI5mkaddadbUJ8JpTd8/TZj9MWtr4YbGY3bFNNTcQ+w
/tVBbhHUN+dpR+1moszY
=dfPB
-----END PGP SIGNATURE-----

--aYDVKSzuImP48n7V--
