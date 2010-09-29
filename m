From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [GIT PULL] omap2 sparse fixes
Date: Thu, 30 Sep 2010 05:16:56 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB7FE911@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9402785A390E@dbde02.ent.ti.com>
 <20100923225851.GR4211@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F859E@dbde02.ent.ti.com>
 <20100925001914.GO4211@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F917C@dbde02.ent.ti.com>
 <20100928152139.GB3117@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F94C9@dbde02.ent.ti.com>
 <20100928183157.GH3117@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB7FE8F9@dbde02.ent.ti.com>
 <20100929215635.GC3117@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49866 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918Ab0I2XrV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 19:47:21 -0400
In-Reply-To: <20100929215635.GC3117@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dtor@mail.ru>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

 

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Thursday, September 30, 2010 3:27 AM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org; Samuel Ortiz; Dmitry 
> Torokhov; linux-mtd@lists.infradead.org; Russell King - ARM Linux
> Subject: Re: [GIT PULL] omap2 sparse fixes
> 
> * G, Manjunath Kondaiah <manjugk@ti.com> [100929 12:42]:
> > 
> > Tony,
> > 
> > > -----Original Message-----
> > > From: Tony Lindgren [mailto:tony@atomide.com]
> > > Sent: Wednesday, September 29, 2010 12:02 AM
> > > To: G, Manjunath Kondaiah
> > > Cc: linux-omap@vger.kernel.org;
> > > linux-arm-kernel@lists.infradead.org; Samuel Ortiz; 
> Dmitry Torokhov; 
> > > linux-mtd@lists.infradead.org; Russell King - ARM Linux
> > > Subject: Re: [GIT PULL] omap2 sparse fixes
> > > 
> > > * G, Manjunath Kondaiah <manjugk@ti.com> [100928 08:26]:
> > ...
> > 
> > > Yes please take out all patches that are not in 
> arch/arm/*omap*/ path.
> > > The others really should go to the driver maintainers.
> > > 
> > > Tony
> > 
> > Here is new branch which has only arch/arm/*omap*/ related patches.
> 
> Thanks. Noticed one more thing though:
> 
> In your patch "OMAP: mach-omap2: Fix static function 
> warnings" looks like you're adding 
> omap2_gp_clockevent_set_gptimer twice:

Sorry I missed removing this while adding it in timer-gp.h. Also, I noticed
in the same patch, the board_nand_init nd board_flash_init functions are
exported thrgough board-flash.h. 

I moved board-flash.h from mach/board-flash.h to mach-omap2/board-flash.h so
that only board files can access these functions.


> 
> --- a/arch/arm/plat-omap/include/plat/timer-gp.h
> +++ b/arch/arm/mach-omap2/timer-gp.h
> @@ -11,7 +11,6 @@
>  #ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_TIMER_GP_H
>  #define __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_TIMER_GP_H
>  
> -int __init omap2_gp_clockevent_set_gptimer(u8 id);
> +extern int __init omap2_gp_clockevent_set_gptimer(u8 id);
>  
>  #endif
> -
> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> @@ -81,6 +81,6 @@ unsigned int 
> omap_dm_timer_read_counter(struct omap_dm_timer *timer);  
> void omap_dm_timer_write_counter(struct omap_dm_timer *timer, 
> unsigned int value);
>  
>  int omap_dm_timers_active(void);
> -
> +int omap2_gp_clockevent_set_gptimer(u8 id);

Removed.

>  
>  #endif /* __ASM_ARCH_DMTIMER_H */
> 
> Please also be careful that your branch contains the same 
> patches as you've posted for review. Nobody wants to pull 
> different stuff than what was posted! Also looks like Paul 
> had one comment related to the same patch.

Patches are same except pulling out twl and driver patches from
the series.

Paul's comment is addressed and changes are pushed to git branch.
Build tested with omap3_defconfig and boot tested with beagle board.

The following changes since commit 899611ee7d373e5eeda08e9a8632684e1ebbbf00:
  Linus Torvalds (1):
        Linux 2.6.36-rc6

are available in the git repository at:

  git://dev.omapzoom.org/pub/scm/manju/kernel-omap3-dev.git omap_sparse_fixesv2

G, Manjunath Kondaiah (7):
      OMAP: mach-omap2: Fix incorrect assignment warnings
      OMAP: mach-omap2: Fix static declaration warnings
      OMAP2plus: Fix static function warnings
      OMAP: mach-omap2: Fix miscellaneous sparse warnings
      OMAP: plat-omap: Fix static function warnings
      OMAP: Convert write/read functions to raw read/write
      OMAP3: Keypad: Fix incorrect type initializer

-Manjunath

