From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v3 4/5] ASoC: davinci: HDMI audio build for AM33XX and
 TDA998x
Date: Thu, 18 Sep 2014 21:36:21 +0300
Message-ID: <541B2625.2040600@ti.com>
References: <cover.1410898073.git.jsarha@ti.com>	<270f1e048d9a5a17a7f367ecabc509475b8c1145.1410898073.git.jsarha@ti.com>	<20140917194126.GV7960@sirena.org.uk>	<5419F965.9060209@ti.com> <20140918102544.26b28b6b@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38899 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932451AbaIRSgl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Sep 2014 14:36:41 -0400
In-Reply-To: <20140918102544.26b28b6b@armhf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, alsa-devel@alsa-project.org, tony@atomide.com, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, detheridge@ti.com, t-kristo@ti.com

On 09/18/2014 11:25 AM, Jean-Francois Moine wrote:
 > On Thu, 18 Sep 2014 00:13:09 +0300
 > Jyri Sarha <jsarha@ti.com> wrote:
 >
 >>> So, Jean-Francois is also trying to do things with the TDA998x - what's
 >>> the story with that, is this joined up at all?
 >>
 >> Not really. This basic functionality does not touch tda998x at all on
 >> the fly, but just sets i2s configuation in the beginning and bangs the
 >> bits trough McASP. But as long as the old platform data for tda998x
 >> still works after Jean-Francois' patches I should be safe.
 >
 > It should. And you may test it.
 >

I tested by BBB HDMI audio patches with "[PATCH v5] ASoC: tda998x: Add
a codec to the HDMI transmitter", and it works otherwise, but the
default for CTS_N_K has changed from 3 to 2. I just needed to change the
supported format from S32_LE to S24_LE to compensate the change.

 >> The problem with the Jean-Francois' patches is the DT support. The BBB
 >> HDMI video is implemented trough tilcdc-slave mechanism without a DT
 >> node for the tda encoder, which renders Jean-Francois' approach unusable
 >> for BBB.
 >
 > I used the TDA998x with DT support for a long time with a hack by using
 > parts of drm_i2c_encoder_init(). Now, I think that this function could
 > be used as it is just setting no platform_data in info.
 >
 >> The whole tilcdc slave approach may not be the most elegant way to use
 >> the tda driver, but it does not look like it is going to change any time
 >> soon.
 >
 > Right: I proposed a patch for that and it was rejected.
 >

The tilcdc is not actively maintained by anybody ATM and that is why
it is so hard to make any bigger changes to it. I hope we can change
this at some point, but for now I am just trying to get a simple HDMI
audio working on BBB with minimal changes.

 >> Best regards,
 >> Jyri
 >>
 >> ps. I have been thinking on something similar to Jean-Francois' patch
 >> for SiI9022 which I have been working on lately. Also I have been
 >> wondering if it would be possible to come up with a generic ASoC codec
 >> component driver or library that could be used with any HDMI encoder to
 >> produce the ASoC codec component. Unfortunately I am in too early stage
 >> to produce anything more concrete.
 >
 > Here are some thoughts about this topic.
 >
 > The video and audio worlds don't know about each other.
 > The only solution I found is to let the encoder create the codec as
 > a child device. Then, the codec knows from which encoder it depends.
 > This could have been done using Russell's components, but the codec
 > should have been declared in the DT. This is not useful.
 >

There is anothere option of putting the ASoC codec code into an ASoC
library module and registering the ASoC codec component under the HDMI
encoder device. However, this approach does not allow building the
ASoC as modules if the HDMI encoder driver is built in. So a separate
platform device for the codec component is probably better.

 > The codec interacts with the encoder in 2 ways:
 > - it uses the HDMI parameters retrieved by the encoder,
 > - it gives the audio source type to the encoder.
 > I used exported functions for that, but, for a generic codec, theses
 > functions could be given through the codec platform_data.
 >
 > The codec declares the DAI(s) prior to know the encoder. The DAI table
 > must be in the codec because of the snd_soc_dai_ops.
 > For a generic codec, this DAI table could be built dynamically from
 > information (name, id) also given through the codec platform_data.
 >

This is pretty much what I have been thinking too. The API between the
generic ASoC HDMI codec could use already existing the linux headers
derived HDMI standard. The ASoC side code should build the hdmi audio
infoframe and configure the stream header bits etc, so basically do
all the generic stuff coming from HDMI standard. Writing the bits
to the appropriate registers in the encoder chip would be left to the
HDMI encoder driver.

Best regards,
Jyri

