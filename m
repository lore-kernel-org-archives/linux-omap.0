From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] drm: refcnt drm_framebuffer
Date: Wed, 1 Aug 2012 07:55:35 -0500
Message-ID: <CAF6AEGt0wZb9vpu62SmZG9zH_QF7=_HdA2=jepLc-6+rw-X=+A@mail.gmail.com>
References: <1343751621-1868-1-git-send-email-rob.clark@linaro.org>
	<1343754016_22717@CP5-2952>
	<CAF6AEGurctYdnsXg6SoT9nWPjX9z+nhMwU9NO3K+hAqKmszi1Q@mail.gmail.com>
	<1343756872_22859@CP5-2952>
	<CAF6AEGuY3-vF4DRmQrQVo_gwKgfKFczf7zXUZtUm4Ke__ewQwA@mail.gmail.com>
	<20120801113650.GA8283@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:49568 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681Ab2HAMzg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Aug 2012 08:55:36 -0400
Received: by vcbfk26 with SMTP id fk26so6973721vcb.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Aug 2012 05:55:35 -0700 (PDT)
In-Reply-To: <20120801113650.GA8283@intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>, Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org

On Wed, Aug 1, 2012 at 6:36 AM, Ville Syrj=E4l=E4
<ville.syrjala@linux.intel.com> wrote:
> On Tue, Jul 31, 2012 at 02:28:29PM -0500, Rob Clark wrote:
>> On Tue, Jul 31, 2012 at 12:47 PM, Chris Wilson <chris@chris-wilson.c=
o.uk> wrote:
>> > On Tue, 31 Jul 2012 12:41:28 -0500, Rob Clark <rob.clark@linaro.or=
g> wrote:
>> >> On Tue, Jul 31, 2012 at 12:00 PM, Chris Wilson <chris@chris-wilso=
n.co.uk> wrote:
>> >> > On Tue, 31 Jul 2012 11:20:21 -0500, Rob Clark <rob.clark@linaro=
=2Eorg> wrote:
>> >> >> From: Rob Clark <rob@ti.com>
>> >> >>
>> >> >> This simplifies drm fb lifetime, and if the crtc/plane needs t=
o hold
>> >> >> a ref to the fb when disabling a pipe until the next vblank, t=
his
>> >> >> avoids the need to make disabling an overlay synchronous.  Thi=
s is a
>> >> >> problem that shows up when userspace is using a drm plane to
>> >> >> implement a hw cursor.. making overlay disable synchronous cau=
ses
>> >> >> a performance problem when x11 is rapidly enabling/disabling t=
he
>> >> >> hw cursor.  But not making it synchronous opens up a race cond=
ition
>> >> >> for crashing if userspace turns around and immediately deletes=
 the
>> >> >> fb.  Refcnt'ing the fb makes it possible to solve this problem=
=2E
>> >> >
>> >> > Presumably you have a follow-on patch putting the new refcnt to=
 use so
>> >> > that we can judge whether you truly need refcnting on the fb it=
self in
>> >> > addition to the refcnted object and the various hw bookkeeping =
that
>> >> > needs to be performed?
>> >>
>> >> Yes, I do.. although it is a bit experimental at this point, so n=
ot
>> >> really ready to be submitted as anything other than an RFC.. it i=
s
>> >> part of omapdrm kms re-write to use dispc directly rather than go=
 thru
>> >> omapdss.  (With omapdss we don't hit this issue because disabling
>> >> overlays is forced to be synchronous.. so instead we have the
>> >> performance problem I mentioned.)
>> >>
>> >> I *could* just rely on the GEM refcnt, but that gets messier when=
 you
>> >> take into account multi-planar formats.  I suppose I also could h=
ave
>> >> my own internal refcnt'd object to hold the set of GEM objects
>> >> associated w/ the fb, but, well, that seems a bit silly.  And
>> >> refcnt'ing the fb had been mentioned previously as a good thing t=
o do
>> >> (I think it was danvet?)
>> >
>> > Sure, there are a few places in the code that have caused ordering
>> > issues in the past due to lack of refcnting the fb... But since yo=
u
>> > haven't fixed up those cases, I'm looking for justification for ad=
ding
>> > that extra bit of complexity. Adding a new interface and no users =
is
>> > just asking for trouble.
>>
>> hmm, I did realize that drm_plane cleanup only happens as a result o=
f
>> drm_framebuffer_cleanup().. which doesn't work too well if the drive=
r
>> is holding a ref to the fb :-/
>>
>> so I guess at a minimum I need to fix plane cleanup to be part of
>> drm_fb_helper_restore_fbdev_mode()
>
> Your patch would still significantly change the behavior of
> drm_mode_rmfb(). Currently it disables all planes and crtcs which
> currently use the fb, and it removes the fb id from the idr so that
> no new users of the fb can appear afterwards.
>
> Not that I really like the current behaviour of drm_mode_rmfb(), but
> it's been like that always, so changing it doesn't seem acceptable.

yeah, I'm working on an update that decouples the crtc/plane shutdown
from deleting the fb, which should address these issues

BR,
-R

> --
> Ville Syrj=E4l=E4
> Intel OTC
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
