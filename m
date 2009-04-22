From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 2/7][RFC] OMAP4: Create board support for OMAP_4430SDP.
Date: Wed, 22 Apr 2009 10:17:37 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B3D8F3F8@dbde02.ent.ti.com>
References: <1240319293-19662-1-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-2-git-send-email-santosh.shilimkar@ti.com>
 <20090421181428.GI25864@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46626 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240AbZDVErr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 00:47:47 -0400
In-Reply-To: <20090421181428.GI25864@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> > + * Board support header for OMAP4430 SDP.
> > + *
> > + * Copyright (C) 2009 Texas Instruments
> > + *
> > + * Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > + *
> > + * Based on arch/arm/plat-omap/include/mach/board-3430sdp.h
> > + *
> > + * This program is free software; you can redistribute it 
> and/or modify
> > + * it under the terms of the GNU General Public License 
> version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +#ifndef __ARCH_ARM_MACH_OMAP4_BOARD_4430SDP_H
> > +#define __ARCH_ARM_MACH_OMAP4_BOARD_4430SDP_H
> > +
> > +extern void sdp4430_flash_init(void);
> > +
> > +/* NAND */
> > +#define DEBUG_BASE		0x08000000 /* debug board */
> > +#define NAND_BASE		0x0C000000 /* NAND flash */
> > +#define ONENAND_MAP		0x20000000 /* OneNand flash */
> > +
> > +/* various memory sizes */
> > +#define FLASH_SIZE_SDPV1	SZ_64M
> > +#define FLASH_SIZE_SDPV2	SZ_128M
> > +#endif
> > +
> 
> Let's leave out the board-4430sdp.h and move the defines to 
> the board-4430sdp.c.
> 
> Also it sounds like the NAND defines are not yet needed. I'm thinking
> that we should have just a generic gpmc-onenand.c file based on the
> board-n800-flash.c that works for all boards with onenand connected
> to the GPMC.
Yes. This was added as a place holder since next NAND driver patches would need that. Sounds ok to me but may be Nand driver owner might have some comments on the same. We can take this up later when adding NAND support.
For now I agree with you point.
  
> b/arch/arm/plat-omap/include/mach/omap44xx.h
		
> IO_ADDRESS(OMAP44XX_SCU_BASE)
> > +#define OMAP44XX_LOCAL_TWD_BASE		0x48240600
> > +#define OMAP44XX_VA_LOCAL_TWD_BASE	
> IO_ADDRESS(OMAP44XX_LOCAL_TWD_BASE)
> > +#define OMAP44XX_LOCAL_TWD_SIZE		0x00000100
> > +#define OMAP44XX_WKUPGEN_BASE		0x48281000
> > +#define OMAP44XX_VA_WKUPGEN_BASE	
> IO_ADDRESS(OMAP44XX_WKUPGEN_BASE)
> 
> Could these defines have just OMAP4_ prefix? If some later omap4
> changes these, we can define them separately with the correct
> prefix.
I have kept this just to keep uniformity. Also generally we will have derivatives of ICs and this defines would 
Help there. Instead of modifying later we can keep this way.

Regards
Santosh