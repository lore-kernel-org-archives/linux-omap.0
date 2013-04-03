From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/1] OMAPDSS: DSI: Use devm_clk_get()
Date: Wed, 3 Apr 2013 08:53:05 +0300
Message-ID: <515BC3C1.3070502@ti.com>
References: <1364902403-9980-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9BFC7B4B3415156BFAC4216C"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48630 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762440Ab3DCFxP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 01:53:15 -0400
In-Reply-To: <1364902403-9980-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, FlorianSchandinat@gmx.de, akpm@linux-foundation.org

--------------enig9BFC7B4B3415156BFAC4216C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-04-02 14:33, Sachin Kamat wrote:
> Using devm_clk_get cleans up some code.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
> Compile tested on linux-next tree (20130402).
> ---
>  drivers/video/omap2/dss/dsi.c |   19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)

Thanks, applied to omapdss patches.

 Tomi



--------------enig9BFC7B4B3415156BFAC4216C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRW8PFAAoJEPo9qoy8lh71EP4QAIWxLc73HP3jauk8XwYwFUJE
u9rUip0bF/hccsniwI/y+gP/NZWi2/K1eCUBauWNydf15CXXEToN+0VvIOUZq32a
WsWq6Wy3z0f2gxfVypxD4bFURYl8bnhZMgGS+jWKmngyePexZKSMkAwqXz+3Ts+1
o+oUpMBwXMYUk+EGWxjDOQFWs8r4WMbHiRfeK80tn2ulIqbOOG9wBN1JJtE87Xri
B9TRQ2p3TXIr0Bx+TmY0ly+eqVO5MB9n83x0IIpLLHXgWfho00oqWCo7ZRoOcE79
iiS5CHCJSj4Lx8W6aB0A54mhJlLyetOC0sGguQVFxq7yUO0/7cDB05ufO5OuszYv
FwXtcfGeVyQO/3SBQ1rLaeGAYUgCyi/QgV3bnxxlqfvOiEpVzrsR8BX31y/hytGg
lnPM8YkP1VFpdc7hQ0w4k/2lenamVJoTcGDkOsQivtw2p5xYQYtK84lYF9omI0DS
gt1oQ6YRw7lIuBZpp0ZyyfB9Aqd4UvUW/uiIGnmQ3whDLoPIcnkO52Qf50KSI/fD
LSl5BhmiJd+e++RKvw79XF/i34zSzR6+BpniQ5uulbTxMMJpVMC3ZYC4DXo5+PkS
5At1U5TpwqKi8cvmy67TeA1QD2pkeM62v6kgqWRGBe2TSIsboZnccJ+HZJyIV/L3
8VQ0fmibRolBBs/laq0C
=ig01
-----END PGP SIGNATURE-----

--------------enig9BFC7B4B3415156BFAC4216C--
