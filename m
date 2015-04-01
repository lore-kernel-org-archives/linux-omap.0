From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Index ruledata in drvdata with
 substream->stream
Date: Wed, 1 Apr 2015 21:34:22 +0100
Message-ID: <20150401203422.GI6023@sirena.org.uk>
References: <20150327062008.GA11983@mwanda>
 <1427449671-18014-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VkVuOCYP9O7H3CXI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:46434 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbbDAUe3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2015 16:34:29 -0400
Content-Disposition: inline
In-Reply-To: <1427449671-18014-1-git-send-email-jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, dan.carpenter@oracle.com


--VkVuOCYP9O7H3CXI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 27, 2015 at 11:47:51AM +0200, Jyri Sarha wrote:
> The serializer direction definitions runs from 1 to 2, which does not
> suite the purpose. The substream->stream is perfect for the purpose
> and should have been used from the beginning.

Applied, thanks.

--VkVuOCYP9O7H3CXI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVHFZNAAoJECTWi3JdVIfQwwoH/1OewVKBRhANTEbwGkAWoE7m
AI+RlXNhQWy1v5uWj7MszAj0MsXlgxUqlWnF1JjkOO7SjkRgF/+o675jOXvE9cZy
1/zIaXo/ET+kjqJ1Ljxf+Xx3Mqnukf4lNwwSPLxl58gni+/jPvLPa9Jk2A1ofO1d
GZ6X3evY//pICqdPdZX8PagwD06aEKdHjCU3o2sJB23LblKpw6MjLJUukyvjNuHj
KJfApnbitbz2JyniYDwHU/x6TkQ1Pw095VVrFHJqCzlRihJb57ZAiNkPE+OWkPmR
1lDduyhPrncs3qO+d04JYBDqHspaAjq+p6OqEzxoDRMeS1KB/+ewSom1VDLzQp8=
=st2x
-----END PGP SIGNATURE-----

--VkVuOCYP9O7H3CXI--
