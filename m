From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.8-rc3
Date: Mon, 14 Jan 2013 21:14:59 +0200
Message-ID: <20130114191459.GA9402@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1301141756460.20390@utopia.booyaka.com>
 <20130114184018.GA18224@blackmetal.musicnaut.iki.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53401 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757150Ab3ANTPQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Jan 2013 14:15:16 -0500
Content-Disposition: inline
In-Reply-To: <20130114184018.GA18224@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 14, 2013 at 08:40:18PM +0200, Aaro Koskinen wrote:
> On Mon, Jan 14, 2013 at 05:59:12PM +0000, Paul Walmsley wrote:
> > Here are some basic OMAP test results for Linux v3.8-rc3.
> > Logs and other details at:
> >=20
> >     http://www.pwsan.com/omap/testlogs/test_v3.8-rc3/20130109222058/
> >=20
> >=20
> > Test summary
> > ------------
> >=20
> > Boot to userspace:
> >     Pass ( 9/11): 2420n800, 2430sdp, 3517evm, 3530es3beagle,
> >   	   	  3730beaglexm, 37xxevm, 4430es2panda, 5912osk,
> > 		  4460pandaes
> >     FAIL ( 2/11): am335xbone, cmt3517=20
>=20
> N900 boot is unstable again, I2C issues are back.

damn!

> Boot succeeds and fails randomly. Let's see if this can be bisected.
> The same kernel works on N950.

fair enough, it might be something related to some errata fix which
might have been missed. Can you apply this small patch just so I know if
there is something pending in CNT reg ?

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 20d41bf..173e883 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -462,6 +462,10 @@ static int omap_i2c_wait_for_bb(struct omap_i2c_dev *d=
ev)
 	while (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG) & OMAP_I2C_STAT_BB) {
 		if (time_after(jiffies, timeout)) {
 			dev_warn(dev->dev, "timeout waiting for bus ready\n");
+			dev_warn(dev->dev, "SA %04x CON %04x CNT %04x\n",
+					omap_i2c_read_reg(dev, OMAP_I2C_SA_REG),
+					omap_i2c_read_reg(dev, OMAP_I2C_CON_REG),
+					omap_i2c_read_reg(dev, OMAP_I2C_CNT_REG));
 			return -ETIMEDOUT;
 		}
 		msleep(1);


you might also want to try merging my latest i2c patches, which missed
the merge window, as they might help with this issue too.

The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:

  Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git i2c-deferred-=
STP

for you to fetch changes up to a7b1b41b270be84f6bf6e7d3654d74c873b3daf8:

  i2c: omap: get rid of b_hw flag (2013-01-14 21:04:16 +0200)

----------------------------------------------------------------
Felipe Balbi (6):
      i2c: omap: no need to access platform_device
      i2c: omap: also complete() when stat becomes zero
      i2c: omap: improve 'rev' a little bit
      i2c: omap: in case of VERSION_2 read IRQSTATUS_RAW but write to IRQST=
ATUS
      i2c: omap: wait for transfer completion before sending STP bit
      i2c: omap: get rid of b_hw flag

 drivers/i2c/busses/i2c-omap.c | 184 +++++++++++++++++++++-----------------=
----
 1 file changed, 93 insertions(+), 91 deletions(-)

--=20
balbi

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ9FkzAAoJEIaOsuA1yqRE0T0QAIpkWQ9lUBITPUkI3wuiJGWp
gb6OCHgEL9yrPXpKl84GlsifLz1bIdA4YltO+rpgEFgxASAGbyLEKXNiBYlFOoGg
LIP+H3v0qEILEmme/pMORt2FYJfKnPpMh3ehP1C9RiigEeHEG3GSCkm/99HjwgMh
oyLaC4g4JHYVRsyJQ2S5nN/0YGHxZVDYFZVscBamnWkHaRGW9woZx56PbbAtus0D
dfaLE3kmgurJuSNjpMyk96HUuW6oclf8dZKUbd0XJWeprXBESCUJCcAFjP6PAD3E
Y8Bp6h0oSPR2Wnu8TncRvH9MAxZpo8HUD4xqV7H54pTNFwPnoaB/7rSTm5PT3vxf
GGJDjvqdlneans655U8TAw52yUgWMQ6mKsjhHfXKVOI/jRMPgPIYy1nVkNVztyj0
nzEZOO2hRGRhdu5PfZ5gB8ZEkBIQAvZIgPGFavOKyVa1PPC0SM1KmzI5hd6StSCd
6a/QfCF1B6WLOkZcVj/tRYv+DFRDKVjNlq7u6ktuNWBNDW1auZdIUVL14Q92FlLt
14BKyr6/8EgSt4qAdRgzf+Z36OVAcYtr9dkmjQGcsUA5tliLTn1gENW2x+AMq+nD
HrZP7NJZN3OGw/1P4vC0BDqVwOOHnJiNJ8+IzP/uLiTeM4gPN66e/XfBWH4zoI0j
vt1tSjwFREV1qBgcKvLh
=N4y6
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
