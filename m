From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4] drivers: video: use module_platform_driver_probe()
Date: Thu, 4 Apr 2013 14:41:07 +0300
Message-ID: <515D66D3.3040904@ti.com>
References: <1363352558-6275-1-git-send-email-fabio.porcedda@gmail.com> <515AB113.6030700@ti.com> <CAHkwnC_AAJ5bcoH0=Zq8vVufKXqwC4WVtc9wY01h07FbZveGeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig59EF975BA17D3C63FFBB50C8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44066 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758711Ab3DDLlV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Apr 2013 07:41:21 -0400
In-Reply-To: <CAHkwnC_AAJ5bcoH0=Zq8vVufKXqwC4WVtc9wY01h07FbZveGeg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, David Howells <dhowells@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

--------------enig59EF975BA17D3C63FFBB50C8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-04-04 14:38, Fabio Porcedda wrote:
> On Tue, Apr 2, 2013 at 12:21 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
>> On 2013-03-15 15:02, Fabio Porcedda wrote:
>>> This patch converts the drivers to use the
>>> module_platform_driver_probe() macro which makes the code smaller and=

>>> a bit simpler.
>>>
>>> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
>>> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
>>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com> # atmel_lcdfb.c
>>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> Cc: David Howells <dhowells@redhat.com>
>>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com> # amif=
b.c
>>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>> ---
>>>
>>> Notes:
>>>     v4:
>>>      - add acked-by Nicolas & Laurent
>>>      - fix amifb.c
>>>     v3:
>>>      - add missing drivers: amifb, atmel_lcdfb, vrfb
>>>      - split patch set to each maintainer to easy up respin
>>>     v2:
>>>      - rebased over linux-next and remove already converted drivers
>>>
>>>  drivers/video/amifb.c          | 14 +-------------
>>>  drivers/video/atmel_lcdfb.c    | 13 +------------
>>>  drivers/video/omap2/vrfb.c     | 13 +------------
>>>  drivers/video/sh_mipi_dsi.c    | 12 +-----------
>>>  drivers/video/sh_mobile_hdmi.c | 12 +-----------
>>>  5 files changed, 5 insertions(+), 59 deletions(-)
>>
>> Thanks, applied to fbdev branch.
>=20
> Thanks for taking it.
> I don't see this patch neither in linux-next nor in
> git://gitorious.org/linux-omap-dss2/linux.git,
> in which repository/branch is it?

I just pushed for-next branch an hour ago or so, to the above mentioned
gitorious tree. So should be in linux-next tomorrow, I guess.

 Tomi



--------------enig59EF975BA17D3C63FFBB50C8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRXWbTAAoJEPo9qoy8lh71IdQP/16mfFBQLYxdxpNm3pM9f/dK
RjGDt7jUnB03PXbG9SJc6ga5PPoJ4fNWONMPGiftp9PNnkeKQhvWDmbGoaAtF8+R
MMReuO2z9ioB9Tk13JASGQXvTu8sd3FSrX2Tv7rS3V6zE/kWiSFC+LM2vj6UQcuH
z22fNBeE/r4yIpdL7w+H6NnnJ1wK/6jr60e9fZUalSKMtnIvY27D6TXH3p23DpVq
SfKDU1vWfR/rba1Dgh+5woyJnnE+E5yjWPgW3DNzruF1+AUp/g7LZ90EMDnRBXdE
KAVteAgWGtWmm5BQVbTbSYofa9j04yx/E8AvxogFbB/ZLXIhcbExxpyZ20owdf/b
vFPoKb30jsfH55PxSBqKUW4up9vwousNAuJkEltB+clVfcal9AEefbEw+8OmNigJ
VvIRZ7emGA0CB3gMY5tXvk3xJ9AmaI7neyFi+qCOYO7/cqoPm0wi0MwIvbmrp1j0
lPsLIvAsU+HI1hIKQBw6uVvtHW/xKsgKhQREAvO41HW3ROnQuNouH66UJ4NIO9sE
896LRxPhi9+eVxJWt9ZBf3+bUT5ugQe2I2YKIYZYlvhmk1n8ulJ6UZckjY0hq9kn
ixFzi8CJnzxEMdt9ZPQHOqEgT22Hn6l+CGB9kuShR3qjSjqNOKp0r3agDyQWarzj
TF4sLUk92JddfHImEALz
=p8IH
-----END PGP SIGNATURE-----

--------------enig59EF975BA17D3C63FFBB50C8--
