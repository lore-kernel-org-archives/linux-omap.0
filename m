From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 10/16] ARM: omap: fix section mismatch warning for
 omap_secondary_startup()
Date: Wed, 08 Feb 2012 16:39:10 +0000
Message-ID: <E1RvAY2-0006HR-Dh@rmk-PC.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34998 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755839Ab2BHQjQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 11:39:16 -0500
In-Reply-To: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org

WARNING: vmlinux.o(.text+0x1c664): Section mismatch in reference from the function omap_secondary_startup() to the function .cpuinit.text:secondary_startup()
The function omap_secondary_startup() references
the function __cpuinit secondary_startup().
This is often because omap_secondary_startup lacks a __cpuinit
annotation or the annotation of secondary_startup is wrong.

Unfortunately, fixing this causes a new warning which is harder to
solve:

WARNING: arch/arm/mach-omap2/built-in.o(.text+0x5328): Section mismatch in reference from the function omap4_hotplug_cpu() to the function .cpuinit.text:omap_secondary_startup()
The function omap4_hotplug_cpu() references
the function __cpuinit omap_secondary_startup().
This is often because omap4_hotplug_cpu lacks a __cpuinit
annotation or the annotation of omap_secondary_startup is wrong.

because omap4_hotplug_cpu() is used by power management code as well,
which may not end up using omap_secondary_startup().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/omap-headsmp.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
index b13ef7e..503ac77 100644
--- a/arch/arm/mach-omap2/omap-headsmp.S
+++ b/arch/arm/mach-omap2/omap-headsmp.S
@@ -18,6 +18,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
+	__CPUINIT
 /*
  * OMAP4 specific entry point for secondary CPU to jump from ROM
  * code.  This routine also provides a holding flag into which
-- 
1.7.4.4

