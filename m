From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 3/5] ASoC: tlv320aic31xx: Add DT binding document
Date: Mon, 3 Mar 2014 14:38:19 +0800
Message-ID: <20140303063819.GS2411@sirena.org.uk>
References: <cover.1393405575.git.jsarha@ti.com>
 <a72a69de5c86ee9e0931bac8d42cd72e4bee1a6b.1393405575.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YHEjEQMqr9bPKtC0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:54729 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbaCCGiq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Mar 2014 01:38:46 -0500
Content-Disposition: inline
In-Reply-To: <a72a69de5c86ee9e0931bac8d42cd72e4bee1a6b.1393405575.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com, peter.ujfalusi@ti.com, detheridge@ti.com


--YHEjEQMqr9bPKtC0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2014 at 11:14:27AM +0200, Jyri Sarha wrote:

> +- ai31xx-micbias-vg - MicBias Voltage required.
> +	1 - MICBIAS output is powered to 2.0V,
> +	2 - MICBIAS output is powered to 2.5V,
> +	3 - MICBIAS output is connected to AVDD,
> +	If this node is not mentioned or if the value is incorrect, then MicBias
> +	is powered down.

Please provide defines for these as part of the binding.  It's not clear
to me why leaving the micbias powered down is a sane default, it'll only
be powered up if it's connected to something and used which doesn't seem
altogether sane.  I'd suggest picking 2.0V (the lowest voltage so least
likely to cause damage).

--YHEjEQMqr9bPKtC0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFCNYAAoJELSic+t+oim9IXsP/3+uG/OfbmudlM7w0fBFPk/f
zG7oEQ4j/aBDVZPMYJhqq0Mz5hGLh79W63533nLQg57G2RQzIrRzSdU8/VGq3Nab
6dns3kvS1hiZF9GqbSesXyYSXfTgWrH0kguke8OmS1Tb59TtdZWJG7RQ9tfWAOut
q/pppQEYvh1i8dncuCRmezaU10QNAzyGbSbw/hOX4/YtQfVClA4m9gbehhu6IPX7
5XJyugD/ysbDN/nCfOLS3W2xul0II4npqVOwnSc/nSrcZ3bbsLZ37sj15NOpkX9e
41WZcHiucb07HQO8K8KJMs027PdHqk2mqx6CDsjhncZU0J2w0/9XgHBI8a80GzuE
FssBne+OVGN5kK4w3DX3ElCNVdXxZn8TlbCw7AGtxnnPB0KCRln38a9JanZM9SXv
2L289c6NvPsAtGB5zpCG9XzktVavtBnPnDMj6HOGuGA8hzpI++mryFuTqVMhzBuJ
RlFalBXDC7QEsSMGexWuSoxZvmC7AKXUpi0lk06OjYqHHQ58bm6CkL7Yr8go25eF
HeWv3mjcWN58mwNIg0vUrRn3A2B8VbvsdHkb0JxsktCB648yuPJjaufYaSEhoTbj
80ycLXNeCeGjPKYujIdUB9AYpMBMI8TsdWamfOrG2wRJQsB3PJadnumZYqzf6Ral
arAxpp31byG5iB8Nbc3V
=BW/b
-----END PGP SIGNATURE-----

--YHEjEQMqr9bPKtC0--
