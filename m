From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH v3 4/5] ASoC: davinci: HDMI audio build for AM33XX and
 TDA998x
Date: Thu, 18 Sep 2014 10:25:44 +0200
Message-ID: <20140918102544.26b28b6b@armhf>
References: <cover.1410898073.git.jsarha@ti.com>
	<270f1e048d9a5a17a7f367ecabc509475b8c1145.1410898073.git.jsarha@ti.com>
	<20140917194126.GV7960@sirena.org.uk>
	<5419F965.9060209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:50820 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200AbaIRIXb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2014 04:23:31 -0400
In-Reply-To: <5419F965.9060209@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, alsa-devel@alsa-project.org, tony@atomide.com, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, detheridge@ti.com, t-kristo@ti.com

On Thu, 18 Sep 2014 00:13:09 +0300
Jyri Sarha <jsarha@ti.com> wrote:

> > So, Jean-Francois is also trying to do things with the TDA998x - wh=
at's
> > the story with that, is this joined up at all?
>=20
> Not really. This basic functionality does not touch tda998x at all on=
=20
> the fly, but just sets i2s configuation in the beginning and bangs th=
e=20
> bits trough McASP. But as long as the old platform data for tda998x=20
> still works after Jean-Francois' patches I should be safe.

It should. And you may test it.

> The problem with the Jean-Francois' patches is the DT support. The BB=
B=20
> HDMI video is implemented trough tilcdc-slave mechanism without a DT=20
> node for the tda encoder, which renders Jean-Francois' approach unusa=
ble=20
> for BBB.

I used the TDA998x with DT support for a long time with a hack by using
parts of drm_i2c_encoder_init(). Now, I think that this function could
be used as it is just setting no platform_data in info.

> The whole tilcdc slave approach may not be the most elegant way to us=
e=20
> the tda driver, but it does not look like it is going to change any t=
ime=20
> soon.

Right: I proposed a patch for that and it was rejected.

> Best regards,
> Jyri
>=20
> ps. I have been thinking on something similar to Jean-Francois' patch=
=20
> for SiI9022 which I have been working on lately. Also I have been=20
> wondering if it would be possible to come up with a generic ASoC code=
c=20
> component driver or library that could be used with any HDMI encoder =
to=20
> produce the ASoC codec component. Unfortunately I am in too early sta=
ge=20
> to produce anything more concrete.

Here are some thoughts about this topic.

The video and audio worlds don't know about each other.
The only solution I found is to let the encoder create the codec as
a child device. Then, the codec knows from which encoder it depends.
This could have been done using Russell's components, but the codec
should have been declared in the DT. This is not useful.

The codec interacts with the encoder in 2 ways:
- it uses the HDMI parameters retrieved by the encoder,
- it gives the audio source type to the encoder.
I used exported functions for that, but, for a generic codec, theses
functions could be given through the codec platform_data.

The codec declares the DAI(s) prior to know the encoder. The DAI table
must be in the codec because of the snd_soc_dai_ops.
=46or a generic codec, this DAI table could be built dynamically from
information (name, id) also given through the codec platform_data.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
