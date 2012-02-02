From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH 1/1] omap3: add definition for CONTROL_CAMERA_PHY_CTRL
Date: Thu, 2 Feb 2012 15:03:30 +0200
Message-ID: <20120202130330.GB841@valkosipuli.localdomain>
References: <1323875656-17147-1-git-send-email-sakari.ailus@iki.fi>
 <alpine.DEB.2.00.1201110700220.31702@utopia.booyaka.com>
 <20120111230355.GU9323@valkosipuli.localdomain>
 <201201120057.44435.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-68.nebula.fi ([83.145.220.68]:43986 "EHLO
	smtp-68.nebula.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740Ab2BBNDg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Feb 2012 08:03:36 -0500
Content-Disposition: inline
In-Reply-To: <201201120057.44435.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Paul Walmsley <paul@pwsan.com>, tony@atomide.com, linux-omap@vger.kernel.org, saaguirre@ti.com

Hi Laurent,

On Thu, Jan 12, 2012 at 12:57:44AM +0100, Laurent Pinchart wrote:
> On Thursday 12 January 2012 00:03:55 Sakari Ailus wrote:
> > On Wed, Jan 11, 2012 at 07:11:58AM -0700, Paul Walmsley wrote:
> > > On Sun, 8 Jan 2012, Sakari Ailus wrote:
> > > > Hi Tony and Paul,
> > > > 
> > > > On Wed, Dec 14, 2011 at 05:14:16PM +0200, Sakari Ailus wrote:
> > > > > The register is used to configure the behaviour of the CSI-2 and
> > > > > CCP-2 receivers. This register is available only in OMAP3630.
> > > > > 
> > > > > The original patch was submitted by Vimarsh Zutshi.
> > > > > 
> > > > > Signed-off-by: Sakari Ailus <sakari.ailus@iki.fi>
> > > > > ---
> > > > > 
> > > > >  arch/arm/mach-omap2/control.h |    1 +
> > > > >  1 files changed, 1 insertions(+), 0 deletions(-)
> > > > > 
> > > > > diff --git a/arch/arm/mach-omap2/control.h
> > > > > b/arch/arm/mach-omap2/control.h index d4ef75d..6a26a0d 100644
> > > > > --- a/arch/arm/mach-omap2/control.h
> > > > > +++ b/arch/arm/mach-omap2/control.h
> > > > > @@ -183,6 +183,7 @@
> > > > > 
> > > > >  #define OMAP3630_CONTROL_FUSE_OPP120_VDD1      
> > > > >  (OMAP2_CONTROL_GENERAL + 0x0120) #define
> > > > >  OMAP3630_CONTROL_FUSE_OPP50_VDD2        (OMAP2_CONTROL_GENERAL +
> > > > >  0x0128) #define OMAP3630_CONTROL_FUSE_OPP100_VDD2      
> > > > >  (OMAP2_CONTROL_GENERAL + 0x012C)
> > > > > 
> > > > > +#define OMAP3630_CONTROL_CAMERA_PHY_CTRL	(OMAP2_CONTROL_GENERAL +
> > > > > 0x02f0)
> > > > 
> > > > I assume this patch hasn't gone anywhere yet which might be good. While
> > > > the definition of this register would appear to belong to this file,
> > > > it is being included from the OMAP 3 ISP driver, which only uses it if
> > > > it's running on the 3630. The problem is that control.h isn't
> > > > apparently intended to be included except locally and I didn't find a
> > > > suitable file under include/mach to put this definition either.
> > > > Currently this file is being included by the ISP driver with an
> > > > explicit path.
> > > > 
> > > > Do you have an insight how this could be handled better?
> > > 
> > > We've been trying to ensure that register accesses to/from a given IP
> > > block only occur in a driver for that IP block.  So under that principle,
> > > any System Control Module accesses should go into a System Control Module
> > > driver.  Then that SCM driver should export (via EXPORT_SYMBOL) a
> > > higher-level interface to whatever code uses it.  The idea is that this
> > > interface would remain stable no matter what underlying SoC was in use.
> > > 
> > > Only thing is, we don't yet have a SCM driver.  Historically, since the
> > > SCM is tightly coupled with the underlying SoC, when we've needed to do
> > > something like this in the past, we've added code to
> > > arch/arm/mach-omap2/control.c.  But that's not really workable now.
> > > 
> > > Do you know if this register, or something like it, is present on later
> > > OMAPs?  Also, which bitfields are you planning to use?
> > 
> > I don't believe it exists on other OMAPs --- possibly on 3730 but the CSI-2
> > receiver is not officially supported on it. The register does not exist on
> > the 3430, at least not under the same name --- a reason for not existing
> > could be that the 3430 only has one CSI-2 receiver. The 4430 doesn't seem
> > to have it either, at least not under that name.
> > 
> > I think the solution to conditionally access it in the ISP driver would be,
> > albeit not pretty, a workable one: the driver is unlikely to be used on
> > other platforms and this is a single register accessed in a single
> > location. I'm of course open for better options.
> 
> A (maybe less intrusive) hack would be to add an accessor function in 
> arch/arm/mach-omap2/control.c and EXPORT_SYMBOL it.

The functions in that file are currently defined in... surprise: control.h!

So, is this something that in your opinion warrants creating another public
header file, or is there an obvious public place to put this definition?

I see not much difference since the register is only available on one OMAP 3
version (3[67]xx). Also, if the OMAP 3 ISP driver would be used on any other
SoC than the OMAP 3, we'd need again to handle the situation differently.

Regards,

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi	jabber/XMPP/Gmail: sailus@retiisi.org.uk
