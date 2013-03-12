From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 4/4] omapdss: features: fixed supported outputs for OMAP4
Date: Tue, 12 Mar 2013 11:37:54 +0530
Message-ID: <513EC63A.5060707@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com> <1362493070-17706-5-git-send-email-archit@ti.com> <513DCE08.20404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35870 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754315Ab3CLGIl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Mar 2013 02:08:41 -0400
In-Reply-To: <513DCE08.20404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: robdclark@gmail.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org

On Monday 11 March 2013 05:58 PM, Tomi Valkeinen wrote:
> On 2013-03-05 16:17, Archit Taneja wrote:
>> The support outputs struct for overlay managers is incorrect for OMAP4. Make
>> these changes:
>>
>> - DPI isn't supported via the LCD1 overlay manager, remove DPI as a supported
>>    output.
>> - the TV manager can suppport DPI, but the omapdss driver doesn't support that
>>    yet, we require some muxing at the DSS level, and we also need to configure
>>    the hdmi pll in the DPI driver so that the TV manager has a pixel clock. We
>>    don't support that yet.
>>
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> ---
>>   drivers/video/omap2/dss/dss_features.c |    6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
>> index d7d66ef..7f791ae 100644
>> --- a/drivers/video/omap2/dss/dss_features.c
>> +++ b/drivers/video/omap2/dss/dss_features.c
>> @@ -202,12 +202,10 @@ static const enum omap_dss_output_id omap3630_dss_supported_outputs[] = {
>>
>>   static const enum omap_dss_output_id omap4_dss_supported_outputs[] = {
>>   	/* OMAP_DSS_CHANNEL_LCD */
>> -	OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_DBI |
>> -	OMAP_DSS_OUTPUT_DSI1,
>> +	OMAP_DSS_OUTPUT_DBI | OMAP_DSS_OUTPUT_DSI1,
>>
>>   	/* OMAP_DSS_CHANNEL_DIGIT */
>> -	OMAP_DSS_OUTPUT_VENC | OMAP_DSS_OUTPUT_HDMI |
>> -	OMAP_DSS_OUTPUT_DPI,
>> +	OMAP_DSS_OUTPUT_VENC | OMAP_DSS_OUTPUT_HDMI,
>>
>>   	/* OMAP_DSS_CHANNEL_LCD2 */
>>   	OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_DBI |
>>
>
> Thanks, I'll apply this to omapdss fixes branch.

Hi, just one point here, this patch is a prerequisite for the patch 2/4 
in this series. So we need to make sure that the 2/4 patch is not 
without this one in a kernel.

Tomi,

About patch '2/4', could you have a look at it too? It basically tries 
to do a dynamic assignment of channels to outputs. I worked on this 
before you posted the misc series with recommended_channel for outputs. 
This patch tries to figure out managers with supported_outputs. It isn't 
the most optimal way, as it can't back track and chose a better manager, 
but it still seems to do a reasonable job.

We could also use the recommended channel way for omapdrm, I can't 
figure out what's the better approach at the moment.

Archit
