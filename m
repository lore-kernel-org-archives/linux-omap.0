From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 02/12] serial context save/restore
Date: Tue, 2 Sep 2008 09:20:22 +0530
Message-ID: <001f01c90caf$07d4da90$LocalHost@wipultra1382>
References: <20080901200633.GD28999@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54514 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbYIBDul (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2008 23:50:41 -0400
In-Reply-To: <20080901200633.GD28999@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> Sent: Tuesday, September 02, 2008 1:37 AM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 02/12] serial context save/restore
> 
> On Mon, Sep 01, 2008 at 07:07:27PM +0530, Rajendra Nayak wrote:
> > This patch adds the context save restore functions for UART
> > --- linux-omap-2.6.orig/include/linux/serial_reg.h	2008-09-01
> > 18:11:29.000000000 +0530
> > +++ linux-omap-2.6/include/linux/serial_reg.h	
> 2008-09-01 18:11:50.000000000 +0530
> > @@ -323,6 +323,7 @@
> >  #define UART_OMAP_MVER		0x14	/* Module 
> version register */
> >  #define UART_OMAP_SYSC		0x15	/* System 
> configuration register */
> >  #define UART_OMAP_SYSS		0x16	/* System 
> status register */
> > +#define UART_OMAP_WER           0x17    /* Wake-up enable 
> register */
> 
> Please match the indentation style.
> > 
> >  #endif /* _LINUX_SERIAL_REG_H */
> > 
> > Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/serial.h
> > ===================================================================
> > --- 
> linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/serial.h	
> 2008-09-01
> > 18:11:29.000000000 +0530
> > +++ linux-omap-2.6/arch/arm/plat-omap/include/mach/serial.h	
> 2008-09-01
> > 18:11:50.000000000 +0530
> > @@ -39,5 +39,16 @@
> >  				__ret = 1;			\
> >  			__ret;					\
> >  			})
> > -
> > +#ifndef __ASSEMBLY__
> 
> There should be a blank line between the previous macro and this
> ifndef.

Ok. I'll repost this patch with the fixes.

> 
> 

