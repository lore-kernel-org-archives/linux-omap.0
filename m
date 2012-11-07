From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH 12/12] OMAPDSS: DPI: always use DSI PLL if available
Date: Wed, 7 Nov 2012 13:18:23 -0600
Message-ID: <CAF6AEGsvRV=ez_aqz_tkb+azNMy4jQuSVdd7oKg6=nTnguX-Kw@mail.gmail.com>
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
	<CAF6AEGvJqmvkvkbnegVvnt+SxrWajB=Vq-LsY=k1c96eeyQEXA@mail.gmail.com>
	<509A7A95.804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64853 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698Ab2KGTS0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 14:18:26 -0500
In-Reply-To: <509A7A95.804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tomi Valkeinen <tomba@iki.fi>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Wed, Nov 7, 2012 at 9:13 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 2012-11-07 16:32, Rob Clark wrote:
>> On Wed, Nov 7, 2012 at 4:01 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
>>> Hotplugging is not some abstract future scenario, we already have
>>> hardware that could use it. For example, omap3 SDP board has a
>>> switchable output to DVI or LCD panel. In this case we know what the two
>>> options are, but the disabled component is still effectually removed
>>> from the system, and plugged back in when it's enabled.
>>
>> I would look at this as two different connectors which can not be used
>> at the same time.  You have this scenario with desktop graphics cards.
>
> Yes, that's an option with fixed amount of display devices. But doesn't
> work for capes.

Only if capes are hotpluggable.. otherwise probe what cape(s?) are
present at boot time (is this possible to detect a cape from sw?), and
create the associated connector(s).

Anyways, I think we are stretching a bit hard for use cases for
hot-pluggable panels..  I just prefer to ignore hotplug for now and
come back to it when there is a more legitimate use-case.

>>> Hotplug is not a high priority item, but I do wish we get it supported
>>> in common panel framework. Then it's at least possible to extend drm in
>>> the future to support it.
>>>
>>>
>>>
>>> Anyway, this makes me wonder... omapdrm currently maps the elements of
>>> the whole video pipeline to drm elements (encoder, connector, etc).
>>> Would it make more sense to just map the DISPC to these drm elements?
>>> Connector would then be the output from DISPC.
>>
>> I think:
>>
>>   plane->overlay
>>   crtc->manager
>>
>> is pretty clear.  And really
>>
>>   encoder->output
>>
>> should be the way it is..  on the branch w/ omapdss/omapdrm kms
>
> I'm not so sure. The output (dpi/dsi/hdmi...) is the second step in our
> chain. The primary "output" is in the DISPC module, the overlay manager.
> That's where the timings, pixel clock, etc. are programmed. The second
> step, our output, is really a converter IP. It receives the primary
> output, converts it and outputs something else. Just like an external
> converter chip would do.
>

the timings, pixel clock, vblank/framedone irqs, that all maps to crtc.

encoder == converter, so I think this fits.  "An encoder takes pixel
data from a CRTC and converts it to a format suitable for any attached
connectors" (from drm docbook)

> And the output can be quite a bit anything. For example, with DBI or DSI
> command mode outputs we don't have any of the conventional video
> timings. It doesn't make sense to program, say, video blanking periods
> to those outputs. But even with DBI and DSI we do have video blanking
> periods in the DISPC's output, the ovl mgr.

the encoder has mode_fixup() which can alter the timings that end up
getting set, which might be a way to account for this.  I guess really
it should be the panel driver that is telling the encoder what
adjusted timings to give to the crtc.. so the panel driver doesn't
quite map to connector.

