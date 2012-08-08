From: Archit Taneja <a0393947@ti.com>
Subject: Re: [RFC 08/17] OMAPDSS: DSI: Maintain own copy of timings in driver
 data
Date: Wed, 8 Aug 2012 11:27:48 +0530
Message-ID: <5021FFDC.6080006@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>  <1343817088-29645-9-git-send-email-archit@ti.com> <1344348462.7216.77.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45217 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab2HHF7P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 01:59:15 -0400
In-Reply-To: <1344348462.7216.77.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com

On Tuesday 07 August 2012 07:37 PM, Tomi Valkeinen wrote:
> On Wed, 2012-08-01 at 16:01 +0530, Archit Taneja wrote:
>> The DSI driver currently relies on the timings in omap_dss_device struct to
>> configure the DISPC and DSI blocks accordingly. This makes the DSI interface
>> driver dependent on the omap_dss_device struct.
>>
>> Make the DPI driver data maintain it's own timings field. The panel driver is
>            ^^^
> DSI
>
>> expected to call omapdss_dsi_set_timings() to set these timings before the panel
>> is enabled.
>>
>> Signed-off-by: Archit Taneja <archit@ti.com>d
>> ---
>>   drivers/video/omap2/displays/panel-taal.c |    2 ++
>>   drivers/video/omap2/dss/dsi.c             |   27 ++++++++++++++++++++++-----
>>   include/video/omapdss.h                   |    2 ++
>>   3 files changed, 26 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
>> index 3f5acc7..4775580 100644
>> --- a/drivers/video/omap2/displays/panel-taal.c
>> +++ b/drivers/video/omap2/displays/panel-taal.c
>> @@ -1060,6 +1060,8 @@ static int taal_power_on(struct omap_dss_device *dssdev)
>>   		goto err0;
>>   	};
>>
>> +	omapdss_dsi_set_timings(dssdev, &td->panel_config->timings);
>> +
>>   	r = omapdss_dsi_display_enable(dssdev);
>>   	if (r) {
>>   		dev_err(&dssdev->dev, "failed to enable DSI\n");
>
> Video timings for command mode panel are meaningless. If we need to pass
> the resolution of the panel, perhaps we should have a separate function
> for that.
>
> However, with a quick glance at dsi.c, we don't even use the
> dssdev->panel.timings for cmd mode panel. But we do use
> dssdev->get_resolution() in a few places. Those calls could be replaced
> by storing the panel size in dsi.c, given with omapdss_dsi_set_size() or
> such. We could use the timings field in dsi.c to store them, though.

I am a bit unclear about resolution when it comes to command mode panels.

For command mode panels, we can perform rotation at the panel side. That 
is, the panel refreshes itself by fetching pixels from it's buffer in a 
rotated way. Is that right?

If the original resolution is 864x480, and we set rotation at panel side 
to make the rotation 480x864, the DISPC manager size should also be 
configured at 480x864 right?

We seem to be setting the manager timings only once when DSI is enabled. 
After that, setting rotation doesn't impact manager size.

I am asking this to understand if we need to keep resolution as a 
separate parameter than timings. That is, timings represents the initial 
width and height of the panel, and resolution represents the current 
width and height of the panel.

Archit

