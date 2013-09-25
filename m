From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS display-new custom enable/disable hooks
Date: Wed, 25 Sep 2013 09:12:26 +0300
Message-ID: <52427ECA.1080500@ti.com>
References: <CAAfyv349Xjt7Wy-R34OW81SzmUX-1WhfVZdbhWVDoOXpUKa9ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="IKXppJ9GvGlakbiiHNsJtoV6mxVpVm6Up"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56040 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036Ab3IYGM2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Sep 2013 02:12:28 -0400
In-Reply-To: <CAAfyv349Xjt7Wy-R34OW81SzmUX-1WhfVZdbhWVDoOXpUKa9ug@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--IKXppJ9GvGlakbiiHNsJtoV6mxVpVm6Up
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 24/09/13 23:04, Belisko Marek wrote:
> Hi,
>=20
> we're using connector-analog-tv driver to enable TV out on gta04
> board. There is exception that we need to change some twl registers +
> some gpio when enable/disable TV output. My question is if there is
> some way how to do that or do we need to copy'n'paste code from
> connector-analog-tv driver and extend it for handling we need (let's
> call it hack)?

What are those TWL registers and GPIO used for? If they are board
specific things, then I see two options:

- Presuming you're using board files, you could add
platform_enable/disable callbacks to the connector's platform_data, and
make the connector driver call those callbacks.

- Create a new display encoder driver, which handles the TWL and GPIO,
and position it in the video pipeline between VENC and the connector.

The first option is obviously not upstreamable, as it won't work with
DT. And I'm not enthusiastic about merging board specific display
drivers either, but so far I haven't figured better ways to implement
board specific oddities.

 Tomi



--IKXppJ9GvGlakbiiHNsJtoV6mxVpVm6Up
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSQn7KAAoJEPo9qoy8lh71n5sQAIzOcECU1/kKdGVfG4/0hwe7
ZCNkFjP7ltfXBZ2ot8bc0ZHi2QoG8M5pyPKOvzMZX7NdJfzvuOiYYcYqH06fJ4Jo
c8gwU8rSF31XZYbP0gcfAE5gw3ArhD9mxU7lbEa5yQel1CpY57Isuo7SdHKJx64K
AfDYJ8KvXGlsdsp5934x2qyEBW9UGl1P4+KdSVodKnqojXoKJcah05VyaSYBql+C
20dfRELa0b3J9seylj5ruFB/AOIFFpDTeChkL7YQ1M69UnrJe5n8xjMs4KecpQmE
IMuK+DmwHaIzz9trDatTY+myrUDLH+9skSUyOtffBvJZEDnmgNeMlDoXKdr7TxlC
vH6Br9xg5mutOdhBn7SbHB26JN/lf+sjVhJ+FyITnW4lGUivuMt4byrdX074TCuN
bSKQk40TV1Uy0bQ/eVNmhB8MgzelQiFuQ7GU0jE0PyJjz/OY/nWMT16xgErXfWzh
QDk4NVTImZTNoGdJkkWIIeovbr8yXTLPdUkDp8GdNhq16Lugk7qjVnSo9fzRhY2V
7mSVCt4lx3i7Gloz5ZotzYObZJq8dq3bGXiZkeoYSNwVSScxEe4ZTEynIY7B5QBo
Vm6rnAsFI2k49SL4T+ESs/IdQOrFIiHyY//3pzOt73nsNCbTn2+VH7Ncd6PSaXRN
fiY2lcfk0JlbZzPjvZti
=QmUV
-----END PGP SIGNATURE-----

--IKXppJ9GvGlakbiiHNsJtoV6mxVpVm6Up--
