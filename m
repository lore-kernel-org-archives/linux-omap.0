From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP: hwmod/PMU/PRCM patches for 3.7
Date: Mon, 24 Sep 2012 01:08:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209240102290.31370@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209210103140.6888@utopia.booyaka.com> <20120921205322.GK28835@atomide.com> <20120921231039.GN28835@atomide.com> <alpine.DEB.2.00.1209220002290.6510@utopia.booyaka.com> <20120922002111.GP28835@atomide.com>
 <alpine.DEB.2.00.1209220211090.8626@utopia.booyaka.com> <20120923190933.GS28835@atomide.com> <20120923210638.GT28835@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37580 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754711Ab2IXBIP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Sep 2012 21:08:15 -0400
In-Reply-To: <20120923210638.GT28835@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, 23 Sep 2012, Tony Lindgren wrote:

> Or maybe it's possible to split the series into smaller chunks
> that can be pulled in to the existing branches without causing
> new merge conflicts?

Well here's what I did, hopefully it's suitable.  Built a tag with all of 
the clock and hwmod/runtime PM patches together, and based it on v3.6-rc6 
+ omap-cleanup-b-for-3.7 + cleanup-fixes-for-v3.7 + 
omap-devel-am33xx-for-v3.7.  All of these are upstream.

Then I did a test merge with your commit 
219e2d6f43760509a0f0a084e8aa4711efb78c56:

  git checkout -b temp_tmlind_merge
  git reset --hard 219e2d6f43760509a0f0a084e8aa4711efb78c56
  git merge omap-devel-b-c-2-for-3.7

There are two conflicts, both trivial, and the patch below is how they got 
resolved here.

Then probably you'll want to add Santosh's branch back in on top of that.


- Paul

commit 18f6bc7930d08b5d63d2f8ad33c850340b8837fa
Merge: 219e2d6 76a5d9b
Author: Paul Walmsley <paul@pwsan.com>
Date:   Sun Sep 23 19:01:45 2012 -0600

    Merge tag 'omap-devel-b-c-2-for-3.7' into temp_tmlind_merge
    
    OMAP patches intended for the 3.7 merge window:
    
    - Runtime PM conversions for the GPMC and RNG IP blocks
    - Preparation patches for the OMAP common clock framework conversion
    - clkdev alias additions required by other drivers
    - Performance Monitoring Unit (PMU) support for OMAP2, 3, and non-4430 OMAP4
    - OMAP hwmod code and data improvements
    - Preparation patches for the IOMMU runtime PM conversion
    - Preparation patches for OMAP4 full-chip retention support
    
    Based on a merge of v3.6-rc6, the omap-cleanup-b-for-3.7 tag
    (7852ec0536ca39cefffc6301dc77f8ae55592926),the cleanup-fixes-for-v3.7
    tag (de6ca33a96a6bf61fcb91d3d399703e19ead9d1e), and the
    omap-devel-am33xx-for-v3.7 tag
    (11964f53eb4d9ce59a058be9999d9cfcb1ced878), due to dependencies.
    
    These patches have been tested for meaningful warnings from
    checkpatch, sparse, smatch, and cppcheck.  Basic build, boot[1], and
    PM test logs are available here:
    
        http://www.pwsan.com/omap/testlogs/hwmod_prcm_clock_a_3.7/20120923173830/
    
    ...
    
    1. Note that the N800 boot fails due to a known issue present in the
       base commit:
    
        http://www.spinics.net/lists/arm-kernel/msg196034.html
    
    Conflicts:
    	arch/arm/mach-omap2/devices.c
    	drivers/spi/spi-omap2-mcspi.c

diff --cc arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 94b38af,016429d..2857772
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@@ -20,15 -20,16 +20,16 @@@
  #include <plat/omap_hwmod.h>
  #include <plat/dma.h>
  #include <plat/serial.h>
 -#include <plat/l3_3xxx.h>
 -#include <plat/l4_3xxx.h>
 +#include "l3_3xxx.h"
 +#include "l4_3xxx.h"
  #include <plat/i2c.h>
  #include <plat/mmc.h>
 -#include <plat/mcbsp.h>
 -#include <plat/mcspi.h>
 +#include <linux/platform_data/asoc-ti-mcbsp.h>
 +#include <linux/platform_data/spi-omap2-mcspi.h>
  #include <plat/dmtimer.h>
+ #include <plat/iommu.h>
  
 -#include <mach/am35xx.h>
 +#include "am35xx.h"
  
  #include "soc.h"
  #include "omap_hwmod_common_data.h"
diff --cc drivers/spi/spi-omap2-mcspi.c
index b9b7ad0,b5d6994..d3d62f1
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@@ -41,8 -41,7 +41,7 @@@
  
  #include <linux/spi/spi.h>
  
- #include <plat/clock.h>
 -#include <plat/mcspi.h>
 +#include <linux/platform_data/spi-omap2-mcspi.h>
  
  #define OMAP2_MCSPI_MAX_FREQ		48000000
  #define SPI_AUTOSUSPEND_TIMEOUT		2000
