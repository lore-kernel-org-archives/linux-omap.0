From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2 v2] ASoC: omap: Add HA (HEAD acoustics) DSP add-on
 card audio driver for TAO3530
Date: Sat, 16 Aug 2014 15:40:24 +0100
Message-ID: <20140816144024.GP28623@sirena.org.uk>
References: <1399372596-10744-1-git-send-email-sr@denx.de>
 <1399372596-10744-2-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FRaepaAnLTQkJ4tS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:38971 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbaHPViG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Aug 2014 17:38:06 -0400
Content-Disposition: inline
In-Reply-To: <1399372596-10744-2-git-send-email-sr@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>, Lars-Peter Clausen <lars@metafoo.de>


--FRaepaAnLTQkJ4tS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 06, 2014 at 12:36:36PM +0200, Stefan Roese wrote:

> HA DSP card which features a HA DSP audio codec is intended to be connected
> to TAO-3530 (or BeagleBoard) using McBSP3 for digital audio and I2C bus for
> codec control. A GPIO signal from CPU to codec is used to request clock
> signals active.

So, it's been a while.  In part this is because I'm still really not
happy with the exceptionally generic name here - there must be some kind
of name that's more specific than the entire company here?  It seems
awfully generic.

> +	/* Set CODEC as master */
> +	fmt |= SND_SOC_DAIFMT_CBM_CFM;
> +
> +	/* Set codec DAI configuration */
> +	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
> +	if (ret < 0) {
> +		pr_err("Can't set codec DAI configuration\n");
> +		return ret;
> +	}
> +
> +	/* Set cpu DAI configuration */
> +	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
> +	if (ret < 0) {
> +		pr_err("Can't set cpu DAI configuration\n");
> +		return ret;
> +	}

Just initialise the format in the DAI link and leave the error checking
for the number of channels as the only code here.

> +	ret = devm_gpio_request(&pdev->dev, priv->gpio,	"HA-DSP clock request");
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to request GPIO %u\n", priv->gpio);
> +		return ret;
> +	}
> +
> +	ret = gpio_direction_output(priv->gpio, 0);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to set pin direction\n");
> +		return -EINVAL;
> +	}

devm_gpio_request_one()

--FRaepaAnLTQkJ4tS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT721VAAoJELSic+t+oim99/EP/2Y4gfhyRnvIT3tA94ZlfgV+
BpBIdki1e6fIuRC1l/OlkNS+jUQtPOceZpVGT07PoF8u+XpMGvj3MSIoMZChCsmq
rztwZ0DGMp+5Lif+0NiDURYlFJLS4v8Zt3xjcGYCAcg1eWOzh6XinJmdlirDda53
UDxPW1xnXJ8vnxEP70Hx//AcWZ9sEifBpx5UNMuAPmy6UyC81uoiZ8WBV6D6aU98
ptO4rpUGxacWpV8oYpUm01cswrZ5cK7r8jnblBa37gAadY33QuUDvl97fLyZDdSh
VKsnxnCK5dyGdpuYmFNiR7dJxacY25+//+GMuD5iM3vyxF9pVj1IWbeuPuXr4htT
mMrJVBGrp60fMVGMJ1IcNdMW0IVOoMnyPCKecDn1PFlvOFxdrnVTjN+c2wK5P6P6
4YBfRR7wx9M34xfBiMZZwclYHO2YNlnk7GdKBXK+ANgVmeQ/kZhDBi+YJW1TolJA
XLlDLmEf0F8rH3vts7af1RXpowAPv0pC3bkh2jWqau2n/tG/EXoi4OKZ1k2rtw0C
FvRvrMWV4sBGZTOPYek0UbA9czZzIXNFntNZwbAUxERpNI+lx2fnk8A4cLVCxfad
m++tyqHWM2fIru6H11KB6RiitIW7Aa/WFfZhRbunIEW09b+PPwPiPnSA1vb6g5ik
6seXC9NpJ4tg2iS9jW5J
=snBK
-----END PGP SIGNATURE-----

--FRaepaAnLTQkJ4tS--
