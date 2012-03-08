From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 08/21] OMAPDSS: clean up the omapdss platform data mess
Date: Thu, 8 Mar 2012 13:47:44 +0530
Message-ID: <4F586B28.1050403@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>  <1331124290-6285-9-git-send-email-tomi.valkeinen@ti.com>  <4F57A4E5.6070201@ti.com> <1331193777.2354.21.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59701 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754694Ab2CHISD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Mar 2012 03:18:03 -0500
In-Reply-To: <1331193777.2354.21.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 08 March 2012 01:32 PM, Tomi Valkeinen wrote:
> On Wed, 2012-03-07 at 23:41 +0530, Archit Taneja wrote:
>> On Wednesday 07 March 2012 06:14 PM, Tomi Valkeinen wrote:
>>> The omapdss pdata handling is a mess. This is more evident when trying
>>> to use device tree for DSS, as we don't have platform data anymore in
>>> that case. This patch cleans the pdata handling by:
>>>
>>> - Remove struct omap_display_platform_data. It was used just as a
>>>     wrapper for struct omap_dss_board_info.
>>> - Pass the platform data only to omapdss device. The drivers for omap
>>>     dss hwmods do not need the platform data. This should also work better
>>>     for DT, as we can create omapdss device programmatically in generic omap
>>>     boot code, and thus we can pass the pdata to it.
>>> - Create dss functions for get_ctx_loss_count and dsi_enable/disable_pads
>>>     that the dss hwmod drivers can call.
>>>
>>> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
>>> ---
>>>    arch/arm/mach-omap2/display.c   |   37 ++++++++++++++++++-------------------
>>>    drivers/video/omap2/dss/core.c  |   35 +++++++++++++++++++++++++++++++++++
>>>    drivers/video/omap2/dss/dispc.c |   21 ++-------------------
>>>    drivers/video/omap2/dss/dsi.c   |   17 +++--------------
>>>    drivers/video/omap2/dss/dss.h   |    3 +++
>>>    drivers/video/omap2/dss/hdmi.c  |    2 --
>>>    include/video/omapdss.h         |    5 -----
>>>    7 files changed, 61 insertions(+), 59 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
>>> index 3677b1f..279c124 100644
>>> --- a/arch/arm/mach-omap2/display.c
>>> +++ b/arch/arm/mach-omap2/display.c
>>> @@ -185,10 +185,23 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
>>>    	struct omap_hwmod *oh;
>>>    	struct platform_device *pdev;
>>>    	int i, oh_count;
>>> -	struct omap_display_platform_data pdata;
>>>    	const struct omap_dss_hwmod_data *curr_dss_hwmod;
>>>
>>> -	memset(&pdata, 0, sizeof(pdata));
>>> +	/* create omapdss device */
>>> +
>>> +	board_data->dsi_enable_pads = omap_dsi_enable_pads;
>>> +	board_data->dsi_disable_pads = omap_dsi_disable_pads;
>>> +	board_data->get_context_loss_count = omap_pm_get_dev_context_loss_count;
>>
>> Why are the checks for board data being NULL removed here?
>
> We didn't check if board_data is NULL in the earlier version either. And
> I don't think there's need to check that, because if the board file
> calls this function, it should also give the board data.
>
> However, the earlier version didn't set the func pointers if the func
> pointer in the board_data was != NULL. Did you mean that? I removed that
> check, as I don't see a need for it. The func pointers should be set by
> this function, and I don't see why the board file would need to use its
> own versions.

Yes, I had meant the function pointers being != NULL, yes it doesn't 
make sense for the board file to populate these.

>
>>> diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
>>> index 8613f86..3efd473 100644
>>> --- a/drivers/video/omap2/dss/core.c
>>> +++ b/drivers/video/omap2/dss/core.c
>>> @@ -87,6 +87,41 @@ struct regulator *dss_get_vdds_sdi(void)
>>>    	return reg;
>>>    }
>>>
>>> +int dss_get_ctx_loss_count(struct device *dev)
>>> +{
>>> +	struct omap_dss_board_info *board_data = core.pdev->dev.platform_data;
>>> +	int cnt;
>>> +
>>> +	if (!board_data || !board_data->get_context_loss_count)
>>> +		return -ENOENT;
>>
>> why do we check board_data being NULL here and not in omap_display_init()?
>
> I added it for DT case, because then we don't have board_data for the
> devices defined in the DT data. However, for now we always have the
> board_data, and in this patch I should just move the code. So I'll
> remove the check, and add it later with DT code if needed.

Ok. When DT will be in use, would omap_display_init() be called or not?

>
> (and actually, I don' think the check is needed in DT case either...)

I don't know how things would work in DT case. So I'm not sure what's 
happening here.

Archit

>
>   Tomi
>
>
>
>

