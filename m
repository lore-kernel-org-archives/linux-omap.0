From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] Fix compile error in usb-ehci.c
Date: Fri, 16 Jan 2009 14:39:16 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815D56@dbde02.ent.ti.com>
References: <20090116072823.GM4128@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56352 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756716AbZAPJJ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 04:09:26 -0500
In-Reply-To: <20090116072823.GM4128@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Friday, January 16, 2009 12:58 PM
> To: Gadiyar, Anand
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] Fix compile error in usb-ehci.c
> 
> * Gadiyar, Anand <gadiyar@ti.com> [090115 20:48]:
> > From: Anand Gadiyar <gadiyar@ti.com>
> > 
> > Fix this compile error
> 
> Can you please resend via the usb list?

Isn't this omap specific? I don't mind sending this through the USB list,
except that I think it has nothing to do with USB.

> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> 
> >   CC      arch/arm/mach-omap2/usb-ehci.o
> > arch/arm/mach-omap2/usb-ehci.c:39: error: 
> 'INT_34XX_EHCI_IRQ' undeclared here (not in a function)
> > make[1]: *** [arch/arm/mach-omap2/usb-ehci.o] Error 1
> > make: *** [arch/arm/mach-omap2] Error 2
> > 
> > Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> > ---
> > diff --git a/arch/arm/mach-omap2/usb-ehci.c 
> b/arch/arm/mach-omap2/usb-ehci.c
> > index 489439d..6af0b02 100644
> > --- a/arch/arm/mach-omap2/usb-ehci.c
> > +++ b/arch/arm/mach-omap2/usb-ehci.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/usb/musb.h>
> >  
> >  #include <mach/hardware.h>
> > +#include <mach/irqs.h>
> >  #include <mach/pm.h>
> >  #include <mach/usb.h>
> 
> 