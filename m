From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 00/13] OMAP: DMA: hwmod and DMA as platform device
Date: Tue, 09 Nov 2010 15:11:47 -0800
Message-ID: <87tyjqhz2k.fsf@deeprootsystems.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35028 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659Ab0KIXLw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Nov 2010 18:11:52 -0500
Received: by pzk28 with SMTP id 28so2057pzk.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Nov 2010 15:11:52 -0800 (PST)
In-Reply-To: <1288099513-1854-1-git-send-email-manjugk@ti.com> (Manjunath
	Kondaiah G.'s message of "Tue, 26 Oct 2010 18:55:00 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> This patch series converts DMA library into platform device and hwmod 
> adaptation is done for omap2+ processors.
>
> It also replaces cpu_*is* checks by moving omap1 and omap2+ processor 
> code into repsective mach-omapx directories. The common code in plat-omap
> will use device attributes for differentiating omap1 and omap2 code.

This summary, and the various changelogs need to be updated to be more
descriptive, particularily in the usage of the words 'device' and
'driver'.

The changelog terminology used is confusing, and sometimes wrong.  What
is actually being done is splitting up the current DMA library into 3
parts: a common platform_driver (plat-omap/dma.c), OMAP1 device code
(mach-omap1/dma.c) and OMAP2+ device code (mach-omap2/dma.c)

> Build Report:
> omap1:  Success for omap_h2_1610_defconfig
> omap2+: Success for omap2plus_defconfig
>
> Test Report:
> omap2+:(multiboot defconfig boots on all the omap2+ boards listed below):
> OMAP4BLAZE: http://pastebin.com/HVnim30G
> OMAP3630ZOOM3: http://pastebin.com/JJwrtP4F
> OMAP243SDP: http://pastebin.com/mz7cVQL3
>
> omap1 : Not tested 
>
> Test cases executed:
> 1. All applicable TI DMA tests which are located at:
> http://dev.omapzoom.org/?p=richo/device_driver_test.git;a=tree;f=dma/test_code;h=0d00de3c0fe6933b405c62da63f694883f3e4b8f;hb=2c50a5a58dea0ffc2d31b827935aeef9b9d11253
>
> 2. Use case tests :  TI MMC tests are executed with differenct types of
> files systems such as DOS, ext2, ext3 etc on omap4 blaze and omap3630 zoom3. 
> More information can be found at:
> http://dev.omapzoom.org/?p=richo/device_driver_test.git;a=tree;f=mmc/test_code;h=d0bc1984eef46ac45719efb02b5c1f4193422a1b;hb=2c50a5a58dea0ffc2d31b827935aeef9b9d11253
>
> Dependencies:
> This patch series has dependency on omap_device patch:
> https://patchwork.kernel.org/patch/282212/

Thanks for the thorough build and test report.   Very nice.

Kevin

> This patch series applies on:
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> Branch: master
> commit a83d12a47c9a8c78a184910150797045d69a1570
> Merge: f9f47f5 c1fb8df
> Author: Tony Lindgren <tony@atomide.com>
> Date:   Fri Oct 22 11:21:08 2010 -0700
>
>     Linux-omap rebuilt: Updated to v2.6.36, add 24xx uart fix
>
> Changelist summary:
> v3:
> Review comments fixed:
> http://www.listware.net/201008/linux-omap/89002-patch-v2-0011-omap-dma-hwmod-and-dma-as-platform-driver.html
>  - created and tested on latest linux-omap master branch(2.6.36 kernel)
>
> v2:
> The review comments which are fixed can be found at:
> http://www.spinics.net/lists/linux-omap/msg34291.html
> http://www.spinics.net/lists/linux-omap/msg34292.html
> http://www.spinics.net/lists/linux-omap/msg34078.html
> http://www.spinics.net/lists/linux-omap/msg34083.html
>
> v1:
> These changes are based on comments received during internal discussions which has changes(compared to previous version) such as:
>  - Code optimization
>  - Patches are rearranged in more meaningful way so that git bisect works at any
>    intermediate patch in the series.
>  - Build tested for all omap's(OMAP1 and OMAP2PLUS)
>  - Boot tested for OMAP3 and OMAP4(appreciate if some one tests on OMAP1/2)
>  - Applicalbe tests are executed on OMAP3 and OMAP4 boards
>  - Rebased and added descriptor autoloading feature(only for omap3630 and omap4)
>
>
> Benoit Cousson (1):
>   OMAP4: DMA: hwmod: add system DMA
>
> G, Manjunath Kondaiah (12):
>   OMAP: DMA: Replace read/write macros with functions
>   OMAP: DMA: Introduce errata handling feature
>   OMAP: DMA: Introduce DMA device attributes
>   OMAP2420: DMA: hwmod: add system DMA
>   OMAP2430: DMA: hwmod: add system DMA
>   OMAP3: DMA: hwmod: add system DMA
>   OMAP1: DMA: Introduce DMA driver as platform device
>   OMAP2+: DMA: hwmod: Device registration
>   OMAP: DMA: Convert DMA library into DMA platform Driver
>   OMAP: DMA: Use DMA device attributes
>   sDMA: descriptor autoloading feature
>   OMAP: PM: DMA: Enable runtime pm
>
>  arch/arm/mach-omap1/Makefile               |    2 +-
>  arch/arm/mach-omap1/dma.c                  |  665 ++++++++++
>  arch/arm/mach-omap1/include/mach/dma.h     |   51 +
>  arch/arm/mach-omap2/Makefile               |    2 +-
>  arch/arm/mach-omap2/dma.c                  | 1579 ++++++++++++++++++++++++
>  arch/arm/mach-omap2/include/mach/dma.h     |   86 ++
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |   85 ++
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |   85 ++
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   93 ++
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   99 ++
>  arch/arm/plat-omap/dma.c                   | 1850 ++++------------------------
>  arch/arm/plat-omap/include/plat/dma.h      |  387 ++++---
>  12 files changed, 3207 insertions(+), 1777 deletions(-)
>  create mode 100644 arch/arm/mach-omap1/dma.c
>  create mode 100644 arch/arm/mach-omap1/include/mach/dma.h
>  create mode 100644 arch/arm/mach-omap2/dma.c
>  create mode 100644 arch/arm/mach-omap2/include/mach/dma.h
>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
