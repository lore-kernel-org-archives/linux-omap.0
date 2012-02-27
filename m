From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2] regulator: twl6030: add support for vdd1, vdd2 and
 vdd3 regulators
Date: Mon, 27 Feb 2012 13:54:25 +0000
Message-ID: <20120227135425.GE3191@opensource.wolfsonmicro.com>
References: <1330096902-20933-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:57386 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753135Ab2B0Ny2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Feb 2012 08:54:28 -0500
Content-Disposition: inline
In-Reply-To: <1330096902-20933-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 24, 2012 at 05:21:42PM +0200, Tero Kristo wrote:
> vdd1 and vdd2 are now common regulators for twl4030 and twl6030. Also
> added vdd3 as a new regulator for twl6030. twl6030 vdd1...vdd3 smps
> regulator voltages can only be controlled through the smartreflex
> voltage channel, thus the support for the voltage_get and set is
> minimal and requires external controller.

Please coordinate with Rajendra and Peter to produce a unified set of
updates for this driver.  There's too many people sending overlapping
patches here.

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPS4sKAAoJEBus8iNuMP3dLeYQAJlCjgeqsuJ3EalRuBZrCGxh
bAKWJtRYcmJ5X7wSCDY+/2KtBhwtv4U+gTHrvJ4fUDyGRuj9YI7TFqa2KelHDOjq
SDqvRaktzLCMPqu4tBAnHipf5FwjRab6AXLIFC3F5EGk7fEZfM+te/F5cJxWvd06
tmNv+xigBFobEEmUXPuO4YHHb6e8uSncfeRn4vbq9YAPgVQdm4uOyQnBIqZ0hKX5
dDVZitKAyp4Dx/hJ//EMSThlQZuwVNgvoR1owxlLkJjfaG3UqxRaknYJCkIo4HPF
m6utopyVwRdao+aq6E1Xa5+opZZlI2UN5RByAyvd7w5wySMgy53XhO43xWL7QzQm
wd0o6kFQvu0L5rxb0SZJWObVeIq4778yoG2fk5ez036yKJxoMtXZ/i3/D0n7O03k
OIAZizfaKsqlkSbDga+YSR2XqWlNPkfKzS3dl4biBABJfItQUsQ1K+GARrUvV2n8
xXpaGbm5l0/uwKeww0kh+3nIDj4GJY9nIPCKR6jYy0/Gx/7MeFRAPl2/+74rmTR0
WTKmPRt2fMVc5P8FjmdqcgDNhI7Laft5rxYfu40EZEIDN9CHUekxmy9+Xx7n3kn4
orpbgoYf19LV2lMdKi0zkJ7TvOrQgcy3Pp0nlk0c4rMboODgIsXTM8RblGxW21kV
9YmmioY2kE25TQAzQt7y
=wraB
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--
