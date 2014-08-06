From: Felipe Balbi <balbi@ti.com>
Subject: Re: Working in custom board - supporting and patches
Date: Wed, 6 Aug 2014 11:48:41 -0500
Message-ID: <20140806164841.GA31131@saruman.home>
References: <CAE1pncZc6-n_g2JxMz4WcnY4-iGna_pK+B1mMCYqPeFgTqHX6w@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52682 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757307AbaHFQtN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Aug 2014 12:49:13 -0400
Content-Disposition: inline
In-Reply-To: <CAE1pncZc6-n_g2JxMz4WcnY4-iGna_pK+B1mMCYqPeFgTqHX6w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Boris Vinogradov <no111u3@gmail.com>
Cc: linux-omap@vger.kernel.org

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 06, 2014 at 11:44:47PM +0700, Boris Vinogradov wrote:
> Hello,
>=20
> I'm using another arm boards and know basics in linux kernel.
>=20
> I need a little help (sorry, my english it's so bad) - Now I'm writed
> patches for AM335x(BeagleBone Black) and need to append it in mainline
> kernel - because this code activity using in another distribution. But
> usign with selfpatching.

take a look at Documentation/SubmittingPatches,
Documentation/CodingStyle and Documentation/SubmitChecklist. That'll
help you.

After that, just send a series os patches to the proper interested
parties (use scripts/get_maintainer.pl to help figuring out who to add
to Cc).

good luck.

--=20
balbi

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT4lxpAAoJEIaOsuA1yqREBkwP/j0aLOBKMrbtHoIsuLCPfheM
5b9LSZLESTHRHJiINqff3G7B6YFAqHaUYWtdb+gxLovW732+tnWcRPWSTJ/odVRV
s7mJkuRUrAxubL2b9NIA8s+57Kl+30n+4eY4ni86H9CnMhg4Ll8OCX7SfujQJDYJ
JkSoNR+ZD9fvR/nelrPlYZjzf+VH9UwzJ5heR6pJ2ZDZW/BcohAjKu1I6LOqRWMr
CQ7WEJCs6Jtv14XOkDZQjKOX3Luqh8V7EWzjMM4lZgiOPbzkAE5UbqmubrB1xT8h
PacqGrv+8UYyuq7bcmUoqgC1fQYI49kMa53AfH6vrAmyukyAuwRLI7uZzm/0ag+6
EMzVP3q6v8vQ7Cjl8PuZCnUau48StFyp4Pi/CdbYmcLZFoV7A611u9EvmBFJG/a9
PADtLClGHU1VSmUjMuzNAnFtNsKwy5zRdUp2FjmZPghvlkkEZ+vjeVWUQ010ZgwI
xCFTgTfxPOM51I4bSfsFJEI14sfmcyaI2f/duNE+0pedZWPaOQQEb/tMv+tVLTfo
vv9DtX0wrNiOVHk9AAtPtH9Gyn/wIU8/SggPmlbDf1qNmKFRVFcQviJAubP7LbJT
LznA9pEQA/+XBxGTCaNi7n3mNSIdpCJvhpz1BduvWNRrzuM/T6YKTcACjl5CQXb2
oqVr16F/aatrn7ZJn+9O
=r0C1
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
