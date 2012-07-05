From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention
 issue
Date: Thu, 5 Jul 2012 13:19:01 +0200
Message-ID: <20120705111901.GR22065@sortiz-mobl>
References: <87fw9o32v2.fsf@ti.com>
 <CAP05o4KxWFjCCP05KzQgo4vWLdvOCeT=DWGXvEEnyWkomH1tXA@mail.gmail.com>
 <20120622103050.GG28472@arwen.pp.htv.fi>
 <87ehp71liv.fsf@ti.com>
 <20120622203645.GD29290@arwen.pp.htv.fi>
 <87d34nfdei.fsf@ti.com>
 <871uku85o8.fsf@ti.com>
 <CAP05o4+hxt6zY0AxK5aNW7a3Hyiw0_krP9=XK_prN5=Uk2SxmA@mail.gmail.com>
 <CAP05o4KinrK7N13nivOy+reibY526c8sv6ySkxwDZwDMJHSaiQ@mail.gmail.com>
 <87k3yj4pn4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10262 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752778Ab2GELHj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Jul 2012 07:07:39 -0400
Content-Disposition: inline
In-Reply-To: <87k3yj4pn4.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Munegowda, Keshava" <keshava_mgowda@ti.com>, balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, notasas@gmail.com, Paul Walmsley <paul@pwsan.com>

Hi Kevin, Keshava,

On Wed, Jul 04, 2012 at 06:33:35AM -0700, Kevin Hilman wrote:
> "Munegowda, Keshava" <keshava_mgowda@ti.com> writes:
> 
> > On Tue, Jul 3, 2012 at 12:17 PM, Munegowda, Keshava
> > <keshava_mgowda@ti.com> wrote:
> >> On Mon, Jul 2, 2012 at 10:24 PM, Kevin Hilman <khilman@ti.com> wrote:
> >>> Felipe, Keshava,
> >>>
> >>> Kevin Hilman <khilman@ti.com> writes:
> >>>
> >>>> Felipe Balbi <balbi@ti.com> writes:
> >>>>
> >>>> [...]
> >>>>
> >>>>> Keshava is reverting a fix for a HW errata. I can't accept it as it will
> >>>>> cause regressions. Granted, regression by regression, there's no change,
> >>>>> but I simply can't knowingly cause a regression to the driver just to
> >>>>> have PM working. We need a real fix for this issue.
> >>>>
> >>>> Sure, as long as there is a fix in this -rc cycle.
> >>>>
> >>>> This driver intoduced changes in v3.5 that break PM for the whole SoC
> >>>> (by preventing CORE retention.)  These changes were clearly not tested
> >>>> with PM.
> >>>>
> >>>> If you cannot fix this during the -rc cycle, then you need to revert the
> >>>> driver PM changes that broke PM for the *whole* SoC.
> >>>
> >>> What's the status of this regression?
> >>>
> >>> This is still broken in v3.5-rc and is preventing CORE retention for the
> >>> *whole* SoC.
> >>>
> >>> Please fix this, either with a proper fix, or a revert for 3.5-rc.
> >>
> >>
> >> The proper fix for this is implement ion of ehci remote wakeup through
> >> I/O chain handler; it takes time.
> >> As Felipe also mentioned,  This patch is OK for now.
> >
> > Sorry, Felipe still insist not to revert this patch, but to change
> > this patch requires quite more changes in the usbhs core
> > and we need to see the how the hub control changes need to be brought
> > in to usbhs core. so , reverting is the
> > best solution to time being.
> >
> > Its observed that ehci was enabled after linux kernal version 3.3 ;
> > before that even though driver was there
> > the ehci deriver was disabled by defaults; and it is expected the
> > people who want to use NFS then can enable it
> > explicitly.
> >
> > so,  the solution is
> >
> > 1. Use this patch ( reverting the hw errata ) to fix the NFS Boot and
> > suspend/resume crash
> 
> Or, use the patches from Russ Dill where were more targetted fixes.
> Either way, I'm OK with that.
Keshava, I'll wait for your decision here to know which patch you want me to
take.



> > 2. Disable the ehci driver to make the pm work in idle case ;
> >               This configuration should exist till the ehci remote
> > wakeup implementation completes.
> 
> Yes.  Please disabled it by default.
> 
> Until PM in this driver can work without breaking PM for the whole SoC,
> it should remain disabled.
So, I should expect another patch here as well.
FYI, I was planning to send a pull request for MFD 3.5 fixes to Linus
tomorrow, but I'll wait for you. Hopefully I should be able to send it on
Monday.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
