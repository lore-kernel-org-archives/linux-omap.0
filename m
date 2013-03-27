From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH v3 3/8] drm/omap: Make fixed resolution panels work
Date: Wed, 27 Mar 2013 13:05:22 +0530
Message-ID: <5152A13A.7060805@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com> <1364305525-28496-1-git-send-email-archit@ti.com> <1364305525-28496-4-git-send-email-archit@ti.com> <51529EC2.4040403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60359 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804Ab3C0HgM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 03:36:12 -0400
In-Reply-To: <51529EC2.4040403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: robdclark@gmail.com, andy.gross@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Wednesday 27 March 2013 12:54 PM, Tomi Valkeinen wrote:
> On 2013-03-26 15:45, Archit Taneja wrote:
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
>> v3: clear the timings local variable first before using memcmp
>> v2: make sure the timings we try to set for a fixed resolution panel match the
>>      panel's timings
>>
>>   drivers/gpu/drm/omapdrm/omap_connector.c |   27 +++++++++++++++++++++++++--
>>   drivers/gpu/drm/omapdrm/omap_encoder.c   |   17 +++++++++++++++--
>>   2 files changed, 40 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
>> index c451c41..912759d 100644
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
>>   	} else {
>>   		ret = connector_status_unknown;
>>   	}
>
> Can we leave this part out? I don't like hardcoding things like that,
> and if I'm not mistaken, this only affects VENC.
>
> If the code above would use detect where available, and presume the
> panel is connected in other cases, it'll be right for all other displays
> but VENC, for which we have no connect information.
>
> Or, there could be a special case for VENC, like above, which sets the
> connector status to unknown for that. And connected for all others. It'd
> still be hardcoded, but for much less cases.

I guess we can leave the status for VENC as always connected too, if we 
leave it as unknown by default and have no detect func for VENC, it 
would never run with omapdrm.

Archit

