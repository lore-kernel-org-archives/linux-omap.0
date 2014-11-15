From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [PATCH v7.1 11/19] OMAPDSS: hdmi: Make hdmi_mode_has_audio()
 more user friedly
Date: Sat, 15 Nov 2014 17:52:00 +0200
Message-ID: <546776A0.2060305@mentor.com>
References: <cover.1415803064.git.jsarha@ti.com> <8047b50c76efecd72e7219f7871c59cc4a8ee5f5.1415803065.git.jsarha@ti.com> <5466139E.5040308@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:40519 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009AbaKOPwG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Nov 2014 10:52:06 -0500
In-Reply-To: <5466139E.5040308@mentor.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com

Hi Jyri,

On 14.11.2014 16:37, Vladimir Zapolskiy wrote:
> Hi Jyri,
> 
> On 12.11.2014 16:41, Jyri Sarha wrote:
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> ---
>>  drivers/video/fbdev/omap2/dss/hdmi.h |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
>> index a6e08ff..6d129f2 100644
>> --- a/drivers/video/fbdev/omap2/dss/hdmi.h
>> +++ b/drivers/video/fbdev/omap2/dss/hdmi.h
>> @@ -345,9 +345,9 @@ void hdmi_wp_audio_config_format(struct hdmi_wp_data *wp,
>>  		struct hdmi_audio_format *aud_fmt);
>>  void hdmi_wp_audio_config_dma(struct hdmi_wp_data *wp,
>>  		struct hdmi_audio_dma *aud_dma);
>> -static inline bool hdmi_mode_has_audio(int mode)
>> +static inline bool hdmi_mode_has_audio(struct hdmi_config *cfg)
>>  {
>> -	return mode == HDMI_HDMI ? true : false;
>> +	return cfg->hdmi_dvi_mode == HDMI_HDMI ? true : false;
>>  }
>>  
>>  /* HDMI DRV data */
>>
> 
> would it be possible for you to rearrange the changes preserving the
> following sequence?
> 
> 1) 13/19
> 2) 15/19
> 3) 11/19
> 4) 14/19
> 5) 16/19
> 
> Otherwise I'm worried that someone's git rebase may fail.

sorry, git bisect of course.

--
With best wishes,
Vladimir

