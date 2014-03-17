From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Turn power off only once.
Date: Mon, 17 Mar 2014 13:17:21 +0000
Message-ID: <20140317131721.GG11706@sirena.org.uk>
References: <1395041491-22152-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nhYGnrYv1PEJ5gA2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:33068 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbaCQNR3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2014 09:17:29 -0400
Content-Disposition: inline
In-Reply-To: <1395041491-22152-1-git-send-email-jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, lgirdwood@gmail.com


--nhYGnrYv1PEJ5gA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 17, 2014 at 09:31:31AM +0200, Jyri Sarha wrote:
> Regulator code keep count of enables and disables. Double disable
> causes an ugly warning.

Applied, thanks.

--nhYGnrYv1PEJ5gA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTJvXeAAoJELSic+t+oim9lm4P/Rkl7lnG0ETXsZucpBnQrmsw
jRC4qWW+CJuT9ykykp/d6C32DVPC6YJUVw5D12c74G29epqS4zVNLbQqKsI25RID
b6gYa9AaCu3FDOmN0tLh34QuYFbQZ8x68nWRsUNFVWkzw5zbI7oVZHRoJY1bwmpY
Jdw9bns+AkPHAY8da9wvNRPhYnnMZ0d6WaUa42Z8pE3h3zSRji15N79SlDTlibnd
C94IjEh8fmvUAhdpU4/S1ZzdA1q6KKuTPBIm8cSnI94hIEFovzGnj1GRLdGnZeZf
KRKZGe2Dr8TohwK+eb8fcjCRii4sPLPB/zjX8mJaQx2cfklVUY7L0GmvvjqoinKa
pjwg75J7I5mWd27G4/+PufPn7ByhdTXhz4Din/UvepRRQMN6Bvq1pgdmsBVckgzM
LvPuIvYVwVZnsNDzHrV8bGiUKk/O2r6JehXg77Fbwly/DZAplgpHFq1apg2cOPl8
+LNKVdew7JsvydtTiBfKNJVvcgOaHkDYCmhPS2EDJtCKLNoS9nv9vgqjcpNWIuTV
89MC+e4GILtaR7FGpa6egUyOA3Z4Q0RAdtlV9yzEvoNSzCGnV/RxBZkFMjddjbV+
sfWQvpDFSrhVYgIEOLUUVBHyKOTLbGTLd3MH7ZNNp+esmYt66x6ZyPrXbuDjDewL
y7F88idz+x5pMmv8fju1
=nhFI
-----END PGP SIGNATURE-----

--nhYGnrYv1PEJ5gA2--
