From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH 12/12] OMAPDSS: DPI: always use DSI PLL if available
Date: Wed, 7 Nov 2012 08:32:05 -0600
Message-ID: <CAF6AEGvJqmvkvkbnegVvnt+SxrWajB=Vq-LsY=k1c96eeyQEXA@mail.gmail.com>
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
	<CAF6AEGuNyqO-teda1sv8c8m9x1j8Fm13HYuWB4N3gccJeKFTFg@mail.gmail.com>
	<509A3171.8010100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62329 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab2KGOcI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 09:32:08 -0500
In-Reply-To: <509A3171.8010100@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tomi Valkeinen <tomba@iki.fi>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Wed, Nov 7, 2012 at 4:01 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 2012-11-06 16:40, Rob Clark wrote:
>
>> I mean, similar to how we handle the subdev for dmm..  the
>> omap_drm_init() does the platform_driver_register() for the dmm device
>> before the platform_driver_register() for omapdrm itself, so we know
>> if there is a dmm device, the driver gets probed first before omapdrm.
>
> Well, I consider that a bit hacky too. That's not how linux device
> framework is supposed to be used. I know it makes life easier to do the
> registering like that, though.
>
>> It could be a matter of iterating through a list, or something like
>> this.. that is basically an implementation detail.  But the end result
>> is that the order the drivers are registered is controlled so the
>> probe sequence works out properly (not to mention suspend/resume
>> sequence).
>
> I feel that this kind of solution just tries to solve the generic
> problem of init/suspend ordering in a single driver, instead of fixing
> the device framework itself.
>
> Or, of course it's possible that our drive architecture just sucks, and
> the device framework is fine. In that case the workaround is even worse,
> and we should fix our drivers.

well, I guess by splitting things up into many pieces, we push the
device framework in ways that it is not pushed on desktop.  But I've
enough on my plate so I wasn't going to volunteer to try and fix that
;-)

controlling the order that the drivers are registered is currently the
most straightforward way to not have problems w/ probe/init/suspend..

>>> I think we should support proper hotplugging of the panels. This would
>>> fix the problem about init order, but it would also give us device
>>> hotplug support. Obviously nobody is going to solder panel to a running
>>> board, but I don't see any reason why panels, or, more likely, panels on
>>> an add-on boards (like the capes being discussed in omap ml) would not
>>> be hotpluggable using whatever connector is used on the particular use case.
>>>
>>> And even if we don't support removing of the devices, things like the
>>> add-on capes could cause the panel on the cape to be identified at some
>>> late time (the panel is not described in the board file or DT data, but
>>> found at runtime depending on the ID of the cape). This would add
>>> another step to the init sequence that should be just right, if we don't
>>> support hotplug.
>>
>> If capes are really hot-pluggable, then maybe it is worth thinking
>> about how to make this more dynamic.  Although it is a bigger problem,
>> which involves userspace being aware that connectors can dynamically
>> appear/disappear.  And the dynamic disappearing is something I worry
>> about more.. it adds the possibility of all sorts of interesting race
>> conditions, such as connectors disappearing in the middle of modeset.
>> I prefer not making things more complicated and error prone than they
>> need to be.  If there is not a legitimate use case for connector hw
>> dynamically appearing/disappearing then I don't think we should go
>> there.  It sounds nice and simple and clean, but in reality I think it
>> just introduces a whole lot of ways for things to go wrong.  A wise
>
> Yes, I agree that it complicates things.
>
>> man once said:
>>
>> https://github.com/robclark/kernel-omap4/blob/master/Documentation/SubmittingPatches#L700
>
> I've done things simple lots of times in the omapdss driver, only to
> have to rewrite the thing in more complex way later to accommodate new
> scenarios. I think it's good to write the code in a bit more generic way
> than the use case at the moment of writing requires, because more often
> than not, it'll save time in the future.

well, if it is not effecting userspace ABI, then I think, when in
doubt I prefer to start simple.  It can always be changed later if
needed.

> Hotplugging is not some abstract future scenario, we already have
> hardware that could use it. For example, omap3 SDP board has a
> switchable output to DVI or LCD panel. In this case we know what the two
> options are, but the disabled component is still effectually removed
> from the system, and plugged back in when it's enabled.

I would look at this as two different connectors which can not be used
at the same time.  You have this scenario with desktop graphics cards.

> Hotplug is not a high priority item, but I do wish we get it supported
> in common panel framework. Then it's at least possible to extend drm in
> the future to support it.
>
>
>
> Anyway, this makes me wonder... omapdrm currently maps the elements of
> the whole video pipeline to drm elements (encoder, connector, etc).
> Would it make more sense to just map the DISPC to these drm elements?
> Connector would then be the output from DISPC.

I think:

  plane->overlay
  crtc->manager

is pretty clear.  And really

  encoder->output

should be the way it is..  on the branch w/ omapdss/omapdrm kms
re-write, this is how it is for plane/crtc, except for now:

  encoder+connector->dssdev

Basically the encoder is doing the "control" stuff (power on/off, set
timings, etc), and the connector is only doing non control stuff
(detect, reading edid, etc).

But I think this will probably change a bit as CFP comes into the
picture.  Currently the drm connector is somewhat a "passive" element,
but I think this will have to change a bit w/ CFP.

> This would map the drm elements to the static hardware blocks, and the
> meaning of those blocks would be quite similar to what they are in the
> desktop world (I guess).
>
> The panel driver, the external chips, and the DSS internal output blocks
> (dsi, dpi, ...) would be handled separately from those drm elements. The
> DSS internal blocks are static, of course, but they can be effectively
> considered the same way as external chips.

I think dsi/dpi/etc map to encoder.  The big question is where the
panel's fit.  But to userspace somehow this should look like
connectors.  I think:

  encoder->output
  connector->panel

could work.. although connector is less passive than KMS currently
assumes.  And "panel" could really be a whole chain in the case of
bridge chips, etc.  I don't know, maybe there are better ways.  But I
think userspace really just wants to know "which monitor" which is
basically connector.

> The omapdrm driver needs of course to access those separate elements
> also, but that shouldn't be a problem. If omapdrm needs to call a
> function in the panel driver, all it needs to do is go through the chain
> to find the panel. Well, except if one output connected two two panels
> via a bridge chip...

yeah, that is a really ugly case in our hw since it is quite
non-transparent (ie. implications about use of planes, etc).

> And if drm is at some point extended to support panel drivers, or chains
> of external display entities, it would be easier to add that support.
>
> What would it require the manage the elements like that? Would it help?
> It sounds to me that this would simplify the model.

I'm not really entirely sure..  other than at least other drivers
supporting CFP will have the same requirements ;-)

I guess the two best options are either bury some sort of chain of
panel drivers in the connector, or introduce some internal elements in
DRM which are not necessarily visible to userspace.  (Or at least
userspace should have the option to ignore it for backwards
compatibility.  For atomic pageflip/modeset, the converting of
everything to properties makes it easier to think about exposing new
KMS mode object types to userspace.)

Either way, I think we need to break this into stages.  And first
stage is to ignore chains of panel drivers and just support single
panel drivers (ignoring bridges, etc).  I'm not entirely sure what the
second stage should be, but am open to suggestions and seeing how it
evolves.

BR,
-R

>  Tomi
>
>
