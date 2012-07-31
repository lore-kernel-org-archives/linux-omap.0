From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [RFC 0/3] solving omapdrm/omapdss layering issues
Date: Tue, 31 Jul 2012 09:45:40 -0500
Message-ID: <CAF6AEGuqi+E7i1cuZTCts1y46E3SDUzd8E3kuW52=jRC5EksaQ@mail.gmail.com>
References: <1343437674-24246-1-git-send-email-rob.clark@linaro.org>
	<1343742034.2633.56.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:54609 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640Ab2GaOpl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jul 2012 10:45:41 -0400
Received: by vcbfk26 with SMTP id fk26so5876551vcb.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jul 2012 07:45:40 -0700 (PDT)
In-Reply-To: <1343742034.2633.56.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Andy Gross <andy.gross@ti.com>

On Tue, Jul 31, 2012 at 8:40 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi,
>
> On Fri, 2012-07-27 at 20:07 -0500, Rob Clark wrote:
>> From: Rob Clark <rob@ti.com>
>>
>> I've been working for the better part of the week on solving some of
>> the omapdss vs kms mismatches, which is one of the bigger remaining
>> issues in the TODO before moving omapdrm out of staging.
>>
>> The biggest place that this shows up is in GO bit handling.  Basically,
>> some of the scanout related registers in DSS hw block are only shadow
>> registers, and if the GO bit is set during the vblank the hw copies
>> into the actual registers (not accessible to CPU) and clears the GO
>> bit.  When the GO bit is set, there is no safe way to update these
>> registers without undefined results.  So omapdss tries to be friendly
>> and abstract this, by buffering up the updated state, and applying it
>
> It's not really about being friendly. Omapdss tries to do as little as
> possible, while still supporting all its HW features. Shadow registers
> are a bit tricky creating this mess.

What I mean by 'friendly' is it tries to abstract this for simple
users, like an fbdev driver.  But this really quickly breaks down w/ a
more sophisticated user.  Which is why I've been more in favor of
making omapdss less of a layer.  The idea of using it as some helper
functions which handle a bit the variation of different generations of
hw while not abstracting the fundamental operating concepts of DSS IP
block (ie. GO bit stuff) seems perfect to me.  So dispc plus
dss_feature stuff seems like just what I'm looking for.

>> on the next vblank once the GO bit is cleared.  But this causes all
>> sorts of mayhem at the omapdrm layer, which would like to unpin the
>> previous scanout buffer(s) on the next vblank (or endwin) irq.  Due
>> to the buffering in omapdss, we have no way to know on a vblank if we
>> have switched to the scanout buffer or not.  Basically it works ok as
>> long as userspace is only ever updating on layer (either crtc or drm
>> plane) at a time.  But throw together hw mouse cursor (drm plane)
>> plus a window manager like compiz which does page flips, or wayland
>> (weston drm compositor) with hw composition (drm plane), and things
>> start to fail in a big way.
>>
>> I've tried a few approaches to preserve the omapdss more or less as it
>> is, by adding callbacks for when GO bit is cleared, etc.  But the
>> sequencing of setting up connector/encoder/crtc is not really what
>> omapdss expects, and would generally end up confusing the "apply"
>> layer in omapdss (it would end up not programming various registers
>> because various dirty flags would get cleared, for example mgr updated
>> before overlay connected, etc).
>
> Can you give more info what the problem is? It shouldn't end up not
> programming registers, except if there's a bug there.

Yeah, it is probably just a bug.. and a bug could be fixed.  But with
all that extra code it is certainly a lot harder to debug.  So 'could'
and 'should' are maybe two different things.

> Didn't the apply-id stuff I proposed some months ago have enough stuff
> to make this work?

I guess the approach I was trying was similar to that proposal.. it
probably could be made to work.  But I am really not a big fan of
unnecessary complexity.  And unnecessary layering adds complexity.
This is why in general most of the drm folks have preferred an
approach of helper fxns rather than layers.  And I tend to agree with
them.

> The thing about shadow registers is that we need to manage them in one
> central place. And the same shadow registers are used for both the
> composition stuff (overlays etc) and output stuff (video timings &
> configuration). If omapdrm handles the composition shadow registers, it
> also needs to handle all the other shadow registers.

Yup.. I'm handling it in a central place :-)

basically all the register programming is coming through the 'struct
omap_drm_apply' mechanism, so it is all aligned to vblank/framedone
and GO bit status.  So probably that isn't strictly needed, because
I'm treating all registers as shadow'd registers, but that seemed like
a clean approach.

