From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH 06/12] OMAPDSS: hdmi4: Register HDMI audio ASoC drivers
 from HDMI driver
Date: Fri, 27 Jun 2014 18:33:21 +0300
Message-ID: <53AD8EC1.6050302@ti.com>
References: <cover.1403807781.git.jsarha@ti.com> <f61b31d0b08c8a0b6ee295d5b0da62ead23983c9.1403807781.git.jsarha@ti.com> <53AD57F9.3030300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35261 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753367AbaF0Pdn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jun 2014 11:33:43 -0400
In-Reply-To: <53AD57F9.3030300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, jyri.sarha@iki.fi

On 06/27/2014 02:39 PM, Tomi Valkeinen wrote:
> On 26/06/14 22:20, Jyri Sarha wrote:
...
>> +#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
>> +	/* drvdata is only used by HDMI audio */
>> +	hdmi.audio.hdmi_lock = &hdmi.lock;
>> +	hdmi.audio.wp = &hdmi.wp;
>> +	hdmi.audio.core = &hdmi.core;
>> +	hdmi.audio.cfg = &hdmi.cfg;
>> +	hdmi.audio.hdmi_dai_drv = &omap_hdmi_dai;
>> +	hdmi.audio.audio_start = hdmi4_audio_start;
>> +	hdmi.audio.audio_stop = hdmi4_audio_stop;
>> +	hdmi.audio.audio_config = hdmi4_audio_config;
>> +	dev_set_drvdata(&pdev->dev, &hdmi.audio);
>> +	r = hdmi_audio_register(pdev);
>> +	if (r) {
>> +		DSSERR("Registering HDMI audio failed\n");
>> +		hdmi_uninit_output(pdev);
>> +		pm_runtime_disable(&pdev->dev);
>> +		return r;
>> +	}
>> +#endif
>
> I don't think it's a good idea to reserve the driver data for audio. We
> need to change the hdmi drivers sooner or later to support multiple
> instances, and at that point having drvdata for audio will cause problems.
>
> If you don't want to make the hdmi struct public yet, maybe just add a
> function to this file which takes a pointer to the hdmi struct and
> returns the audio part. That way you can set the whole hdmi struct as
> driver data, which should be future safe.
>

Adding a function is not as simple as that because the OMAP4 and OMAP5 
structs are subtly different and hdmi_audio.c is common to both. I'll 
make the minimal changes to make the struct public.

Cheers,
Jyri
