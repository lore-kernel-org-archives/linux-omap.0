From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH early RFC 0/2] Implement ASoC HDMI codec library
Date: Fri, 15 May 2015 10:13:07 +0300
Message-ID: <55559C83.6080700@ti.com>
References: <cover.1431508524.git.jsarha@ti.com> <20150513194236.68a0d0a6@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56846 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbbEOHN3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2015 03:13:29 -0400
In-Reply-To: <20150513194236.68a0d0a6@armhf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, tomi.valkeinen@ti.com, rmk+kernel@arm.linux.org.uk

On 05/13/15 20:42, Jean-Francois Moine wrote:
> On Wed, 13 May 2015 12:23:45 +0300
> Jyri Sarha <jsarha@ti.com> wrote:
>
>> Jean-Francois, would you consider trying the generic ASoC patch with
>> your HW, as I can not test the spdif functionality with mine?
>
> Hi Jyri,
>
> I am not sure to need all the stuff you coded.
>

You do not need to use all of the stuff on the ASoC side. At minimum you 
could just implement hw_params() and audio_shutdown() for struct 
hdmi_codec_ops and just use the hw_params() parameters you need. With 
such and implementation the tda998x side would not look too different 
from what you are having now.

> My tda998x CODEC is quite empty and it works fine in my system.
> If you look at my last patch request ([PATCH v12 6/6] ASoC: tda998x:
> add a codec to the HDMI transmitter -

The idea for my lib is to work for all external HDMI encoders with i2s 
and/or spdif interface. And avoid the need to create a new HW specific 
ASoC module and API for each HDMI encoder.

> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-May/091758.html),
> the code is much smaller than yours and does not ask for a structure
> constraint (+/* Has to be the first member of the hdmi endcoder's
> drvdata */).
>

If that is generally considered annoying, I can get around it by adding 
a private_data member to struct snd_soc_dai (Mark, is that Ok?).

With the above change it is simply a matter of choice whether the 
library is actually a platform driver.

> So, I'd rather see a real hdmi codec library, i.e. a set of common
> functions as Russell's DRM ELD helper, each specific hdmi codec being
> free about the mechanism used for the exchanges with the hdmi
> transmitter.
>

Well, this is a real library and these are common functions for all HDMI 
encoder fitting the description. If we want to avoid each encoder from 
adding their own module to ASoC side and implementing their own API, we 
need something similar to what I wrote.

I am happy to do what ever changes are considered necessary, but I think 
I my idea in general is sound.

Of course another option would be just to implement the ASoC component 
within the video side driver and use the ASoC structures directly.

Best regards,
Jyri
