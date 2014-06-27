From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH 04/12] OMAPDSS: hdmi_audio: Integrated ASoC DAI component
 driver implementation
Date: Fri, 27 Jun 2014 15:06:34 +0300
Message-ID: <53AD5E4A.4030305@ti.com>
References: <cover.1403807781.git.jsarha@ti.com> <69f5b1481bd8b8a005b5d9142626f3529a0d71c7.1403807781.git.jsarha@ti.com> <53AD5C28.6000009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57120 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752845AbaF0MGu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jun 2014 08:06:50 -0400
In-Reply-To: <53AD5C28.6000009@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, jyri.sarha@iki.fi

On 06/27/2014 02:57 PM, Tomi Valkeinen wrote:
> On 26/06/14 22:20, Jyri Sarha wrote:
...
>> --- a/drivers/video/fbdev/omap2/dss/Makefile
>> +++ b/drivers/video/fbdev/omap2/dss/Makefile
>> @@ -14,5 +14,7 @@ omapdss-$(CONFIG_OMAP2_DSS_DSI) += dsi.o
>>   omapdss-$(CONFIG_OMAP2_DSS_HDMI_COMMON) += hdmi_common.o hdmi_wp.o hdmi_pll.o \
>>   	hdmi_phy.o
>>   omapdss-$(CONFIG_OMAP4_DSS_HDMI) += hdmi4.o hdmi4_core.o
>> +omapdss-$(CONFIG_OMAP4_DSS_HDMI_AUDIO) += hdmi_audio.o
>>   omapdss-$(CONFIG_OMAP5_DSS_HDMI) += hdmi5.o hdmi5_core.o
>> +omapdss-$(CONFIG_OMAP5_DSS_HDMI_AUDIO) += hdmi_audio.o
>
> This adds the hdmi_audio.o twice. I'm not sure what the linker does, but
> I don't think that's correct.
>

Well, it works, but it is ugly.

> Maybe have a internal CONFIG_OMAP_DSS_HDMI_AUDIO option, which is
> selected if OMAP4 or OMAP5 HDMI AUDIO is selected by the user.
>
> That same internal option could be used in the code also (where is
> applies), instead of "if OMAP4_AUDIO || OMAP5_AUDIO".
>

I'll implement your suggestion.

Cheers,
Jyri



