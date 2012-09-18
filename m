From: Felipe Balbi <balbi@ti.com>
Subject: Re: How to disable message "Uncompressing linux..." on kernel start?
Date: Tue, 18 Sep 2012 11:49:52 +0300
Message-ID: <20120918084951.GA22993@arwen.pp.htv.fi>
References: <5448984682E7954C9BFF27F747A9C6CA56E2F0@dolphin.TIGRIS.local>
 <5448984682E7954C9BFF27F747A9C6CA56E308@dolphin.TIGRIS.local>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:53765 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752849Ab2IRIyg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Sep 2012 04:54:36 -0400
Received: by lagy9 with SMTP id y9so4781359lag.19
        for <linux-omap@vger.kernel.org>; Tue, 18 Sep 2012 01:54:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5448984682E7954C9BFF27F747A9C6CA56E308@dolphin.TIGRIS.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maximilian Schwerin <Maximilian.Schwerin@tigris.de>
Cc: linux-omap@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 18, 2012 at 08:39:53AM +0200, Maximilian Schwerin wrote:
> I have been convinced that my patch for disabling the message
> "Uncompressing linux..." on kernel start was not all that good an idea.
> As the problem still remains an issue for me and I'd like to find a fix
> for everyone I'd like to ask for pointers where or how to fix this.
>=20
> To sum up my problem: I'm using the primary serial port on an OMAP3 as a
> debug console for development. In production we set the u-boot silent
> option which disables all kernel logging to this serial port. The only
> kernel message that remains is "Uncompressing linux..." at the very
> beginning. As we connect an external device via this port in production
> environments this is not acceptable.

I don't think that would be an acceptable patch upstream, but you can
hold a local patch to remove that print from your own kernel. I'd still
try to get the production environment to ignore that "Uncompressing
Linux..." string, otherwise you will have to keep patching the kernel
for every release you try to use. Anyway, this should do:

diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/mis=
c.c
index 8e2a8fc..e7c8ff3 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -144,11 +144,8 @@ decompress_kernel(unsigned long output_start, unsigned=
 long free_mem_ptr_p,
=20
 	arch_decomp_setup();
=20
-	putstr("Uncompressing Linux...");
 	ret =3D do_decompress(input_data, input_data_end - input_data,
 			    output_data, error);
 	if (ret)
 		error("decompressor returned an error");
-	else
-		putstr(" done, booting the kernel.\n");
 }

--=20
balbi

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQWDWvAAoJEIaOsuA1yqRE+XUP/Rc4Xzs2i8l2ZHYWzjBXY3ba
QIacQEtzxgmfvAu6EYERb22Qv/zXpR3O4vr5sTRwZfhb+GvTmcBmFiFmfPvEO9PK
NWqs+H1qhaQ200X+2+kARSJKz6JHQJ2JvFjYUO9SqNN/RI27XtZNfnnjzn9LZX02
oV8s6ovOmWUBPggra/feTS8lL2Qm3fvPx5etMlvkptZMfNxuhFSlLzedoNGdGJN1
OYnwgW2gcgJLCZGKvTdQyIyGujiikvddCrVv5OpwwHRgfGpJGK5ZIVCrdKP33x6w
F0M7TwQFdHQYZFA0mzTC337I8aQrnYFsc/bDl4gqx+MqS6IfVxww967M9BDLbd85
SZYRWXXJxy2tnOz3PKi3hw+n+V0q4VG/PqJH97ewZbP0g7bcakDR6Ma5EA/jvBry
7yrGVFUlZYhJyjgPhjz6Qq+swafTRMtBmkBtSvYoxCZCF7sW7PyFSp9x1g6Jh/SA
fmek+c9+5mucQmdTM7W/RAIpcnExZN7IoxuW0EswZPkZ5osfaSx/IXTXJPEa5VEp
TB1JSG7zDZoUtsU5ohOYGr5CDR4/EBx4aivRDATqHUe7HOmrlGDZo6AcoSG3INUL
9WUZy5/BNUFjymY1L7t5R0cYbOb4occXiauz5tV66Wdr89g13iCLwnsGdiuPTzG2
riAhPqqoBjXbdYAQfUuP
=cZRj
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
