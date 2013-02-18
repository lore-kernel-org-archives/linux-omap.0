From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH] omapdrm: Make fixed resolution panels work
Date: Mon, 18 Feb 2013 17:00:00 +0530
Message-ID: <512210B8.6080400@ti.com>
References: <1360842744-8325-1-git-send-email-archit@ti.com> <CAF6AEGvgQxYtV=FD_B29LCONALSieR+PWVpgOD0Wn4SM88zn2g@mail.gmail.com> <5121D705.6040908@ti.com> <5121E6F9.1030905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43585 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149Ab3BRLap (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Feb 2013 06:30:45 -0500
In-Reply-To: <5121E6F9.1030905@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rob Clark <robdclark@gmail.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, greg@kroah.com

On Monday 18 February 2013 02:01 PM, Tomi Valkeinen wrote:
> On 2013-02-18 09:23, Archit Taneja wrote:
>
>>>> diff --git a/drivers/staging/omapdrm/omap_connector.c
>>>> b/drivers/staging/omapdrm/omap_connector.c
>>>> index 4cc9ee7..839c6e4 100644
>>>> --- a/drivers/staging/omapdrm/omap_connector.c
>>>> +++ b/drivers/staging/omapdrm/omap_connector.c
>>>> @@ -110,6 +110,11 @@ static enum drm_connector_status
>>>> omap_connector_detect(
>>>>                           ret = connector_status_connected;
>>>>                   else
>>>>                           ret = connector_status_disconnected;
>>>> +       } else if (dssdev->type == OMAP_DISPLAY_TYPE_DPI ||
>>>> +                       dssdev->type == OMAP_DISPLAY_TYPE_DBI ||
>>>> +                       dssdev->type == OMAP_DISPLAY_TYPE_SDI ||
>>>> +                       dssdev->type == OMAP_DISPLAY_TYPE_DSI) {
>>>> +               ret = connector_status_connected;
>>>
>>> hmm, why not just have a default detect fxn for panel drivers which
>>> always returns true?  Seems a bit cleaner.. otherwise, I guess we
>>> could just change omap_connector so that if dssdev->detect is null,
>>> assume always connected.  Seems maybe a slightly better way since
>>> currently omap_connector doesn't really know too much about different
>>> sorts of panels.  But I'm not too picky if that is a big pain because
>>> we probably end up changing all this as CFP starts coming into
>>> existence.
>>>
>>> Same goes for check_timings/set_timings..  it seems a bit cleaner just
>>> to have default fxns in the panel drivers that do-the-right-thing,
>>> although I suppose it might be a bit more convenient for out-of-tree
>>> panel drivers to just assume fixed panel if these fxns are null.
>
> Yeah, I can't make my mind about null pointer. It's nice to inform with
> a null pointer that the panel doesn't support the given operation, or
> that it doesn't make sense, but handling the null value makes the code a
> bit complex.
>
> For example, our VENC driver doesn't know if there's a TV connected or
> not, so neither true or false as connect return value makes sense there.
> Or, for a DSI command mode panel, set_timings doesn't really make much
> sense.
>
>> Maybe having default functions in omapdss might be a better idea. There
>> is an option of adding default functions in omap_dss_register_driver()
>> (drivers/video/omap2/dss/core.c).
>>
>> Tomi, do you think it's fine to add some more default panel driver funcs?
>
> We can add default funcs. However, adding them in
> omap_dss_register_driver is not so nice, as it makes the omap_dss_driver
> (which is essentially an "ops" struct) non-constable. Instead, we should
> move the setting of the default funcs to the drivers.
>
> If I'm not mistaken, we could manage that with a helper macro. Assigning
> a value to the same field of a struct should be ok by the compiler, and
> should cause only the last assignment to be taken into use. So:
>
> static struct foo zab = {
> 	.bar = 123, /* ignored */
> 	.bar = 234, /* used */
> };
>
> And so we could have:
>
> static struct omap_dss_driver my_panel_driver = {
> 	OMAPDSS_DEFAULT_PANEL_OPS, /* macro for default ops */
>
> 	.enable = my_panel_enable,
> 	/* ... */
> };

This sounds nice, but if the panel driver ops are going to be changed 
again in CPF, then it might make sense to do this later, depending on 
how it CPF handles default ops in panel drivers.

Maybe we should leave this patch as-is, since we know it will be 
modified later.

Archit

