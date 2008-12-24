From: green <greenfreedom10@gmail.com>
Subject: using git with linux-omap
Date: Tue, 23 Dec 2008 21:24:19 -0600
Message-ID: <20081224032419.GG4080@swansys>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RwxaKO075aXzzOz0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:56555 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbYLXDYj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 22:24:39 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1887171qwe.37
        for <linux-omap@vger.kernel.org>; Tue, 23 Dec 2008 19:24:37 -0800 (PST)
Content-Disposition: inline
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--RwxaKO075aXzzOz0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey, I am trying to figure out git and am having trouble with something tha=
t=20
ought to be simple.

I have cloned linux-omap-2.6 and created a local branch.  In the local bran=
ch I=20
have made one very simple commit with a single line change to Makefile for =
use=20
when cross-compiling (arm-linux-gnueabi-).  I would like to be able to reba=
se=20
that branch (just the 1 commit) onto any commit in the master branch so tha=
t I=20
can test N810 builds using git-bisect without modifying the Makefile every=
=20
time.  I can easily move the branch forward to the latest commit with 'git=
=20
rebase master' (with the local branch active) but something like 'git rebas=
e=20
v2.6.27-omap1' returns merge errors.  Of course that 1 commit will apply ea=
sily=20
to that specific tree.

Is this possible?  What am I missing?  Thanks lots!

--RwxaKO075aXzzOz0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklRq2MACgkQ682C+dBP+oTEigCgwVGmPJy3WsLvsoBVIthSh8bJ
Jn0AoLHFldRK1szctWU/A+7W453uAPaS
=TIS0
-----END PGP SIGNATURE-----

--RwxaKO075aXzzOz0--
