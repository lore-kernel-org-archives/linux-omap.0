From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH RFC 4/9] ASoC: hdmi-codec: Add devicetree binding with
 documentation
Date: Wed, 20 Nov 2013 13:34:58 +0100
Message-ID: <20131120133458.3822a165@armhf>
References: <cover.1384862950.git.jsarha@ti.com>
	<829968f1a6b34176de8a04dd4ad473b2b37be783.1384862950.git.jsarha@ti.com>
	<20131120102342.7befe75e@armhf>
	<20131120100959.GV2674@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:50122 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752997Ab3KTMdG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Nov 2013 07:33:06 -0500
In-Reply-To: <20131120100959.GV2674@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jyri Sarha <jsarha@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com

On Wed, 20 Nov 2013 10:09:59 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Nov 20, 2013 at 10:23:42AM +0100, Jean-Francois Moine wrote:
>=20
> > But now, I am wondering again about these `empty`codecs:
> > - in a DT context, should we continue to add / modify such codecs?
> > - what do you think about my generic DT codec? (indeed, I would do =
a new
> >   version according to the previous remarks)
>=20
> We still want to be able to have users just name the CODEC on their
> board rather than have to type in all the details from the datasheet,
> if we're going to try to amalgamate the drivers it should still let
> people do that.

OK. But it seems to me that the codec is not tied to the board, but
rather to the audio connector / transmitter.

In the case of the tda998x HDMI transmitter, either i2s or s/pdif may
be used, thanks to the actual codecs 'hdmi' and 'spdif tx'. But they
don't work the same way: the 'hdmi' codec handles both playback and
record, and recording is disabled by program in the sound device,
while the 'spdif tx' codec is selected by the codec-dai-name
("dit-hifi" - it is "dir-hifi" for recording). It would be nice if
these codecs would have the same behaviour...

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
