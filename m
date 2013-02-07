From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/2] ARM: dts: Add DT bindings for OMAP SDMA
Date: Thu, 7 Feb 2013 10:39:46 +0200
Message-ID: <20130207083946.GB15462@arwen.pp.htv.fi>
References: <1360184596-1603-1-git-send-email-jon-hunter@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57330 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590Ab3BGIkF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Feb 2013 03:40:05 -0500
Content-Disposition: inline
In-Reply-To: <1360184596-1603-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Vinod Koul <vinod.koul@intel.com>, Russell King <linux@arm.linux.org.uk>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Matt Porter <mporter@ti.com>, Felipe Balbi <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Balaji T K <balajitk@ti.com>

--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2013 at 03:03:14PM -0600, Jon Hunter wrote:
> Adds device-tree bindings from SDMA on OMAP2+ devices. DMA client
> bindings are also added for devices that have SPI and MMC bindings
> populated. Client binding data is based upon existing HWMOD data for
> OMAP and has been checked against OMAP documentation.
>=20
> Testing includes ...
> 1. Boot tested on OMAP3430 Beagle board, OMAP4430 Panda board and
>    OMAP4460 Panda board with and without device-tree present.
> 2. Testing of MMC1 with SD card on OMAP3430 Beagle board, OMAP4430
>    Panda board and OMAP4460 Panda board with and without device-tree
>    present.

looks alright to me:

Reviewed-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRE2hSAAoJEIaOsuA1yqRE5l4P/270iwZl3A+j1gTlOAD/1OC8
7DoCio7lJTmZM4L76zWyzTYFn5Vn0akDWSdFhXD7fQZf9zhoQsqAcdqwEXRoOwBT
+ouONpCKtPYAplLIupE1aXkCsBAsV0AlybTEa/OotRPtQOAvzOavHpQF8C1KWOHS
6ATzcWNlgDaUaDNgwVAD4+V1bs3Zdke5sret6AFLJlBgPXrQvKERNJ4edA9aXyFa
pij6yOGttWVHXZDMSUgmyb2+gmbf24en35vNm66hpT3sVilZ9CpTH0d7JL43j1q0
SBPRCeuReXPisaozy3chao6L6Gv6cozbCLsIIXCbbVcZaT7dVWndWrAqNwb6GwHk
VxxQZ619g2KgMw/X6lvawO8j9eEd8L4Uj7YEviPap/tlNgwMxGjduNQP3h2oam0C
uFgXrLpS6pjcatbAMAl3wDhAtu+ubSgyD+5BRfL44w/+dp/M0emdJ42S2hF23nO4
aO0+50lWF42tWJ4zxj3K7Y03ZN9spumNWlVkrpF8jJSVbsq8fGeAQ1c6dTXKWZoV
WOcX0yqu4lBuWVRzQQ1Pl8DZTh1R7GV/T4Eeg+hGom/r74CBbmbLUE/GjJGCacJF
VBCDQrX607c7EObCIGYaQFBZNF3otDkh/0aopNyGN+DU4ur8QoKtBwy4OT3bIi6G
bdga2RX3mJhJflB1utXH
=NEuJ
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
