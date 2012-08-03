From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [RFC 0/3] solving omapdrm/omapdss layering issues
Date: Fri, 3 Aug 2012 07:22:11 -0500
Message-ID: <CAF6AEGuWdZnSw+1o+sTxH6Ek02UBeJk05CQF3zc3sxgO9tf57Q@mail.gmail.com>
References: <1343437674-24246-1-git-send-email-rob.clark@linaro.org>
	<1343742034.2633.56.camel@deskari>
	<CAF6AEGuqi+E7i1cuZTCts1y46E3SDUzd8E3kuW52=jRC5EksaQ@mail.gmail.com>
	<1343812870.2645.37.camel@deskari>
	<CAF6AEGuoVaOwwXnS3MKcoeKrtA3=Oi108jqM3iObd3EqTmC9Bw@mail.gmail.com>
	<1343891600.5767.12.camel@lappyti>
	<CAF6AEGuCTu_KtH-G+gQDA=2pmKtbsoe5k8m78=bJT6cRDVFm0A@mail.gmail.com>
	<1343913338.2686.56.camel@deskari>
	<CAF6AEGttViUf9QJ3YZsqbk3bD3KV9=j_KhmyAFMy9eb6PwRoHA@mail.gmail.com>
	<CAB2ybb-wrRXUxEK2hOUrHV-Peb+HhPM944+ZSARmMtxMK1Z91w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:57561 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576Ab2HCMWM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Aug 2012 08:22:12 -0400
Received: by vcbfk26 with SMTP id fk26so586921vcb.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Aug 2012 05:22:12 -0700 (PDT)
In-Reply-To: <CAB2ybb-wrRXUxEK2hOUrHV-Peb+HhPM944+ZSARmMtxMK1Z91w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Semwal, Sumit" <sumit.semwal@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org

