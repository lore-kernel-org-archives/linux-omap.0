From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/21] ARM: OMAP: SRAM: Move omap2 sram-fn.S to
	sram242x.S
Date: Tue, 17 Jun 2008 10:36:14 +0300
Message-ID: <20080617073613.GE13078@atomide.com>
References: <1212802253-17797-1-git-send-email-tony@atomide.com> <1212802253-17797-2-git-send-email-tony@atomide.com> <1212802253-17797-3-git-send-email-tony@atomide.com> <1212802253-17797-4-git-send-email-tony@atomide.com> <1212802253-17797-5-git-send-email-tony@atomide.com> <1212802253-17797-6-git-send-email-tony@atomide.com> <1212802253-17797-7-git-send-email-tony@atomide.com> <1212802253-17797-8-git-send-email-tony@atomide.com> <1212802253-17797-9-git-send-email-tony@atomide.com> <20080614080553.GI32122@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Dzs2zDY0zgkG72+7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:60189 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbYFQHfn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2008 03:35:43 -0400
Content-Disposition: inline
In-Reply-To: <20080614080553.GI32122@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080614 11:06]:
> On Fri, Jun 06, 2008 at 06:30:40PM -0700, Tony Lindgren wrote:
> > This file will get split between sram242x.S and sram243x.S
> > in following patch.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Please use '-M' so git diff detects renames.

Here's the updated patch with diff -M.

Tony

--Dzs2zDY0zgkG72+7
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0008-omap-sram-mv-omap2.patch"

>From 6a1b926ac526ffd806057a57b9df8c85d6f5657b Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 17 Jun 2008 10:29:12 +0300
Subject: [PATCH] ARM: OMAP: SRAM: Move omap2 sram-fn.S to sram242x.S

This file will get split between sram242x.S and sram243x.S
in following patch.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 2feb687..6c59b26 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := irq.o id.o io.o sram-fn.o memory.o control.o prcm.o clock.o mux.o \
+obj-y := irq.o id.o io.o sram242x.o memory.o control.o prcm.o clock.o mux.o \
 		devices.o serial.o gpmc.o timer-gp.o
 
 # Power Management
diff --git a/arch/arm/mach-omap2/sram-fn.S b/arch/arm/mach-omap2/sram242x.S
similarity index 100%
rename from arch/arm/mach-omap2/sram-fn.S
rename to arch/arm/mach-omap2/sram242x.S

--Dzs2zDY0zgkG72+7--
