From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 6/6] OMAPDSS: VENC: Maintian copy of video output polarity
 in private data
Date: Thu, 16 Aug 2012 17:57:19 +0530
Message-ID: <502CE727.6070906@ti.com>
References: <343817088-29645-1-git-send-email-archit@ti.com>  <1345102594-6222-1-git-send-email-archit@ti.com>  <1345102594-6222-7-git-send-email-archit@ti.com> <1345117118.15132.7.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59015 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753855Ab2HPM2s (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 08:28:48 -0400
In-Reply-To: <1345117118.15132.7.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 16 August 2012 05:08 PM, Tomi Valkeinen wrote:
> On Thu, 2012-08-16 at 13:06 +0530, Archit Taneja wrote:
>> The VENC driver currently relies on the omap_dss_device struct to configure the
>> video output polarity. This makes the VENC interface driver dependent on the
>> omap_dss_device struct.
>>
>> Make the VENC driver data maintain it's own polarity field. A panel driver
>> is expected to call omapdss_venc_set_vid_out_polarity() before enabling the
>> interface.
>>
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> ---
>>   drivers/video/omap2/dss/dss.h        |    2 ++
>>   drivers/video/omap2/dss/venc.c       |   13 ++++++++++++-
>>   drivers/video/omap2/dss/venc_panel.c |    6 ++++++
>>   3 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
>> index c17d298..b2cf5530 100644
>> --- a/drivers/video/omap2/dss/dss.h
>> +++ b/drivers/video/omap2/dss/dss.h
>> @@ -479,6 +479,8 @@ u32 omapdss_venc_get_wss(struct omap_dss_device *dssdev);
>>   int omapdss_venc_set_wss(struct omap_dss_device *dssdev, u32 wss);
>>   void omapdss_venc_set_type(struct omap_dss_device *dssdev,
>>   		enum omap_dss_venc_type type);
>> +void omapdss_venc_set_vid_out_polarity(struct omap_dss_device *dssdev,
>> +		enum omap_dss_signal_level vid_out_pol);
>>   int venc_panel_init(void);
>>   void venc_panel_exit(void);
>>
>> diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
>> index 2d90fcf..8cb372f 100644
>> --- a/drivers/video/omap2/dss/venc.c
>> +++ b/drivers/video/omap2/dss/venc.c
>> @@ -303,6 +303,7 @@ static struct {
>>
>>   	struct omap_video_timings timings;
>>   	enum omap_dss_venc_type type;
>> +	enum omap_dss_signal_level vid_out_pol;
>>   } venc;
>>
>>   static inline void venc_write_reg(int idx, u32 val)
>> @@ -447,7 +448,7 @@ static int venc_power_on(struct omap_dss_device *dssdev)
>>   	else /* S-Video */
>>   		l |= (1 << 0) | (1 << 2);
>>
>> -	if (dssdev->phy.venc.invert_polarity == false)
>> +	if (venc.vid_out_pol == OMAPDSS_SIG_ACTIVE_HIGH)
>>   		l |= 1 << 3;
>
> Are you sure this is correct? I know practically nothing about analog
> TV, but the TRM doesn't seem to say much about that bit, except it can
> be used to "invert the video output". It doesn't say there's an
> active/inactive level for the signal.

Well, the code works :), I'm also not totally sure about whether it 
should be represented as a 2-level signal, it seemed like it would be 
nicer to give it a signal level rather than keeping it as a bool, which 
could vary for other SoC's?

I am considering not to pass this via the panel driver for now, I don't 
know if all VENC IPs needs to do this, maybe it's okay to leave this 
dssdev reference for now?

Archit

>
>   Tomi
>

