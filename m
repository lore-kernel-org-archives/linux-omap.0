From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/1] omap3: add definition for CONTROL_CAMERA_PHY_CTRL
Date: Wed, 11 Jan 2012 07:11:58 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201110700220.31702@utopia.booyaka.com>
References: <1323875656-17147-1-git-send-email-sakari.ailus@iki.fi> <20120108104339.GP9323@valkosipuli.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51346 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757501Ab2AKOL7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jan 2012 09:11:59 -0500
In-Reply-To: <20120108104339.GP9323@valkosipuli.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, laurent.pinchart@ideasonboard.com

Hi Sakari

On Sun, 8 Jan 2012, Sakari Ailus wrote:

> Hi Tony and Paul,
> 
> On Wed, Dec 14, 2011 at 05:14:16PM +0200, Sakari Ailus wrote:
> > The register is used to configure the behaviour of the CSI-2 and CCP-2
> > receivers. This register is available only in OMAP3630.
> > 
> > The original patch was submitted by Vimarsh Zutshi.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@iki.fi>
> > ---
> >  arch/arm/mach-omap2/control.h |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
> > index d4ef75d..6a26a0d 100644
> > --- a/arch/arm/mach-omap2/control.h
> > +++ b/arch/arm/mach-omap2/control.h
> > @@ -183,6 +183,7 @@
> >  #define OMAP3630_CONTROL_FUSE_OPP120_VDD1       (OMAP2_CONTROL_GENERAL + 0x0120)
> >  #define OMAP3630_CONTROL_FUSE_OPP50_VDD2        (OMAP2_CONTROL_GENERAL + 0x0128)
> >  #define OMAP3630_CONTROL_FUSE_OPP100_VDD2       (OMAP2_CONTROL_GENERAL + 0x012C)
> > +#define OMAP3630_CONTROL_CAMERA_PHY_CTRL	(OMAP2_CONTROL_GENERAL + 0x02f0)
> 
> I assume this patch hasn't gone anywhere yet which might be good. While the
> definition of this register would appear to belong to this file, it is being
> included from the OMAP 3 ISP driver, which only uses it if it's running on
> the 3630. The problem is that control.h isn't apparently intended to be
> included except locally and I didn't find a suitable file under include/mach
> to put this definition either. Currently this file is being included by the
> ISP driver with an explicit path.
> 
> Do you have an insight how this could be handled better?

We've been trying to ensure that register accesses to/from a given IP 
block only occur in a driver for that IP block.  So under that principle, 
any System Control Module accesses should go into a System Control Module 
driver.  Then that SCM driver should export (via EXPORT_SYMBOL) a 
higher-level interface to whatever code uses it.  The idea is that this 
interface would remain stable no matter what underlying SoC was in use.

Only thing is, we don't yet have a SCM driver.  Historically, since the 
SCM is tightly coupled with the underlying SoC, when we've needed to do 
something like this in the past, we've added code to 
arch/arm/mach-omap2/control.c.  But that's not really workable now.

Do you know if this register, or something like it, is present on later 
OMAPs?  Also, which bitfields are you planning to use?


- Paul
