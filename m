From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v3 00/14] Rework OMAP4+ HDMI audio support
Date: Thu, 14 Aug 2014 12:28:07 +0300
Message-ID: <53EC8127.7090405@ti.com>
References: <cover.1407503813.git.jsarha@ti.com> <20140813110425.GL17528@sirena.org.uk> <53EB5F6A.9060308@ti.com> <20140813172632.GE17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49432 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751861AbaHNJ2Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Aug 2014 05:28:16 -0400
In-Reply-To: <20140813172632.GE17528@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com

On 08/13/2014 08:26 PM, Mark Brown wrote:
> On Wed, Aug 13, 2014 at 03:51:54PM +0300, Jyri Sarha wrote:
>
>> I guess then the least bad alternative would be cutting the cpu-dai driver
>> away from drivers/video/fbdev/omap2/dss/hdmi_audio.c and placing it under
>> sound/soc/omap and registering it from hdmi_audio.c the same way as
>> hdmi-audio-codec and asoc-simple-card is now registered.
>
>> There would be two devices for a single ip, but at least the ASoC side
>> driver would receive its resources directly from the HDMI video driver with
>> necessary tools to synchronize the access.
>
> Just a MFD really.
>
>> This approach would work for other HDMI audio situation too, where there
>> would usually (for tda998x and SiI9022 at least) be a need to register an
>> i2s codec driver associated with the HDMI encoder. It would probably be
>> possible to make a single codec driver to work with multiple HDMI encoders
>> if the API between the codec and endcoder drivers is designed that in mind.
>
>> How does this sound?
>
> This sounds like a way forward, I definitely think it's a good idea to
> standardise the interfaces as much as we can.
>

After discussing with Peter and Tomi I decided to change the approach a 
bit. There should not be any new device registered, just ASoC components 
that are implemented under sound/soc as a library rather than a device 
driver.

The library would export a register and unregister functions to be 
called from video driver directory. The functions will then register the 
necessary ASoC components under the video device.

If there are no objections I'll go ahead implementing this approach, 
first for OMAP HDMI audio, and later for SiI9022 driver we are cooking.

Best regards,
Jyri
