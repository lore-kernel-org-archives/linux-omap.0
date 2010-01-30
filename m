From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 9/9] omap2/3/4: Add omap4 into omap3_defconfnig
Date: Fri, 29 Jan 2010 18:01:43 -0800
Message-ID: <20100130020142.10590.89073.stgit@baageli.muru.com>
References: <20100130020036.10590.78028.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49483 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756161Ab0A3CBU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jan 2010 21:01:20 -0500
In-Reply-To: <20100130020036.10590.78028.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Add omap4 into omap3_defconfig. Note that this does not
yet boot on omap4, but boots on omap2 and omap3.

Also note that CONFIG_SMP does not currently work on
uniprocessor ARMs.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap3_defconfig |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap3_defconfig b/arch/arm/configs/omap3_defconfig
index 2bc80d7..714835e 100644
--- a/arch/arm/configs/omap3_defconfig
+++ b/arch/arm/configs/omap3_defconfig
@@ -239,7 +239,7 @@ CONFIG_ARCH_OMAP_OTG=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_ARCH_OMAP2=y
 CONFIG_ARCH_OMAP3=y
-# CONFIG_ARCH_OMAP4 is not set
+CONFIG_ARCH_OMAP4=y
 
 #
 # OMAP Feature Selections
@@ -295,6 +295,7 @@ CONFIG_MACH_OMAP_ZOOM3=y
 CONFIG_MACH_CM_T35=y
 CONFIG_MACH_IGEP0020=y
 CONFIG_MACH_OMAP_3630SDP=y
+CONFIG_MACH_OMAP_4430SDP=y
 # CONFIG_OMAP3_EMU is not set
 # CONFIG_OMAP3_SDRC_AC_TIMING is not set
 
@@ -334,6 +335,7 @@ CONFIG_ARM_L1_CACHE_SHIFT=6
 # CONFIG_ARM_ERRATA_430973 is not set
 # CONFIG_ARM_ERRATA_458693 is not set
 # CONFIG_ARM_ERRATA_460075 is not set
+CONFIG_ARM_GIC=y
 CONFIG_COMMON_CLKDEV=y
 
 #
@@ -350,6 +352,7 @@ CONFIG_TICK_ONESHOT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+# CONFIG_SMP is not set
 CONFIG_VMSPLIT_3G=y
 # CONFIG_VMSPLIT_2G is not set
 # CONFIG_VMSPLIT_1G is not set
@@ -361,6 +364,7 @@ CONFIG_HZ=128
 # CONFIG_THUMB2_KERNEL is not set
 CONFIG_AEABI=y
 CONFIG_OABI_COMPAT=y
+CONFIG_ARCH_HAS_HOLES_MEMORYMODEL=y
 # CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
 # CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
 # CONFIG_HIGHMEM is not set

