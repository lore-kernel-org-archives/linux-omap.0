From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 05/20] OMAPDSS: remove initial display code from omapdss
Date: Mon, 29 Oct 2012 16:06:55 +0530
Message-ID: <508E5C47.6000809@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com> <1351070951-18616-6-git-send-email-tomi.valkeinen@ti.com> <508E54C8.9070209@ti.com> <508E597F.60406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52912 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758538Ab2J2KhL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Oct 2012 06:37:11 -0400
In-Reply-To: <508E597F.60406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Monday 29 October 2012 03:55 PM, Tomi Valkeinen wrote:
> On 2012-10-29 12:04, Archit Taneja wrote:
>> On Wednesday 24 October 2012 02:58 PM, Tomi Valkeinen wrote:
>>> Currently omapdss driver sets up the initial connections between
>>> overlays, overlay manager and a panel, based on default display
>>> parameter coming from the board file or via module parameters.
>>>
>>> This is unnecessary, as it's the higher level component that should
>>> decide what display to use and how. This patch removes the code from
>>> omapdss, and implements similar code to omapfb.
>>>
>>> The def_disp module parameter and the default display platform_data
>>> parameter are kept in omapdss, but omapdss doesn't do anything with
>>> them. It will just return the default display name with
>>> dss_get_default_display_name() call, which omapfb uses. This is done to
>>> keep the backward compatibility.
>>
>> We might need to do something similar for omap_vout and omapdrm also to
>> set the initial connections.
>
> I believe omapdrm already does this.
>
> For omap_vout... I'm not sure if we can do that. Both omapfb and
> omap_vout work at the same time, so they could be setting up the
> settings at the same time, perhaps with conflicting values. The reason I
> left omap_vout out is that I think omapfb is always used with omap_vout,
> thus the config can be left for omapfb. I didn't test this, though.

I thought we could have omap_vout without omapfb, at least we can build 
it separately. Anyway, setting initial connections in omap_vout doesn't 
seem very important as we generally have both of them together.

>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> ---
>>>    drivers/video/omap2/dss/core.c           |    1 +
>>>    drivers/video/omap2/dss/display.c        |   78
>>> +++---------------------------
>>>    drivers/video/omap2/omapfb/omapfb-main.c |   77
>>> ++++++++++++++++++++++++-----
>>>    include/video/omapdss.h                  |    1 +
>>>    4 files changed, 75 insertions(+), 82 deletions(-)
>>>
>>> diff --git a/drivers/video/omap2/dss/core.c
>>> b/drivers/video/omap2/dss/core.c
>>> index 685d9a9..4cb669e 100644
>>> --- a/drivers/video/omap2/dss/core.c
>>> +++ b/drivers/video/omap2/dss/core.c
>>> @@ -57,6 +57,7 @@ const char *dss_get_default_display_name(void)
>>>    {
>>>        return core.default_display_name;
>>>    }
>>> +EXPORT_SYMBOL(dss_get_default_display_name);
>>
>> Since we are exporting this, it might be better to name it
>> omapdss_get_default_display_name
>
> True.
>
>>>    enum omapdss_version omapdss_get_version(void)
>>>    {
>>> diff --git a/drivers/video/omap2/dss/display.c
>>> b/drivers/video/omap2/dss/display.c
>>> index 1e58730..6d33112 100644
>>> --- a/drivers/video/omap2/dss/display.c
>>> +++ b/drivers/video/omap2/dss/display.c
>>> @@ -320,86 +320,21 @@ void omapdss_default_get_timings(struct
>>> omap_dss_device *dssdev,
>>>    }
>>>    EXPORT_SYMBOL(omapdss_default_get_timings);
>>>
>>> -/*
>>> - * Connect dssdev to a manager if the manager is free or if force is
>>> specified.
>>> - * Connect all overlays to that manager if they are free or if force is
>>> - * specified.
>>> - */
>>> -static int dss_init_connections(struct omap_dss_device *dssdev, bool
>>> force)
>>> +int dss_init_device(struct platform_device *pdev,
>>> +        struct omap_dss_device *dssdev)
>>>    {
>>> +    struct device_attribute *attr;
>>>        struct omap_dss_output *out;
>>> -    struct omap_overlay_manager *mgr;
>>>        int i, r;
>>>
>>>        out = omapdss_get_output_from_dssdev(dssdev);
>>>
>>> -    WARN_ON(dssdev->output);
>>> -    WARN_ON(out->device);
>>> -
>>>        r = omapdss_output_set_device(out, dssdev);
>>>        if (r) {
>>>            DSSERR("failed to connect output to new device\n");
>>>            return r;
>>>        }
>>
>> So, we still manage the output-device links in the omapdss driver, but
>> move the manager-output and overlay-manager links to omapfb. I guess
>> this is fine. But maybe this split might change based on how generic
>> panel framework looks like, and how much we want to expose outputs to
>> fb/drm.
>
> We can set the output-device link in omapdss because it's a hardware
> configuration. A panel is connected to an output, so there's nothing to
> configure there. ovls and ovl-mgrs, on the other hand, may be configured
> depending on the use cases.

Yes, that makes sense.

Archit

