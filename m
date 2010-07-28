From: "Sin, David" <davidsin@ti.com>
Subject: RE: [RFC 1/8] TILER-DMM: DMM-PAT driver for TI TILER
Date: Wed, 28 Jul 2010 09:39:21 -0500
Message-ID: <513FF747EED39B4AADBB4D6C9D9F9F7903D64D75EB@dlee02.ent.ti.com>
References: <1279927348-21750-1-git-send-email-davidsin@ti.com>
 <513FF747EED39B4AADBB4D6C9D9F9F7903D644D974@dlee02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E7394044ED6385D@dbde02.ent.ti.com>
 <201007281200.23458.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35174 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754730Ab0G1Ojl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jul 2010 10:39:41 -0400
In-Reply-To: <201007281200.23458.laurent.pinchart@ideasonboard.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King <rmk@arm.linux.org.uk>, Ohad Ben-Cohen <ohad@wizery.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Molnar, Lajos" <molnar@ti.com>

> -----Original Message-----
> From: Laurent Pinchart [mailto:laurent.pinchart@ideasonboard.com] 
> Sent: Wednesday, July 28, 2010 5:00 AM
> To: linux-arm-kernel@lists.infradead.org
> Cc: Hiremath, Vaibhav; Sin, David; 
> linux-omap@vger.kernel.org; Tony Lindgren; Russell King; Ohad 
> Ben-Cohen; Kanigeri, Hari; Shilimkar, Santosh; Molnar, Lajos
> Subject: Re: [RFC 1/8] TILER-DMM: DMM-PAT driver for TI TILER
> 
> 
> On Tuesday 27 July 2010 21:53:28 Hiremath, Vaibhav wrote:
> > On Wednesday 28 July 2010 00:35:00 Sin, David wrote:
> > > On Tuesday 27 July 2010 01:38:00 Hiremath, Vaibhav wrote:
> > > > On Saturday 24 July 2010 04:52:00 Sin, David wrote:
> 
> [snip]
> 
> > > > [Hiremath, Vaibhav] If I understand correctly, DMM stands for
> > > > dynamic memory manager. Is it something which can only be
> > > > used with Video devices? Any specific reason why this is part
> > > > of drivers/media/video/ directory,
> > >
> > > [dhs] Any device can use TILER memory, but there is a big 
> advantage,
> > > performance-wise, for 2-Dimensional macro block based 
> buffers.  This HW
> > > is intended for image/video hardware accelerators (e.g. 
> OMAP4 IVA-HD). 
> > > Plus there's the added advantage of doing zero-copy flips 
> and rotations
> > > for the OMAP display and image sub-systems.
> > 
> > [Hiremath, Vaibhav] When you mention Tiler memory, you 
> meant Tiler Virtual
> > memory which is independent of physical memory. Driver 
> requesting/using
> > Tiler is responsible for allocating physical memory. Is 
> that understanding
> > correct?

[dhs] Yes this is correct.  I'm referring to the 33 bit 4 GB TILER virtual memory.

> > 
> > If yes, then feature wise it is same as VRFB in OMAP3, 
> where it provides
> > virtual address space and driver requesting VRFB is responsible for
> > physical memory allocation. There could be additional features,
> > enhancement and stuff but zero-copy rotation for DSS, then 
> its same as
> > VRFB.
> > 
> > Don't you think is would be very difficult to use for 
> drivers with such
> > proposals, I can comment from DSS point of view,
> > 
> > In case of OMAP4 80% of code is being re-used from OMAP3 
> (located under
> > drivers/video/omap2/), which is currently supported hardware
> > rotation/mirroring and hardly tied to VRFB API's.
> > 
> > Now with this driver we have to do something,
> > 
> > cpu_is_omap34xx()
> >         VRFB
> > else if cpu_is_omap44xx()
> >         Tiler
> > 
> > I am not sure about further OMAP series of devices, where 
> we might have
> > something else with DSS IP reuse (along with software). And 
> I believe
> > Tiler is not part of DSS at all. Again if some other 
> devices are using
> > Tiler API's it would become more difficult to re-use the 
> code when same IP
> > is being used in multiple SoC's.
> > 
> > Does it make sense to you to have registration based 
> mechanism (function
> > pointer) where you register your hardware 
> capabilities/API's, driver don't
> > have to dependent on underneath hardware block. Ofcource if 
> driver intend
> > to use some specific/custom feature supported by some 
> hardware block then
> > he has to call that API under cpu_is_xxxx
> 
> I think I agree with it. The tiler provides dynamic views on 
> arbitrary 
> physical memory. Ideally it shouldn't be tied to the 
> media/video subsystem 
> (obviously it should still provide an interface for V4L drivers).
> 
> It's getting a bit hard to comment on the proposal, as 
> there's no public 
> documentation I'm aware of beside the Documentation/arm/TILER 
> file in the 
> patch set, and that information is far too concise and vague.
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 

[dhs] I understand what you're stating here, conceptually, but I'm missing some details.  Do you mean that there needs to be a generic layer between a given video memory allocator and V4L? and that set of APIs should point to specific functions based on availability (e.g. VRFB, TILER, future TILER, other IP, etc)?

Laurent:  The TRM for DMM-TILER should be publicly available already, but for some reason, I'm not able to see the link.  I will work on this...  