From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: DRA7: beagle-x15: hwmod: Fix boot crash with
 DEBUG_LL
Date: Tue, 6 Jan 2015 09:42:56 -0600
Message-ID: <20150106154256.GF6502@saruman>
References: <1420532690-29340-1-git-send-email-lokeshvutla@ti.com>
 <20150106140517.GA3897@kahuna>
 <20150106150851.GB6502@saruman>
 <54ABFCA7.3080306@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z+pzSjdB7cqptWpS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32957 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755437AbbAFPnw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Jan 2015 10:43:52 -0500
Content-Disposition: inline
In-Reply-To: <54ABFCA7.3080306@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: balbi@ti.com, Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, nsekhar@ti.com, t-kristo@ti.com, stable@vger.kernel.org

--z+pzSjdB7cqptWpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 06, 2015 at 09:17:59AM -0600, Nishanth Menon wrote:
> On 01/06/2015 09:08 AM, Felipe Balbi wrote:
> > On Tue, Jan 06, 2015 at 08:05:17AM -0600, Nishanth Menon wrote:
> >>> For using DEBUG_LL, enable CONFIG_DEBUG_OMAP4UART3 in menuconfig.
> >>>
> >>> Fixes: 90020c7 (ARM: OMAP: DRA7: hwmod: Create initial DRA7XX SoC dat=
a)
> >>
> >> Fixes: 90020c7b2c5e ("ARM: OMAP: DRA7: hwmod: Create initial DRA7XX So=
C data")
> >=20
> > what's the difference ? why do you want that many more characters if
> > those 7 are enough for git to find a uniq commit ? Try this:
> >=20
> > $ git show --abbrev-commit 90020c7b2c5e02200bc752c8cfeba91c4435588c
> >=20
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Docu=
mentation/SubmittingPatches#n160

alright, if it's Documented, it's best done ;-)

--=20
balbi

--z+pzSjdB7cqptWpS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrAKAAAoJEIaOsuA1yqRE3zwP/0HpNjZ95BZWg5ER5o4i458K
TfNzXJHJVjHk7DlVY0T15ekbYanPzTc7cqZvLjGj4eBW19EyM2tMkJe/koUji0Vr
tdSDbbwcwnWlqps8TG+08BwLw2UfAe675IY30nw0Hrd73QgYgn8pY1Bpg8lsbwiT
ioD99pAuI0FjJoiZyLs3u14va2UKWBZCHKt8xFP1EeDXuI0VPQQTa6lb0udSk6SG
yZo7G2BU3rTe77zCUjM/R1/Hz0kuUebhMmlUlLC5Vgg1bsAEb9Ud2p6vRRshrIZK
Hgzir9OCdKloxR8afe/laB+f1TGywOjSbx8A7Uff3lDAZCWSPRNtErMj/zDwtErv
Fzr/5Enab68axojwDf1VaG8ZPz0DqSRVtgVoHqlGD7rTuzPqlQuWpE1NfmwQ+C+7
tkPl4aavGopKvNmJiUMoceuaypl88qrwaidAAg1CKRGHjkILiDpqNpaNwQfp8Y9t
ve9Z3BGqSLNPUf/N5Ck3TaGRzy1HYq2m31aaEZTrlvGPPUwD6qhh3Mz8GAqBlG/Z
PVr/pq0hNhVYCNfHyPVD2a+NOepf9RJvyMCwFPfXEYkU6NNCL1Vr+XuHE3wYaJgu
mNJ2sodbZ4pVTB3xl2bAhixM0zqmjRZ4atkNNMBYMJP9a9ufNFvVD6dRvXvmGAUx
6bNX25J/VNvhAQqBwz3L
=sz6G
-----END PGP SIGNATURE-----

--z+pzSjdB7cqptWpS--
