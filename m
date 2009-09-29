From: green <greenfreedom10@gmail.com>
Subject: Re: linux-omap git tree updated to v2.6.32-rc1, important changes,
	please read
Date: Tue, 29 Sep 2009 09:36:44 -0500
Message-ID: <20090929143644.GB10356@swansys>
References: <20090928190404.GE18957@atomide.com> <87ske6razb.fsf@purkki.valot.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f212.google.com ([209.85.217.212]:58354 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbZI2OhB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Sep 2009 10:37:01 -0400
Received: by gxk4 with SMTP id 4so3885045gxk.8
        for <linux-omap@vger.kernel.org>; Tue, 29 Sep 2009 07:37:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87ske6razb.fsf@purkki.valot.fi>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Kalle Valo wrote at 2009-09-28 16:54 -0500:
> Tony Lindgren <tony@atomide.com> writes:
> > Please note that "Remove omap extra version in Makefile"
> > commit means that you now need to set the ARCH and CROSS_COMPILE
> > for your compiler.
>=20
> A handy tip is to create GNUmakefile containing this:
>=20
> ARCH=3Darm
> CROSS_COMPILE=3Darm-linux-
> include Makefile
>=20
> Now you can just write 'make' to compile the kernel as before.

Great tip!

> The tip is also here:
>=20
> http://elinux.org/N800#Simplify_make

I have been doing that since I noticed it at the above link.

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrCG3wACgkQ682C+dBP+oRZBACeNBDzeoPN7qqy2ntnI2wcnOaP
HmgAoJWH3zDwkj4VIE4NKWywQFgnoFSm
=TRyE
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
