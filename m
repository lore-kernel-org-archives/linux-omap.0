From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC 1/8] TILER-DMM: DMM-PAT driver for TI TILER
Date: Wed, 28 Jul 2010 21:16:22 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044EE51DAD@dbde02.ent.ti.com>
References: <1279927348-21750-1-git-send-email-davidsin@ti.com>
 <513FF747EED39B4AADBB4D6C9D9F9F7903D644D974@dlee02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E7394044ED6385D@dbde02.ent.ti.com>
 <201007281200.23458.laurent.pinchart@ideasonboard.com>
 <513FF747EED39B4AADBB4D6C9D9F9F7903D64D75EB@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33289 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785Ab0G1Pqo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jul 2010 11:46:44 -0400
In-Reply-To: <513FF747EED39B4AADBB4D6C9D9F9F7903D64D75EB@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sin, David" <davidsin@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King <rmk@arm.linux.org.uk>, Ohad Ben-Cohen <ohad@wizery.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Molnar, Lajos" <molnar@ti.com>

> -----Original Message-----
> From: Sin, David
> Sent: Wednesday, July 28, 2010 8:09 PM
> To: Laurent Pinchart; linux-arm-kernel@lists.infradead.org
> Cc: Hiremath, Vaibhav; linux-omap@vger.kernel.org; Tony Lindgren; Russell
> King; Ohad Ben-Cohen; Kanigeri, Hari; Shilimkar, Santosh; Molnar, Lajos
> Subject: RE: [RFC 1/8] TILER-DMM: DMM-PAT driver for TI TILER
> 
> > -----Original Message-----
> > From: Laurent Pinchart [mailto:laurent.pinchart@ideasonboard.com]
> > Sent: Wednesday, July 28, 2010 5:00 AM
> > To: linux-arm-kernel@lists.infradead.org
> > Cc: Hiremath, Vaibhav; Sin, David;
> > linux-omap@vger.kernel.org; Tony Lindgren; Russell King; Ohad
> > Ben-Cohen; Kanigeri, Hari; Shilimkar, Santosh; Molnar, Lajos
> > Subject: Re: [RFC 1/8] TILER-DMM: DMM-PAT driver for TI TILER
<snip>

> > I think I agree with it. The tiler provides dynamic views on
> > arbitrary
> > physical memory. Ideally it shouldn't be tied to the
> > media/video subsystem
> > (obviously it should still provide an interface for V4L drivers).
> >
> > It's getting a bit hard to comment on the proposal, as
> > there's no public
> > documentation I'm aware of beside the Documentation/arm/TILER
> > file in the
> > patch set, and that information is far too concise and vague.
> >
> > --
> > Regards,
> >
> > Laurent Pinchart
> >
> 
> [dhs] I understand what you're stating here, conceptually, but I'm missing
> some details.  Do you mean that there needs to be a generic layer between a
> given video memory allocator and V4L? 
> and that set of APIs should point to
> specific functions based on availability (e.g. VRFB, TILER, future TILER,
> other IP, etc)?
> 
[Hiremath, Vaibhav] David,
As far as Memory allocator is concerned I think it is more generic term and should not really tie to underneath hardware/feature (Tiler, VRFB or could be anything). This is long time issue with every Embedded devices dealing with Video, due to their dynamic requirement of memory/buffers.

Have you looked at Samsung (CMA) and Qualcomm (IOMMU) patches for memory allocation/management? I think it is worth to look at their approach. 

Thanks,
Vaibhav

> Laurent:  The TRM for DMM-TILER should be publicly available already, but
> for some reason, I'm not able to see the link.  I will work on this...
