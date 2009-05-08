From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: [PATCH 1/3] OMAP4: SMP: Add OMAP4430 SMP board files
Date: Fri, 8 May 2009 11:43:03 +0530
Message-ID: <001801c9cfa4$0cf99840$LocalHost@wipultra793>
References: <1241681366-21094-1-git-send-email-santosh.shilimkar@ti.com> <04c801c9cfa0$4563dfa0$LocalHost@wipultra793> <EAF47CD23C76F840A9E7FCE10091EFAB02B4688490@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39600 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751516AbZEHGN1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 May 2009 02:13:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

----- Original Message ----- 
From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
To: "V, Hemanth" <hemanthv@ti.com>; 
<linux-arm-kernel@lists.arm.linux.org.uk>
Cc: <linux-omap@vger.kernel.org>
Sent: Friday, May 08, 2009 11:18 AM
Subject: RE: [PATCH 1/3] OMAP4: SMP: Add OMAP4430 SMP board files


> -----Original Message-----
> From: V, Hemanth
> Sent: Friday, May 08, 2009 11:16 AM
> To: Shilimkar, Santosh; linux-arm-kernel@lists.arm.linux.org.uk
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/3] OMAP4: SMP: Add OMAP4430 SMP board files
>
> ---- Original Message ----- 
> From: "Santosh Shilimkar" <santosh.shilimkar@ti.com>
> Subject: [PATCH 1/3] OMAP4: SMP: Add OMAP4430 SMP board files
>
>
> > diff --git a/arch/arm/mach-omap2/omap-headsmp.S
> > b/arch/arm/mach-omap2/omap-headsmp.S
> > new file mode 100644
> > index 0000000..0afe039
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/omap-headsmp.S
> > @@ -0,0 +1,49 @@
> > +/*
> > + * Secondary CPU startup routine source file.
> > + *
> > + * Copyright (C) 2009 Texas Instruments, Inc.
> > + *
> > + * Author:
> > + *      Santosh Shilimkar <santosh.shilimkar@ti.com>
> > + *
> > + * Interface functions needed for the SMP. This file is
> based on arm
> > + * realview smp platform.
> > + * Copyright (c) 2003 ARM Limited.
> > + *
> > + * This program is free software,you can redistribute it
> and/or modify
> > + * it under the terms of the GNU General Public License
> version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/linkage.h>
> > +#include <linux/init.h>
> > +
> > + __INIT
> > +
> > +/*
> > + * OMAP4 specific entry point for secondary CPU to jump from ROM
> > + * code.  This routine also provides a holding flag into which
> > + * secondary core is held until we're ready for it to initialise.
> > + * The primary core will update the this flag using a hardware
> > + * register AuxCoreBoot1.
> > + */
>
> Is initialization done by u-boot like icache_enable taken
> care somewhere
> for the secondary cpu.

>>U-boot has no knowledge of secondary CPUs. Kernel takes care of it with 
>>help of ROM code.

For my information could you pl point to the routine which does this, i.e 
enable instruction cache on the secondary cpu. 

