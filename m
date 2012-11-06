From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH 12/12] OMAPDSS: DPI: always use DSI PLL if available
Date: Tue, 6 Nov 2012 08:40:15 -0600
Message-ID: <CAF6AEGuNyqO-teda1sv8c8m9x1j8Fm13HYuWB4N3gccJeKFTFg@mail.gmail.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
	<1351613409-21186-13-git-send-email-tomi.valkeinen@ti.com>
	<5090D28E.6050703@ti.com>
	<50939B84.6090602@ti.com>
	<5093A3FB.1060806@ti.com>
	<5093A530.5050302@ti.com>
	<5093A9E8.70106@ti.com>
	<5093AE79.9010603@ti.com>
	<5093B4F3.1000703@ti.com>
	<50977EEF.3040403@ti.com>
	<5097CB81.7050204@ti.com>
	<509913A4.5080408@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54781 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab2KFOkT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 09:40:19 -0500
In-Reply-To: <509913A4.5080408@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomba@iki.fi>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Tue, Nov 6, 2012 at 7:41 AM, Tomi Valkeinen <tomba@iki.fi> wrote:
> On 2012-11-05 16:21, Rob Clark wrote:
>> On 11/05/2012 02:55 AM, Tomi Valkeinen wrote:
>>>>> But even then, choosing the manager is not easy, as whoever chooses the
>>>>> >>manager needs to observe all the possible displays used at the same
>>>>> >>time...
>>>> >
>>>> >Right. I was wondering if omapfb/omapdrm could understand the 'all
>>>> >possible displays information' better compared to a panel's probe.
>>>> >
>>>> >Even omapdrm/omafb can't be perfect because we could insert a panel
>>>> >driver module at any time, and omapfb/omapdrm may miss that out.
>>> True, omapdrm/fb may have a better idea. It's still unclear though.
>>> Currently we have quite strict order in the sequence the modules need to
>>> be loaded, which is quite bad and causes issues. We should make things
>>> more dynamic, so that the initialization of the drivers could happen
>>> more freely.
>>>
>>> But that creates more problems: when booting up, omapfb starts. But
>>> omapfb can't know if all the panel drivers have already been loaded.
>>> omapfb may see that DVI is the default display, but what should it do if
>>> DVI doesn't have a driver yet? It could wait, but perhaps the driver for
>>> DVI will never even be loaded.
>>
>> The encoder which is connected to the crtc (manager) is picked by
>> combination of encoder->possible_crtcs bitmask and
>> connector->best_encoder().  We could keep things limited so that the
>> association of crtc to encoder (manager to output, roughly) never
>> changes, but this isn't really the right thing to do.  It is better that
>> the dssdev not rely on knowing the manager it is attached to at probe
>> time, but instead grab resources more dynamically.
>>
>> Also, at the moment we don't really have any notification to userspace
>> about new encoders/connectors showing up (or conversely, being
>> removed).  Only about existing connectors being plugged/unplugged.  The
>> closest analogy is perhaps the USB display devices, but even there it is
>> only the entire drm device that is plugged/unplugged.  And TBH I don't
>> really see the point in supporting panel drivers being dynamically
>> loaded.  It isn't like someone is dynamically soldering on a new display
>> connector to some board that is running.  I think omapfb or omapdrm
>> probe should trigger registering the compiled-in panel drivers, so that
>> it can be sure that the dssdev's pop up before it goes and creates drm
>> connector objects.  Currently we have to hack around this in omapdrm
>> with late_initcall() to ensure the panel drivers are probed first, but
>> that is an ugly hack that I'd like to get rid of.
>
> We have panel devices and panel drivers, each of which can appear at any
> time. Both are needed for the panel probe to happen. If we don't support
> device hotplugging (dynamic creation of devices), we need to use
> late_initcall for omapfb/drm. At least I don't see any other option.
>
> You say that omapdrm should trigger registering of the drivers. How
> would that work? Do you mean that the panel drivers would register
> themselves to some common list, and omapdrm would go through this list
> when drm is loaded, calling probe for the items in the list? I guess
> that's doable, but... It's not how kernel drivers are supposed to work,
> and so doesn't sound very clean approach to me.

I mean, similar to how we handle the subdev for dmm..  the
omap_drm_init() does the platform_driver_register() for the dmm device
before the platform_driver_register() for omapdrm itself, so we know
if there is a dmm device, the driver gets probed first before omapdrm.

It could be a matter of iterating through a list, or something like
this.. that is basically an implementation detail.  But the end result
is that the order the drivers are registered is controlled so the
probe sequence works out properly (not to mention suspend/resume
sequence).

> I think we should support proper hotplugging of the panels. This would
> fix the problem about init order, but it would also give us device
> hotplug support. Obviously nobody is going to solder panel to a running
> board, but I don't see any reason why panels, or, more likely, panels on
> an add-on boards (like the capes being discussed in omap ml) would not
> be hotpluggable using whatever connector is used on the particular use case.
>
> And even if we don't support removing of the devices, things like the
> add-on capes could cause the panel on the cape to be identified at some
> late time (the panel is not described in the board file or DT data, but
> found at runtime depending on the ID of the cape). This would add
> another step to the init sequence that should be just right, if we don't
> support hotplug.

If capes are really hot-pluggable, then maybe it is worth thinking
about how to make this more dynamic.  Although it is a bigger problem,
which involves userspace being aware that connectors can dynamically
appear/disappear.  And the dynamic disappearing is something I worry
about more.. it adds the possibility of all sorts of interesting race
conditions, such as connectors disappearing in the middle of modeset.
I prefer not making things more complicated and error prone than they
need to be.  If there is not a legitimate use case for connector hw
dynamically appearing/disappearing then I don't think we should go
there.  It sounds nice and simple and clean, but in reality I think it
just introduces a whole lot of ways for things to go wrong.  A wise
man once said:

https://github.com/robclark/kernel-omap4/blob/master/Documentation/SubmittingPatches#L700

BR,
-R

> Yes, I know it's not simple =). And I'm fine with simpler approach for
> the time being, but I'd like full hotplug to be the future goal. At
> least the common panel framework should not create restrictions about
> this, even if drm wouldn't allow device hotplug.
>
>  Tomi
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
