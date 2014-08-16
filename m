From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 5/7] net: cpsw: Add am33xx MACID readout
Date: Sat, 16 Aug 2014 11:46:48 -0500
Message-ID: <20140816164647.GA2858@katana>
References: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
 <1408202315-20006-6-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34833 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686AbaHPQrJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 16 Aug 2014 12:47:09 -0400
Content-Disposition: inline
In-Reply-To: <1408202315-20006-6-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Steven Rostedt <rostedt@goodmis.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
> index 9cfaab8152be..5a31c2b322ee 100644
> --- a/drivers/net/ethernet/ti/Makefile
> +++ b/drivers/net/ethernet/ti/Makefile
> @@ -8,5 +8,6 @@ obj-$(CONFIG_TI_DAVINCI_EMAC) += davinci_emac.o
>  obj-$(CONFIG_TI_DAVINCI_MDIO) += davinci_mdio.o
>  obj-$(CONFIG_TI_DAVINCI_CPDMA) += davinci_cpdma.o
>  obj-$(CONFIG_TI_CPSW_PHY_SEL) += cpsw-phy-sel.o
> +obj-$(CONFIG_TI_CPSW_CTRL_MACID) += cpsw-ctrl-macid.o
>  obj-$(CONFIG_TI_CPSW) += ti_cpsw.o
>  ti_cpsw-y := cpsw_ale.o cpsw.o cpts.o

Leftover from your last series?


--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT74r3AAoJEBQN5MwUoCm2dBAQAIib9q2jmNSLalkIkYywNe+O
7qcKAtCVZ1u+idRL8UQ2gj/jNFu2Dx7Am7SRw2jXf7c27q77tIa9C9V4qV2wZ+BL
yc8Qm8I6/4pzN1bbaK5Lmyw5xMIocqE7PcjsVjB/TXEgaw/NuVU2bzB2QpIHsqUB
tdGLdALA2/f4Uz8gyj+/lRLcuEw23d9icTRIImcU+MMLGfWKxnUP9BnGGkvJEEtF
Y9mJLOn9ErZ98n98ThZmV+8U0FhYHcsiz2Nz1Yk8hwvBifEz1MJ2UU1CnSArTfxe
f3Dc661hrW8KTWCV2cnm01wbHDN4H+MWhhO1qIfDICwszE8UQyIKtfMq+Sy4jX4g
KKa6id0yj0B3Bkfq8TfdJFom1zkukUAAWFXLqJ3NSTetcGGDr1tKgkUIrfnfOClk
j9HcOMiTyPaUhGUVWHisWb/c5PIm9OmZMBoWwEWcoeK9B+rGc5GCyvhY3SvBlKYw
SUL0bI/GOQo/hlXqzDbmBqtYfocgAUfh3HUQ3I/VYhxntCiT9N1mnRjLyM5trJOp
f028/+NrzBLZkeuR71lwI22fIuwjlspVn/PWnjFR87N4VBfDI0r7alOdP/Ka1x88
2zQQmLTCtw0tP1eFTFxh2KaEuOJp0II3B5/L9n5e7j3E3ho+jGHphsxEmR/rRerO
30x/hyOsVcFWukrb1BBG
=Gloq
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
