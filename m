From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: OMAPFB: fix framebuffer console colors
Date: Mon, 06 Aug 2012 14:22:40 +0300
Message-ID: <1344252160.12136.13.camel@deskari>
References: <1344097153-13903-1-git-send-email-notasas@gmail.com>
	 <1344232816.6227.0.camel@lappyti> <501F9946.3030504@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-mRQgIRfhBiPmudfaE48f"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:44046 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753673Ab2HFLWq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Aug 2012 07:22:46 -0400
Received: by lagv3 with SMTP id v3so1155516lag.20
        for <linux-omap@vger.kernel.org>; Mon, 06 Aug 2012 04:22:43 -0700 (PDT)
In-Reply-To: <501F9946.3030504@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-mRQgIRfhBiPmudfaE48f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-08-06 at 13:15 +0300, Igor Grinberg wrote:
> On 08/06/12 09:00, Tomi Valkeinen wrote:
> > On Sat, 2012-08-04 at 19:19 +0300, Grazvydas Ignotas wrote:
> >> omapfb does not currently set pseudo palette correctly for color depth=
s
> >> above 16bpp, making red text invisible, command like
> >>   echo -e '\e[0;31mRED' > /dev/tty1
> >> will display nothing on framebuffer console in 24bpp mode.
> >> This is because temporary variable is declared incorrectly, fix it.
> >=20
> > Thanks, applied to OMAP DSS tree.
>=20
> Is it also applicable to stable?
> If yes, Tomi, can you please add the Cc tag?

Yes, the bug has been there from the beginning.

I can add the Cc tag. But I wonder is it enough just to have the tag, or
should I also send the patch forward? And does it only get applied to
the latest stable tree, not the earlier ones?

 Tomi


--=-mRQgIRfhBiPmudfaE48f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQH6kAAAoJEPo9qoy8lh71Kv4P/jQckcjT/Lyv4apgbPOn4hBz
98lRECYJjnMr6DeVvFfae+hplwYURc4YDjcEAku1U2HOw+xKP+79LI5OTkO01Q7G
18C51jLzgphBLmcylc2DTSmhug91jovhm9b18lYFUvfEVA79UL7zdDIZ4xBuG9G2
kW0CDYS1zP6xDpitcGPhyuOeJPZWjTlitm9Q+G45NNwUtDKuybAC2DXTUd7Jnhn+
0bKPr2gVdO83W4Ef3o952rFkM1/FGbhiTgD8xQ0qmn4HqpehTZM4rjvPOTfRlNTu
CV3Itgg6hVppm+O4ZXlQUp2RdBEVsZkpWUVF7EwacrPHb6cjBHdiH0KQ3H7VYVlK
qo49pumNLsAwR2kPUBhnLobqF/yAXVThCNZSUa4qUSmBBcjnwoieyqZyJigIQsC6
XZvqTkUXHwnS+XcLoJ/HXRZrWOorwKGuAOGZNcEMdl1WHis80YOi32ZKKtFxWRJR
0FolMl0yueST+qKlGP82Ll+XcnVMZWsOOlN36BNhge9Cc07lQUaBXs05dxEor3n/
VQBuTX0Kg5Th0PXm6+voIThTLRoZDrZIQcrmgmipFCh66aB2NVvOJjDmfzn/L8S1
4xV/T669j1sualS0vjyDsXYZhPXo8eRtBOmP2YMWttOIxGURqpajOpnGZQLajFjF
1i93T9rbaHdwnje+/zh3
=IlJM
-----END PGP SIGNATURE-----

--=-mRQgIRfhBiPmudfaE48f--

