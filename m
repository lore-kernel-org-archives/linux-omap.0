From: green <greenfreedom10@gmail.com>
Subject: n810 internal mmc boot
Date: Fri, 27 Feb 2009 18:27:17 -0700
Message-ID: <20090228012717.GB4366@swansys>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:59072 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522AbZB1B1U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2009 20:27:20 -0500
Received: by qw-out-2122.google.com with SMTP id 5so2326164qwi.37
        for <linux-omap@vger.kernel.org>; Fri, 27 Feb 2009 17:27:18 -0800 (PST)
Content-Disposition: inline
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Any news on booting n810 from internal mmc?  It hasn't worked for a while.

I've been trying to figure out which commit to blame between=20
v2.6.28-omap1..cb4befa9201 but no luck: git is still rather new to me.

Any tips how to successfully perform a bisect with these crazy-big merges? =
=20
Commits in the linux merge won't build/work.

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmokvQACgkQ682C+dBP+oREGwCfUXqoPXUNqfZlER/hLwCGKRMQ
pOYAoIbp4H2i4GkozXP9k/7bG4twdgT+
=Sab3
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