On Fri, Aug 3, 2012 at 1:01 AM, Semwal, Sumit <sumit.semwal@ti.com> wrote:
> Hi Rob, Tomi,
> On Thu, Aug 2, 2012 at 7:46 PM, Rob Clark <rob.clark@linaro.org> wrote:
>> On Thu, Aug 2, 2012 at 8:15 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>> On Thu, 2012-08-02 at 07:45 -0500, Rob Clark wrote:
>>>> On Thu, Aug 2, 2012 at 2:13 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>>> > On Wed, 2012-08-01 at 09:25 -0500, Rob Clark wrote:
>>>> >> On Wed, Aug 1, 2012 at 4:21 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>>> >
>>>> >> > I guess the fact is that DRM concepts do not really match the OMAP DSS
>>>> >> > hardware, and we'll have to use whatever gives us least problems.
>>>> >>
>>>> >> Actually, I think it does map fairly well to the hardware.. at least
>>>> >> more so than to omapdss ;-)
>>>> >
>>>> > Hm, I'm not sure I understand, omapdss concepts map directly to the
>>>> > hardware.
>>>>
>>>> I think it is mainly exposing the encoder and panel as two separate
>>>> entities.. which seems to be what Archit is working on
>>>
>>> I still don't follow =) They are separate entities. Omapdss models the
>>> HW quite directly, I think. It doesn't expose everything, though, as the
>>> output drivers (dsi.c, dpi.c etc) are used via the panel drivers.
>>
>> right.. so we just need to expose the output drivers as separate
>> entities, and let omapdrm propagate information such as timings
>> between them
>>
>>>> in case of something like DVI bridge from DPI, this seems pretty
>>>> straightforward.. only the connector needs to know about DDC stuff,
>>>> which i2c to use and that sort of thing.  So at kms level we would
>>>> have (for example) an omap_dpi_encoder which would be the same for DPI
>>>> panel (connector) or DPI->DVI bridge.  For HDMI I'm still looking
>>>> through the code to see how this would work.  Honestly I've looked
>>>> less at this part of code and encoder related registers in the TRM,
>>>> compared to the ovl/mgr parts, but at least from the 'DSS overview'
>>>> picture in the TRM it seems to make sense ;-)
>>>>
>>>> KMS even exposes the idea that certain crtcs can connect to only
>>>> certain encoders.  Or that you could you could have certain connectors
>>>> switched between encoders.  For example if you had a hw w/ DPI out,
>>>> and some mux to switch that back and forth between a DPI lcd panel and
>>>> a DPI->DVI bridge.  (Ok, I'm not aware of any board that actually does
>>>> this, but it is in theory possible.)  So we could expose possible
>>>> video chain topologies to userspace in this way.
>>>
>>> OMAP3 SDP board has such a setup, with manual switch to select between
>>> LCD and DVI.
>>
>> ahh, good to know.. so I'm not crazy for wanting to expose this
>> possibility to userspace
>>
>>>> The other thing is that we don't need to propagate timings from the
>>>> panel up to the mgr at the dss level.. kms is already handling this
>>>> for us.  In my latest version, which I haven't pushed, I removed the
>>>> 'struct omap_overlay_mgr' ptr from 'struct omap_dss_device'.
>>>
>>> You're thinking only about simple DPI cases. Consider this example, with
>>> a DSI-to-DP bridge chip. What we have is the following flow of data:
>>>
>>> DISPC -> DSI -> DSI-2-DP -> DP monitor
>>>
>>> The timings you are thinking about are in the DISPC, but here they are
>>> only one part of the link. And here the DISPC timings are not actually
>>> the timings what the user is interested about. The user wants his
>>> timings to be between DSI-2-DP chip and the DP monitor.
>>>
>>> Timings programmed to DISPC are not the same. The timings for DISPC come
>>> from the DSI driver, and they may be very different than the user's
>>> timings. With DSI video mode, the DISPC timings would have some
>>> resemblance to the user's timings, mainly the time to send one line
>>> would be the same. With DSI cmd mode, the DISPC timings would be
>>> something totally different, most likely with 0 blank times and as fast
>>> pixel clock as possible.
>>
>> hmm, well kms already has a concept of adjusted_timings, which could
>> perhaps be used here to propagate the timings between crtc->encoder..
>> although the order is probably backwards from what we want (it comes
>> from the crtc to the encoder.. and if I understand properly we want it
>> the other way and actually possibly from the connector).  But that
>> isn't to say that internally in omapdrm the crtc couldn't get the
>> adjusted timings from the connector.  So I still think the parameter
>> flow doesn't need to be 'under the hood' in omapdss.
>>
>> And fwiw, the adjusted_timings stuff is handled by drm_crtc_helper
>> fxns, so if the way the core kms handles it isn't what we want, we can
>> just plug in our own fxn instead of using drm_crtc_helper_set_mode(),
>> so that isn't really a big problem.
>>
>>> What omapdss does currently is that you set the user's timings to the
>>> right side of the chain, which propagate back to DSS. This allows the
>>> DSI-2-DP bridge use DSI timings that work optimally for the bridge, and
>>> DSI driver will use DISPC timings that work optimally for it.
>>>
>>> And it's not only about timings above, but also other settings related
>>> to the busses between the components. Clock dividers, polarities, stuff
>>> like that.
>>
>> I expect we could handle other settings in the same way as the timings.
>>
>>>> I think the problem was there were some cases, like ovl updates before
>>>> setting the mgr, where the user_info_dirty flag would be cleared but
>>>> the registers not updated.  This is what I meant by sequence of
>>>
>>> Hmm, I'd appreciate more info about this if you can give. Sounds like a
>>> bug, that shouldn't happen.
>>>
>>> So you mean that you have an ovl, with no manager set. And you change
>>> the settings of the ovl before assigning it to a mgr? That's something I
>>> haven't really tested, so it could bug, true.
>>>
>>>> operations at KMS level confusing omapdss.  This should be fixable
>>>> with some debugging.  Although getting rid of the state tracking at
>>>> omapdss level altogether was a much simpler solution, and is the one I
>>>> prefer :-)
>>>
>>> Yes, I don't prefer the state tracking either (we didn't have it in
>>> earlier versions of omapdss), but I still don't see an option to it if
>>> we want to support all the stuff we have.
>>
>> well, we do have to do state tracking *somewhere*.. I just prefer to
>> do it only in one layer instead of two ;-)
>>
> Let me add a little more to the 'boiling pot' ;) - what about
> writeback? Writeback, from DSS perspective, is an integral part of the
> DSS offering, is needed for many compelling use cases, and needs to
> sync with the overlays and the managers (depending on mode) for state
> information.
>
> As such, Omapdss needs to worry about the way writeback is structured,
> and the way it interacts with the other entities in the system.
>
> Even though AFAIK DRM doesn't provide a capture mechanism to help
> support writeback through omapdrm, we still need to provide a clean
> way to use the writeback path with the display ones that we've talked
> about here till now.

well, first: all the fancy features in the world don't matter if
fundamental use cases like multi-layer updates don't work.

but that said, writeback doesn't strictly change anything.
Configuring the input side of writeback (ie input to dss) *must* be
done through drm in order to not bypass the authentication mechanism
in drm.  We can't have non-authenticated clients configuring things so
that the contents of the screen get written back to memory, that is a
security hole.  After that, you maybe just need to provide some fxns
for the (presumably v4l capture) interface can configure the output
side of WB.  I guess this is roughly analogous to how hdmi audio
works.  It could be that we register a v4l2 driver within omapdrm, or
that we export some fxns that a v4l2 driver outside of omapdrm can
use.  Probably we should look at how hdmi audio and alsa hook together
in other drivers to see what the right precedent is to follow.

BR,
-R

>> BR,
>> -R
>
> Best,
> ~Sumit.
>>>  Tomi
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
