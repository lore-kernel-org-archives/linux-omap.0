From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v3 4/5] ASoC: davinci: HDMI audio build for AM33XX and
 TDA998x
Date: Thu, 18 Sep 2014 00:13:09 +0300
Message-ID: <5419F965.9060209@ti.com>
References: <cover.1410898073.git.jsarha@ti.com> <270f1e048d9a5a17a7f367ecabc509475b8c1145.1410898073.git.jsarha@ti.com> <20140917194126.GV7960@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51982 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756625AbaIQVNd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Sep 2014 17:13:33 -0400
In-Reply-To: <20140917194126.GV7960@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, alsa-devel@alsa-project.org, tony@atomide.com, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, detheridge@ti.com, t-kristo@ti.com, Jean-Francois Moine <moinejf@free.fr>

On 09/17/2014 10:41 PM, Mark Brown wrote:
> On Tue, Sep 16, 2014 at 11:40:17PM +0300, Jyri Sarha wrote:
>> Adds configuration option for HDMI audio support for AM33XX based
>> boards with NXP TDA998x HDMI transmitter. The audio is connected to
>> NXP TDA998x trough McASP running in i2s mode.
>
> So, Jean-Francois is also trying to do things with the TDA998x - what's
> the story with that, is this joined up at all?
>

Not really. This basic functionality does not touch tda998x at all on 
the fly, but just sets i2s configuation in the beginning and bangs the 
bits trough McASP. But as long as the old platform data for tda998x 
still works after Jean-Francois' patches I should be safe.

The problem with the Jean-Francois' patches is the DT support. The BBB 
HDMI video is implemented trough tilcdc-slave mechanism without a DT 
node for the tda encoder, which renders Jean-Francois' approach unusable 
for BBB.

The whole tilcdc slave approach may not be the most elegant way to use 
the tda driver, but it does not look like it is going to change any time 
soon.

Best regards,
Jyri

ps. I have been thinking on something similar to Jean-Francois' patch 
for SiI9022 which I have been working on lately. Also I have been 
wondering if it would be possible to come up with a generic ASoC codec 
component driver or library that could be used with any HDMI encoder to 
produce the ASoC codec component. Unfortunately I am in too early stage 
to produce anything more concrete.

