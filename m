From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH RFC 4/9] ASoC: hdmi-codec: Add devicetree binding with
 documentation
Date: Wed, 20 Nov 2013 10:23:42 +0100
Message-ID: <20131120102342.7befe75e@armhf>
References: <cover.1384862950.git.jsarha@ti.com>
	<829968f1a6b34176de8a04dd4ad473b2b37be783.1384862950.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:51780 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834Ab3KTJVu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Nov 2013 04:21:50 -0500
In-Reply-To: <829968f1a6b34176de8a04dd4ad473b2b37be783.1384862950.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com, broonie@kernel.org

On Tue, 19 Nov 2013 14:12:24 +0200
Jyri Sarha <jsarha@ti.com> wrote:

> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  Documentation/devicetree/bindings/sound/hdmi.txt |   17 ++++++++++++=
+++++
>  sound/soc/codecs/hdmi.c                          |   10 ++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/hdmi.txt
	[snip]

A couple of months ago, I proposed a 'generic DT based simple
codec' (http://www.spinics.net/lists/arm-kernel/msg274322.html) which
was supposed to replace all of the `empty` codecs in a DT context.
These codecs do nothing except defining some audio parameters.
They are mainly spdif tx/rx, hdmi, bt-sco, dmic, wm8727 and wm8782.

This generic codec would have been used for the tda998x which is the
HDMI transmitter of the Cubox. But, as its utility was not clear yet,
I switched to the 'spdif transmitter' codec which has DT support. This
last codec works fine without change, with either i2s or spdif input in
the tda998x. It is well suited to the Cubox because the Marvell Armada
510 audio subsystem does not support sound recording (nor does the
tda998x while the 'hdmi' code provides recording), and also because it
supports a wider range of rates than the 'hdmi'codec (I have no problem
with 22.05kHz audio).

But now, I am wondering again about these `empty`codecs:
- in a DT context, should we continue to add / modify such codecs?
- what do you think about my generic DT codec? (indeed, I would do a ne=
w
  version according to the previous remarks)

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
