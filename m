From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP: PM: BUG: 3.0-rc6 does not compile, tusb6010_omap.c fails
 to compile "musb undeclared"
Date: Thu, 14 Jul 2011 10:45:18 +0300
Message-ID: <20110714074517.GB2614@legolas.emea.dhcp.ti.com>
References: <1310492385.28106.20.camel@victhor-laptop>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:44835 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753761Ab1GNHpW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jul 2011 03:45:22 -0400
Received: by mail-yw0-f41.google.com with SMTP id 39so2649545ywm.28
        for <linux-omap@vger.kernel.org>; Thu, 14 Jul 2011 00:45:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310492385.28106.20.camel@victhor-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Victhor <victhor.foster@gmail.com>
Cc: linux-omap@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 12, 2011 at 02:39:45PM -0300, Victhor wrote:
> | drivers/usb/musb/tusb6010_omap.c: In function 'tusb_omap_use_shared_dma=
req':
> | drivers/usb/musb/tusb6010_omap.c:92: error: 'musb' undeclared (first us=
e in this function)
> | drivers/usb/musb/tusb6010_omap.c:92: error: (Each undeclared identifier=
 is reported only once
> | drivers/usb/musb/tusb6010_omap.c:92: error: for each function it appear=
s in.)

hmm... how about this ?

diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_o=
map.c
index c784e6c..07c8a73 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -89,7 +89,7 @@ static inline int tusb_omap_use_shared_dmareq(struct tusb=
_omap_dma_ch *chdat)
        u32             reg =3D musb_readl(chdat->tbase, TUSB_DMA_EP_MAP);
=20
        if (reg !=3D 0) {
-               dev_dbg(musb->controller, "ep%i dmareq0 is busy for ep%i\n",
+               dev_dbg(chdat->musb->controller, "ep%i dmareq0 is busy for =
ep%i\n",
                        chdat->epnum, reg & 0xf);
                return -EAGAIN;
        }

--=20
balbi

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOHp6NAAoJEAv8Txj19kN1A2EH/1FnsI7DFXqavaqnHlXula8V
CFJOp9KVb5t8mwsTgtVkQJB2BnJuZVO6ZvMjxSabcPRt7pEWPa6QG/r+kZNlA0AP
UxaDQUzftiE1ebn5MP9vcjBN12ZOGD6QDHWNK28jI1+PGBBuccrSinqgxM5Kge/+
R9aqnNEo1zBZqz2IAjLMBv3nRoyUqYDZ2ZT7g1NqqsVyRqNfhhQMCSNomvUJgyBc
yu/WEI/ZFSq1I1VO3IPLMCJCWDZVSK0t8ugNZUtpPlIJ1tqT5zta9OzECFW7v8hV
ZuN4rKQn6gwhrh5ZZhxiBQG7EEoYNSj7/4fUFWUe6ymUPq7Vl0CH4bWYuqisE2E=
=aToW
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
