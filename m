From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/21] ARM: OMAP: SRAM: Move sram-fn.S from plat-omap
	to mach-omap1
Date: Tue, 17 Jun 2008 10:34:34 +0300
Message-ID: <20080617073433.GD13078@atomide.com>
References: <1212802253-17797-1-git-send-email-tony@atomide.com> <1212802253-17797-2-git-send-email-tony@atomide.com> <1212802253-17797-3-git-send-email-tony@atomide.com> <1212802253-17797-4-git-send-email-tony@atomide.com> <1212802253-17797-5-git-send-email-tony@atomide.com> <1212802253-17797-6-git-send-email-tony@atomide.com> <1212802253-17797-7-git-send-email-tony@atomide.com> <1212802253-17797-8-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UoPmpPX/dBe4BELn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52316 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbYFQHeA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2008 03:34:00 -0400
Content-Disposition: inline
In-Reply-To: <1212802253-17797-8-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org


--UoPmpPX/dBe4BELn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [080607 04:31]:
> This file is omap1 specific.

Here's this patch updated with diff -M to show rename.

Tony

--UoPmpPX/dBe4BELn
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0007-omap-sram-mv-omap1.patch"

>From e5d5f0c90ad3f80409901459e32c903a0357b1d8 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 17 Jun 2008 10:29:10 +0300
Subject: [PATCH] ARM: OMAP: SRAM: Move sram-fn.S from plat-omap to mach-omap1

This file is omap1 specific.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index c06f525..5e9416e 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := io.o id.o clock.o irq.o mux.o serial.o devices.o
+obj-y := io.o id.o sram.o clock.o irq.o mux.o serial.o devices.o
 
 obj-$(CONFIG_OMAP_MPU_TIMER)	+= time.o
 obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
diff --git a/arch/arm/plat-omap/sram-fn.S b/arch/arm/mach-omap1/sram.S
similarity index 100%
rename from arch/arm/plat-omap/sram-fn.S
rename to arch/arm/mach-omap1/sram.S
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index bc639a3..2c4051c 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := common.o sram.o sram-fn.o clock.o devices.o dma.o mux.o gpio.o \
+obj-y := common.o sram.o clock.o devices.o dma.o mux.o gpio.o \
 	 usb.o fb.o
 obj-m :=
 obj-n :=

--UoPmpPX/dBe4BELn--
