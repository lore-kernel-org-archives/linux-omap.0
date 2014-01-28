From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [alsa-devel] [PATCH RFC v3 0/8] Beaglebone-Black HDMI audio
Date: Tue, 28 Jan 2014 10:23:53 +0100
Message-ID: <20140128102353.48e8fb51@armhf>
References: <y>
	<cover.1390836773.git.jsarha@ti.com>
	<52E6806A.2090109@metafoo.de>
	<52E686B2.9060806@ti.com>
	<20140127190641.273890c6@armhf>
	<52E6B42F.4050901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:35774 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754635AbaA1JX5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jan 2014 04:23:57 -0500
In-Reply-To: <52E6B42F.4050901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Lars-Peter Clausen <lars@metafoo.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, broonie@kernel.org, peter.ujfalusi@ti.com, detheridge@ti.com

On Mon, 27 Jan 2014 21:31:59 +0200
Jyri Sarha <jsarha@ti.com> wrote:

> I would suggest to leave the CTS_N_K to the current setting (3), unle=
ss=20
> we can change the CTS_N_K on the fly according to the used sample for=
mat.

Yes, this is possible:

- the tda998x codec may call the tda998x hdmi in the hw_params()
  function, i.e. when the sample format is known, and then,

- the tda998x_audio_update() function may have the audio parameters
  (struct snd_pcm_hw_params) as an argument, and CTS_N_K may be set
  to either 1, 2 or 3 for SNDRV_PCM_FORMAT_S16_LE / S24_LE and S32_LE.

This is working in my machine. Would it also work for you?

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
