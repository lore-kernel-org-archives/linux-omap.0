From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [alsa-devel] [PATCH RFC v2 REPOST 3/8] ASoC: davinci-evm: HDMI
 audio support for TDA998x trough McASP I2S bus
Date: Wed, 15 Jan 2014 16:51:00 +0100
Message-ID: <20140115165100.3bfab96f@armhf>
References: <cover.1387535299.git.jsarha@ti.com>
 <d3c3f645d39338df0ee9686cb030255ce36a249d.1387535302.git.jsarha@ti.com>
 <20131231132555.GA31886@sirena.org.uk>
 <52D67099.1040904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:60081 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789AbaAOPvf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jan 2014 10:51:35 -0500
In-Reply-To: <52D67099.1040904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: Mark Brown <broonie@kernel.org>, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 15 Jan 2014 13:27:21 +0200
Jyri Sarha <jsarha@ti.com> wrote:

>  From driver/gpu/drm/i2c/tda998x_drv.c. The driver configures CTS_N=20
> register statically to a value that works only with 4 byte samples.=20
> According to my tests it is possible to support 3 and 2 byte samples =
too=20
> by changing the CTS_N register value, but I am not sure if the=20
> configuration can be changed on the fly. My data sheet of the nxp chi=
p=20
> is very vague about the register definitions, but I suppose the regis=
ter=20
> configures some clock divider on the chip. HDMI supports only upto 24=
bit=20
> audio and the data sheet states that any extraneous least significant=
=20
> bits are ignored.

In the tda998x driver, the CTS_N is automatic (AIP_CNTRL_0_ACR_MAN is
not set).

Then, in my Cubox (Marvell A510 + tda19988), the 16, 24 and 32 bits
formats are working well with I2S input at any rate.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
