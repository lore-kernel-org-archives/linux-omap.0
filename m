From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH v2 3/4] drm/omap: Make fixed resolution panels work
Date: Tue, 12 Mar 2013 20:08:29 +0530
Message-ID: <513F3DE5.2090903@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com> <1363093583-28285-1-git-send-email-archit@ti.com> <513F3658.3000300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54784 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038Ab3CLOjN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 10:39:13 -0400
In-Reply-To: <513F3658.3000300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: robdclark@gmail.com, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org

On Tuesday 12 March 2013 07:36 PM, Tomi Valkeinen wrote:
> On 2013-03-12 15:06, Archit Taneja wrote:
>> The omapdrm driver requires omapdss panel drivers to expose ops like detect,
>> set_timings and check_timings. These can be NULL for fixed panel DPI, DBI, DSI
>> and SDI drivers. At some places, there are no checks to see if the panel driver
>> has these ops or not, and that leads to a crash.
>>
>> The following things are done to make fixed panels work:
>>
>> - The omap_connector's detect function is modified such that it considers panel
>>    types which are generally fixed panels as always connected(provided the panel
>>    driver doesn't have a detect op). Hence, the connector corresponding to these
>>    panels is always in a 'connected' state.
>>
>> - If a panel driver doesn't have a check_timings op, assume that it supports the
>>    mode passed to omap_connector_mode_valid(the 'mode_valid' drm helper function)
>>
>> - The function omap_encoder_update shouldn't really do anything for fixed
>>    resolution panels, make sure that it calls set_timings only if the panel
>>    driver has one.
>>
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> ---
>> Note: In v2, we make sure that the mode passed on to omapdrm matches the timings
>> of the fixed resolution panel.
>>
>>   drivers/gpu/drm/omapdrm/omap_connector.c |   27 +++++++++++++++++++++++++--
>>   drivers/gpu/drm/omapdrm/omap_encoder.c   |   17 +++++++++++++++--
>>   2 files changed, 40 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
>> index c451c41..a72fedd 100644
>> --- a/drivers/gpu/drm/omapdrm/omap_connector.c
>> +++ b/drivers/gpu/drm/omapdrm/omap_connector.c
>> @@ -110,6 +110,11 @@ static enum drm_connector_status omap_connector_detect(
>>   			ret = connector_status_connected;
>>   		else
>>   			ret = connector_status_disconnected;
>> +	} else if (dssdev->type == OMAP_DISPLAY_TYPE_DPI ||
>> +			dssdev->type == OMAP_DISPLAY_TYPE_DBI ||
>> +			dssdev->type == OMAP_DISPLAY_TYPE_SDI ||
>> +			dssdev->type == OMAP_DISPLAY_TYPE_DSI) {
>> +		ret = connector_status_connected;
>
> I have to say I don't like this. We shouldn't care about the type here.
> I think it's better just to default to connected if there's no detect
> function (or unknown? I'm not sure what is the practical difference).
>
> If it works fine without using dssdev->type, we have one less place to
> worry when doing dss dev model changes =).
>
>>   	} else {
>>   		ret = connector_status_unknown;
>>   	}
>> @@ -189,12 +194,30 @@ static int omap_connector_mode_valid(struct drm_connector *connector,
>>   	struct omap_video_timings timings = {0};
>>   	struct drm_device *dev = connector->dev;
>>   	struct drm_display_mode *new_mode;
>> -	int ret = MODE_BAD;
>> +	int r, ret = MODE_BAD;
>>
>>   	copy_timings_drm_to_omap(&timings, mode);
>>   	mode->vrefresh = drm_mode_vrefresh(mode);
>>
>> -	if (!dssdrv->check_timings(dssdev, &timings)) {
>> +	/*
>> +	 * if the panel driver doesn't have a check_timings, it's most likely
>> +	 * a fixed resolution panel, check if the timings match with the
>> +	 * panel's timings
>> +	 */
>> +	if (dssdrv->check_timings) {
>> +		r = dssdrv->check_timings(dssdev, &timings);
>> +	} else {
>> +		struct omap_video_timings t;
>> +
>> +		dssdrv->get_timings(dssdev, &t);
>> +
>> +		if (memcmp(&timings, &t, sizeof(struct omap_video_timings)))
>> +			r = -EINVAL;
>> +		else
>> +			r = 0;
>
> memcmp on two structs is often not a good idea. There could be padding
> bytes there, with uninitialized data. I'm not sure if that's the case
> here, though, but it could well change any time (perhaps even depending
> on compiler version).

I saw usage of memcmp on structs in the kernel, but then most of them 
were in drivers and not core, and could be mistakes :)

adding '__attribute__((packed))' to omap_video_timings might be helpful 
I suppose. But I don't know if it's safe to do a memcmp even with a 
packed struct.

>
> I'm still pondering whether it'd just be simpler to require all the
> dssdrv ops to be filled, probably using a helper macro in the panel
> drivers... Did you consider that approach? I'm not saying to go for it,
> I'm saying I can't make my mind which would be better =).

I didn't consider it mainly because I thought we were going to get rid 
of our private omapdss panel drivers with CDF panels, and efforts in 
fixing it wouldn't be much useful. But if there isn't any other good 
alternative, then I can try to see what macros look like.

Of course, simpler options for this patch would be to do a manual 
compare of the fields instead of a memcmp, or adding default ops in 
omap_dss_register_driver.

One thing about common panel driver functions in general is that they 
won't use the panel driver's locking. So if a panel driver doesn't 
create a get_timings() op assuming that omapdss will make a default func 
for it, we would miss out on the panel lock. I don't know if that's 
really bad, and doing a memcmp or anything else in omapdrm also doesn't 
help with this case.

Archit

