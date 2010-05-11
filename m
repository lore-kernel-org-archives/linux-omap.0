From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/09] OMAP:GPIO:Implement GPIO in HWMOD way
Date: Tue, 11 May 2010 08:54:02 -0700
Message-ID: <20100511155402.GC13600@atomide.com>
References: <1271951720-21714-1-git-send-email-charu@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5387A73@dbde02.ent.ti.com>
 <20100507153204.GB387@atomide.com>
 <87pr13okkk.fsf@deeprootsystems.com>
 <20100510222257.GJ16460@atomide.com>
 <87r5licvmr.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58972 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab0EKPyI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 11:54:08 -0400
Content-Disposition: inline
In-Reply-To: <87r5licvmr.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Kevin Hilman <khilman@deeprootsystems.com> [100511 08:16]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Kevin Hilman <khilman@deeprootsystems.com> [100510 08:09]:
> >> Tony Lindgren <tony@atomide.com> writes:
> >> 
> >> > * Varadarajan, Charulatha <charu@ti.com> [100506 23:52]:
> >> >> Tony/ Kevin,
> >> >> 
> >> >> > -----Original Message-----
> >> >> > From: Varadarajan, Charulatha
> >> >> > Sent: Thursday, April 22, 2010 9:25 PM
> >> >> > To: linux-omap@vger.kernel.org
> >> >> > Cc: Nayak, Rajendra; paul@pwsan.com; tony@atomide.com;
> >> >> > khilman@deeprootsystems.com; Varadarajan, Charulatha
> >> >> > Subject: [PATCH 00/09] OMAP:GPIO:Implement GPIO in HWMOD way
> >> >> > 
> >> >> > This patch series implements GPIO as an early platform driver.
> >> >> > It makes OMAP2PLUS specific GPIO to get adapted to HWMOD FW.
> >> >> > OMAP1 specific GPIO is implemented as early platform device.
> >> >> > 
> >> >> > This patch series is created on "origin/pm-wip/hwmods". 
> >> >> 
> >> >> Planning to send few more patches for adapting some other
> >> >> drivers to HWMOD FW. 
> >> >> Which tree should those patches be created on?
> >> >> LO mainline? or hwmods branch? or runtime branch?
> >> >
> >> > All the patches should be against the most recent tag
> >> > in Linus' mainline tree, currently v2.6.34-rc6.
> >> >
> >> > If there are some dependencies to other patches, we need
> >> > to get those upstream immediately.
> >> 
> >> Please use pm-wip/runtime, which is currently based on v2.6.34-rc6
> >> + PM changes already submitted for 2.6.35 (3 patches)
> >
> > That's for the "few more patches for adapting some other drivers",
> > not for the GPIO patches, right?
> >
> > AFAIK, the GPIO patches should not have dependencies to the pm-wip.
> 
> Basing on pm-wip/runtime is for a couple reasons, but the most
> important is to avoid conflicts in the hwmod data files.  Since all the
> hwmods are in the same file, it makes it easy for me to track them
> if they apply onto existing hwmods.
> 
> > Kevin, let me know if you got some things ready to go that can
> > be pulled into omap-for-linus.
> 
> Nothing yet for hwmod.  The stuff that's mostly done is UART + MMC,
> but those both still need validation on OMAP2 and OMAP4.

OK, just trying to cut down dependencies between patches.
 
> >> In addition, this has the in-progress UART + MMC hwmod changes.
> >
> > Sounds like those are not ready to go yet then. So I guess it's
> > currently only your pm-next that's ready to go?
> 
> I've submitted PM core stuff in pm-next and I've also submitted some
> GPIO changes for 2.6.35.
> 
> I have a few more things to add to pm-next, and I'll be doing that
> today.

OK

Regards,

Tony
