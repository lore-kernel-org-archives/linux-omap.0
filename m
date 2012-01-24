From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] omap2430 musb: Make musb_otg_notification non-blocking
Date: Tue, 24 Jan 2012 10:56:12 +0200
Message-ID: <20120124085610.GI27414@legolas.emea.dhcp.ti.com>
References: <20111230123628.76720567@notabene.brown>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dCSxeJc5W8HZXZrD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:35723 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755211Ab2AXI4Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 03:56:16 -0500
Content-Disposition: inline
In-Reply-To: <20111230123628.76720567@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org


--dCSxeJc5W8HZXZrD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 30, 2011 at 12:36:28PM +1100, NeilBrown wrote:
>=20
>=20
> This callback is on an 'atomic notificaitons' queue but is written
> as a blocking notifier.
>=20
> Convert to use a work-queue to run from non-atomic context.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>

doesn't apply.

--=20
balbi

--dCSxeJc5W8HZXZrD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPHnIqAAoJEIaOsuA1yqREiCAP/2zmxX9MIHpJjbBnFxrjxSm8
zdMIaCiap21N7CTE5+x9rgnSwD66utQKZYhkSU0KPcLlAOGGVLgomZV7aLlU3qqj
r5zRJuKxmgxfXcQSV1bEBGJnyO7W56wwe/Ks2PRpUTxGHYjx3fqWW4jWpfuxunaL
w/VBdpkJuf7ZeE36UNbhOoGN9Lb9AE54vMHmqdOn3IrWONSVYdQkKB5xtfitBtzJ
plXK2Ux/MWbeJfFiYR5sExbWUsG9HVyUCh8FNRR4SDdw5k3SVDZoNqAru5rg8ULx
N4s130P1efVF7h+XioHTnDccUuHHoJb/N6wweDg7p/NsWa9RrDz9FPdf3WtWu1fB
/N9eugX3xVtUBICmSnOrxkArX2f/Dqy9XNAAfUPqPPwB5clwEqlVGxF4aC8isXVT
9YiaxFdO2gSobyDiauk4R+K8yj9Yo23ic8fCb8GH52FFSkqVEpNH47DDS4DH6ztZ
+po5ysspmpzOr+w2B4cbTWVeYKeLhms+delMcyhDrVccNur1HvUaqhKKxL+7c4X9
WPYeXAVo6/6MER+wnF3JPGblRJ//2Dh1b1I6WBpX/ci4R6D6KvSrOl5y5ow36kDM
6UGLum+NANAXnbUvIESkgCtTBVetLdV1ID+jdwLb0FfWwjjU+xJCcD/aV3XODNsl
d8m4AkcGFb73tn/CClqA
=ph3r
-----END PGP SIGNATURE-----

--dCSxeJc5W8HZXZrD--
