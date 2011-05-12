From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: beagleboardxm 2.6.39rc4 mcbsp problems.
Date: Thu, 12 May 2011 14:01:44 +0300
Message-ID: <201105121401.44607.peter.ujfalusi@ti.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com> <4DCB0042.8040202@gmail.com> <20110512092555.17ebf795.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32980 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738Ab1ELLBr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 May 2011 07:01:47 -0400
In-Reply-To: <20110512092555.17ebf795.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Steve Calfee <stevecalfee@gmail.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>

On Thursday 12 May 2011 09:25:55 Jarkko Nikula wrote:
> Of course for this you need to use omap as a master and codec as a
> slave. One example for this is sound/soc/omap/omap3pandora.c.
>=20
>  static struct omap_board_mux board_mux[] __initdata =3D {
> +	OMAP3_MUX(MCBSP1_FSX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(MCBSP1_CLKX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(MCBSP1_DR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(MCBSP1_DX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +

I think the CLKX, FSX need to be input, since the config suggests,t tha=
t=20
McBSP1 is the slave port:

> [ 1566.123962] omap-mcbsp omap-mcbsp.1: PCR0:  0x0f0f

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
