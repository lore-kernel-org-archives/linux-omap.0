From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [RFC 0/3] solving omapdrm/omapdss layering issues
Date: Wed, 1 Aug 2012 11:53:17 -0500
Message-ID: <CAF6AEGvjKCgPh=sTL922J48N9eqMGD_kNrYx_bU-zBF-bXv=Ww@mail.gmail.com>
References: <1343437674-24246-1-git-send-email-rob.clark@linaro.org>
	<1343742034.2633.56.camel@deskari>
	<CAF6AEGuqi+E7i1cuZTCts1y46E3SDUzd8E3kuW52=jRC5EksaQ@mail.gmail.com>
	<1343812870.2645.37.camel@deskari>
	<CAF6AEGuoVaOwwXnS3MKcoeKrtA3=Oi108jqM3iObd3EqTmC9Bw@mail.gmail.com>
	<50195D54.8020604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:34119 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab2HAQxS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Aug 2012 12:53:18 -0400
Received: by vbbff1 with SMTP id ff1so7171189vbb.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Aug 2012 09:53:17 -0700 (PDT)
In-Reply-To: <50195D54.8020604@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Andy Gross <andy.gross@ti.com>

On Wed, Aug 1, 2012 at 11:46 AM, Archit Taneja <archit@ti.com> wrote:
> Hi,
>
>
> On Wednesday 01 August 2012 07:55 PM, Rob Clark wrote:
>>
>> On Wed, Aug 1, 2012 at 4:21 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>
>> wrote:
>>>
>>> On Tue, 2012-07-31 at 09:45 -0500, Rob Clark wrote:
>>>>
>>>> On Tue, Jul 31, 2012 at 8:40 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>
>>>> wrote:
>>>
>>>
>>>>> It's not really about being friendly. Omapdss tries to do as little as
>>>>> possible, while still supporting all its HW features. Shadow registers
>>>>> are a bit tricky creating this mess.
>>>>
>>>>
>>>> What I mean by 'friendly' is it tries to abstract this for simple
>>>> users, like an fbdev driver.  But this really quickly breaks down w/ a
>>>
>>>
>>> No, that's not what omapdss tries to do. I'm not trying to hide the
>>> shadow registers and the GO bit behind the omapdss API, I'm just trying
>>> to make it work.
>>>
>>> The omapdss API was made with omapfb, so it's true that the API may not
>>> be good for omapdrm. But I'm happy to change the API.
>>>
>>>> And btw, I think the current mapping of drm_encoder to mgr in omapdrm
>>>> is not correct.  I'm just in the process of shuffling things around.
>>>> I think drm/kms actually maps quite nicely to the underlying hardware
>>>> with the following arrangement:
>>>>
>>>>   drm_plane -> ovl
>>>>   drm_crtc -> mgr
>>>>   drm_encoder -> DSI/DPI/HDMI/VENC encoder
>>>>   drm_connector -> pretty much what we call a panel driver today
>>>
>>>
>>> Hmm, what was the arrangement earlier?
>>
>>
>> it was previously:
>>
>>    plane -> ovl
>>    crtc -> placeholder
>>    encoder -> mgr
>>    connector -> dssdev (encoder+panel)
>>
>> although crtc is really the point where you should enable/disable
>> vblank irqs, so the new arrangement is somewhat cleaner (although on
>> my branch the encoder/connector part are not finished yet)
>>
>>> I guess the fact is that DRM concepts do not really match the OMAP DSS
>>> hardware, and we'll have to use whatever gives us least problems.
>>
>>
>> Actually, I think it does map fairly well to the hardware.. at least
>> more so than to omapdss ;-)
>>
>> The one area that kms mismatches a bit is decoupling of ovl from mgr
>> that we have in our hw..  I've partially solved that a while back w/
>> the patch in drm to add "private planes" so the omap_crtc internally
>> uses an omap_plane.  It isn't exposed to userspace to be able to
>> re-use the planes from unused crtcs, although I have some ideas about
>> that (but not yet time to work on it).
>>
>>>> It would be quite useful if you could look at the omap_drm_apply
>>>> mechanism I had in omapdrm, because that seems like a quite
>>>> straightforward way to deal w/ shadowed registers.  I think it will
>>>
>>>
>>> Yes, it seems straightforward, but it's not =).
>>>
>>> I had a look at your omapdrm-on-dispc-2 branch. What you are doing there
>>> is quite similar to what omapdss was doing earlier. It's not going to
>>> work reliably with multiple outputs and fifomerge.
>>>
>>> Configuring things like overlay color mode are quite simple. They only
>>> affect that one overlay. Also things like manager default bg color are
>>> simple, they affect only that one manager.
>>>
>>> But enabling/disabling an overlay or a manager, changing the destination
>>> mgr of an overlay, fifomerge... Those are not simple. You can't do them
>>> directly, as you do in your branch.
>>>
>>> As an example, consider the case of enabling an overlay (vid1), and
>>> moving fifo buffers from currently enabled overlay (gfx) to vid1: you'll
>>> first need to take the fifo buffers from gfx, set GO, and wait for the
>>> settings to take effect. Only then you can set the fifo buffers for
>>> vid1, enable it and set GO bit.
>>
>>
>> hmm, it does sound like it needs a bit of a state machine to deal with
>> multi-step updates.. although that makes races more of a problem,
>> which was something I was trying hard to avoid.
>>
>> For enabling/disabling an output (manager+encoder), this is relatively
>> infrequent, so it can afford to block to avoid races.  (Like userspace
>> enabling and then rapidly disabling an output part way through the
>> enable.)  But enabling/disabling an overlay, or adjusting position or
>> scanout address must not block.  And ideally, if possible, switching
>> an overlay between two managers should not block.
>>
>> For fifomerge, if I understand correctly, it shouldn't really be
>> needed for functionality, but mainly as a power optimization?  If this
>> is the case I wonder about an approach of disabling fifomerge when
>> there are ongoing setting changes, and then setting it after things
>> settle down?  I'll have to think about it, but I was trying to avoid
>> needing a multi-step state machine to avoid the associated race
>> conditions, but if this is not possible then it is not possible.
>>
>>> I didn't write omapdss's apply.c for fun or to make omapfb simpler. I
>>> made it because the shadow register system is complex, and we need to
>>> handle the tricky cases somewhere.
>>>
>>> So, as I said before, I believe you'll just end up writing similar code
>>> to what is currently in apply.c. It won't be as simple as your current
>>> branch.
>>>
>>> Also, as I mentioned earlier, you'll also need to handle the output side
>>> of the shadow registers. These come from the output drivers (DPI, DSI,
>>> etc, and indirectly from panel drivers). They are not currently handled
>>> in the best manner in omapdss, but Archit is working on that and in his
>>> version apply.c will handle also those properly.
>>
>>
>> The encoder/connector part of things is something that I have not
>> tackled yet.. but I expect if there is something that can handle
>> fifomerge, etc, then it should also be usable from the encoder code.
>>
>> I need to have a closer look at the patches from Archit (I assume you
>> are talking about the series he sent earlier today) and see if that
>> makes things easier for me to map properly to kms encoder/connector.
>
>
> I guess the work Tomi is talking about is already merged in 3.6. It ensures
> that interface drivers(DSI/HDMI) don't do direct DISPC register writes on
> overlay managers. For example, when HDMI's timings are changed, the TV
> manager's DISPC_SIZE_DIGIT needs to be configured, and it's a shadow
> register. There was no guarantee previously that when the HDMI driver writes
> to this register the GO bit of the TV manager is clear.

