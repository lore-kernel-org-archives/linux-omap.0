From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v3 00/14] Rework OMAP4+ HDMI audio support
Date: Wed, 13 Aug 2014 15:51:54 +0300
Message-ID: <53EB5F6A.9060308@ti.com>
References: <cover.1407503813.git.jsarha@ti.com> <20140813110425.GL17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38507 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751AbaHMMwE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Aug 2014 08:52:04 -0400
In-Reply-To: <20140813110425.GL17528@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com

On 08/13/2014 02:04 PM, Mark Brown wrote:
> On Fri, Aug 08, 2014 at 04:23:41PM +0300, Jyri Sarha wrote:
>> Question to ASoC maintainers:
>>    Do feel it is Ok to put ASoC code outside sound/soc the way I do
>>    in these patches (in patch 0006 particularly)?
>
> I'm not thrilled about the idea, it's going to result in breakage during
> API updates and more cross tree coordination needs.
>

I guess then the least bad alternative would be cutting the cpu-dai 
driver away from drivers/video/fbdev/omap2/dss/hdmi_audio.c and placing 
it under sound/soc/omap and registering it from hdmi_audio.c the same 
way as hdmi-audio-codec and asoc-simple-card is now registered.

There would be two devices for a single ip, but at least the ASoC side 
driver would receive its resources directly from the HDMI video driver 
with necessary tools to synchronize the access.

This approach would work for other HDMI audio situation too, where there 
would usually (for tda998x and SiI9022 at least) be a need to register 
an i2s codec driver associated with the HDMI encoder. It would probably 
be possible to make a single codec driver to work with multiple HDMI 
encoders if the API between the codec and endcoder drivers is designed 
that in mind.

How does this sound?

Best regards,
Jyri
