From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/14] omap1: htcherald: Update defconfig to include mux
	support
Date: Fri, 11 Dec 2009 15:53:42 -0800
Message-ID: <20091211235342.3189.5163.stgit@localhost>
References: <20091211234919.3189.95607.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58199 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934009AbZLKXxg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 18:53:36 -0500
In-Reply-To: <20091211234919.3189.95607.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Cory Maccarrone <darkstar6262@gmail.com>

From: Cory Maccarrone <darkstar6262@gmail.com>

The existing htcherald_defconfig did not include mux support, which
prevented USB and other functionality from working out of the box.
This change updates the defconfig to add it in.  It also aligns the
defconfig to the -rc8 kernel config.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/htcherald_defconfig |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/htcherald_defconfig b/arch/arm/configs/htcherald_defconfig
index 3382676..1b39691 100644
--- a/arch/arm/configs/htcherald_defconfig
+++ b/arch/arm/configs/htcherald_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.32-rc6
-# Sat Nov 14 10:56:01 2009
+# Linux kernel version: 2.6.32-rc8
+# Sat Dec  5 12:16:24 2009
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -198,7 +198,9 @@ CONFIG_ARCH_OMAP1=y
 # OMAP Feature Selections
 #
 # CONFIG_OMAP_RESET_CLOCKS is not set
-# CONFIG_OMAP_MUX is not set
+CONFIG_OMAP_MUX=y
+# CONFIG_OMAP_MUX_DEBUG is not set
+CONFIG_OMAP_MUX_WARNINGS=y
 CONFIG_OMAP_MCBSP=y
 # CONFIG_OMAP_MBOX_FWK is not set
 CONFIG_OMAP_MPU_TIMER=y
@@ -207,6 +209,7 @@ CONFIG_OMAP_LL_DEBUG_UART1=y
 # CONFIG_OMAP_LL_DEBUG_UART2 is not set
 # CONFIG_OMAP_LL_DEBUG_UART3 is not set
 # CONFIG_OMAP_LL_DEBUG_NONE is not set
+CONFIG_OMAP_SERIAL_WAKE=y
 # CONFIG_OMAP_PM_NONE is not set
 CONFIG_OMAP_PM_NOOP=y
 

