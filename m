From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/5] ARM: OMAP4: SMP: Update defconfig for OMAP4430
Date: Wed, 27 May 2009 21:56:39 +0530
Message-ID: <1243441599-27043-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48632 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760053AbZE0Q1G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 May 2009 12:27:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch updates omap_4430sdp_defconfig to add SMP and LOCAL_TIMER
support for OMAP4430 SDP platform.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/configs/omap_4430sdp_defconfig |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index 67a3a77..99c5d1a 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -30,7 +30,7 @@ CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 # General setup
 #
 CONFIG_EXPERIMENTAL=y
-CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
@@ -104,6 +104,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_STOP_MACHINE=y
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
@@ -244,6 +245,9 @@ CONFIG_VMSPLIT_3G=y
 # CONFIG_VMSPLIT_2G is not set
 # CONFIG_VMSPLIT_1G is not set
 CONFIG_PAGE_OFFSET=0xC0000000
+CONFIG_SMP=y
+CONFIG_NR_CPUS=2
+CONFIG_LOCAL_TIMERS=y
 # CONFIG_PREEMPT is not set
 CONFIG_HZ=128
 CONFIG_AEABI=y
@@ -695,6 +699,7 @@ CONFIG_HAVE_FUNCTION_TRACER=y
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_KGDB is not set
+# CONFIG_ARM_UNWIND is not set
 # CONFIG_DEBUG_USER is not set
 # CONFIG_DEBUG_ERRORS is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
-- 
1.5.4.7

