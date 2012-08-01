From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] drm: refcnt drm_framebuffer
Date: Wed, 1 Aug 2012 14:36:50 +0300
Message-ID: <20120801113650.GA8283@intel.com>
References: <1343751621-1868-1-git-send-email-rob.clark@linaro.org>
 <1343754016_22717@CP5-2952>
 <CAF6AEGurctYdnsXg6SoT9nWPjX9z+nhMwU9NO3K+hAqKmszi1Q@mail.gmail.com>
 <1343756872_22859@CP5-2952>
 <CAF6AEGuY3-vF4DRmQrQVo_gwKgfKFczf7zXUZtUm4Ke__ewQwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:12013 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753164Ab2HALgz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Aug 2012 07:36:55 -0400
Content-Disposition: inline
In-Reply-To: <CAF6AEGuY3-vF4DRmQrQVo_gwKgfKFczf7zXUZtUm4Ke__ewQwA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: Chris Wilson <chris@chris-wilson.co.uk>, Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org

On Tue, Jul 31, 2012 at 02:28:29PM -0500, Rob Clark wrote:
> On Tue, Jul 31, 2012 at 12:47 PM, Chris Wilson <chris@chris-wilson.co=
=2Euk> wrote:
> > On Tue, 31 Jul 2012 12:41:28 -0500, Rob Clark <rob.clark@linaro.org=
> wrote:
> >> On Tue, Jul 31, 2012 at 12:00 PM, Chris Wilson <chris@chris-wilson=
=2Eco.uk> wrote:
> >> > On Tue, 31 Jul 2012 11:20:21 -0500, Rob Clark <rob.clark@linaro.=
org> wrote:
> >> >> From: Rob Clark <rob@ti.com>
> >> >>
> >> >> This simplifies drm fb lifetime, and if the crtc/plane needs to=
 hold
> >> >> a ref to the fb when disabling a pipe until the next vblank, th=
is
> >> >> avoids the need to make disabling an overlay synchronous.  This=
 is a
> >> >> problem that shows up when userspace is using a drm plane to
> >> >> implement a hw cursor.. making overlay disable synchronous caus=
es
> >> >> a performance problem when x11 is rapidly enabling/disabling th=
e
> >> >> hw cursor.  But not making it synchronous opens up a race condi=
tion
> >> >> for crashing if userspace turns around and immediately deletes =
the
> >> >> fb.  Refcnt'ing the fb makes it possible to solve this problem.
> >> >
> >> > Presumably you have a follow-on patch putting the new refcnt to =
use so
> >> > that we can judge whether you truly need refcnting on the fb its=
elf in
> >> > addition to the refcnted object and the various hw bookkeeping t=
hat
> >> > needs to be performed?
> >>
> >> Yes, I do.. although it is a bit experimental at this point, so no=
t
> >> really ready to be submitted as anything other than an RFC.. it is
> >> part of omapdrm kms re-write to use dispc directly rather than go =
thru
> >> omapdss.  (With omapdss we don't hit this issue because disabling
> >> overlays is forced to be synchronous.. so instead we have the
> >> performance problem I mentioned.)
> >>
> >> I *could* just rely on the GEM refcnt, but that gets messier when =
you
> >> take into account multi-planar formats.  I suppose I also could ha=
ve
> >> my own internal refcnt'd object to hold the set of GEM objects
> >> associated w/ the fb, but, well, that seems a bit silly.  And
> >> refcnt'ing the fb had been mentioned previously as a good thing to=
 do
> >> (I think it was danvet?)
> >
> > Sure, there are a few places in the code that have caused ordering
> > issues in the past due to lack of refcnting the fb... But since you
> > haven't fixed up those cases, I'm looking for justification for add=
ing
> > that extra bit of complexity. Adding a new interface and no users i=
s
> > just asking for trouble.
>=20
> hmm, I did realize that drm_plane cleanup only happens as a result of
> drm_framebuffer_cleanup().. which doesn't work too well if the driver
> is holding a ref to the fb :-/
>=20
> so I guess at a minimum I need to fix plane cleanup to be part of
> drm_fb_helper_restore_fbdev_mode()

Your patch would still significantly change the behavior of
drm_mode_rmfb(). Currently it disables all planes and crtcs which
currently use the fb, and it removes the fb id from the idr so that
no new users of the fb can appear afterwards.

Not that I really like the current behaviour of drm_mode_rmfb(), but
it's been like that always, so changing it doesn't seem acceptable.

--=20
Ville Syrj=E4l=E4
Intel OTC
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
