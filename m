From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
Date: Fri, 17 Dec 2010 14:29:54 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BD0DBA3B@dbde02.ent.ti.com>
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
 <1291123945.24627.223.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33970 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752708Ab0LQJAN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 04:00:13 -0500
In-Reply-To: <1291123945.24627.223.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Ville Syrj?l? <ville.syrjala@nokia.com>, M?ns Rullg?rd <mans@mansr.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Tuesday, November 30, 2010 7:02 PM
> To: Hiremath, Vaibhav
> Cc: Paul Mundt; Ville Syrj?l?; M?ns Rullg?rd; linux-omap@vger.kernel.org;
> linux-fbdev@vger.kernel.org
> Subject: RE: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
> 
> On Tue, 2010-11-30 at 12:29 +0530, ext Hiremath, Vaibhav wrote:
> > > -----Original Message-----
> > > From: Paul Mundt [mailto:lethal@linux-sh.org]
> > > Sent: Tuesday, November 30, 2010 12:10 PM
> > > To: Ville Syrj?l?
> > > Cc: Hiremath, Vaibhav; M?ns Rullg?rd; linux-omap@vger.kernel.org;
> linux-
> > > fbdev@vger.kernel.org
> > > Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
> > >
> > > On Tue, Nov 30, 2010 at 03:34:40PM +0900, Paul Mundt wrote:
> > > > On Fri, Nov 26, 2010 at 02:55:39PM +0200, Ville Syrj?l? wrote:
> > > > > On Fri, Nov 26, 2010 at 05:38:11PM +0530, ext Hiremath, Vaibhav
> wrote:

<snip>

> > > a WAITFORHWSYNC or something similar.
> > [Hiremath, Vaibhav] Yes exactly, this name fits to the use-case and
> sounds ok to me.
> >
> > Tomi,
> > Any comments?
> 
> Ah, I seem to have been dropped out from this mail thread...
> 
> Yes, WAITFORHWSYNC sounds much better.
> 
> But there seems to be some misunderstanding of what this is about.
> Deferred IO or manual update displays are not directly related to this.
> This is about configuration registers, ie. address, size, etc. of the
> framebuffer, not about the contents of the framebuffer.
> 
> The reason why WAITFORGO was implemented is:
> 
> OMAP has user writeable shadow registers and hidden real registers for
> display controller. The shadow registers are latched to real registers
> on VFP, but only if GO bit has been set. The GO bit is cleared by the HW
> when latching has been done.
> 
> If the GO bit is set, we cannot touch the shadow registers because we
> don't know when the VFP  will happen. That's why there's additionally a
> SW cache for the config, so that we don't need to block when the GO bit
> is up and the user wants to change the config. The driver "flushes" the
> SW config to real registers in VSYNC interrupt handler.
> 
> This is why the user may need to wait multiple vsyncs until the config
> has really been written to the real HW registers, and WAITFORGO waits
> for this. But if there has not been any config changes, WAITFORGO
> doesn't wait at all.
> 
> So WAITFORVSYNC and WAITFORGO do quite a different thing on OMAP. It is
> true what Hiremath says, WAITFORVSYNC is difficult (impossible?) to use
> properly on OMAP as if the config write happens between VFP and VSYNC,
> the config is not actually yet in the real registers.
> 
> But I'm still not comfortable with just moving WAITFORGO over
> WAITFORVSYNC. At least we should then change WAITFORGO to always wait at
> least for the next vsync, so that it wouldn't return immediately when
> there are no pending changes. This would make WAITFORGO act like
> WAITFORVSYNC in many cases, but not always.
> 
> And to add to the confusion, there are multiple overlays on OMAP. They
> may be currently shared by multiple users (for example omapfb and v4l2).
> If the user uses WAITFORVSYNC, the call will return for every vsync, as
> expected. If he uses WAITFORGO, the call will return in random number of
> vsyncs from the user's point of view, because the other user may be
> competing from the same resource.
> 
> One could still argue that always using WAITFORGO is better, as there's
> the problem with WAITFORVSYNC that Hiremath described. But then again,
> WAITFORGO acts differently than what (I think) WAITFORVSYNC should do.
> 
> So summa summarum, I didn't know how to solve this perfectly earlier,
> and thus I implemented WAITFORGO, and I still don't know what would be
> the perfect solution.
> 
[Hiremath, Vaibhav] We did not had a closure on this topic, so summarizing our discussion here,

Let's keep FBIO_WAITFORVSYNC (or OMAPFB_WAITFORVSYNC) ioctl as is, since as of now the way we understand this ioctl is, it should barely wait for next vsync. 

Change the OMAPFB_WAITFORGO to (standard) FBIO_WAITFORHWSYNC, currently this will be used in OMAP2/3 Fb-display driver.

Thanks,
Vaibhav

>  Tomi
> 

