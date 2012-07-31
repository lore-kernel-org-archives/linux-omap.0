From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH] drm: refcnt drm_framebuffer
Date: Tue, 31 Jul 2012 18:47:45 +0100
Message-ID: <1343756872_22859@CP5-2952>
References: <1343751621-1868-1-git-send-email-rob.clark@linaro.org> <1343754016_22717@CP5-2952> <CAF6AEGurctYdnsXg6SoT9nWPjX9z+nhMwU9NO3K+hAqKmszi1Q@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.fireflyinternet.com ([109.228.6.236]:34992 "EHLO
	fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753730Ab2GaRsF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jul 2012 13:48:05 -0400
In-Reply-To: <CAF6AEGurctYdnsXg6SoT9nWPjX9z+nhMwU9NO3K+hAqKmszi1Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, Greg KH <greg@kroah.com>, patches@linaro.org

On Tue, 31 Jul 2012 12:41:28 -0500, Rob Clark <rob.clark@linaro.org> wrote:
> On Tue, Jul 31, 2012 at 12:00 PM, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> > On Tue, 31 Jul 2012 11:20:21 -0500, Rob Clark <rob.clark@linaro.org> wrote:
> >> From: Rob Clark <rob@ti.com>
> >>
> >> This simplifies drm fb lifetime, and if the crtc/plane needs to hold
> >> a ref to the fb when disabling a pipe until the next vblank, this
> >> avoids the need to make disabling an overlay synchronous.  This is a
> >> problem that shows up when userspace is using a drm plane to
> >> implement a hw cursor.. making overlay disable synchronous causes
> >> a performance problem when x11 is rapidly enabling/disabling the
> >> hw cursor.  But not making it synchronous opens up a race condition
> >> for crashing if userspace turns around and immediately deletes the
> >> fb.  Refcnt'ing the fb makes it possible to solve this problem.
> >
> > Presumably you have a follow-on patch putting the new refcnt to use so
> > that we can judge whether you truly need refcnting on the fb itself in
> > addition to the refcnted object and the various hw bookkeeping that
> > needs to be performed?
> 
> Yes, I do.. although it is a bit experimental at this point, so not
> really ready to be submitted as anything other than an RFC.. it is
> part of omapdrm kms re-write to use dispc directly rather than go thru
> omapdss.  (With omapdss we don't hit this issue because disabling
> overlays is forced to be synchronous.. so instead we have the
> performance problem I mentioned.)
> 
> I *could* just rely on the GEM refcnt, but that gets messier when you
> take into account multi-planar formats.  I suppose I also could have
> my own internal refcnt'd object to hold the set of GEM objects
> associated w/ the fb, but, well, that seems a bit silly.  And
> refcnt'ing the fb had been mentioned previously as a good thing to do
> (I think it was danvet?)

Sure, there are a few places in the code that have caused ordering
issues in the past due to lack of refcnting the fb... But since you
haven't fixed up those cases, I'm looking for justification for adding
that extra bit of complexity. Adding a new interface and no users is
just asking for trouble.
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
