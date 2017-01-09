From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900 headset detection & MIC Bias + TVOUT
Date: Mon, 9 Jan 2017 14:13:17 +0100
Message-ID: <20170109131317.GD26301@pali>
References: <201701070007.49137@pali>
 <20170109112749.6gmtytxuqzfai57e@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170109112749.6gmtytxuqzfai57e@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, joerg Reisenweber <joerg@openmoko.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Monday 09 January 2017 11:27:49 Mark Brown wrote:
> On Sat, Jan 07, 2017 at 12:07:49AM +0100, Pali Rohár wrote:
> 
> > All that is needed in N900 sound driver, file sound/soc/omap/rx51.c. Can 
> > you help me which functions should I call to enable/disable it 
> > correctly? In headset detection code I need to be sure that nobody 
> > (other kernel drivers or userspace via alsamixer) except current 
> > function could change Bias settings.
> 
> > MIC Bias is controlled by MICBIAS_CTRL in aic34 'B' part codec, file 
> > tlv320aic3x.c.
> 
> Microphone biases are normally controlled by supply widgets and managed
> via DAPM.  You can see quite a few examples of this in existing drivers.

So... can I call snd_soc_dapm_mutex_lock(dapm) at function startup,
start doing cable detection and when needed call this?

snd_soc_dapm_enable_pin_unlocked(dapm, "HS Mic");
snd_soc_dapm_sync_unlocked(dapm);

And at the end of function revert back "HS Mic" pin status and call
snd_soc_dapm_mutex_unlock(dapm)?

-- 
Pali Rohár
pali.rohar@gmail.com
