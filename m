From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH] omapdrm: Make fixed resolution panels work
Date: Mon, 18 Feb 2013 12:53:49 +0530
Message-ID: <5121D705.6040908@ti.com>
References: <1360842744-8325-1-git-send-email-archit@ti.com> <CAF6AEGvgQxYtV=FD_B29LCONALSieR+PWVpgOD0Wn4SM88zn2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34338 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753666Ab3BRHYe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Feb 2013 02:24:34 -0500
In-Reply-To: <CAF6AEGvgQxYtV=FD_B29LCONALSieR+PWVpgOD0Wn4SM88zn2g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>, tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, greg@kroah.com

On Thursday 14 February 2013 09:24 PM, Rob Clark wrote:
> On Thu, Feb 14, 2013 at 6:52 AM, Archit Taneja <archit@ti.com> wrote:
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
>> I tested this with picodlp on a OMAP4 sdp board. I couldn't get any other
>> working boards with fixed DPI panels. I could try the DSI video mode panel
>> on an OMAP5 sevm, but that will require me to patch a lot of things to get
>> omap5 dss work with DT. I can try if needed.
>>
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> ---
>>   drivers/staging/omapdrm/omap_connector.c |   10 ++++++++--
>>   drivers/staging/omapdrm/omap_encoder.c   |    6 ++++--
>>   2 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/omapdrm/omap_connector.c b/drivers/staging/omapdrm/omap_connector.c
>> index 4cc9ee7..839c6e4 100644
>> --- a/drivers/staging/omapdrm/omap_connector.c
>> +++ b/drivers/staging/omapdrm/omap_connector.c
>> @@ -110,6 +110,11 @@ static enum drm_connector_status omap_connector_detect(
>>                          ret = connector_status_connected;
>>                  else
>>                          ret = connector_status_disconnected;
>> +       } else if (dssdev->type == OMAP_DISPLAY_TYPE_DPI ||
>> +                       dssdev->type == OMAP_DISPLAY_TYPE_DBI ||
>> +                       dssdev->type == OMAP_DISPLAY_TYPE_SDI ||
>> +                       dssdev->type == OMAP_DISPLAY_TYPE_DSI) {
>> +               ret = connector_status_connected;
>
> hmm, why not just have a default detect fxn for panel drivers which
> always returns true?  Seems a bit cleaner.. otherwise, I guess we
> could just change omap_connector so that if dssdev->detect is null,
> assume always connected.  Seems maybe a slightly better way since
> currently omap_connector doesn't really know too much about different
> sorts of panels.  But I'm not too picky if that is a big pain because
> we probably end up changing all this as CFP starts coming into
> existence.
>
> Same goes for check_timings/set_timings..  it seems a bit cleaner just
> to have default fxns in the panel drivers that do-the-right-thing,
> although I suppose it might be a bit more convenient for out-of-tree
> panel drivers to just assume fixed panel if these fxns are null.

Maybe having default functions in omapdss might be a better idea. There 
is an option of adding default functions in omap_dss_register_driver() 
(drivers/video/omap2/dss/core.c).

Tomi, do you think it's fine to add some more default panel driver funcs?

Archit

>
> BR,
> -R
>
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
>> diff --git a/drivers/staging/omapdrm/omap_encoder.c b/drivers/staging/omapdrm/omap_encoder.c
>> index e053160..871af12e 100644
>> --- a/drivers/staging/omapdrm/omap_encoder.c
>> +++ b/drivers/staging/omapdrm/omap_encoder.c
>> @@ -128,13 +128,15 @@ int omap_encoder_update(struct drm_encoder *encoder,
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
>>
>>          return 0;
>>   }
>> --
>> 1.7.9.5
>>
>

