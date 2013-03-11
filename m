From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: OMAP: zoom: Use pwm stack for lcd and keyboard backlight
Date: Mon, 11 Mar 2013 14:12:03 +0200
Message-ID: <513DCA13.40705@ti.com>
References: <1363003076-17360-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9298E65CE42147E1CDA91344"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39631 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751Ab3CKMMK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 08:12:10 -0400
In-Reply-To: <1363003076-17360-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--------------enig9298E65CE42147E1CDA91344
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-11 13:57, Peter Ujfalusi wrote:
> Use pwm_leds driver for the keyboard light and pwm-backlight for the lc=
d
> backlight control (instead of implementing the PWM driver part in the b=
oard
> file).
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/mach-omap2/board-zoom-display.c     | 56 --------------------=
--------
>  arch/arm/mach-omap2/board-zoom-peripherals.c | 53 ++++++++++++++++++++=
+++++-
>  2 files changed, 52 insertions(+), 57 deletions(-)

I can't test this, but looks fine to me. Good to get rid of the hacky
backlight code in board-zoom-display.c.

 Tomi



--------------enig9298E65CE42147E1CDA91344
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRPcoTAAoJEPo9qoy8lh71RSIQAKwJsHR629T1Qv54qVf0Xdx5
j0jgLgXVkDeZzbP8la8KmxZnRMZKdrE2EplcCdpNr4Ios8Yul6dgCqRTu1XHwxVb
XmiGhxpf9krlVaZT5fzNVyJ96Vsn8BNMFReG82res24t3gbboGrDT/C7s4HCBpU+
9HcLeHBlhoHQzU/EH/Ji4EKdYagREL/nEI0UHBDzHqda4AQ6NylSvWcfe8lyT4I+
eR1HgVPcO3162v/0I88ldkT7IVf8aYfilGuQgjUrcGp3WZB/FmWfrYfADhJC9eQR
+URIdF6NyQ7jyv864LRvAQpu8cYu7WLCOpLR7FUwn/QDON3gh6n5nLbk+rRfE4Gc
FEbDPc1LUs/pOwWXC0MGEpsyAxdBxXN8KY1VINuf0XKT453rOcmgKeR344pb9YFF
9j8Fh0SdqWdGsbVimODhieFLs5wgKB/3b/SiBavi/A/DJYsnK8qLd5zn33jEvaX1
bFKf4dFABGcdt/oE7ZstJpFW7NPTtpRHDMN1KrgFuaCIWu+Cpo5aN3lKYM/zm72M
pgqIM+exewnBfDFW/QIzBPvJUVe7CVVgrxj4JgYVY79xJTA2OvrFoyKLqoSmQj/o
UaccsKTbBOANCXT/qJ/XzkSLBzLZrNqMsrgvd/Bn3smC8ust9Fj69kAmLA/4pybu
8GzzKhYiCC4QpB0cEpgv
=0P9T
-----END PGP SIGNATURE-----

--------------enig9298E65CE42147E1CDA91344--
