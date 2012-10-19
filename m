From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 0/7] crypto: omap-sham updates
Date: Fri, 19 Oct 2012 14:53:53 -0700
Message-ID: <1350683640-15044-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:45314 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932972Ab2JSVyY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Oct 2012 17:54:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

This series updates the crypto omap-sham driver and supporting
infrastructure.

Notes:

a) Based on current k.o. c9623de (Merge branch 'v4l_for_linus'
   of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media)

b) These have only been tested on an omap2420 h4 and an am37x evm.  If you
   have different hardware available and a few minutes, please test them.
   A quick and easy test is to enable tcrypt as a module
   (CONFIG_CRYPTO_TEST=m), boot, then run 'modprobe tcrypt sec=2 mode=403'.
   'CONFIG_CRYPTO_SHA1' and 'CONFIG_CRYPTO_DEV_OMAP_SHAM' also have to be
   enabled.  A quick 'grep omap-sham /proc/interrupts' will tell you if
   the omap-sham driver was really used.

c) To test these patches, you will likely need...
   i) The patch included here:
	   http://marc.info/?l=kernel-janitors&m=134910841909057&w=2
   ii) This patch from linux-omap/master:
	   27615a9 (ARM: OMAP: Trivial driver changes to remove include
			   plat/cpu.h)
   iii) This patch from Paul Walmsley:
	   http://www.spinics.net/lists/linux-omap/msg79436.html

d) If you prefer, a version you can test is available at
   git@github.com:mgreeraz/linux-mag.git mag/wip/crypto-test

e) There is a reduction in DMA performance after switching to dmaengine
   (see http://www.spinics.net/lists/linux-omap/msg79855.html)

f) Many thanks to Jon Hunter for testing on his omap2420 h4.

Mark A. Greer (7):
  ARM: OMAP2xxx: hwmod: Convert SHAM crypto device data to hwmod
  ARM: OMAP2xxx: hwmod: Add DMA information for SHAM module
  ARM: OMAP3xxx: hwmod: Convert SHAM crypto device data to hwmod
  ARM: OMAP2+: Remove unnecessary message when no SHA IP is present
  crypto: omap-sham: Convert to use pm_runtime API
  crypto: omap-sham: Add code to use dmaengine API
  crypto: omap_sham: Remove usage of private DMA API

 arch/arm/mach-omap2/clock2420_data.c               |   1 +
 arch/arm/mach-omap2/clock2430_data.c               |   1 +
 arch/arm/mach-omap2/clock3xxx_data.c               |   1 +
 arch/arm/mach-omap2/devices.c                      |  81 +++------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   1 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   1 +
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |  18 ++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  43 +++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  60 +++++++
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   2 +
 drivers/crypto/omap-sham.c                         | 192 +++++++++++----------
 11 files changed, 250 insertions(+), 151 deletions(-)

-- 
1.7.12