>> Finally, in frustration, this afternoon I hit upon an idea.  Why not
>> just use the dispc code in omapdss, which is basically a stateless
>> layer of helper functions, and bypass the stateful layer of omapdss.
>
> If you do this, you'll need to implement all the stuff of the stateful
> layer in omapdrm. You can't just call the dispc funcs and expect things
> to work reliably. Things like enabling/disabling overlays with fifomerge
> requires possibly multiple vsyncs. And output related shadow registers
> may be changed separately from the composition side.

All the dispc fxn calls (except whatever is done directly from the
'omap_dss_device', which I haven't converted over yet) are done
synchronized to the ovl mgrs GO bit.  I haven't hooked up fifomerge
yet, although looking at the apply code in omapdss, that looks like it
should be pretty straightforward to hook into the same omap_drm_apply
mechanism.

> The apply.c is not there to make the life of the user of omapdss's easy,
> it's there to make the DSS hardware work properly =).
>
>> Since KMS helper functions already give us the correct sequence for
>> setting up the hardware, this turned out to be rather easy.  And fit
>> it quite nicely with my mechanism to queue up updates when the GO bit
>> is not clear.  And, unlike my previous attempts, it actually worked..
>> not only that, but it worked on the first boot!
>
> Well, not having read the omapdrm code, I'm not in the best position to
> comment, but I fear that while it seems to work, you have lots of corner
> cases where you'll get glitches. We had a lot simpler configuration
> model in the omapdss for long time, until the small corner cases started
> to pile up and new features started to cause problems, and I wrote the
> current apply mechanism.

I think you'd like drm/kms if you start to get into it.. and really it
is much better if folks like you who really know the hw well, and have
lot of experience with the corner cases are working at the drm/kms
layer and not staying beneath an omapdss arbitrary layer.  I have a
pretty good idea of what is needed from userspace and graphics
standpoint, but not your level of experience w/ DSS and related IP
blocks and all different sorts of crazy display panel technology.  So
I could really use your help at the drm/kms layer :-)

And btw, I think the current mapping of drm_encoder to mgr in omapdrm
is not correct.  I'm just in the process of shuffling things around.
I think drm/kms actually maps quite nicely to the underlying hardware
with the following arrangement:

 drm_plane -> ovl
 drm_crtc -> mgr
 drm_encoder -> DSI/DPI/HDMI/VENC encoder
 drm_connector -> pretty much what we call a panel driver today

>> So I am pretty happy about how this is shaping up.  Not only is it
>> simpler that my previous attepmts, and solves a few tricky buffer
>> unpin related issues.  But it also makes it very easy to wire in the
>> missing userspace vblank event handling without resorting to duct-
>> tape.
>
> Why is giving an event from omapdss at vsync "duct-tapy"?

well, at a minimum, it is duplicating at omapdss a lot of what drm
irq/vblank infrastructure already provides.

>> Obviously there is stuff still missing, and some hacks.  This is
>> really just a proof of concept at this stage.  But I wanted to send an
>> RFC so we could start discussing how to move forward.  Ie. could we
>> reasonably add support to build dispc as a library of stateless helper
>> functions, sharing it and the panel drivers between omapdrm and the
>> legacy omapdss based drivers.  Or is there no clean way to do that, in
>> which case we should just copy the code we need into omapdrm, and
>> leave the deprecated omapdss as it is for legacy drivers.
>
> I agree that we need to get omapdrm work well, as it's (or will be) the
> most important display framework. And if managing that requires us to
> combine omapdss and omapdrm, I'm fine with it.
>
> But, again, so far I don't understand why it's so difficult to have them
> separate with omapdss giving notifications of important events, and also
> how combining the two drivers would fix any issues (though I agree it
> could simplify some code somewhat).

I do think with enough debugging it *could* be made to work w/
separate omapdss layer.  But I'm a big fan or 'simpler is better'..
or maybe to put it another way, there is plenty of necessary
complexity (like managing memory/dmm in a dynamic way synchronized
with display/gpu/etc), so lets not make the problem more complex with
unnecessary complexity.

> So what I propose is first to look at the problems you have, so that I
> understand what the problem is with omapdss-omapdrm interaction.

It's quite likely that I'm not doing a very good job of explaining it.
 And unfortunately the current GO related issues aren't something that
show up w/ a simple fliptest/modetest.. they are showing up w/ more
complex userspace like compiz or wayland.  Although maybe I could
enhance modetest to the point where it triggers the same problems.

It would be quite useful if you could look at the omap_drm_apply
mechanism I had in omapdrm, because that seems like a quite
straightforward way to deal w/ shadowed registers.  I think it will
get a bit cleaner w/ moving the mgr code into the crtc, so I should
have an updated version of my current omapdrm-on-dispc patch later
today.

BR,
-R

>  Tomi
>
