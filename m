From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap-dmic: Clean up with devm_request_and_ioremap
Date: Wed, 13 Feb 2013 13:24:11 +0000
Message-ID: <20130213132410.GH5062@opensource.wolfsonmicro.com>
References: <1360740127-4154-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9sSKoi6Rw660DLir"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47836 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932690Ab3BMNYN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 08:24:13 -0500
Content-Disposition: inline
In-Reply-To: <1360740127-4154-1-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org


--9sSKoi6Rw660DLir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 13, 2013 at 08:22:07AM +0100, Sebastien Guiriec wrote:
> Clean up dmic code with devm_request_and_ioremap function.

Applied, thanks.

--9sSKoi6Rw660DLir
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRG5MwAAoJELSic+t+oim9ED4QAIiNj4lO8F09++saMnmgevQ4
jCBcwVlMsSmihCzy2w5KTre5Wum5Yz/r2/yGSERBGGvaMvHKJnf8gJX/t5o3XaEH
3XoZRh18t1rRbuWc08k0TVt4u+BdK3Y5mjLNsmt50dLm0gsdquOFIw3qWQ//8Qg5
h/sWZKiLdLSSvPhcnL1EcoxBP+jdG3INtU90gYapZGYBJWbKpJ5IBJNnhBxQfSFL
hQTM/aODi92sQhOF5m4ToTxpHYACwc6laCQFuaKStrTqkVx4aSgojmH3yHQJ69u3
kzRR0td28+x0eRLfpdAx5hvpUWQH4s9KL3yA5A49bxUMDFYMYsYDS4GMznT1u2lc
QFiemxxYg/3RcmFU5xoyq4bDpvp5Z3/1kZwKalPGdLZfXD2DSQU+moTjlcCtTo+f
azZoeRj9kYxl/2PivZgtEgLlgaKql4gAiSUOTWmOluLbKM4QMXm/PcDpQPtmqa/+
lL/8/LnBn/aBDdP3RDEaiGEnZ+vXTTnDHdBZZTDefi1HCUlTLLISnzP3GtXRh1ja
t+eqB0hfvcU0XoPVG2W88gSSaY4KafVoCavM/CcMMYQjuBPwRDx+d5zWUjwkLDKl
iFEQQpfgpnkaC2E3eaFrz7mAH/OfjqrmrD+EZA+8C0+R65VmAsI1k69zwvpnqHOv
13HVUBBoInQO/h4TdzqB
=+GJh
-----END PGP SIGNATURE-----

--9sSKoi6Rw660DLir--
