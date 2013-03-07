From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 3/4] drm/omap: Make fixed resolution panels work
Date: Thu, 7 Mar 2013 12:59:58 +0530
Message-ID: <513841F6.1020405@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com> <1362493070-17706-4-git-send-email-archit@ti.com> <CAF6AEGvua0r8Ri0YNAT7051XAKGooEcDbfCNQB_rrGzGoOfOUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39881 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485Ab3CGHas (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Mar 2013 02:30:48 -0500
In-Reply-To: <CAF6AEGvua0r8Ri0YNAT7051XAKGooEcDbfCNQB_rrGzGoOfOUQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org

On Wednesday 06 March 2013 06:15 AM, Rob Clark wrote:
> On Tue, Mar 5, 2013 at 9:17 AM, Archit Taneja <archit@ti.com> wrote:
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
>>   drivers/gpu/drm/omapdrm/omap_connector.c |   10 ++++++++--
>>   drivers/gpu/drm/omapdrm/omap_encoder.c   |    6 ++++--
>>   2 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
>> index c451c41..c952324 100644
>> --- a/drivers/gpu/drm/omapdrm/omap_connector.c
>> +++ b/drivers/gpu/drm/omapdrm/omap_connector.c
>> @@ -110,6 +110,11 @@ static enum drm_connector_status omap_connector_detect(
>>                          ret = connector_status_connected;
>>                  else
>>                          ret = connector_status_disconnected;
>> +       } else if (dssdev->type == OMAP_DISPLAY_TYPE_DPI ||
>> +                       dssdev->type == OMAP_DISPLAY_TYPE_DBI ||
>> +                       dssdev->type == OMAP_DISPLAY_TYPE_SDI ||
>> +                       dssdev->type == OMAP_DISPLAY_TYPE_DSI) {
>> +               ret = connector_status_connected;
>>          } else {
>>                  ret = connector_status_unknown;
>>          }
>> @@ -189,12 +194,13 @@ static int omap_connector_mode_valid(struct drm_connector *connector,
>>          struct omap_video_timings timings = {0};
>>          struct drm_device *dev = connector->dev;
>>          struct drm_display_mode *new_mode;
>> -       int ret = MODE_BAD;
>> +       int r, ret = MODE_BAD;
>>
>>          copy_timings_drm_to_omap(&timings, mode);
>>          mode->vrefresh = drm_mode_vrefresh(mode);
>>
>> -       if (!dssdrv->check_timings(dssdev, &timings)) {
>> +       r = dssdrv->check_timings ? dssdrv->check_timings(dssdev, &timings) : 0;
>> +       if (!r) {
>>                  /* check if vrefresh is still valid */
>>                  new_mode = drm_mode_duplicate(dev, mode);
>>                  new_mode->clock = timings.pixel_clock;
>> diff --git a/drivers/gpu/drm/omapdrm/omap_encoder.c b/drivers/gpu/drm/omapdrm/omap_encoder.c
>> index d48df71..9aed178 100644
>> --- a/drivers/gpu/drm/omapdrm/omap_encoder.c
>> +++ b/drivers/gpu/drm/omapdrm/omap_encoder.c
>> @@ -135,13 +135,15 @@ int omap_encoder_update(struct drm_encoder *encoder,
>>
>>          dssdev->output->manager = mgr;
>>
>> -       ret = dssdrv->check_timings(dssdev, timings);
>> +       ret = dssdrv->check_timings ?
>> +               dssdrv->check_timings(dssdev, timings) : 0;
>>          if (ret) {
>>                  dev_err(dev->dev, "could not set timings: %d\n", ret);
>>                  return ret;
>>          }
>>
>> -       dssdrv->set_timings(dssdev, timings);
>> +       if (dssdrv->set_timings)
>> +               dssdrv->set_timings(dssdev, timings);
>
> maybe either here or _mode_valid(), for panels that don't have
> set_timings(), we should double check that the new timings match what
> we get from the panel's get_timings().  Other than that, it looks
> fine.

Yeah, we should do that. I guess it makes more sense to do it earlier, 
i.e, in mode_vaild.

Archit

