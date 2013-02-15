From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/RFT PATCH 0/2] SERIAL: OMAP: Remove idle handling from
 driver
Date: Fri, 15 Feb 2013 15:08:42 +0200
Message-ID: <20130215130842.GD16558@arwen.pp.htv.fi>
References: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
 <511E323E.3050104@ti.com>
 <20130215130745.GC16558@arwen.pp.htv.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33081 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161260Ab3BONI4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Feb 2013 08:08:56 -0500
Content-Disposition: inline
In-Reply-To: <20130215130745.GC16558@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: a0131647 <sourav.poddar@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, vaibhav.bedia@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2013 at 03:07:45PM +0200, Felipe Balbi wrote:
> On Fri, Feb 15, 2013 at 06:33:58PM +0530, a0131647 wrote:
> > Hi,
> > On Friday 15 February 2013 05:36 PM, Santosh Shilimkar wrote:
> > >OMAP UART IP needs manual idle modes based on state of the
> > >IP. Currently this is handled by the driver with function pointers
> > >implemented in platform code.
> > >
> > >This however breaks in case of device tree because of missing
> > >idle handling.
> > >
> > >The series tries to address the issue
> > >
> > >Patches has been tested on OMAP4 and OMAP5 devices where the console
> > >slugishness was observed without idle mode handling. CPUIDLE and
> > >suspend tested ok on these devices.
> > >
> > >Need help in testing on OMAP2, OMAP3 and AM3XXX devices.
> > >
> > Tested this series on omap3630 beagle board for:
> > 1. Retention in idle and suspend.
> > 2. Off mode in idle and suspend.
> >=20
> > Tested-by: Sourav Poddar <sourav.poddar@ti.com>
>=20
> try setting autosuspend_delay to -1

Also try DT boot and try to wakeup from echo mem > /sys/power/state by
sending data through UART console.

--=20
balbi

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRHjNaAAoJEIaOsuA1yqREBjMQAKFmRpbX1/UirvFCeV6xd74Z
nYYCeyJng7V7EYGEeS/oXDXhoaOTuhjlKV9KMUQaskfT0iyAb9dyIoHJC6jqx6ZA
VcfGRd8se7yCkbF2NripwRw3CI2Rl2HSNBq6vjFwW/2m8l5Rs9w8Xwb47jfdxq3B
xoEFFY8w9nWlhtzBiK6YgML4fGTp0NCRgixwirpjvZBL12V6gQkgEyuNW2TJTpRD
5cXUFZzRaisOpZ5OJy/OI9hZUJQS2oY/o7k6PUUHvbmWM6WAmkxO5la0PKemUB9b
KVa4NQ4azfGOTKdew3xeK0ie/Lo+KrJTAPHfB2Yy81lfpJHjCJg2XprOEV+ZUL1M
jky1Cg4AaXYg1jS2tgM/9/f1YYjTPehsG6Ty925fZuQlsMBy2MDrnN1BSN9sGwk5
7rEVjsdvKiW18LSS1lMzOpmsiAcBzJF8dXIBcQ0qe/+0fVML+/1sN3DYUcejFE1x
6vb4ZaUuUacRmc8hTjbIgPzrJ6M3F4cXV6F3YfrSFND+yxTWxU3XtmQL0IUGc6Is
90+cSFMpfNzNcw/nxAkL0PJlVNFwL/X/TYhmQnyR6Pt2QhAoVxEv9+D7xsTkVb7d
Ntrj1ZOPqH6i31+Gn+BSWQnqeesJAmDKsCy6Si8Pgp2nFsnHqIKIrXeS6cwuoTJY
6HVmKH5WUgWKp9JRjNtR
=+tcj
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--
