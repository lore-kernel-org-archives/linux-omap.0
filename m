From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 2/2] drm: omap: disconnect devices when omapdrm module
 is removed
Date: Thu, 19 Sep 2013 16:21:37 +0530
Message-ID: <523AD739.1030801@ti.com>
References: <1379502502-8781-1-git-send-email-archit@ti.com> <1379580585-18364-1-git-send-email-archit@ti.com> <523ACD07.5020406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59621 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717Ab3ISKwc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Sep 2013 06:52:32 -0400
In-Reply-To: <523ACD07.5020406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, robdclark@gmail.com
Cc: linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi,

On Thursday 19 September 2013 03:38 PM, Tomi Valkeinen wrote:
> On 19/09/13 11:49, Archit Taneja wrote:
>> omapdrm established connections for omap_dss_device devices when probed. It
>> should also be responsible to disconnect the devices. Keeping the devices
>> connected can prevent the panel driver modules from unloading, it can also
>> cause problems when omapdrm is re-inserted.
>>
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> ---
>>   drivers/gpu/drm/omapdrm/omap_drv.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
>> index 45fbb1c..44a1203 100644
>> --- a/drivers/gpu/drm/omapdrm/omap_drv.c
>> +++ b/drivers/gpu/drm/omapdrm/omap_drv.c
>> @@ -86,6 +86,13 @@ static bool channel_used(struct drm_device *dev, enum omap_channel channel)
>>
>>   	return false;
>>   }
>> +static void omap_disconnect_dssdevs(void)
>> +{
>> +	struct omap_dss_device *dssdev = NULL;
>> +
>> +	for_each_dss_dev(dssdev)
>> +		dssdev->driver->disconnect(dssdev);
>> +}
>
> With a quick test, it looks like omapdrm leaves the displays enabled
> when exiting. This can be fixed by adding to the above loop:
>
> 		if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED)
> 			dssdev->driver->disable(dssdev);
>
> However... omapdrm still crashes when unloading, and it could be somehow
> related to leaving something un-removed. Disabling a CRTC should disable
> the display, and maybe omapdrm should disable (and clean-up) all CRTCs
> on exit, and maybe that would remove the crash, and also fix the issue
> of leaving displays enabled.
>
> But I'm just guessing there, I have no idea how the process of unloading
> a drm driver goes.

It seems like dev_unload is the place where we should disconnect the 
dssdevs.

omap_modeset_free() calls drm_mode_config_cleanup() which calls omapdrm 
specific destroy funcs for connectors, encoders and crtcs.

I don't think crtcs should disable the device. I think it's the 
encoder(and connector) which is mapped to a display. The omap_encoder's 
destroy op should disable the dssdev device.

I'm not sure about this though. Rob, do you have any comment on this?

Archit

