From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [alsa-devel] [PATCH RFC v2 REPOST 3/8] ASoC: davinci-evm: HDMI
 audio support for TDA998x trough McASP I2S bus
Date: Wed, 22 Jan 2014 11:46:47 +0100
Message-ID: <20140122114647.20f75d0d@armhf>
References: <cover.1387535299.git.jsarha@ti.com>
	<d3c3f645d39338df0ee9686cb030255ce36a249d.1387535302.git.jsarha@ti.com>
	<20131231132555.GA31886@sirena.org.uk>
	<52D67099.1040904@ti.com>
	<20140115165100.3bfab96f@armhf>
	<52DF8D60.9020505@ti.com>
	<20140122111953.238349a5@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:55768 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754571AbaAVKrG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jan 2014 05:47:06 -0500
In-Reply-To: <20140122111953.238349a5@armhf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Jyri Sarha <jsarha@ti.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 22 Jan 2014 11:19:53 +0100
Jean-Francois Moine <moinejf@free.fr> wrote:

> As both I2S and S/PDIF may be used for HDMI output in the Cubox,
> I wrote a tda998x CODEC which gets the audio ports from the DT and
> dynamically sets these ports and the audio type (i2s / spdif) on audi=
o
> streaming start. I have not submitted yet this codec and the associat=
ed
> changes in tda998x, because I am waiting for a first patch series on =
the
> tda998x to be applied
> (http://lists.freedesktop.org/archives/dri-devel/2014-January/051552.=
html).

Sorry, the last patch request is

http://lists.freedesktop.org/archives/dri-devel/2014-January/052201.htm=
l

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
