From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH] Fix generic irq chip
Date: Fri, 20 May 2011 23:05:10 +0100
Message-ID: <20110520220510.GC30675@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53105 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757247Ab1ETWFq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 May 2011 18:05:46 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Lennert Buytenhek <kernel@wantstofly.org>, Nicolas Pitre <nico@fluxnic.net>, Thomas
Cc: linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org

As a result of c42321c (genirq: Make generic irq chip depend on
CONFIG_GENERIC_IRQ_CHIP), we now need those platforms using this in
my tree to select this symbol.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
--
Please send acks ASAP.  Thanks to Mark for pointing this out with a patch
for Samsung.

 arch/arm/Kconfig           |    2 ++
 arch/arm/plat-omap/Kconfig |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 44c16f0..9b63bab 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -854,6 +854,7 @@ config ARCH_DAVINCI
 	select HAVE_IDE
 	select CLKDEV_LOOKUP
 	select GENERIC_ALLOCATOR
+	select GENERIC_IRQ_CHIP
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	help
 	  Support for TI's DaVinci platform.
@@ -1033,6 +1034,7 @@ config PLAT_IOP
 
 config PLAT_ORION
 	bool
+	select GENERIC_IRQ_CHIP
 	select HAVE_SCHED_CLOCK
 
 config PLAT_PXA
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index cd5f993..29b4c35 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -18,6 +18,7 @@ config ARCH_OMAP1
 config ARCH_OMAP2PLUS
 	bool "TI OMAP2/3/4"
 	select CLKDEV_LOOKUP
+	select GENERIC_IRQ_CHIP
 	select OMAP_DM_TIMER
 	help
 	  "Systems based on OMAP2, OMAP3 or OMAP4"
