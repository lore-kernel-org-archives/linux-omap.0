From: green <greenfreedom10@gmail.com>
Subject: Re: wear-leveling necessary on N810 internal/removable cards?
Date: Thu, 15 May 2008 21:45:35 -0500
Message-ID: <20080516024535.GE11713@swansys>
References: <20080515231104.GC11713@swansys> <9c9fda240805151714ydf70459gf3d8e073671cc5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:34992 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbYEPDGs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 23:06:48 -0400
Received: by py-out-1112.google.com with SMTP id u52so658330pyb.10
        for <linux-omap@vger.kernel.org>; Thu, 15 May 2008 20:06:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9c9fda240805151714ydf70459gf3d8e073671cc5b@mail.gmail.com>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2008.05.16, 137, Kyungmin Park wrote:
> On Fri, May 16, 2008 at 8:11 AM, green <greenfreedom10@gmail.com> wrote:
> > Simply: do the controllers for the internal and removeable Flash cards =
of the
> > Nokia N810 do wear-leveling automatically or should I use something lik=
e JFFS2
> > to handle that?  I suppose that the location of the kernel, initfs, and=
 rootfs
> > does not do wear-leveling because the maemo OS does use JFFS2 for the r=
ootfs,
> > but I'm not sure about the two Flash cards.
>=20
> It's MMC cards which means it does its own wear-leveling internally.
> So you don't need to worry it.

Okay, thanks!

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFILPVP682C+dBP+oQRAvwAAKCC+hLtn+sG5U6PgFgozojCqzt8AwCgr0Mb
jOMwxzcbrg3pPFcyt8fIuco=
=+EKO
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--
