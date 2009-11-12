From: "Lohithakshan, Ranjith" <ranjithl@ti.com>
Subject: RE: [PATCH] AM35xx: Clock table updates for AM3505/17
Date: Thu, 12 Nov 2009 10:36:36 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BBA00659@dbde02.ent.ti.com>
References: <1257417540-21120-1-git-send-email-ranjithl@ti.com>
 <87iqdg20wn.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45160 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbZKLFGf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 00:06:35 -0500
In-Reply-To: <87iqdg20wn.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Kevin, 

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Thursday, November 12, 2009 3:13 AM
> To: Lohithakshan, Ranjith
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] AM35xx: Clock table updates for AM3505/17
> 
> Ranjith Lohithakshan <ranjithl@ti.com> writes:
> 
> > AM3505/17 though a OMAP3530 derivative have the following
> > main differences
> >
> > 	- Removal of the following OMAP3 modules
> > 		- IVA
> > 		- ISP/CAM
> > 		- Modem and D2D components (MAD2D, SAD2D)
> > 		- USIM
> > 		- SSI
> > 		- Mailboxes
> > 		- USB OTG
> > 		- ICR
> > 		- MSPRO
> > 		- SmartReflex
> > 	- SDRC replaced with EMIF4 Controller in the SDRC subsystem
> > 	  thus adding support for DDR2 memory devices
> > 	- Addition of the following new modules
> > 		- Ethernet MAC (CPGMAC)
> > 		- CAN Controller (HECC)
> > 		- New USB OTG Controller with integrated Phy
> > 		- Video Processing Front End (VPFE)
> > 		- Additional UART (UART4)
> > 	- All security accelerators disabled on GP devices and not to
> > 	  be accessed or configured
> >
> > This patch defines CPU flags for AM3505/17 and update the 
> clock table.
> > Clock support for new modules will be added by subsequent patches.
> >
> > Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
> 
> A question on the approach here, as I'm wondering if this approach is
> really needed.
> 
> Rather than handling these details in the clock tree, why not handle
> the special cases using the feature checks: omap_has_*().  
> 

The differences (mainly removals) are many and too unique to AM3517/05. 
As per the chip spec, the clock related registers for the removed modules are 
not to be programmed and we need a way to prevent these clocks getting 
registered from the existing table (even if they are not enabled or used later). 
In my opinion, if we define feature macros for modules like (MSPRO, USIM,Mailbox etc) 
they will be too specific for the AM35xx use. Taking these aspects into 
consideration, I feel tha defining CK_35XX flags and using it in clock table appear 
to be better.

Ranjith