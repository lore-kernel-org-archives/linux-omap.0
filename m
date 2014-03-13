From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5] ASoC: tlv320aic31xx: Add basic codec driver
 implementation
Date: Thu, 13 Mar 2014 12:20:07 +0000
Message-ID: <20140313122007.GQ366@sirena.org.uk>
References: <1394535452-17865-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cnBsrynPgIOyCJkL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:46671 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655AbaCMMUP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2014 08:20:15 -0400
Content-Disposition: inline
In-Reply-To: <1394535452-17865-1-git-send-email-jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com


--cnBsrynPgIOyCJkL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 11, 2014 at 12:57:32PM +0200, Jyri Sarha wrote:
> This commit adds a bare bones driver support for TLV320AIC31XX family
> audio codecs. The driver adds basic stereo playback trough headphone
> and speaker outputs and mono capture trough microphone inputs.

Applied, thanks.  One thing it'd be good to fix:

> +Optional properties:
> +
> +- gpio-reset - gpio pin number used for codec reset
> +- ai31xx-micbias-vg - MicBias Voltage setting

This is optional but...

> +	of_property_read_u32(np, "ai31xx-micbias-vg", &value);
> +	switch (value) {
> +	case MICBIAS_2_0V:
> +	case MICBIAS_2_5V:
> +	case MICBIAS_AVDDV:
> +		aic31xx->pdata.micbias_vg = value;
> +		break;
> +	default:
> +		dev_err(aic31xx->dev,
> +			"Bad ai31xx-micbias-vg value %d DT\n",
> +			value);
> +		aic31xx->pdata.micbias_vg = MICBIAS_2_0V;
> +	}

...you'll get an error if it's missing (and an uninitialised memory
read).

--cnBsrynPgIOyCJkL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIaJ0AAoJELSic+t+oim9zFIQAJi/CDeMM6X/riLxySVGLPa8
gKhESbL6Ka4j9cfI54fdfeDS3KWEB7kW9DhcZoE892Zu9/PyY3RyB13ryQh8YEuX
B2r4xAVuLdoPn0YMDBNAlATWCJjDJFSFlo6nglCM8jgvoZKVPMPql3mMmxZPP6Mo
LSOVuj1GyKKa0mfEZEIazuqWaknv183L7nCbKoV+O0Szts/gauWfg/8pE7NhZkYS
X051Nsn1iYSxgfD3fsABKGR+j7jljxJ04H7QXV77h23prthKmQ7dFGAvJWSACIiD
zVTjAVd9EeWYl7XAl60tpxBO9FZy04oGnxe4bOUyDsPX4jMQO0Md/dbBAg7iGmm4
2IdlQR60LzEL6SqkrgMKMU6gh4B7jpDVmh2LztmaN+0w6w5v9Q31UM45DfAoaXze
Sqd2CAxft8z0HmB6V2rD0HbOBycIDZTaG4PMPCH+kNXvfBYu51Fal48GeB6CvPYa
6VKEZS/aqSVf7FEe4mQ7qfvF5GjcicwzHmI71gXZ/T9QjOS1zOnnJD1Ifk0pV9oH
ns+GWnyYBpJOi21nKLGJbmH/iWZQn9llLpg2qHcHF0bH/EqsE2HPkOV8nNXT3w83
0ycM6VoJbKqaxH15SRTbVv45n/zfsPwIccPL1QqB/g8NAfcbQAsMctc4OfxtyZCC
oFAon0a8Un3v6drjpo9C
=ZKc6
-----END PGP SIGNATURE-----

--cnBsrynPgIOyCJkL--
