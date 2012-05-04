From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 08/25] OMAPDSS: clean up the omapdss platform data mess
Date: Fri, 4 May 2012 14:06:17 +0530
Message-ID: <4FA39501.3070205@ti.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>  <1336053481-25433-9-git-send-email-tomi.valkeinen@ti.com>  <4FA369D2.1070809@ti.com> <1336120320.2701.1.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53799 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928Ab2EDIg5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 May 2012 04:36:57 -0400
In-Reply-To: <1336120320.2701.1.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday 04 May 2012 02:02 PM, Tomi Valkeinen wrote:
> On Fri, 2012-05-04 at 11:02 +0530, Archit Taneja wrote:
>> Hi,
>>
>> On Thursday 03 May 2012 07:27 PM, Tomi Valkeinen wrote:
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
>>>    arch/arm/mach-omap2/display.c   |   39 +++++++++++++++++++--------------------
>>>    drivers/video/omap2/dss/core.c  |   35 +++++++++++++++++++++++++++++++++++
>>>    drivers/video/omap2/dss/dispc.c |   21 ++-------------------
>>>    drivers/video/omap2/dss/dsi.c   |   17 +++--------------
>>>    drivers/video/omap2/dss/dss.h   |    3 +++
>>>    drivers/video/omap2/dss/hdmi.c  |    2 --
>>>    include/video/omapdss.h         |    5 -----
>>>    7 files changed, 62 insertions(+), 60 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
>>> index 60cded4..07232fd 100644
>>> --- a/arch/arm/mach-omap2/display.c
>>> +++ b/arch/arm/mach-omap2/display.c
>>> @@ -191,10 +191,24 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
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
>>> +	board_data->set_min_bus_tput = omap_dss_set_min_bus_tput;
>>> +
>>> +	omap_display_device.dev.platform_data = board_data;
>>> +
>>> +	r = platform_device_register(&omap_display_device);
>>> +	if (r<   0) {
>>> +		pr_err("Unable to register omapdss device\n");
>>> +		return r;
>>> +	}
>>
>> After this patch, the "omapdss" platform device is registered before the
>> other dss platform devices. This would change the sequence of probes of
>> these devices. Was this intentional?
>
> Hmm. The sequence shouldn't change. The order in which the devices are
> registered doesn't matter if there are no drivers registered yet. When
> the drivers are registered, and there's a device for it, the probe will
> be done. So in this case the order of the driver registration will
> dictate the order of probes.

Oh okay, I don't know where the initcalls exactly happen, but I guess 
they will happen after the .init_machine op in the board file.

Do you know where the initcalls happen, I couldn't find it by browsing 
the kernel code :)

Archit
>
>   Tomi
>

