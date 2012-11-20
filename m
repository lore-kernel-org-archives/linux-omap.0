From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/5] OMAPFB: use dma_alloc instead of omap's vram
Date: Tue, 20 Nov 2012 17:09:10 +0200
Message-ID: <50AB9D16.3010309@ti.com>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com> <20121112225037.GU6801@atomide.com> <50A601FA.5060401@ti.com> <20121119220443.GD18567@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig814EC106AC792CE8E67CBF4E"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53851 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261Ab2KTPJU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Nov 2012 10:09:20 -0500
In-Reply-To: <20121119220443.GD18567@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: archit@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org

--------------enig814EC106AC792CE8E67CBF4E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-20 00:04, Tony Lindgren wrote:

>> Should we enable CMA by default in omap2plus_defconfig? And perhaps on=

>> omap1 also?
>=20
> Yes if that's now needed for DSS.

DSS works fine without CMA, at least for small displays, and when fb
allocation is done at boot time. So it's not a strict "need".

I'm not sure how easily FB allocations start to fail without CMA, and
how much CMA helps.

I'm not even sure what's the default DMA pool size on OMAP... If it's
the one set with "coherent_pool" kernel parameter, then the default
seems to be 256K, which is quite small for video use. For CMA the
default global area is 16M. Both can, of course, be changed with boot
params or kernel config (at least for CMA).

But I think it makes sense to have CMA by default even if non-CMA kernel
would work.

 Tomi



--------------enig814EC106AC792CE8E67CBF4E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQq50WAAoJEPo9qoy8lh71bvYP/iupOqgFPIe2IZ2mpn/9yhnC
RIlEQQVBSNInSWWWZRcBf3Htz27uuc9IK88lYx5lEAEttQ1nfh7KU3Azwei+3nZa
fcNkt41vHGIVHRKHkPJiQVRuLjYFtquTf2stYXcp/pNBUrXK/JCyvHYH/lm0fBRF
Me0f7kCbtBb/HRSIhUwpmpECo0Ca79tDSBYdU1hAQZ+u/pmFbbWxDiChuwCrIepx
kj4fXuWNI22hzkxW8ln5XehVebb0DRnMfPe1zXlRJesUQFiOdLduT1nMy9/nPBZX
p3DBxmNOtRAnkXJZz+U3W5RBZzjqBQics380AG8MB7L7u7Y1YwWM6dGE0EjaKcrD
3Z0aPT3JHVhZ3ZcoGt4dByPXAWneUL6rmRni2fXm2sgs1byfV7X7ptAv9oNtx6fd
iaVYcLGrTOJ767eXltjAQYk/DyNZdjl0hLjgPe47P2EvLToLKuSDaR60D0jGz+iO
O0lT8yZsx7m3ybKJAgKwTnAgswUlixz+k0cIWVWV23QnAIQH6xPd2o7zNzSs40G/
ZjAAxc62HS23s9bABdmpXN9DMURZfYP047i51ZwOmRAEUReb1KnrjtRIjEeTdYJ6
OMoMWIY1zaNNNfX86VsALyLKO9rAyGgZP0yXe5V9WzMXEwbOI0Jfm+xzkXZwzIIR
6POofTSHonwCGmK54QY9
=YnQi
-----END PGP SIGNATURE-----

--------------enig814EC106AC792CE8E67CBF4E--
