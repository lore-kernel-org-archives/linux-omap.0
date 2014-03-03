From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 2/5] ASoC: tlv320aic31xx: Add codec driver to
 Makefile and Kconfig
Date: Mon, 3 Mar 2014 13:09:31 +0800
Message-ID: <20140303050931.GQ2411@sirena.org.uk>
References: <cover.1393405575.git.jsarha@ti.com>
 <e5ddd051ac319649d50da0da804750c1c6619edb.1393405575.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KZa8Qkr7Zx+i11wB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:54704 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbaCCFJf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Mar 2014 00:09:35 -0500
Content-Disposition: inline
In-Reply-To: <e5ddd051ac319649d50da0da804750c1c6619edb.1393405575.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com, peter.ujfalusi@ti.com, detheridge@ti.com


--KZa8Qkr7Zx+i11wB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2014 at 11:14:26AM +0200, Jyri Sarha wrote:

> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -74,6 +74,7 @@ config SND_SOC_ALL_CODECS
>  	select SND_SOC_TLV320AIC23 if I2C
>  	select SND_SOC_TLV320AIC26 if SPI_MASTER
>  	select SND_SOC_TLV320AIC32X4 if I2C
> +	select SND_SOC_TLV320AIC31XX if I2C
>  	select SND_SOC_TLV320AIC3X if I2C
>  	select SND_SOC_TPA6130A2 if I2C
>  	select SND_SOC_TLV320DAC33 if I2C

Keep these files sorted and don't send the build infrastructure as a
separate patch unless the driver as a whole is split into multiple
patches - there is no value unless the driver is being built up over
several patches, it just raises a review question on the driver patch.

--KZa8Qkr7Zx+i11wB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFA6IAAoJELSic+t+oim9JwcP/ioC6TFOTfJQRQBYFGsDFKXX
GIUE4wnOremY889iMVkKHNPBgOzwuQ83BL1MdXpIQR3K6fE5Uv5PnfJBs06UnBtp
qWICjAF0Mgr7FoFY1Fg543GmCqkwIFu9OxeulYdgZuArRv/jSRNUJBRhBAfyl5tH
1Msu0K2Zfx/SPIMcsJSZlm0TMI110pk29jJv3ntYOk0OMkyb8oOLLELoDd3CQ0Iq
HZToO69HFdsDDrJ3IOOcsq9lLx7JZPjrXI7HitN0B/yDlCrEmbkzxSHxrhQz8GQC
ximNHdoRj2sv+S9JEDOs19gJ2bI9/H2uSSHFxVZSWuOjhe8wFx+REY8iFrqmIRwa
8JKqESPet9t0xWZ8/EWMhKVmhYsMG9Uhpn++YbCmWZJv0yzc04YAQ2/DvHV2zyrC
vEufB8OvqeDQG4K7dnnA/rBmjUTzPrZfX3ytl8+dCwE1Xfjkb4hTFia/L6Db0JvY
VpSgdL251w42+JSCcBk9SD0cR+n1unnWxk3xuABEabPnLBYdAhVsF0HXjPcAzI8u
+R/Fsp4VgZujATXA4Y0Ok3e7YAoQrCgy5fcy2NpfcG2EFmgN8V+4qLz7G5Gnzdvn
N+hnrTebGiU1X5yAlRa8XVbs/y3hB6dYnshIcNlkWKTKvQTfLExWsFhbU8ip1LES
2snxtMcbcxL58OyiVdca
=QoOQ
-----END PGP SIGNATURE-----

--KZa8Qkr7Zx+i11wB--
