From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/11] ARM: OMAP: OMAP5 & AM43x DSS
Date: Mon, 12 May 2014 16:25:41 +0300
Message-ID: <5370CBD5.3060107@ti.com>
References: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="tfx4TgjU53kmeTE3xw50MVRTACcI94Hve"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48479 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756723AbaELN0K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 May 2014 09:26:10 -0400
In-Reply-To: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Archit Taneja <archit@ti.com>

--tfx4TgjU53kmeTE3xw50MVRTACcI94Hve
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 09/05/14 14:56, Tomi Valkeinen wrote:
> Hi,
>=20
> Here are arch/arm/ patches to add display support for OMAP5 and AM43x.
>=20
> I have these in my tree, in a branch I will send to Tony for merging. M=
ost of
> these patches have already been around the lists, but I wanted to send =
them one
> more time to verify that all looks right and everybody is fine with the=
m.

I have pushed these to:

git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git 3.16/omap

If you're fine with these, I think we can consider that branch stable.
There are probably still a few display related .dts changed for the
board coming up, but I'll add those on top of the current commits.

I also have pushed OMAP5 and AM43xx related OMAPDSS patches to my
for-next branch, so with "3.16/omap" branch and linux-next, the omap5
and am43xx displays should be functional.

How do you want to handle getting the 3.16/omap branch to linux-next?
Will you take "ownership" of the branch, and push it to linux-next?

 Tomi



--tfx4TgjU53kmeTE3xw50MVRTACcI94Hve
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTcMvVAAoJEPo9qoy8lh71LT4QAI2P7+tQl0oW3CFbR1m3VlDy
2cWjUWqBsoLkC4B+NKtU3Du3eBKkjVxDBTYA9xx+2JjdiJLlN30UrHTjHkN+N2SA
hsIWisySrsO4vU14TiP5PPhCRE7Pd4x17bzm4wC1+rDhE+JZUO8t0jvwS5a1taYl
yiYoQuZ02KjMSGF9fcjZDqEzu8kV1vhtUtHTtQgT7Zm4RbxY3RnqKRleIqra8cOT
69b9UWibeoFwN1rw87w68HN1pNZ1xTPsWsWLiT9T+VgPXV/CpwQM04zxGUXSqGdK
2ON9eWiVAD7NVvPrQA5y8+IbHKtp3GF0qgfnn08ZGrnNpLhBrrbhZ6GuQlx5InGv
BAjIJLIw6IN9yZsy2jEw3a3buvjUd+o4Q1pahR9YLTtREBIFx1wGGpwWz0ColEe9
KYwbHXIslSE+bXR8wFxdCE3QzDmr02J7ufXMZboX+J2wh96wzL4xqHtisFmy20oj
tOBt2N/sEslpxzZN1PqBW4a4u0TRr0MF9nO04GVQKTvf5J0FnfWkklsIKUP6NBwA
tmHMeGpQpP0N+9KM8SljbfLdATicgH3azYEpTpbORoxQAG09eSvVjSW+0NGEni0M
hMtCnK2Lt5l25Eu6pS9mDahEVwLQrg2nVrAIw6lGLG9b/5/hP8E3zkAo4g+xMUFN
f5VVMVu4QR4nE3iyl3Zw
=rmxF
-----END PGP SIGNATURE-----

--tfx4TgjU53kmeTE3xw50MVRTACcI94Hve--
