From: =?windows-1252?Q?Urs_F=E4ssler?= <urs.fassler@bytesatwork.ch>
Subject: [PATCH 1/2] davinci-mcasp: fix clockin configuration
Date: Thu, 29 Jan 2015 16:40:20 +0100
Message-ID: <54CA5464.7030503@bytesatwork.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="DClN9On2RegRtlmBswhPqVN3Ctw53ouO9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bytesatwork.ch ([91.135.72.15]:40082 "EHLO bytesatwork.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752901AbbA2PsP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Jan 2015 10:48:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: urs.fassler@bytesatwork.ch, perex@perex.cz, tiwai@suse.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DClN9On2RegRtlmBswhPqVN3Ctw53ouO9
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

The CPU seems to be clock master independent of the configuration. Use
bitclock-master flag to decide who is clock master.

---
 sound/soc/davinci/davinci-mcasp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c
b/sound/soc/davinci/davinci-mcasp.c
index 30b94d4..396cdec 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -541,7 +541,7 @@ static int davinci_mcasp_set_sysclk(struct
snd_soc_dai *dai, int clk_id,
 {
 	struct davinci_mcasp *mcasp =3D snd_soc_dai_get_drvdata(dai);
 -	if (dir =3D=3D SND_SOC_CLOCK_OUT) {
+	if (mcasp->bclk_master) {
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AHCLKX);
--=20
2.1.4



--DClN9On2RegRtlmBswhPqVN3Ctw53ouO9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUylRlAAoJEKKADLnESIBjS3sQAKqS1B/m3P2io97P0pa2K0xj
un7ew8E/hKK26pBE5nWc5P+7fdAf4/JWBiZF9aY8c8QBWv/C5Oudyl2Lm0Ul/Qak
8+gfNnQdtL957GeeI7cAYWUlUfthNW7jydpC7YTxOyN4Z5PLoHBa83cPJZ37sNdR
BZv1MrhEpxwRIIOLLbrdFdzAAib4SJJ0xeycGo7xGzR43m9QnASioPTr/+WLDM42
DTL7BjHYplRJImDXNfN8xjxjV1J2eZrTuUkQCaj05xPRJ1eo/fBTnLDWT4e+weVf
llywZI7XDH6ggXTNP6RHnZHOdwCzqbcU6lLUeVZY4K+x2pZiO7AV1S0DCFk3ICWj
DQ2O/uA1mCt6WB4NQi6O05c/sDBHTjjpUMX8SaOVGWacehPjn2cUF8TB4HTaSEkn
X1iZhW9pT/h2Yb+f4rtE8GRG0HK5yT7vT/+G74mbKkmV5LKC00+zmO6SfApdCjzg
8qiINxVj9qm+jBkmh97ABEiC0xB0isISTrjx7ga6Hqxvx44iarb0rM21I5K4ANCG
9W5SdDPrkGY9SMDOIh+gY3fpWX5MhMgXnRMLtHoh3Rzx1DbQMJ2GE6oDTFnxYyhi
Kls6zyFJFpRUl1Wdv6EK5woaofX/xL3uyC7JsMe2R1ABQHh1xZkJfUerzYlnKphX
T5EWrUCr4YE6vwd4Stfi
=K6lC
-----END PGP SIGNATURE-----

--DClN9On2RegRtlmBswhPqVN3Ctw53ouO9--
