From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/11] spi/pl022: Convert to core runtime PM
Date: Mon, 29 Jul 2013 07:04:31 +0100
Message-ID: <20130729060431.GP9858@sirena.org.uk>
References: <1375022606-7576-1-git-send-email-broonie@kernel.org>
 <1375022606-7576-5-git-send-email-broonie@kernel.org>
 <CACRpkdYRdO5C2_mumUcMd6naCA6JaHetFSnC5u6wO0FV8BZhHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e0rzCtfzeQKTRplb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:53393 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884Ab3G2GE7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 02:04:59 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdYRdO5C2_mumUcMd6naCA6JaHetFSnC5u6wO0FV8BZhHQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, linaro-kernel <linaro-kernel@lists.linaro.org>


--e0rzCtfzeQKTRplb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 28, 2013 at 10:52:38PM +0200, Linus Walleij wrote:

> Someone moaned about oneline commit messages in
> the last LWN...

I saw that (and even followed up).  To be honest for this sort of patch
I'm not that concerned about it - it's fairly clear what's going on and
why it might be a good idea.

--e0rzCtfzeQKTRplb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR9gXsAAoJELSic+t+oim9kxYP/j+FTnDaYH8yWhLdSZLPZWbq
5zO+RzDlJ1ykGwWDjDLkc8R9qv8GB1tXmZVtI80lkk+sEdDQglu3ZgUOkQJCRVLp
QnseGPLRHA7Z4n34GYjDQgxCoN4Y9aXCKyzBnQyk1aiuM4T+pzqPFSoPEsHSBy3/
flGqZm+rZ6YZABIQ25m8y4JoDLdQF+wis4pF9+aiPvWwHzdaIL67cZt2k9WWVxlP
HoDEsFcECwxAlXzFMghwhYVjNT4pa6pWMIhTF98cQupxhap/LqE93PUzdwYKTusN
e6FzcjrC5J7l2wJby4f3dR2OhU8BGW00guBvyL/krKFghJkUAvs5NapxKSfScJ7+
SbPkwd+uKy7o6xn8NLIe/YQxdKap3Oq3hxeNZ2wYcGTVdbznYDdhB+CF4JfyIi4b
tO6AzPcEdsGpERmrMLDW15p5Q1U+afnNrQN6ixg5RC1Jx0osP3KTxcyRvRzp/pI8
H6kHovF5C4WfZujFCjlvW/rruIaXtYj39uRA3bvAekeWEca4h5mw9KeOl/HHaW3U
Ekn9/vs6IPlgl0aXHioEpOZW+gomaDwsJcypagKx265rHADo00tne2eKp9WpjfWD
tYjj2WjxdLjT7r3fPowsssFaZwK9NlZdG7ELoc/iiGJEM9Vd1MI8Dg4JL8MOvB+6
2r1StcVPugVsEnGVqFg9
=mhh+
-----END PGP SIGNATURE-----

--e0rzCtfzeQKTRplb--
