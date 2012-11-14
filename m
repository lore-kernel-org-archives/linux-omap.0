From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: OMAP: HDMI: Obtain DMA port from resources
Date: Wed, 14 Nov 2012 12:27:14 +0900
Message-ID: <20121114032712.GQ4415@opensource.wolfsonmicro.com>
References: <1352860249-26348-1-git-send-email-ricardo.neri@ti.com>
 <1352860249-26348-4-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GTGEtWEe6jD60dxL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:45707 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754691Ab2KND1V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Nov 2012 22:27:21 -0500
Content-Disposition: inline
In-Reply-To: <1352860249-26348-4-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: lrg@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org


--GTGEtWEe6jD60dxL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 13, 2012 at 08:30:49PM -0600, Ricardo Neri wrote:
> Instead of defining the address offset of the DMA port for transfers of
> audio samples, obtain this information from the resources of the device.
> This device and its resources are created by the OMAPDSS HDMI driver.

Presumably this needs some other corresponding change in the resource
setup to go in simultaneously...

> -	hdmi_data->dma_params.port_addr =  hdmi_rsrc->start
> -		+ OMAP_HDMI_AUDIO_DMA_PORT;
> +	hdmi_data->dma_params.port_addr =  hdmi_rsrc->start;

...both before and after versions use the resource.

--GTGEtWEe6jD60dxL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQow+JAAoJELSic+t+oim9sFQP+wSVqUY/3jR+DbYdycXueIZz
utnT5UKWZRKWwb6HvRKF5u01vY/PBFsZwIGfhqdwFG8SLe/V5SVzqfalBA0tZeMY
YYn8fr698dYLpEhIcnTW6m4Mqdl74VLe8nKJoc3wC3LGwXu8uy6Sq+8lSHPSgdcZ
F1Oxe5o+Ui2ckuZhb1GaIWTLF4xfFN7GdzBe0BghYjN8k7sL5iPOohuG3tDQRs2M
SH258oOLTz9InY8VvpMzSdaetjcGk2rkcXDBd65hHQ6crxcchvt4YyhmmdYvGTTt
hEBXJ7G6mo+dSZem3wQSLDPyP7aRgo7uYcKayiZRlN3DRnSSUy0ln4f1Rtw2hseq
BlHHf2AUHYp7uNJm6Jodfqx5hImBXjoQa5oZCOIxulEhvApj83HafL45BoPmTiAw
R+gqAa4Tq1lfBcJRMPUFULOE80jFmOHbJWItRZU7+tzhvuTTH+zkuMMxEaK8DkBc
1keu5a0JBbU564nwmiAC/m+Zuj/Ajy4Naw4QDdlgDVm3AHa1+2f77B/QFNIEbQRO
C3tQeEAAcU9eDnT0Duz9pLA5Pb+I9YSAP9svwKmMIpV9Q4C9GikE1tLIQNuYQ+6f
ibTxB+AyghcSH+3/h1sGXNV//46+Myq/xJ/eNy6hTgkR/bgHLoxkbS4idW3LrELw
A4okke6KtBOqmYyiv/Q0
=ddQz
-----END PGP SIGNATURE-----

--GTGEtWEe6jD60dxL--
