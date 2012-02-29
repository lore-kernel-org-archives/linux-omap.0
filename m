From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 10/10] ASoC: omap-mcbsp: Simplify DMA configuration
Date: Wed, 29 Feb 2012 23:34:23 +0000
Message-ID: <20120229233422.GJ8295@opensource.wolfsonmicro.com>
References: <1330414820-4641-1-git-send-email-peter.ujfalusi@ti.com>
 <1330414820-4641-11-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cDtQGJ/EJIRf/Cpq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:36173 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964989Ab2B2Xe0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 18:34:26 -0500
Content-Disposition: inline
In-Reply-To: <1330414820-4641-11-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Grazvydas Ignotas <notasas@gmail.com>


--cDtQGJ/EJIRf/Cpq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 28, 2012 at 09:40:20AM +0200, Peter Ujfalusi wrote:
> Configure the DMA request line, port address, and stream name at
> probe time instead of every time we start a stream.
> These settings are static in the system.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--cDtQGJ/EJIRf/Cpq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPTrX4AAoJEBus8iNuMP3dTBMP/0xX4gU45j+DSrkUQ2x7fqcW
pADIbYJCZr9RcyFyVRxCCY8umYmELTdWiLWJRXoyif1pwOfh9Pm0ldoC2cLAyxNl
VTdyCb5XmcdtCoycpxjmMB3VD/ARB6PDACGYEOlXxQjpEuTmHO8dJ1D2uu2f8tWT
mbltbQQVcXhzPWjqMOe5LCQbNj7cc49vRvBwZfWqSIqIKO23mlLkic+baz7K0ca4
lnddux6WOSjgD4I2Hl7a4WQbqwsHvmeNzlgWeUWmo46QPy9nP8sZb5K6qWd23sTJ
lIvReVAIWS8B0N3IqAnOImQaNhak2TPMarerjioHDkP5QGeAVA1s257DbryqcRLD
EVZ2C1WkAqYWv9dHWXHPCmQMwe/Z2/qV9YqLPOMaPTegdWw/FbtlNCMSDt/5AUL/
kh+c0OHK6MJ6t3FJtF5sOU1gKhtNZXKfC5NhkD1Ft7t8aRJ6FvKJvuZzVDyEUsSI
8F1lfV9XlTVdf7xL6ZHWsErU0FQDg0t1tuDchZEhfz4Q54vKmZiTSxlZwPj2pFz+
nncb4GjxXhFbYvucuVivQT71CekSY17021/WZWUXSivVma9K5YZmyEnHU7xovdf/
YsI6eMzBvUQjrocy0JkL9HWmBOio+pSpFAVxW9O49BWKro49jtZpIW/3vYaQemD1
/Un5zlLaqbPEQnKnV/xZ
=+NV5
-----END PGP SIGNATURE-----

--cDtQGJ/EJIRf/Cpq--
