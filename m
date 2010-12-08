From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/5 v3] OMAP: idle path errata fixes
Date: Wed, 08 Dec 2010 17:03:58 -0600
Message-ID: <4D000EDE.2030706@ti.com>
References: <1291395818-8639-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:54070 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756369Ab0LHXEF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 18:04:05 -0500
Received: by mail-vw0-f42.google.com with SMTP id 11so1418093vws.29
        for <linux-omap@vger.kernel.org>; Wed, 08 Dec 2010 15:04:03 -0800 (PST)
In-Reply-To: <1291395818-8639-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Charulatha Varadarajan <charu@ti.com>, Jean Pihet <jean.pihet@newoldbits.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tao Hu <tghk48@motorola.com>, Tony Lindgren <tony@atomide.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

Nishanth Menon had written, on 12/03/2010 11:03 AM, the following:
> Hi,
> as discussed in [1], here is step 2 - idle path errata fixes.
> this is the next rev incorporating comments from V2 post
> of this series.
> 
> V2: http://marc.info/?l=linux-omap&m=129106200408109&w=2
> 
> Major change in V3:
> 	Erratas are now handled per silicon - it is much cleaner :)
> 	no more redundant cpu_is_omap34xx check anymore
> 	errata configure is __init as it should be
> 
> Eduardo Valentin (1):
>   OMAP3630: PM: Erratum i583: disable coreoff if < ES1.2
> 
> Nishanth Menon (1):
>   OMAP3630: PM: Erratum i608: disable RTA
> 
> Peter 'p2' De Schrijver (2):
>   OMAP3: PM: Erratum i581 support: dll kick strategy
>   OMAP3630: PM: Disable L2 cache while invalidating L2 cache
> 
> Richard Woodruff (1):
>   OMAP3: PM: Update clean_l2 to use v7_flush_dcache_all
> 
>  arch/arm/mach-omap2/control.c   |    5 +-
>  arch/arm/mach-omap2/control.h   |    5 +
>  arch/arm/mach-omap2/pm.h        |    6 ++
>  arch/arm/mach-omap2/pm34xx.c    |   38 ++++++++
>  arch/arm/mach-omap2/sleep34xx.S |  187 ++++++++++++++++++++++++---------------
>  5 files changed, 169 insertions(+), 72 deletions(-)
> 
> bloat-o-meter report Vs 2.6.37-rc4
> add/remove: 1/0 grow/shrink: 6/2 up/down: 220/-12 (208)
> function                                     old     new   delta
> omap3_pm_init                               1776    1868     +92
> omap_sram_idle                              1040    1104     +64
> omap3_save_scratchpad_contents               732     760     +28
> vermagic                                      45      60     +15
> linux_banner                                 131     146     +15
> omap2_init_mmc                              1032    1036      +4
> pm34xx_errata                                  -       2      +2
> omap_serial_init_port                       1120    1116      -4
> prcm_interrupt_handler                       276     268      -8
> 
> [1] http://marc.info/?l=linux-omap&m=129045338806957&w=2
> 
> Cc: Charulatha Varadarajan <charu@ti.com>
> Cc: Jean Pihet <jean.pihet@newoldbits.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Tao Hu <tghk48@motorola.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>

Gentle ping on this series..

Regards,
Nishanth Menon
