From: =?windows-1252?Q?Urs_F=E4ssler?= <urs.fassler@bytesatwork.ch>
Subject: [PATCH 2/2] davinci-mcasp: add option to use AHCLKX pin as clock
 in
Date: Thu, 29 Jan 2015 16:40:46 +0100
Message-ID: <54CA547E.30205@bytesatwork.ch>
References: <1422545689-9310-1-git-send-email-urs.fassler@bytesatwork.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ovUk8ob4BxkpdMGs9OoNxT6aKXReNm6qK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bytesatwork.ch ([91.135.72.15]:40083 "EHLO bytesatwork.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752720AbbA2PsQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Jan 2015 10:48:16 -0500
In-Reply-To: <1422545689-9310-1-git-send-email-urs.fassler@bytesatwork.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: urs.fassler@bytesatwork.ch, perex@perex.cz, tiwai@suse.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ovUk8ob4BxkpdMGs9OoNxT6aKXReNm6qK
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Add option to select AHCLKX pin as clock input source.

---
 sound/soc/davinci/davinci-mcasp.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c
b/sound/soc/davinci/davinci-mcasp.c
index 396cdec..7c0d591 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -85,6 +85,7 @@ struct davinci_mcasp {
  	int	sysclk_freq;
 	bool	bclk_master;
+	bool	ahclkx_pin;
  	/* McASP FIFO related */
 	u8	txnumevt;
@@ -429,7 +430,10 @@ static int davinci_mcasp_set_dai_fmt(struct
snd_soc_dai *cpu_dai,
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS:
 		/* codec is clock master and frame slave */
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
+		if (mcasp->ahclkx_pin)
+			mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
+		else
+			mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, AFSXE);
  		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
@@ -441,7 +445,10 @@ static int davinci_mcasp_set_dai_fmt(struct
snd_soc_dai *cpu_dai,
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		/* codec is clock and frame master */
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
+		if (mcasp->ahclkx_pin)
+			mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
+		else
+			mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, AFSXE);
  		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
@@ -542,7 +549,10 @@ static int davinci_mcasp_set_sysclk(struct
snd_soc_dai *dai, int clk_id,
 	struct davinci_mcasp *mcasp =3D snd_soc_dai_get_drvdata(dai);
  	if (mcasp->bclk_master) {
-		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
+		if (mcasp->ahclkx_pin)
+			mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
+		else
+			mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AHCLKX);
 	} else {
@@ -1340,6 +1350,8 @@ static struct davinci_mcasp_pdata
*davinci_mcasp_set_pdata_from_of(
 	if (ret >=3D 0)
 		pdata->sram_size_capture =3D val;
 +	pdata->clk_input_pin =3D of_property_read_bool(np, "ahclkx-pin");
+
 	return  pdata;
  nodata:
@@ -1412,6 +1424,8 @@ static int davinci_mcasp_probe(struct
platform_device *pdev)
 		goto err;
 	}
 +	mcasp->ahclkx_pin =3D pdata->clk_input_pin;
+
 	mcasp->op_mode =3D pdata->op_mode;
 	/* sanity check for tdm slots parameter */
 	if (mcasp->op_mode =3D=3D DAVINCI_MCASP_IIS_MODE) {
--=20
2.1.4



--ovUk8ob4BxkpdMGs9OoNxT6aKXReNm6qK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUylR+AAoJEKKADLnESIBj/8MP/2mhuH1j6nGYERHjkxBfNjsm
H0N1wIO3RcKnQZOnaowxK4E/80UHmNMEhNCVJ9F2bBCyS5fjfhTs+wkI6QpfOik9
VO5K5vO3x0YBwb+f901K1CSRfe+UhQC9boFpzVkl7AsP7QtPUBteoDbce+RfUlrQ
4IOg+eiOV5yfaoBC05Pam3MGPc7BU87T6twrW1hbkzTlyHU47wYwbFLCSeIFBEAO
79UY4sIh/aBPXBgQI+KFe03rfCggOudbm9CWpYRxtyCoXpt0lX7GyCMOsYA0fF6i
hFqv4WMHXZqGeKsjX9qLvg8CiBGUoZ+6opjL1hITnnhfxwNvmgM9GM8S4HcyRj3R
NNEauE8Rw7XEJou0LBaJISydybRbUa6EhC5uFiyRBmMDQVx5v4ZmpiWo/LApLUY8
2o3vBu8qwTKxEkqwM5oudeIRYyrpWBZsR4nYihlpMZAzZilQZojgSNI70ir9WgNO
U/vks1nCS0f6TYOo0Z0/dh+SomkqkrBTUyTuWJLvUKuHOsfeLr2uZGtPIhRyDPXC
753t9pE6DiazSsUzwzpJqhl5bdcWRsq8ou75TbS54kg1aqrlbVhKH44ytZ/U3itK
LB5oh8cOacYmwfl7WTsOXNipWmvY4rQprdwB4WwF6mgGCBigSREnkap4MYcPFm/K
nwoK3XGmlAB0PIfTatBI
=lKS1
-----END PGP SIGNATURE-----

--ovUk8ob4BxkpdMGs9OoNxT6aKXReNm6qK--
