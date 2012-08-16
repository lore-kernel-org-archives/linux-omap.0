From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCHv7 00/24] I2C big cleanup
Date: Thu, 16 Aug 2012 16:15:38 +0200
Message-ID: <20120816141538.GA13740@pengutronix.de>
References: <1345125835-15524-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47769 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815Ab2HPOPm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Aug 2012 10:15:42 -0400
Content-Disposition: inline
In-Reply-To: <1345125835-15524-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 16, 2012 at 07:33:31PM +0530, Shubhrajyoti D wrote:
> Changes since v1:
>        - removed tabification on patch 6/17
>        - removed dev_err() which was introduced on patch 09/17
> Changes since v2:
>         - do not set full fifo depth in the RDR interrupt.
>         - some changelog updates.
>         - rebase to the Wolfram's tree.
> Changes since v3:
>         - Remove a redundant read of status register
>         - Read the dev->buf_len variable instead of the register
>         as the information of the remaining bytes is there.
> Changes since v4:
>         - Ack the arbitration lost.
>         - Rebase to the i2c-embedded/for-next branch.
> Changes since v5:
>         - Rebase to latest mainline
>         - Added some more cleanup patches so as have a consolidated serie=
s.
> Changes since v6:
>         - Fix comments on setting the pdev to NULL.
>         - Trivial changelog update
>=20
> Tested on omap4sdp and 3430sdp.
>=20
> The following changes since commit 3bf671af14d591ede9251acb0085e8017f3705=
e7:
>=20
>   Merge branch 'fixes-for-3.6' of git://git.kernel.org/pub/scm/linux/kern=
el/git/cooloney/linux-leds (2012-08-13 09:59:04 +0300)
>=20
> are available in the git repository at:
>=20
>   git://gitorious.org/linus-tree/linus-tree.git for_3.6/i2c/big_cleanup

A GIT tree, thanks for that!

Since the series is quite huge, I'd appreciate it if you could wait for
reviews a little bit (a few days) and collect the issues raised there
before resending. I know "release early & often", yet the traffic causes
some overhead here :)

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlAtAIoACgkQD27XaX1/VRsxHACeKJ8p59AzCiEwpBNm6rFQ1yft
DsIAn0P9xM0DPsvGyy6yXy6UgKl/H+RS
=owlh
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
