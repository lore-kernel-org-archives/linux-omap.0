From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 8/10] omap timer cleanup for v3.5 merge window
Date: Thu, 10 May 2012 11:51:31 -0700
Message-ID: <20120510185130.GJ21851@atomide.com>
References: <pull-1336675159-747052>
 <E1SSYJA-0006UJ-4H@merlin.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:43651 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760347Ab2EJSvd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 14:51:33 -0400
Content-Disposition: inline
In-Reply-To: <E1SSYJA-0006UJ-4H@merlin.infradead.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120510 11:49]:
> The following changes since commit bfd17879866b36e95c58721da070d9f2ac7f8901:
> 
>   Merge tag 'omap-devel-c-for-3.5' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into devel-hwmod-data (2012-05-09 09:58:42 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-cleanup-timer-for-v3.5
> 
> for you to fetch changes up to 1fe97c8f6a1de67a5f56e029a818903d5bed8017:
> 
>   ARM: OMAP: Make OMAP clocksource source selection using kernel param (2012-05-09 10:07:05 -0700)
> 
> ----------------------------------------------------------------
> Timer changes to make it easier to support various SoCs
> 
> ----------------------------------------------------------------

And this has a conflict for common headers:


--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@@ -57,16 -56,15 +57,22 @@@ void omap1_init_early(void)
  void omap1_init_irq(void);
  void omap1_restart(char, const char *);
  
 +extern void __init omap_check_revision(void);
 +
 +extern void omap1_nand_cmd_ctl(struct mtd_info *mtd, int cmd,
 +			       unsigned int ctrl);
 +
- extern struct sys_timer omap1_timer;
- extern bool omap_32k_timer_init(void);
- 
 +extern u32 omap_irq_flags;
- 
 +extern int ocpi_enable(void);
++	       
+ extern struct sys_timer omap1_timer;
+ #ifdef CONFIG_OMAP_32K_TIMER
+ extern int omap_32k_timer_init(void);
+ #else
+ static inline int __init omap_32k_timer_init(void)
+ {
+ 	return -ENODEV;
+ }
+ #endif
 -extern void __init omap_init_consistent_dma_size(void);
  
  #endif /* __ARCH_ARM_MACH_OMAP1_COMMON_H */
diff --cc arch/arm/plat-omap/include/plat/common.h
index a557b84,55c514b..d1cb6f5
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@@ -30,10 -30,8 +30,10 @@@
  #include <plat/i2c.h>
  #include <plat/omap_hwmod.h>
  
- extern int __init omap_init_clocksource_32k(void);
+ extern int __init omap_init_clocksource_32k(void __iomem *vbase);
  
 +extern void __init omap_check_revision(void);
 +
  extern void omap_reserve(void);
  extern int omap_dss_reset(struct omap_hwmod *);
  
