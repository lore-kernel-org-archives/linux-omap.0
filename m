From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 4/4] omapdss: features: fixed supported outputs for OMAP4
Date: Tue, 12 Mar 2013 18:27:29 +0530
Message-ID: <513F2639.5060008@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com> <1362493070-17706-5-git-send-email-archit@ti.com> <513DCE08.20404@ti.com> <513EC63A.5060707@ti.com> <513F05A0.6040204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47977 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683Ab3CLM6P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 08:58:15 -0400
In-Reply-To: <513F05A0.6040204@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: robdclark@gmail.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org

On Tuesday 12 March 2013 04:08 PM, Tomi Valkeinen wrote:
> On 2013-03-12 08:07, Archit Taneja wrote:
>> On Monday 11 March 2013 05:58 PM, Tomi Valkeinen wrote:
>>> On 2013-03-05 16:17, Archit Taneja wrote:
>>>> The support outputs struct for overlay managers is incorrect for
>>>> OMAP4. Make
>>>> these changes:
>>>>
>>>> - DPI isn't supported via the LCD1 overlay manager, remove DPI as a
>>>> supported
>>>>     output.
>>>> - the TV manager can suppport DPI, but the omapdss driver doesn't
>>>> support that
>>>>     yet, we require some muxing at the DSS level, and we also need to
>>>> configure
>>>>     the hdmi pll in the DPI driver so that the TV manager has a pixel
>>>> clock. We
>>>>     don't support that yet.
>>>>
>>>> Signed-off-by: Archit Taneja <archit@ti.com>
>>>> ---
>>>>    drivers/video/omap2/dss/dss_features.c |    6 ++----
>>>>    1 file changed, 2 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/video/omap2/dss/dss_features.c
>>>> b/drivers/video/omap2/dss/dss_features.c
>>>> index d7d66ef..7f791ae 100644
>>>> --- a/drivers/video/omap2/dss/dss_features.c
>>>> +++ b/drivers/video/omap2/dss/dss_features.c
>>>> @@ -202,12 +202,10 @@ static const enum omap_dss_output_id
>>>> omap3630_dss_supported_outputs[] = {
>>>>
>>>>    static const enum omap_dss_output_id omap4_dss_supported_outputs[] = {
>>>>        /* OMAP_DSS_CHANNEL_LCD */
>>>> -    OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_DBI |
>>>> -    OMAP_DSS_OUTPUT_DSI1,
>>>> +    OMAP_DSS_OUTPUT_DBI | OMAP_DSS_OUTPUT_DSI1,
>>>>
>>>>        /* OMAP_DSS_CHANNEL_DIGIT */
>>>> -    OMAP_DSS_OUTPUT_VENC | OMAP_DSS_OUTPUT_HDMI |
>>>> -    OMAP_DSS_OUTPUT_DPI,
>>>> +    OMAP_DSS_OUTPUT_VENC | OMAP_DSS_OUTPUT_HDMI,
>>>>
>>>>        /* OMAP_DSS_CHANNEL_LCD2 */
>>>>        OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_DBI |
>>>>
>>>
>>> Thanks, I'll apply this to omapdss fixes branch.
>>
>> Hi, just one point here, this patch is a prerequisite for the patch 2/4
>> in this series. So we need to make sure that the 2/4 patch is not
>> without this one in a kernel.
>>
>> Tomi,
>>
>> About patch '2/4', could you have a look at it too? It basically tries
>> to do a dynamic assignment of channels to outputs. I worked on this
>> before you posted the misc series with recommended_channel for outputs.
>> This patch tries to figure out managers with supported_outputs. It isn't
>> the most optimal way, as it can't back track and chose a better manager,
>> but it still seems to do a reasonable job.
>>
>> We could also use the recommended channel way for omapdrm, I can't
>> figure out what's the better approach at the moment.
>
> Hmm, I think it'd be safer to use the recommended channel from omapdss
> for now. The current omapdss code doesn't really let you use any other
> channel than the recommended one (which was thus renamed to
> dispc_channel in my later version).

I think omapdss needs to give the freedom to set a different dispc 
manager for an output. This is because in omapdrm crtcs are sort of 
floating, and when a connector(and it's encoder) needs to be enabled, it 
tries to look search for a crtc it can connect to. If omapdss sort of 
fixes the output->manager link, which is not how it should work.

I think it is fine for us to use this approach for omapfb when creating 
the links, but not within dss.

For example, the code here:

-	/*
-	 * XXX We shouldn't need dssdev->channel for this. The dsi pll clock
-	 * source for DPI is SoC integration detail, not something that should
-	 * be configured in the dssdev
-	 */
-	dsidev = dpi_get_dsidev(dssdev->channel);
+	dsidev = dpi_get_dsidev(dpi.output.dispc_channel);

We are sort of using the recommended channel to figure out which DSI pll 
to use. We don't have much of an option here because dpi_init_display() 
happens much earlier. But if it were to connect to a different manager 
later on, we would get into trouble.

>
> Or does your patch do a better job at selecting the outputs (I'm mostly
> thinking about OMAP5 here, which has a bit more conflicts with the mgrs
> and outputs than earlier omaps).

My approach is very drm oriented, the problem with omapdrm right now is 
that we want to limit the number of crtcs(which map to managers). The 
lesser the number of crtcs, the more free planes we have for overlaying.

If through bootargs or CONFIG, we set NUM_CRTCs to 2. We can only set up 
only 2 overlay managers. My patch just tries to figure out which are the 
best 2 managers to choose out of the total number of managers, in such a 
way that most encoders/panels on the platform are supported.

The drm framework(I think) keeps the connections between crtc and 
encoders flexible through the possible_crtcs flag maintained by 
encoders. It figures out which crtc is free, and tries to use that one 
at that moment. Once that encoder is done using it, the crtc can be used 
by another encoder later. We can also change the crtc of an 
encoder(after it's off).

So omapdss fixing the dispc channel for an output doesn't seem suitable 
for drm.

Archit

