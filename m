From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] spi: spi-omap2-mcspi.c: Toggle CS after each word
Date: Thu, 24 Jan 2013 19:06:52 +0800
Message-ID: <20130124110648.GM4955@opensource.wolfsonmicro.com>
References: <1358964529-4905-1-git-send-email-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kc9HNjpzOXVc7FFU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:38744 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753258Ab3AXLG7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Jan 2013 06:06:59 -0500
Content-Disposition: inline
In-Reply-To: <1358964529-4905-1-git-send-email-matthias.bgg@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Daniel Mack <zonque@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, eballetbo@gmail.com, javier.martinez@collabora.co.uk, ezequiel.garcia@free-electrons.com, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org


--Kc9HNjpzOXVc7FFU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 23, 2013 at 07:08:49PM +0100, Matthias Brugger wrote:
> This patch allows the board code to define SPI devices which needs to
> toggle the chip select after every word send. This is needed to get a
> better resolution reading e.g. an ADC data stream.
> Apart from that, as in the normal code CS is controlled by software,
> a transfer is done much faster.

As Jarkko says the feature itself seems fine and the coding style fix
seems fine but they should really be separate changes.

--Kc9HNjpzOXVc7FFU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRARXCAAoJELSic+t+oim9mQMP/3TNpoX1+mwsN04TS00xepv/
AmEi8KYsDV2JgqUymmN52SHH5xhagkYu0Sym3c8kzxwrujRaIVm18i2lWGKyJ3OK
LQ/XvYiyNmRh/GTzkAlUH1jBnFa9tcHMwAEWRoEvx7wV6BD2P6wi9xAdnQAcY77C
GagThr1EQ/YHcUD6NApGKGzPQx42+U6Pq/OD+XNa/AskU07xSeOCuoQbcUn2nLWU
muHUr3PSjkV7utUqY5ZVnFVTqu1kOiAbC/S836OMrSaLhLBJQKZZuDTzVB/BqUl2
qQ4dcVLCB/sAldSj8pQIQmWF2sotjOjMJwUCPG6H+NBSvkR15TN4i0J85hXnloYE
06hhPVY9uiAtkxMiof9TYGK+DDWGYkuLToUQexMoFznYlTvjRk7LUG+M2giFCTVV
EubNzGZb6CTaXkeKDig4T2/HLgCuTTTtcPjGZBlDdyepuDAmOSmOvQnYqX2VrRPa
K/j4j8HyvvEKcVLnVcddJ1gGciLHo420FES6lTbXekfz9RkhCCzREK2ELf1Oyf6h
iUJewqyEhrQlnHZyweDk29tnOEQwjlgJZmYVYALzWGZGejW899N7OlbX3/cku63B
ZBIPJmgsVrF7Jx28YUKMNo7SsjXC9UZ3hEa+RDe/axiVmCskNARUFIUFxHWLg+0O
fBv2LFxc6e0SNeRPJwLA
=xmMK
-----END PGP SIGNATURE-----

--Kc9HNjpzOXVc7FFU--
