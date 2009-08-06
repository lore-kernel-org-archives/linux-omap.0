From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/9] omap3: Add CHIP_GE_OMAP3430ES3 for HSUSB
Date: Thu, 6 Aug 2009 16:13:37 +0300
Message-ID: <20090806131336.GP2358@atomide.com>
References: <1249560460-16306-1-git-send-email-ajay.gupta@ti.com> <1249560460-16306-2-git-send-email-ajay.gupta@ti.com> <1249560460-16306-3-git-send-email-ajay.gupta@ti.com> <1249560460-16306-4-git-send-email-ajay.gupta@ti.com> <1249560460-16306-5-git-send-email-ajay.gupta@ti.com> <1249560460-16306-6-git-send-email-ajay.gupta@ti.com> <1249560460-16306-7-git-send-email-ajay.gupta@ti.com> <20090806130715.GA2874@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54434 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755746AbZHFNNl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 09:13:41 -0400
Content-Disposition: inline
In-Reply-To: <20090806130715.GA2874@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: ext Ajay Kumar Gupta <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "david-b@pacbell.net" <david-b@pacbell.net>

* Felipe Balbi <felipe.balbi@nokia.com> [090806 16:06]:
> On Thu, Aug 06, 2009 at 02:07:38PM +0200, ext Ajay Kumar Gupta wrote:
> > OMAP3 HSUSB ports can be individually programmed in PHY or TLL
> > mode in ES3.0 onwards whereas this is not supported in ES2.1
> > and earlier versions.
> > 
> > CHIP_GE_OMAP3430ES3 is added to program this behavior at runtime.
> > 
> > Also updated the existing macros to use the priviously defined
> > *_GE_* logic instead of repeating the same logic again.
> > 
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > ---
> >  arch/arm/plat-omap/include/mach/cpu.h |    7 ++++---
> >  1 files changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
> > index 285eaa3..5848717 100644
> > --- a/arch/arm/plat-omap/include/mach/cpu.h
> > +++ b/arch/arm/plat-omap/include/mach/cpu.h
> > @@ -428,10 +428,11 @@ IS_OMAP_TYPE(3430, 0x3430)
> >   * chips at ES2 and beyond, but not, for example, any OMAP lines after
> >   * OMAP3.
> >   */
> > -#define CHIP_GE_OMAP3430ES2		(CHIP_IS_OMAP3430ES2 | \
> > -					 CHIP_IS_OMAP3430ES3_0 | \
> > -					 CHIP_IS_OMAP3430ES3_1)
> >  #define CHIP_GE_OMAP3430ES3_1		(CHIP_IS_OMAP3430ES3_1)
> > +#define CHIP_GE_OMAP3430ES3		(CHIP_IS_OMAP3430ES3_0 | \
> > +					 CHIP_GE_OMAP3430ES3_1)
> > +#define CHIP_GE_OMAP3430ES2		(CHIP_IS_OMAP3430ES2 | \
> > +					 CHIP_GE_OMAP3430ES3)
> 
> Tony, what about this one ? Do you agree with it ? I need this in order
> to get a buildable driver merged through linux-usb. The usb-ehci.c stuff
> I can postpone to be sent later but without this, ehci-omap.c won't
> build.
> 
> any input is appreciated.

Yeh looks OK to me.

Tony
