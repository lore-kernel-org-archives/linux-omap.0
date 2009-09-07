From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: RE: [PATCH 1/10] omap mailbox: OMAP4-Mailbox - Add build specific
 changes to support OMAP4 mailbox.
Date: Mon, 7 Sep 2009 13:57:22 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD6C407D@dbde02.ent.ti.com>
References: <20090905.110358.124081098.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38124 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752340AbZIGI0k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Sep 2009 04:26:40 -0400
In-Reply-To: <20090905.110358.124081098.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

Hi Hiroshi,
 

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com] 
> Sent: Saturday, September 05, 2009 1:34 PM
> To: C.A, Subramaniam
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; 
> rmk@arm.linux.org.uk; Kanigeri, Hari; Gupta, Ramesh
> Subject: Re: [PATCH 1/10] omap mailbox: OMAP4-Mailbox - Add 
> build specific changes to support OMAP4 mailbox.
> 
> Hi Subramaniam,
> 
> From: "ext C.A, Subramaniam" <subramaniam.ca@ti.com>
> Subject: [PATCH 1/10] omap mailbox: OMAP4-Mailbox - Add build 
> specific changes to support OMAP4 mailbox.
> Date: Fri, 4 Sep 2009 13:47:09 +0200
> 
> > From aa759db084be9a2893de5e61b11f6de6d05508d9 Mon Sep 17 
> 00:00:00 2001
> > From: C A Subramaniam <subramaniam.ca@ti.com>
> > Date: Wed, 2 Sep 2009 17:52:22 +0530
> > Subject: [PATCH 1/10] omap mailbox: OMAP4-Mailbox - Add 
> build specific changes to support OMAP4 mailbox.
> > 
> > This patch adds changes to the build related files of 
> mailbox driver 
> > to support OMAP4 mailbox
> 
> The above comment doesn't match the this modification since 
> adding those module isn't just for OMAP4, but for other omap 
> architecutres(omap2/3/4). So I think that this explanation 
> should be changed as not only for omap4, but just for adding 
> common mailbox support in this Makefile.

I agree on your comments. I will change the description accordingly.

> > 
> > Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
> > Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
> > ---
> >  arch/arm/mach-omap2/Makefile |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/Makefile 
> > b/arch/arm/mach-omap2/Makefile index 735bae5..4bb426d 100644
> > --- a/arch/arm/mach-omap2/Makefile
> > +++ b/arch/arm/mach-omap2/Makefile
> > @@ -39,6 +39,10 @@ endif
> >  obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
> >  obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
> >  
> > +# MAILBOX
> 
> I think that the above line is not necessary since the module 
> names are enough self-explanatory, a little bit nitpicky, though....

I have followed the existing convention present in the Makefile (Power management, clock framework,etc.) as follows:

# Power Management
ifeq ($(CONFIG_PM),y)
obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
obj-$(CONFIG_ARCH_OMAP24XX)		+= sleep24xx.o
obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
endif

# Clock framework
obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o

Please let me know if you still believe that the line needs to be removed.

> 
> > +obj-$(CONFIG_OMAP_MBOX_FWK)	+= mailbox_mach.o
> > +mailbox_mach-objs		:= mailbox.o
> > +
> >  iommu-y					+= iommu2.o
> >  iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
> >  

\
> > --
> > 1.5.3.2
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" 
> > in the body of a message to majordomo@vger.kernel.org More 
> majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html
> 
> 