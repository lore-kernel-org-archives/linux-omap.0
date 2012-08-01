From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [RFC 0/3] solving omapdrm/omapdss layering issues
Date: Wed, 1 Aug 2012 17:41:46 -0500
Message-ID: <CAF6AEGt197Vru5+UYbkAjhc0QspP2z+PGriCWgm2B_8LCMvoCw@mail.gmail.com>
References: <1343437674-24246-1-git-send-email-rob.clark@linaro.org>
	<1343742034.2633.56.camel@deskari>
	<CAF6AEGuqi+E7i1cuZTCts1y46E3SDUzd8E3kuW52=jRC5EksaQ@mail.gmail.com>
	<1343812870.2645.37.camel@deskari>
	<CAF6AEGuoVaOwwXnS3MKcoeKrtA3=Oi108jqM3iObd3EqTmC9Bw@mail.gmail.com>
	<50195D54.8020604@ti.com>
	<CAF6AEGvjKCgPh=sTL922J48N9eqMGD_kNrYx_bU-zBF-bXv=Ww@mail.gmail.com>
	<1343842704.2645.94.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:33243 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756341Ab2HAWlr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Aug 2012 18:41:47 -0400
Received: by vbbff1 with SMTP id ff1so7513911vbb.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Aug 2012 15:41:47 -0700 (PDT)
In-Reply-To: <1343842704.2645.94.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Andy Gross <andy.gross@ti.com>

On Wed, Aug 1, 2012 at 12:38 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Wed, 2012-08-01 at 11:53 -0500, Rob Clark wrote:
>
>> Ok.. this would help.  I'll take a look.  I do request that
>> interfaces/panels don't set any mgr/timing related registers.  I had
>> to comment all this stuff out in my prototype.  Really we want to set
>> the timings separately on the crtc (mgr) / encoder (interface) /
>> connector (panel.. not sure if it is needed, though?).  KMS will take
>> care of propagating the timings through the pipeline.
>
> If we only had auto-update displays, and only the video timings were
> shadow register, it'd work. Unfortunately we have other registers as
> shadow registers also, like DISPC_CONTROL1, DISPC_CONFIG1 and
> DISPC_DIVISOR1.

well, I was kinda thinking we just do all the register access from the
corresponding crtc (mgr)'s GO/apply sequencing..  so if, for example,
you change resolution, then the plane, crtc, encoder, panel all queue
up via omap_crtc_apply() on their associated crtc, and then at the
right time from pre_apply() fxns call the appropriate omapdss/dispc
function(s) for register updates.

I think that would work well for everything but mgr enable/disable
(which is infrequent, so ok to block for a few vblanks), and
fifomerge, which I'm a bit on the fence about.

> But we should think if this could be somehow be changed, so that all the
> shadow register info would come from one place. I do find it a bit
> unlikely with a quick thought, though.
>
> Well, hmm. Perhaps... Omapdrm (or omapfb etc) doesn't really need to
> know about the values of those registers, it just needs to control the
> GO bit. So perhaps if we had some method to inform omapdrm that these
> things have changed, and omapdrm would then set the GO bit as soon as
> possible.

Well, what I'm doing now is basically, if I update anything in any of
the omap_*_info structs, I schedule an apply, and from pre_apply
callback push the changes down to dispc.. I was thinking to follow the
same for encoder and probably connector.  (Not sure if doing things
like setting timings at hdmi need to be GO bit sync'd?  Maybe this
could be bypassed for the connector, but if not it is easy enough just
to use the same mechanism that the plane/crtc/encoder are already
using.)

> But there are some tricky stuff, like the divisors... Well, we need to
> think about this.

I think, if I understand properly, the most tricky thing is the shared
clocks.. although I'm not really sure if we can actually change things
like the core clock when you plug in a 2nd display w/out loosing sync
on the first?  That's seems like a tricky thing either way.  Anything
else, that is only effecting a single crtc->encoder->connector chain
can have register programming sync'd to that mgr's GO bit.

BR,
-R

>  Tomi
>
