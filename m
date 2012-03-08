From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 3/3] ASoC: omap-mcbsp: Single function CLKR/FSR source
 mux configuration
Date: Thu, 8 Mar 2012 10:59:21 +0000
Message-ID: <20120308105921.GB3638@opensource.wolfsonmicro.com>
References: <1331198537-13469-1-git-send-email-peter.ujfalusi@ti.com>
 <1331198537-13469-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34520 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752575Ab2CHK7X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 05:59:23 -0500
Content-Disposition: inline
In-Reply-To: <1331198537-13469-4-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 08, 2012 at 11:22:17AM +0200, Peter Ujfalusi wrote:
> Use single function for the CLKR/FSR mux configuration.
> OMAP2/3 has 6 pin configuration on McBSP1 instance, while on OMAP4
> McBSP4 instance have the 6 pin configuration so the omap2_mcbsp1_mux_* is
> not correct name for all support OMAP versions

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWJDzAAoJEBus8iNuMP3dAKUP+wdD8Oh3ZdHa36K5zNWeHA3o
Zuciy1r2STTG89TrxXf2SuCtfJv2Le0y8Fg590+YDv2OEzuqTWCBCp3F31D53gds
wQLSiEP1Ae4KLRCJStnU8mR2dCJzS8lOUQzXjn3Shv5gxEkPfABqyT1fkKqbjih/
lEZnTMRXcWfHvyQMvBbFv/5fkc6S+y8yQajni0HrfyqNOISHlU9wusFlr+rNnJfR
q4DwieEUArhThlbYMOHEHpjB27+WcGOrfkM3w3eIJ1HYCwDmX8ooyW6qXWqmEjCk
t0k/acN7d6U+Q72eCPV66KDR3QQwAaW+vN0mrJgwRESSHlO8eSCgzCY0lzJoK377
CVdNho0+3PeSDymF6VulnHEjzKxdDaNo2nsa7u+zsMpQokcl0eEZrcX5lAFzrRn0
VT7gveHQX620UvX5nxWb90MKBspfZ8qChNLRKUrS8X7jMR5MRC21w91rIjlxBR3H
th5T5v9PxJoFeaFN+r54bzNykCXm2Fvi4O5tWFY6ByAcHMxj/zlNp11l8VhAk+M6
sUfkqjTzt/A2vIhZbhHTcxBCpoTX1BnVbdZX5x83svsJiYjpkS8zqLlZGMjxPkDd
MKzR2whG33EorNlEEAkbODxf6GwWqBOn6B2vqh265hPyeoII+81YVnk3msJbqnei
wKx5JdQLZI5SayxaC8IL
=G/QS
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
