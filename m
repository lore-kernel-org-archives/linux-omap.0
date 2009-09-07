From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/10] omap mailbox: OMAP4-Mailbox - Add build specific
 changes to support OMAP4 mailbox.
Date: Mon, 07 Sep 2009 11:33:10 +0300 (EEST)
Message-ID: <20090907.113310.212389342.Hiroshi.DOYU@nokia.com>
References: <20090905.110358.124081098.Hiroshi.DOYU@nokia.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DD6C407D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:58296 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbZIGIdf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Sep 2009 04:33:35 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD6C407D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: subramaniam.ca@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, rmk@arm.linux.org.uk, h-kanigeri2@ti.com, grgupta@ti.com

From: "ext C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: RE: [PATCH 1/10] omap mailbox: OMAP4-Mailbox - Add build specific changes to support OMAP4 mailbox.
Date: Mon, 7 Sep 2009 10:27:22 +0200

> > > 
> > > Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
> > > Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
> > > ---
> > >  arch/arm/mach-omap2/Makefile |    4 ++++
> > >  1 files changed, 4 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-omap2/Makefile 
> > > b/arch/arm/mach-omap2/Makefile index 735bae5..4bb426d 100644
> > > --- a/arch/arm/mach-omap2/Makefile
> > > +++ b/arch/arm/mach-omap2/Makefile
> > > @@ -39,6 +39,10 @@ endif
> > >  obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
> > >  obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
> > >  
> > > +# MAILBOX
> > 
> > I think that the above line is not necessary since the module 
> > names are enough self-explanatory, a little bit nitpicky, though....
> 
> I have followed the existing convention present in the Makefile (Power management, clock framework,etc.) as follows:
> 
> # Power Management
> ifeq ($(CONFIG_PM),y)
> obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
> obj-$(CONFIG_ARCH_OMAP24XX)		+= sleep24xx.o
> obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
> obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
> endif
> 
> # Clock framework
> obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
> obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
> 
> Please let me know if you still believe that the line needs to be removed.

I understand that you followed kind of convention, but I still think
that these comments don't make so much sense since these module names
are apparently enough self-explanatory.
