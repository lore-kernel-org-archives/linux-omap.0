From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
Date: Tue, 30 Nov 2010 15:32:25 +0200
Message-ID: <1291123945.24627.223.camel@tubuntu>
References: <19F8576C6E063C45BE387C64729E739404BC762E9A@dbde02.ent.ti.com>
	 <1290589057.13243.22.camel@tubuntu>
	 <19F8576C6E063C45BE387C64729E739404BCCA3A55@dbde02.ent.ti.com>
	 <20101124163100.GB5681@nokia.com>
	 <19F8576C6E063C45BE387C64729E739404BCCA3CAE@dbde02.ent.ti.com>
	 <yw1xeia81nts.fsf@unicorn.mansr.com>
	 <19F8576C6E063C45BE387C64729E739404BCCA401F@dbde02.ent.ti.com>
	 <20101126125539.GG8094@nokia.com> <20101130063440.GF17114@linux-sh.org>
	 <20101130063934.GG17114@linux-sh.org>
	 <19F8576C6E063C45BE387C64729E739404BCCA455A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:58489 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab0K3Ncy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Nov 2010 08:32:54 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E739404BCCA455A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Ville Syrj?l? <ville.syrjala@nokia.com>, M?ns Rullg?rd <mans@mansr.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Tue, 2010-11-30 at 12:29 +0530, ext Hiremath, Vaibhav wrote:
> > -----Original Message-----
> > From: Paul Mundt [mailto:lethal@linux-sh.org]
> > Sent: Tuesday, November 30, 2010 12:10 PM
> > To: Ville Syrj?l?
> > Cc: Hiremath, Vaibhav; M?ns Rullg?rd; linux-omap@vger.kernel.org; linux-
> > fbdev@vger.kernel.org
> > Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
> > 
> > On Tue, Nov 30, 2010 at 03:34:40PM +0900, Paul Mundt wrote:
> > > On Fri, Nov 26, 2010 at 02:55:39PM +0200, Ville Syrj?l? wrote:
> > > > On Fri, Nov 26, 2010 at 05:38:11PM +0530, ext Hiremath, Vaibhav wrote:
> > > > > With this finding, in case of OMAP3 we have to use OMAPFB_WAITFORGO
> > > > > (breaking standard applications).
> > > >
> > > > Applications using the standard fbdev API won't work with manual
> > update
> > > > displays anyway. You need omapfb specific code to handle it so having
> > > > another small difference is not a big deal.
> > > >
> > > > In DirectFB the that's trivial since there's already a simple omap
> > > > gfxdriver where you could override the default flip functionality with
> > > > WAITFORGO based stuff.
> > > >
> > > > Or, as I said, you could add another standard ioctl and fix up
> > userspace
> > > > to use it where appropriate and if the kernel driver supports it.
> > > >
> > > It seems like the WAITFORGO semantics could be layered on top of drivers
> > > using deferred I/O pretty easily, but the question is whether this is
> > > something that userspace plans to make general use of or not. If the
> > only
> > > user of it in userspace code is OMAP-specific, then there's probably not
> > > a lot of point in moving it over to be generic, but if there are
> > > sufficient cases where userspace cares about this information
> > independent
> > > of WAITFORVSYNC for manual update displays, then we can certainly look
> > at
> > > moving it over for those cases.
> > 
> > Also, WAITFORGO is a pretty abysmal name. It seems like what you want is
> > a WAITFORHWSYNC or something similar.
> [Hiremath, Vaibhav] Yes exactly, this name fits to the use-case and sounds ok to me. 
> 
> Tomi,
> Any comments?

Ah, I seem to have been dropped out from this mail thread...

Yes, WAITFORHWSYNC sounds much better.

But there seems to be some misunderstanding of what this is about.
Deferred IO or manual update displays are not directly related to this.
This is about configuration registers, ie. address, size, etc. of the
framebuffer, not about the contents of the framebuffer.

The reason why WAITFORGO was implemented is: 

OMAP has user writeable shadow registers and hidden real registers for
display controller. The shadow registers are latched to real registers
on VFP, but only if GO bit has been set. The GO bit is cleared by the HW
when latching has been done.

If the GO bit is set, we cannot touch the shadow registers because we
don't know when the VFP  will happen. That's why there's additionally a
SW cache for the config, so that we don't need to block when the GO bit
is up and the user wants to change the config. The driver "flushes" the
SW config to real registers in VSYNC interrupt handler.

This is why the user may need to wait multiple vsyncs until the config
has really been written to the real HW registers, and WAITFORGO waits
for this. But if there has not been any config changes, WAITFORGO
doesn't wait at all.

So WAITFORVSYNC and WAITFORGO do quite a different thing on OMAP. It is
true what Hiremath says, WAITFORVSYNC is difficult (impossible?) to use
properly on OMAP as if the config write happens between VFP and VSYNC,
the config is not actually yet in the real registers.

But I'm still not comfortable with just moving WAITFORGO over
WAITFORVSYNC. At least we should then change WAITFORGO to always wait at
least for the next vsync, so that it wouldn't return immediately when
there are no pending changes. This would make WAITFORGO act like
WAITFORVSYNC in many cases, but not always.

And to add to the confusion, there are multiple overlays on OMAP. They
may be currently shared by multiple users (for example omapfb and v4l2).
If the user uses WAITFORVSYNC, the call will return for every vsync, as
expected. If he uses WAITFORGO, the call will return in random number of
vsyncs from the user's point of view, because the other user may be
competing from the same resource.

One could still argue that always using WAITFORGO is better, as there's
the problem with WAITFORVSYNC that Hiremath described. But then again,
WAITFORGO acts differently than what (I think) WAITFORVSYNC should do.

So summa summarum, I didn't know how to solve this perfectly earlier,
and thus I implemented WAITFORGO, and I still don't know what would be
the perfect solution.

 Tomi


