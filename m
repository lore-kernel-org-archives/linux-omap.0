From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH] drm: omap: fix: Defer probe if an omapdss device requests
 for it at connect
Date: Wed, 18 Sep 2013 18:47:51 +0530
Message-ID: <5239A7FF.6040109@ti.com>
References: <1379502502-8781-1-git-send-email-archit@ti.com> <52399F8F.8050104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35328 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752623Ab3IRNSr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Sep 2013 09:18:47 -0400
In-Reply-To: <52399F8F.8050104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: robdclark@gmail.com, linux-omap@vger.kernel.org, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>

On Wednesday 18 September 2013 06:11 PM, Tomi Valkeinen wrote:
> On 18/09/13 14:08, Archit Taneja wrote:
>> Some omapdss panels are connected to outputs/encoders(HDMI/DSI/DPI) that require
>> regulators. The output's connect op tries to get a regulator which may not exist
>> yet because it might get registered later in the kernel boot.
>>
>> omapdrm currently ignores those panels which return a non zero value when
>> connected. A better approach would be for omapdrm to request for probe
>> deferral if a panel's connect op returns -EPROBE_DEFER.
>>
>> The connecting of panels is moved very early in the the drm device's probe
>> before anything else is initialized. When we enter omap_modeset_init(), we have
>> a set of panels that have been connected. We now proceed with registering only
>> those panels which are already connected.
>>
>> Checking whether the panel has a driver or whether it has get_timing/read_edid
>> ops in omap_modeset_init() are redundant with the new display model. These can
>> be removed since a dssdev device will always have a driver associated with it,
>> and all dssdev drivers have a get_timings op.
>>
>> This fixes boot with omapdrm on an omap4 panda ES board. The regulators used by
>> HDMI aren't initialized because I2c isn't initialized, I2C isn't initialized
>> as it's pins are not configured because pinctrl is yet to probe.
>>
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> ---
>>   drivers/gpu/drm/omapdrm/omap_crtc.c |  5 ++++
>>   drivers/gpu/drm/omapdrm/omap_drv.c  | 51 +++++++++++++++++++++----------------
>>   drivers/gpu/drm/omapdrm/omap_drv.h  |  1 +
>>   3 files changed, 35 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
>> index 0fd2eb1..9c01311 100644
>> --- a/drivers/gpu/drm/omapdrm/omap_crtc.c
>> +++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
>> @@ -623,6 +623,11 @@ void omap_crtc_pre_init(void)
>>   	dss_install_mgr_ops(&mgr_ops);
>>   }
>>
>> +void omap_crtc_pre_uninit(void)
>> +{
>> +	dss_uninstall_mgr_ops();
>> +}
>> +
>>   /* initialize crtc */
>>   struct drm_crtc *omap_crtc_init(struct drm_device *dev,
>>   		struct drm_plane *plane, enum omap_channel channel, int id)
>> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
>> index 2603d90..cbe5d8e 100644
>> --- a/drivers/gpu/drm/omapdrm/omap_drv.c
>> +++ b/drivers/gpu/drm/omapdrm/omap_drv.c
>> @@ -87,6 +87,24 @@ static bool channel_used(struct drm_device *dev, enum omap_channel channel)
>>   	return false;
>>   }
>>
>> +static int omap_connect_dssdevs(void)
>> +{
>> +	int r;
>> +	struct omap_dss_device *dssdev = NULL;
>> +
>> +	for_each_dss_dev(dssdev) {
>> +		r = dssdev->driver->connect(dssdev);
>> +		if (r == -EPROBE_DEFER) {
>> +			return r;
>> +		} else if (r) {
>> +			dev_warn(dssdev->dev, "could not connect display: %s\n",
>> +				dssdev->name);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>
> There are two issues with this one:
>
> for_each_dss_dev() uses omap_dss_get_next_device(), and that will
> increase the ref count of the current dssdev. If you interrupt the loop,
> the ref count won't be decreased. I have a hunch that we could have
> similar bugs elsewhere too...

You are saying that the ref counts will be correct only if 
for_each_dss_dev() is fully completed?

Maybe we can save the first dssdev which doesn't connect, save that 
dssdev and let the loop continue for the refcount to get decremented again.

Or maybe use omap_dss_get_next_device in a custom loop, which takes care 
of doing a put() for the device before returning.

>
> Second, in case of error, the dssdevs that were already connected should
> be disconnected. Although maybe that's not important, as they'll end up
> being connected again when the omapdrm is probed the next time.

The one's that were already connected won't connect again and return an 
error which isn't EPROBE_DEFER, so that should be okay right?

Archit
