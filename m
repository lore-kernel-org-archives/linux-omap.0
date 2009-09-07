From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: RE: [PATCH 1/10] omap mailbox: OMAP4-Mailbox - Add build specific
 changes to support OMAP4 mailbox.
Date: Mon, 7 Sep 2009 14:07:44 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD6C4095@dbde02.ent.ti.com>
References: <20090907.113310.212389342.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50543 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956AbZIGIg7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Sep 2009 04:36:59 -0400
In-Reply-To: <20090907.113310.212389342.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

Hi Hiroshi, 

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com] 
> Sent: Monday, September 07, 2009 2:03 PM
> To: C.A, Subramaniam
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; 
> rmk@arm.linux.org.uk; Kanigeri, Hari; Gupta, Ramesh
> Subject: Re: [PATCH 1/10] omap mailbox: OMAP4-Mailbox - Add 
> build specific changes to support OMAP4 mailbox.
> 
> From: "ext C.A, Subramaniam" <subramaniam.ca@ti.com>
> Subject: RE: [PATCH 1/10] omap mailbox: OMAP4-Mailbox - Add 
> build specific changes to support OMAP4 mailbox.
> Date: Mon, 7 Sep 2009 10:27:22 +0200
> 
> > > > 
> > > > Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
> > > > Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
> > > > ---
> > > >  arch/arm/mach-omap2/Makefile |    4 ++++
> > > >  1 files changed, 4 insertions(+), 0 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/mach-omap2/Makefile 
> > > > b/arch/arm/mach-omap2/Makefile index 735bae5..4bb426d 100644
> > > > --- a/arch/arm/mach-omap2/Makefile
> > > > +++ b/arch/arm/mach-omap2/Makefile
> > > > @@ -39,6 +39,10 @@ endif
> > > >  obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
> > > >  obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
> > > >  
> > > > +# MAILBOX
> > > 
> > > I think that the above line is not necessary since the 
> module names 
> > > are enough self-explanatory, a little bit nitpicky, though....
> > 
> > I have followed the existing convention present in the 
> Makefile (Power management, clock framework,etc.) as follows:
> > 
> > # Power Management
> > ifeq ($(CONFIG_PM),y)
> > obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
> > obj-$(CONFIG_ARCH_OMAP24XX)		+= sleep24xx.o
> > obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
> > obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
> > endif
> > 
> > # Clock framework
> > obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
> > obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
> > 
> > Please let me know if you still believe that the line needs 
> to be removed.
> 
> I understand that you followed kind of convention, but I 
> still think that these comments don't make so much sense 
> since these module names are apparently enough self-explanatory.
> 
> 

Sure! I can remove that. I will send a patch with the changes you had mentioned.