From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the omap tree with the arm tree
Date: Mon, 24 Aug 2009 23:14:15 +1000
Message-ID: <20090824231415.79c6909f.sfr@canb.auug.org.au>
References: <20090819150433.4c12c612.sfr@canb.auug.org.au>
	<20090820102004.GD12309@atomide.com>
	<20090824130718.GC5165@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__24_Aug_2009_23_14_15_+1000_vOsNeYunizt0oiU7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:44754 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397AbZHXNOS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Aug 2009 09:14:18 -0400
In-Reply-To: <20090824130718.GC5165@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Syed Rafiuddin <rafiuddin.syed@ti.com>, Russell King <rmk@arm.linux.org.uk>, Kalle Valo <kalle.valo@iki.fi>

--Signature=_Mon__24_Aug_2009_23_14_15_+1000_vOsNeYunizt0oiU7
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Mon, 24 Aug 2009 16:07:18 +0300 Tony Lindgren <tony@atomide.com> wrote:
>
> The merge conflict should be gone now, Kevin realized we don't need the
> platform_data any longer. Will remove that for board-4430sdp.c and serial=
.h
> as a fix once the other pending changes have been merged.

OK, thanks.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__24_Aug_2009_23_14_15_+1000_vOsNeYunizt0oiU7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqSkicACgkQjjKRsyhoI8yd3wCgk3zLj6rV9lUEKmB7ZX9FkhKw
ELQAn38MgMIkjWQd/6LIHhJyCMNC0xgx
=0/6H
-----END PGP SIGNATURE-----

--Signature=_Mon__24_Aug_2009_23_14_15_+1000_vOsNeYunizt0oiU7--
