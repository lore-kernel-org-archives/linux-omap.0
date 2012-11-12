From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/5] OMAPFB: use dma_alloc instead of omap's vram
Date: Mon, 12 Nov 2012 15:50:28 +0200
Message-ID: <50A0FEA4.20304@ti.com>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com> <CANOLnOO0yMabku-_3yhi=1bwohbrb=rtFDOuKf1LPCAFv_OqCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig805F4B598FC11630188F18F4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42168 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752979Ab2KLNug (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Nov 2012 08:50:36 -0500
In-Reply-To: <CANOLnOO0yMabku-_3yhi=1bwohbrb=rtFDOuKf1LPCAFv_OqCQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: archit@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org

--------------enig805F4B598FC11630188F18F4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2012-11-12 15:39, Grazvydas Ignotas wrote:
> Hi,
>=20
> On Mon, Nov 12, 2012 at 12:25 PM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
>> This series changes omapfb to use standard dma_alloc funcs instead of =
omap
>> specific vram allocator. This let's us remove the omap vram allocator,=
 making
>> omapfb platform independent.
>>
>> However, note that using standard dma funcs causes the following downs=
ides:
>>
>> ...
>>
>> 3) OMAPFB_GET_VRAM_INFO ioctl cannot return real values anymore. I
>> changed the ioctl to return 64M for all the values, which, I hope, the=

>> applications will interpret as "there's enough vram".
>=20
> Do at least OMAPFB_QUERY_MEM/OMAPFB_SETUP_MEM still work?

Yes.

>> 4) "vram" kernel parameter to define how much ram to reserve for video=
 use no
>> longer works. The user needs to enable CMA and use "cma" parameter.
>=20
> That's a significant change, you should update Documentation/ .

Ah right. The documentation. I never remember =3D).

> What about omapfb.vram, is it still there?

Yes.

> Perhaps we also need to select/depend on CMA?

dma_alloc_* funcs work fine without CMA. CMA only makes them work
better. Thus I don't think OMAPFB should depend on CMA, but perhaps CMA
should be enabled by default in omap2plus_defconfig?

 Tomi



--------------enig805F4B598FC11630188F18F4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQoP6kAAoJEPo9qoy8lh71bIgP/3fEbeaDbK+XsTpwOEvqW3T5
iIh2cJwLhVkJ8TXDqoolE14iDR+xUSxsWBzMsH3lnwyYyL8JiA9IgZrztRSv/NWD
EzXEqI1bXMeyXyE9tL8PX4SIHJTyHNt2GGVsvM9uSi5dXO8ZY0Z64RkhI4BM/aS+
9zXJwK/T2/f47psj+gP28IGqPifQ1JUnKZeKTrLP2VYdjzyg+PbwL97i1FHLq10Y
JzFcJwChmsMf2SESazS0U1sRRuv/uJ2i7NpbolHzc9hDvRUbP1bQQigHFZ5ARmD+
myjJvhPV1gLptzjP7IFu6CCtmyv7Hi0J2oV/Q4Iftyhg09Kmk093CirB5aR1u3W4
W5kgpQpcMx/nYATLpQFk3fj4sh2nYjtebl+u3/hSBQlS0i/dXCx0CV9oi5DTs7Ef
3a6VoLzd97ThNdAFZE51ZuR7K/fPvTkWMLaWUmZJc5HCmfRio6EejhWHTd39fA3Q
RRzk6yshd9g963r3lRiLLEAp/bH7415hUwj0u57F/s7W2T+0QpPqSyvifW5yyCsQ
VKJTxRaEtDrUWhjc1LihtZWqUnmx+bn4CQoO4jVZmG0/4Jf9abjL33KZfB4pmKnU
GaY/oKu+QVPM5LlxAhX3EC3esOxsmRh7Zy7Bm6ZInrNdGAy1mdY3MvSbQdcg+jQE
SKMFfRHLz7EpXpWOoXbE
=ewP2
-----END PGP SIGNATURE-----

--------------enig805F4B598FC11630188F18F4--
