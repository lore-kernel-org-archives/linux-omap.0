From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v6 1/5] usb: musb: core: Handle Babble condition only in
 HOST mode
Date: Thu, 19 Jun 2014 11:01:53 -0500
Message-ID: <20140619160153.GJ23782@saruman.home>
References: <1401096012-6895-1-git-send-email-george.cherian@ti.com>
 <1401096012-6895-2-git-send-email-george.cherian@ti.com>
 <20140619104441.GD29055@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sT9gWZPUZYhvPS56"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140619104441.GD29055@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: George Cherian <george.cherian@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, zonque@gmail.com, b-liu@ti.com
List-Id: linux-omap@vger.kernel.org

--sT9gWZPUZYhvPS56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 19, 2014 at 03:44:42AM -0700, Tony Lindgren wrote:
> * George Cherian <george.cherian@ti.com> [140526 02:25]:
> > BABBLE and RESET share the same interrupt. The interrupt
> > is considered to be RESET if MUSB is in peripheral mode and
> > as a BABBLE if MUSB is in HOST mode.
> >=20
> > Handle babble condition iff MUSB is in HOST mode.
>=20
> Please get this into mainline kernel for v3.16-rc.

will do. Finishing up my series of build-tests, you should receive
confirmation that the patch applied in a few hours.

--=20
balbi

--sT9gWZPUZYhvPS56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTowlxAAoJEIaOsuA1yqREjjAP/1iOJQuomqLuFrUlq+cNdDTG
7la8fVIN15yPkumM64XbruZt1WuHtuZHEfAHLF0BFhB/wh5Po2SHUyQdS136drwo
oyR1e/vyqeRkBiLT71jYXVNZjSoKcvpgy1+XfbhoDmJg+hXlxaW+qir1Cd6Wcyte
n8+2qAh6OgEGIiNW0v+rcJAs42grEKx4W5QAro6BUP0kuem56kMa3SSCc/uQ8J6L
WCEms3FefM8DcXE0i7goEDg3nsjKUXk0/hchM55VTCl10Tfvs/gGkUllOnp1rOjm
2eI0qmNnLDfRPkCZB6yVhO1eLdz60DVZlKVmKARO9kkN3O+NXFiEXR7O40Zk2NaT
q1/PkjCs5yXowUt30RvTdOcoz6ZiTRKVqWSbQ6sQI4X/nqFauV+55bfxrXnAqMuB
B4Tz+V+owB3es3Y6l+ceXQrto7t94tQ26QIhpD00+ommDSYF99BoLc9JDQTQ2BUP
Ky6QfdxbxINJ9+g3rUyrxG3/qcqlVqV2LuH28+SwiFv1ZClX2z2Q8+MYzZVEITAl
A4/0EIKjsAqjR28Y6MGPqYeY0eyzJxdgiq4+/4qvhjaUaNFt6c6ZY0KjSm3eFxFe
+w+VmFJwdQJ3LZMdY6A4M4iVVos1eb30rD0+D9WFVjA0tsUx/W70KxYBDD06dpbN
JebAdbS7eSkR2R9vAXue
=fgxK
-----END PGP SIGNATURE-----

--sT9gWZPUZYhvPS56--
