From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: hwmod/PRCM: add OMAP5 data
Date: Sun, 9 Jun 2013 21:20:09 -0700
Message-ID: <20130610042008.GA8164@atomide.com>
References: <alpine.DEB.2.02.1306082003200.7001@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44924 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750776Ab3FJEUQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jun 2013 00:20:16 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1306082003200.7001@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [130608 13:11]:
> Hi Tony,
> 
> The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:
> 
>   Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-a-for-3.11
> 
> for you to fetch changes up to e4020aa9a8f37d860024fe8a8c8441f003606d2b:
> 
>   ARM: OMAP5: Enable build and frameowrk initialisations (2013-06-08 12:00:05 -0600)
> 
> ----------------------------------------------------------------
> Add support for the OMAP5 SoC family.
> 
> As part of the transition to DT, no board files will be used
> for OMAP5.  The hwmod data is gradually being transitioned
> away from arch/arm/mach-omap2: IRQ, DMA, and memory map data
> has been moved to DT.  Hopefully the dev_attr and clock role
> data will be the next step.
> 
> Basic test logs are available here, although not for OMAP5,
> since I don't have an OMAP5 board:
> http://www.pwsan.com/omap/testlogs/omap5_v3.10/20130608130949/

Thanks pulled into omap-for-v3.11/omap5. I removed the ocp2scp include
as that's unused and the header is removed with the omap4 clean-up.

Regards,

Tony


Author: Tony Lindgren <tony@atomide.com>
Date:   Sun Jun 9 21:17:15 2013 -0700

    ARM: OMAP5: Remove unused include for ocp2scp
    
    This header is not used, and is removed with the omap4 clean-up.
    
    Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -20,7 +20,6 @@
 #include <linux/io.h>
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/power/smartreflex.h>
-#include <linux/platform_data/omap_ocp2scp.h>
 #include <linux/i2c-omap.h>
 
 #include <linux/omap-dma.h>
