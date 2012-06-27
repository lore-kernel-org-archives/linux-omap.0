From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 17/17] OMAPDSS: DSI: Remove redundant fields in omap_dss_dsi_videomode_data
Date: Wed, 27 Jun 2012 17:48:32 +0530
Message-ID: <4FEAFA18.3070908@ti.com>
References: <1340703414-1915-1-git-send-email-archit@ti.com>  <1340703414-1915-19-git-send-email-archit@ti.com> <1340798746.2649.51.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42807 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752431Ab2F0MTi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jun 2012 08:19:38 -0400
In-Reply-To: <1340798746.2649.51.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Wednesday 27 June 2012 05:35 PM, Tomi Valkeinen wrote:
> On Tue, 2012-06-26 at 15:06 +0530, Archit Taneja wrote:
>> The struct omap_dss_dsi_videomode_data holds polaritiy/logic level information
>> of the DISPC video port signals DE, HSYNC and VSYNC. This information already
>> exists in the omap_video_timings struct.
>>
>> Use the fields in omap_video_timings to program VP_DE_POL, VP_HSYNC_POL and
>> VP_VSYNC_POL in DSI_CTRL. Remove the redundant fields in
>> omap_dss_dsi_videomode_data.
>>
>> Signed-off-by: Archit Taneja<archit@ti.com>
>> ---
>>   drivers/video/omap2/dss/dsi.c |   11 ++++++++---
>>   include/video/omapdss.h       |    3 ---
>>   2 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
>> index 061bf53..3844430 100644
>> --- a/drivers/video/omap2/dss/dsi.c
>> +++ b/drivers/video/omap2/dss/dsi.c
>> @@ -3628,13 +3628,18 @@ static void dsi_config_vp_num_line_buffers(struct omap_dss_device *dssdev)
>>   static void dsi_config_vp_sync_events(struct omap_dss_device *dssdev)
>>   {
>>   	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
>> -	int de_pol = dssdev->panel.dsi_vm_data.vp_de_pol;
>> -	int hsync_pol = dssdev->panel.dsi_vm_data.vp_hsync_pol;
>> -	int vsync_pol = dssdev->panel.dsi_vm_data.vp_vsync_pol;
>> +	int de_pol, hsync_pol, vsync_pol;
>> +	int de_level = dssdev->panel.timings.de_level;
>> +	int hsync_level = dssdev->panel.timings.hsync_level;
>> +	int vsync_level = dssdev->panel.timings.vsync_level;
>>   	bool vsync_end = dssdev->panel.dsi_vm_data.vp_vsync_end;
>>   	bool hsync_end = dssdev->panel.dsi_vm_data.vp_hsync_end;
>>   	u32 r;
>>
>> +	de_pol = de_level == OMAPDSS_SIG_ACTIVE_HIGH ? 1 : 0;
>> +	hsync_pol = hsync_level == OMAPDSS_SIG_ACTIVE_HIGH ? 1 : 0;
>> +	vsync_pol = vsync_level == OMAPDSS_SIG_ACTIVE_HIGH ? 1 : 0;
>> +
>>   	r = dsi_read_reg(dsidev, DSI_CTRL);
>>   	r = FLD_MOD(r, de_pol, 9, 9);		/* VP_DE_POL */
>>   	r = FLD_MOD(r, hsync_pol, 10, 10);	/* VP_HSYNC_POL */
>
> This patch makes the code cleaner, but I find this DSI sync code a bit
> strange.
>
> The sync polarities between DISPC and DSI do not matter elsewhere, they
> do not affect the DSI output, so why do we have them in the panel data?
> Why doesn't dsi.c just use some hardcoded values for these.

Ok, are you saying that unlike DPI, where a panel may request for some 
different polarities. There is no such need for DSI panels, and we can 
set the polarities of DISPC and DSI always to active high(or any other 
combination)?

Well, we are doing that indirectly in a way, a DSI panel driver would 
populate a omap_video_timings struct, and would leave hsync_level, 
vsync_level and de_level empty(i.e, the default values). This would be 
passed to the DSI driver, and the timings would be applied to DISPC. The 
function above would just pick up the same default values and program to 
the DSI registers.

What we could do is ignore these fields in the omap_video_timings when 
passed from the panel driver to DSI driver, and always use a fixed value 
for them, and this way we can use the same fixed values for DSI too. Do 
you think that is better?

Archit
