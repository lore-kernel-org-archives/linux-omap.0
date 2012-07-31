From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] drm: refcnt drm_framebuffer
Date: Tue, 31 Jul 2012 12:59:48 -0500
Message-ID: <CAF6AEGs5fKRfczv49KHC1wm1VuOUFN2Q1RyNAnESRC1uCVT9-A@mail.gmail.com>
References: <1343751621-1868-1-git-send-email-rob.clark@linaro.org>
	<1343754016_22717@CP5-2952>
	<CAF6AEGurctYdnsXg6SoT9nWPjX9z+nhMwU9NO3K+hAqKmszi1Q@mail.gmail.com>
	<1343756872_22859@CP5-2952>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:62438 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191Ab2GaR7t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jul 2012 13:59:49 -0400
Received: by vbbff1 with SMTP id ff1so6049999vbb.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jul 2012 10:59:49 -0700 (PDT)
In-Reply-To: <1343756872_22859@CP5-2952>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, Greg KH <greg@kroah.com>, patches@linaro.org

On Tue, Jul 31, 2012 at 12:47 PM, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> On Tue, 31 Jul 2012 12:41:28 -0500, Rob Clark <rob.clark@linaro.org> wrote:
>> On Tue, Jul 31, 2012 at 12:00 PM, Chris Wilson <chris@chris-wilson.co.uk> wrote:
>> > On Tue, 31 Jul 2012 11:20:21 -0500, Rob Clark <rob.clark@linaro.org> wrote:
>> >> From: Rob Clark <rob@ti.com>
>> >>
>> >> This simplifies drm fb lifetime, and if the crtc/plane needs to hold
>> >> a ref to the fb when disabling a pipe until the next vblank, this
>> >> avoids the need to make disabling an overlay synchronous.  This is a
>> >> problem that shows up when userspace is using a drm plane to
>> >> implement a hw cursor.. making overlay disable synchronous causes
>> >> a performance problem when x11 is rapidly enabling/disabling the
>> >> hw cursor.  But not making it synchronous opens up a race condition
>> >> for crashing if userspace turns around and immediately deletes the
>> >> fb.  Refcnt'ing the fb makes it possible to solve this problem.
>> >
>> > Presumably you have a follow-on patch putting the new refcnt to use so
>> > that we can judge whether you truly need refcnting on the fb itself in
>> > addition to the refcnted object and the various hw bookkeeping that
>> > needs to be performed?
>>
>> Yes, I do.. although it is a bit experimental at this point, so not
>> really ready to be submitted as anything other than an RFC.. it is
>> part of omapdrm kms re-write to use dispc directly rather than go thru
>> omapdss.  (With omapdss we don't hit this issue because disabling
>> overlays is forced to be synchronous.. so instead we have the
>> performance problem I mentioned.)
>>
>> I *could* just rely on the GEM refcnt, but that gets messier when you
>> take into account multi-planar formats.  I suppose I also could have
>> my own internal refcnt'd object to hold the set of GEM objects
>> associated w/ the fb, but, well, that seems a bit silly.  And
>> refcnt'ing the fb had been mentioned previously as a good thing to do
>> (I think it was danvet?)
>
> Sure, there are a few places in the code that have caused ordering
> issues in the past due to lack of refcnting the fb... But since you
> haven't fixed up those cases, I'm looking for justification for adding
> that extra bit of complexity. Adding a new interface and no users is
> just asking for trouble.

fwiw, my line of reasoning was: from userspace perspective, once you
do drm_mode_rmfb(), the fb is gone, so I didn't change where it gets
removed from the list of fb's or anything like that.  Instead I just
left it so that a driver could, if it wants, take an extra ref
temporarily to the fb to keep it around for a bit.  I didn't change
any of the existing drivers, other than update the to call
drm_framebuffer_unreference() instead of fb->funcs->delete() directly,
because I didn't want to break anything in existing drivers, and I
figured the new behavior was better as an opt-in by individual drivers
when they want to take advantage of refcnt'ing.  But if you have
suggestions about related cleanups that should be made, I'm willing to
take that on.

Anyways, like I mentioned, I'm still a little ways from being ready to
submit anything other than RFC patches in omapdrm to use fb
refcnt'ing, so this isn't something that needs to be merged
immediately.  But it seemed like low risk and like it would be
something that other drivers could take advantage of, so I figured it
was worth sending this patch now.

BR,
-R

> -Chris
>
> --
> Chris Wilson, Intel Open Source Technology Centre
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
