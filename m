From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 0/3] Add cyclic DMA support to OMAP DMA engine driver
Date: Wed, 27 Jun 2012 12:40:03 +0100
Message-ID: <20120627114003.GG308@opensource.wolfsonmicro.com>
References: <20120622085911.GA19026@n2100.arm.linux.org.uk>
 <20120622123013.GA7586@sirena.org.uk>
 <20120622131750.GB19226@n2100.arm.linux.org.uk>
 <20120622161155.GM4037@opensource.wolfsonmicro.com>
 <20120625111847.GE19226@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VACxsDaSTfeluoxK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:46940 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752048Ab2F0LkI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jun 2012 07:40:08 -0400
Content-Disposition: inline
In-Reply-To: <20120625111847.GE19226@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Liam Girdwood <lrg@ti.com>


--VACxsDaSTfeluoxK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 25, 2012 at 12:18:47PM +0100, Russell King - ARM Linux wrote:

> It appears to be something to do with the jack detection that's going wrong.
> If I start the audio with the jack disconnected, I never get anything out
> of the board.  It requires the jack to be connected before the first use.
> The on-board speakers used to work without the jack plugged in at one time
> but they seem to be completely non-functional now.

> Confused.

Me too - there's nothing obvious in the code just from inspection that
would affect this.

--VACxsDaSTfeluoxK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP6vD6AAoJEBus8iNuMP3dQbYP/0Q1MXL4FzqTLZ/f79c5YJFf
IPVNtMjk+xmoOheatD6rcamuveaIhEkxT+EBgdfod5Fuc/5jRFCdoZjtItJiZ4C3
NtonHFPFE4jYCIG/VU/C4uTNFkeRA3NJfY0IAKbyLDbxEDUVlm7/3QErsAECs/1S
BbA8MOxxXmdJmOvO36lPo1q3Scesm2mt1cWs4aRazvLxpUVHYwe+qVE/eBQBcL5Z
xVhKhjzV6/r4nvb3iN1IXBW6fWc6pBh2/8QGSO46gqp3Xu6t5U5zotKHhILZ9f7/
aqK2JW5yz5rSjRhCoW/o+zadVf5YSMnu9UJodGqMM7JDYH3iGGggznqN5cBg8U70
/bwEK+Fvlj/DAxQ7f+ZNiRiOEqFCtdriVeQOXcFv6yohwMHptEqeiZ3L/oiEmGqy
cubh8eEFxLNN1lJI9yItCYUwQV0tF4xMAWhEiCWtws2YFJ07Criv55hkS12+Afmk
aVmMDHlT8sVn7fzVuIjgnCI3DBg8BCXW2lgLUdL1pWbeNHILSN2KsncAlRhuWrz7
3OKmtw5n0SJZmAJLZzv1a2v7fdlIRFPb/i9v2X8NmC6lP23iVhHq8QDIwK2ZNMm5
KGaOZ9wG+FM9TAM4rla58gcjPoMprtIwWNF5ARXqp2V4+fcF53BCsg4V7rjdq5UB
GgKNmfOdOQVoU5M+7LtV
=mbnY
-----END PGP SIGNATURE-----

--VACxsDaSTfeluoxK--
