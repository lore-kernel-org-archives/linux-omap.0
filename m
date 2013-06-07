From: Felipe Balbi <balbi@ti.com>
Subject: Re: i2c issue on Panda with DT boot, v3.10-rc4
Date: Fri, 7 Jun 2013 21:39:06 +0300
Message-ID: <20130607183906.GB15295@arwen.pp.htv.fi>
References: <51B1C9D2.6060703@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49648 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755813Ab3FGSkL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jun 2013 14:40:11 -0400
Content-Disposition: inline
In-Reply-To: <51B1C9D2.6060703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 07, 2013 at 02:53:54PM +0300, Tomi Valkeinen wrote:
> Hi,
>=20
> I was testing DT boot with 3.10-rc1 and Pandaboard, and couldn't get the
> DVI output's EDID reading to work. Testing with i2cget and i2cdump, I
> see that I can read individual bytes with i2cget, but using i2cdump
> doesn't work, it just shows 'XX'es.

does it work with v3.9 ? The funny thing is that nothing has changed on
i2c-omap.c for quite some time...

> The same issue is there with 3.10-rc4, although with that one I get
> timeouts with i2cdump, whereas there were no timeouts with -rc1.
>=20
> # i2cget -y 2 0x50 0x10
> 0x0a
> # i2cget -y 2 0x50 0x20
> 0x0f
> # i2cget -y 2 0x50 0x30
> 0x01
> # i2cget -y 2 0x50 0x40
> 0x36
> # i2cget -y 2 0x50 0x50
> 0x4c
> # i2cdump -y 2 0x50
> No size specified (using byte-data access)
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 [   72.814086] omap_i2c 48060000.i2c: timeout waiting for bus ready
> XX [   73.825134] omap_i2c 48060000.i2c: timeout waiting for bus ready
> XX [   74.835327] omap_i2c 48060000.i2c: timeout waiting for bus ready
> XX [   76.097167] omap_i2c 48060000.i2c: timeout waiting for bus ready
> XX [   77.160736] omap_i2c 48060000.i2c: timeout waiting for bus ready
> XX [   78.174682] omap_i2c 48060000.i2c: timeout waiting for bus ready
> XX [   79.194824] omap_i2c 48060000.i2c: timeout waiting for bus ready
> XX [   80.242980] omap_i2c 48060000.i2c: timeout waiting for bus ready
>=20
> i2cdump works fine with non-DT boot (but the i2c bus number is 3).
>=20
> Any ideas?

sounds like there's something left in FIFO which is not getting read
out, then we end up timing out.

Can you try the patch below ? It's patch of a bigger patchset which I
still need to clean a few things up, but they should be very close to
being ready. IIRC, one of the patches creates a problem for N900 (only)
which gets fixed later, I just need to combine those two patches into
one to avoid the regression.

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index aa3b91e..471b434 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1022,9 +1022,8 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 		}
 	} while (stat);
=20
-	omap_i2c_complete_cmd(dev, err);
-
 out:
+	omap_i2c_complete_cmd(dev, err);
 	spin_unlock_irqrestore(&dev->lock, flags);
=20
 	return IRQ_HANDLED;

--=20
balbi

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRsijKAAoJEIaOsuA1yqREkWYQAJjX+fJ9AbaZVQSkTRas1QHq
uuoYEqhyBc78WaxkkeeaFC4L5MbA9eSgoV/I5yE3pC4skyx5taEl6FmMCUcsioaj
Up9X/Kx/jRbSezFdpt7VuoBTMfjXNwhVcifxevAxT1S3NyZsI6L/Dbtof0Jinct4
Y6ZNf2IS9VJ08Qgp4I0lmNf4oGN9mujUeMI8EDaBeWwKWSPh5bnDtyyytrvSgTnB
26A9UVG9FkuXKK7VAA+dDeP4NH44xQgXiuE12oODkFpyM005zv+gdBRLMj4cykS7
qD7lXPU6tTC21hBW4Xyox7ucJuXflJ/gqoJUsBiZensMWxvpAyNbr7a07cdsGPfZ
oBOzSTMr+crGYi5707kAW05TIIkiO8ahwUyMylrli8MQZRvrYQr8y1SqnbYoMcac
cVwXnFQdQ84Y3cOWUCMf8JhB7RWVUyOlkVYr9EPsU8mkvQnCriChkAtLdqazv/bG
Q6LNnz9WL8QZe6DzHQ4L60SD9Jn9/hmSdvERI87hqgMyzmtSdYI25mgtnf/zoIBX
X/m6OuiwHzaXToWtyVFMXpgs3KZhJlBXyr6BYQzSMJTRr2cFS6gHJ0L072QjwK4G
RabBRgwdvtYdjWdX8uisfLQtAtf0IxSXk9qnifc4VFHyNA48N1U7bbMG1m8MoPl0
CpeyM0auYRnP0eTtbtf5
=Wisw
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