> Of course, at the end of the chain we have a panel that uses normal
> video timings (well, most likely but not necessarily), and so we could
> program those timings at the end of the chain, in the block before the
> panel. But even then the encoder doesn't really map to the DSS's output
> block, as the DSS's output block may not have the conventional timings
> (like DBI), or they may be something totally different than what we get
> in the end of the chain to the panel.
>
> So I think mapping encoder to output will not work with multiple display
> blocks in a chain. Thus I'd see the encoder would better match the
> DISPC's output, or alternatively perhaps the block which is just before
> the panel (whatever that is, sometimes it can be OMAP's DSI/HDMI/etc).
> However, the latter may be a bit strange as the block could be an
> external component, possibly hotpluggable.
>
>> re-write, this is how it is for plane/crtc, except for now:
>>
>>   encoder+connector->dssdev
>>
>> Basically the encoder is doing the "control" stuff (power on/off, set
>> timings, etc), and the connector is only doing non control stuff
>> (detect, reading edid, etc).
>>
>> But I think this will probably change a bit as CFP comes into the
>> picture.  Currently the drm connector is somewhat a "passive" element,
>> but I think this will have to change a bit w/ CFP.
>>
>>> This would map the drm elements to the static hardware blocks, and the
>>> meaning of those blocks would be quite similar to what they are in the
>>> desktop world (I guess).
>>>
>>> The panel driver, the external chips, and the DSS internal output blocks
>>> (dsi, dpi, ...) would be handled separately from those drm elements. The
>>> DSS internal blocks are static, of course, but they can be effectively
>>> considered the same way as external chips.
>>
>> I think dsi/dpi/etc map to encoder.  The big question is where the
>> panel's fit.  But to userspace somehow this should look like
>> connectors.  I think:
>>
>>   encoder->output
>>   connector->panel
>>
>> could work.. although connector is less passive than KMS currently
>> assumes.  And "panel" could really be a whole chain in the case of
>> bridge chips, etc.  I don't know, maybe there are better ways.  But I
>> think userspace really just wants to know "which monitor" which is
>> basically connector.
>
> Hmm yes. Well, even if we map encoder and connector to the ovl manager,
> the userspace could see which monitor there is. Obviously we need to
> make changes for that to work, but as a model it feels a lot more
> natural to me than using output and panel for encoder and connector.

well, what we call 'ovl mgr' is really where the (vblank) interrupt
generation is.  This really should be the crtc.  I tried it
differently initially, and it wasn't really working out.

> Perhaps it's wrong to say "map connector to ovl mgr". It would be more
> like "this connector observes the chain connected to this ovl mgr", even
> though the connector wouldn't observe any block in the chain directly.
> Just observing the plug in/out status, etc.
>
> But I think encoder really maps quite well directly to the output side
> of overlay manager.
>
>>> The omapdrm driver needs of course to access those separate elements
>>> also, but that shouldn't be a problem. If omapdrm needs to call a
>>> function in the panel driver, all it needs to do is go through the chain
>>> to find the panel. Well, except if one output connected two two panels
>>> via a bridge chip...
>>
>> yeah, that is a really ugly case in our hw since it is quite
>> non-transparent (ie. implications about use of planes, etc).
>
> Not really in this case. You're perhaps thinking about connecting two
> outputs to a single panel. Which is problematic also.

yes, sorry, I read that backwards..

> We don't have in sights a board that splits one output to two panels, so
> I think we should just ignore that for now. But two outputs for one
> panel is on the table.
>
>>> And if drm is at some point extended to support panel drivers, or chains
>>> of external display entities, it would be easier to add that support.
>>>
>>> What would it require the manage the elements like that? Would it help?
>>> It sounds to me that this would simplify the model.
>>
>> I'm not really entirely sure..  other than at least other drivers
>> supporting CFP will have the same requirements ;-)
>>
>> I guess the two best options are either bury some sort of chain of
>> panel drivers in the connector, or introduce some internal elements in
>> DRM which are not necessarily visible to userspace.  (Or at least
>> userspace should have the option to ignore it for backwards
>> compatibility.  For atomic pageflip/modeset, the converting of
>> everything to properties makes it easier to think about exposing new
>> KMS mode object types to userspace.)
>
> Yes, I don't think we should or need to expose these new elements to
> userspace, at least in the first place.

It *might* be useful someday, if there are ever any settings for a
bridge chip, etc, which we'd want to expose to userspace as
properties..  but I think we can come back to that later.

BR,
-R

>  Tomi
>
>