ahh, ok.. actually I've commented out (I think) all of the mgr
register updates from the HDMI driver for my prototype.  These already
get set properly from the kms crtc (going through GO bit / apply
mechanism to synchronize w/ GO bit), so I don't even need the
interface/panel driver to set this stuff up.

> The stuff I posted today is a part of a bigger series, it's final aim is to
> have an entity in omapdss which is an equivalent of drm_encoder in your new
> drm arrangement, i.e, an entity which represents an interface. We call it
> outputs, a manager would now connect to an output instead of a panel, and
> the output would now connect to the panel. So the connection will be like:

Ok.. this would help.  I'll take a look.  I do request that
interfaces/panels don't set any mgr/timing related registers.  I had
to comment all this stuff out in my prototype.  Really we want to set
the timings separately on the crtc (mgr) / encoder (interface) /
connector (panel.. not sure if it is needed, though?).  KMS will take
care of propagating the timings through the pipeline.

BR,
-R

> ovl->manager->output->device
>
> The whole set is in the tree below, I'm posting the set out in smaller
> parts.
>
> git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git
> out_work_23_july
>
> Archit
>
>>
>>> About your code, I see you have these pre and post apply callbacks that
>>> handle the configuration. Wouldn't it be rather easy to have omapdss's
>>> apply.c call these?
>>
>>
>> Possibly.. really what I am working on now is a proof of concept.  But
>> I think that once it works properly, if there is a way to shuffle
>> things around to get more re-use from omapfb/etc, then that would be a
>> good idea.  I'm not opposed to that.  But we at least need to figure
>> out how to get it working properly for drm/kms's needs.
>>
>>> And then one thing I don't think you've considered is manual update
>>> displays. Of course, one option is to not support those with omapdrm,
>>> but that's quite a big decision. omapdss's apply.c handles those also.
>>
>>
>> well, mainly because it is only proof of concept so far, and I don't
>> actually have any hardware w/ a manual update display.  But I think
>> manual update needs some more work at a few layers.  We need userspace
>> xorg driver to call DRM_IOCTL_MODE_DIRTYFB at the appropriate times
>> (in case it is doing front buffer rendering), then on kernel side we
>> need to defer until gpu access has finished (similar to how a
>> page_flip is handled).  After that, if I understand properly, we can
>> use the same apply mechanism to kick the encoder to push the update
>> out to the display.
>>
>>> Also, can you check again my mail "Re: OMAPDSS vsyncs/apply" Sat, 12 May
>>> 2012 10:01:24, about the request_config() suggestion. I think that would
>>> be somewhat similar to your pre/post callbacks. I'll try to write some
>>> prototype for the request_config suggestion so that it's easier to
>>> understand.
>>
>>
>> I'll look again, but as far as I remember that at least wasn't
>> addressing the performance issues from making overlay enable/disable
>> synchronous.  And fixing that would, I expect, trigger the same
>> problems that I already spent a few days debugging before switching
>> over to handle apply in omapdrm.
>>
>> BR,
>> -R
>>
>>>   Tomi
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
