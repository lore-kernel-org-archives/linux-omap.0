From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCHv2 8/8] OMAP: DSS2: HDMI: improve hdmi output enable
Date: Mon, 12 Sep 2011 16:53:34 +0530
Message-ID: <4E6DEBB6.6090703@ti.com>
References: <1315818773-18660-1-git-send-email-tomi.valkeinen@ti.com>	 <1315818773-18660-9-git-send-email-tomi.valkeinen@ti.com>	 <4E6DE68F.3020809@ti.com> <1315825587.2177.27.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51904 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755043Ab1ILLWl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 07:22:41 -0400
In-Reply-To: <1315825587.2177.27.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "K, Mythri P" <mythripk@ti.com>

On Monday 12 September 2011 04:36 PM, Valkeinen, Tomi wrote:
> On Mon, 2011-09-12 at 16:31 +0530, Archit Taneja wrote:
>> On Monday 12 September 2011 02:42 PM, Valkeinen, Tomi wrote:
>>> Enabling HDMI output often causes sync lost errors, and almost always
>>> causes timeout errors being printed from dispc_mgr_enable_digit_out().
>>>
>>> The sync lost problem seems to go lessen greatly if we first enable the
>>> HDMI output, and only then enable the DISPC output. However, as this is
>>> only based on observations, the fix may not be perfect as the problem
>>> may lie somewhere else. Nevertheless, HDMI works better with this patch.
>>>
>>> This will also fix the dispc's dispc_mgr_enable_digit_out(), as the code
>>> waits for two VSYNCs after enabling the output. If the HDMI output is
>>> disabled (as it was previously), there are no VSYNCs and
>>> dispc_mgr_enable_digit_out() will print timeout errors.
>>>
>>> Cc: Mythri P K<mythripk@ti.com>
>>> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
>>> ---
>>>    drivers/video/omap2/dss/hdmi.c |    4 ++--
>>>    1 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
>>> index 4752137..06a78b2 100644
>>> --- a/drivers/video/omap2/dss/hdmi.c
>>> +++ b/drivers/video/omap2/dss/hdmi.c
>>> @@ -529,10 +529,10 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
>>>    	dispc_set_digit_size(dssdev->panel.timings.x_res,
>>>    			dssdev->panel.timings.y_res);
>>>
>>> -	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 1);
>>> -
>>>    	hdmi.ip_data.ops->video_enable(&hdmi.ip_data, 1);
>>>
>>> +	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 1);
>>> +
>>
>> What content would HDMI push out till the time DIGIT is enabled? It
>> might be interesting to put some milliseconds of delay here and see what
>> happens.
>
> I guess HDMI works independently of DISPC. So HDMI will output whatever
> is in the video port from DISPC to HDMI, regardless of what DISPC does.
> My guess is it's either random bits or, more probably, zeroes.

Okay. I thought HDMI block may probe the video port's DE line or 
something to check if it is pushing out valid content. However, with 
this patch, we are more aligned with what we do in power_off(), i.e 
first disable the manager and then disable HDMI.

Archit

>
> I think this way is the same as used for VENC: first we configure and
> enable VENC, then we enable DISPC digit output.
>
>   Tomi
>
>

