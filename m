From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] spi: spi-omap2-mcspi.c: Toggle CS after each word
Date: Sat, 26 Jan 2013 17:00:35 +0800
Message-ID: <20130126090033.GF30594@opensource.wolfsonmicro.com>
References: <1359031241-3234-1-git-send-email-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bqc0IY4JZZt50bUr"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58437 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752961Ab3AZJAn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 26 Jan 2013 04:00:43 -0500
Content-Disposition: inline
In-Reply-To: <1359031241-3234-1-git-send-email-matthias.bgg@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Daniel Mack <zonque@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, eballetbo@gmail.com, javier.martinez@collabora.co.uk, ezequiel.garcia@free-electrons.com, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org


--Bqc0IY4JZZt50bUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 24, 2013 at 01:40:41PM +0100, Matthias Brugger wrote:
> This patch allows the board code to define SPI devices which needs to
> toggle the chip select after every word send. This is needed to get a
> better resolution reading e.g. an ADC data stream.
> Apart from that, as in the normal code CS is controlled by software,
> a transfer is done much faster.

Applied, thanks.

--Bqc0IY4JZZt50bUr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRA5smAAoJELSic+t+oim9A2gQAJA/TfJCWmz7+Xh4jsBiHp1S
WGVKtAPSHoqf63wVSWOGKncJ0siw7G6sS06yVRyIbAbed5PFV7nQwozHtSkPjdkC
xmIqoBcXwv47/68O+AJ3EUJtqrmUpk1uGbPFmJQhEadWrJ1WMsoJk2L8i3vt/nat
6DIqCKkTFrkl8W2XBhtIrwrLirtvPvf0hyDimBJW4kp9zh+xw8QwCj0y8sQN4Zpj
fUoxkOwQtFfw1Cby4sInDkFCNjh4MZfbBh5dAPavs17wNMxJjbFhkGndi85EWP43
1DEZ6pO7fnhyn4AFMRVMa+6KTbXzCa00/qeKxhJTb7b4TahyQIwbU0PfsaCni5R4
wxfQB+V/Qkc7Gft96i22pUA5SCp1gNfC+gQqkH2LsjRBeQRTF2l95s5ZXcgCsngn
Gs7RuZvMEc0oudDfQ59QISR64nM968pWJwGamFSi8Ub/n15Yio8jHDNOTWot13i1
5up/pzcOOjvlb/7QJGzEYjIqttsr5xUIxrk4eCK085lP+QmPFRfwSf7DvCMWImEb
2AVgiIxAGCLGBBul4Eg8D75ugzjdcaglc0TV+v32IJwpRaVpNIoxa5JQJfrPkcOu
xuj2j1tF9f22JgwY1UclIbSVwjeBluESGi/fCXwLFBYFL+O86h7Pb9CAVXbfumrn
8KJYmcVgKOgl3PZ/LeYO
=a+ak
-----END PGP SIGNATURE-----

--Bqc0IY4JZZt50bUr--
