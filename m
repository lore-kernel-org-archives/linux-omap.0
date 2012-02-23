From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/2] ARM: OMAP: Fix section mismatch warning for platform_cpu_die()
Date: Thu, 23 Feb 2012 12:28:30 +0530
Message-ID: <1329980310-9007-3-git-send-email-santosh.shilimkar@ti.com>
References: <1329980310-9007-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59045 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386Ab2BWG6o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 01:58:44 -0500
In-Reply-To: <1329980310-9007-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

WARNING: vmlinux.o(.text+0x226d0):
Section mismatch in reference from the function
platform_cpu_die() to the function .cpuinit.text:omap4_hotplug_cpu()
The function platform_cpu_die() references
the function __cpuinit omap4_hotplug_cpu().
This is often because platform_cpu_die lacks a __cpuinit
annotation or the annotation of omap4_hotplug_cpu is wrong.

Thanks to Russell King for suggesting __ref annotation trick
just like it's parent function for this warning becasue __cupinit
usage was definitely wrong to fix this warning..

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-hotplug.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index adbe4d8..56c345b 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -33,7 +33,7 @@ int platform_cpu_kill(unsigned int cpu)
  * platform-specific code to shutdown a CPU
  * Called with IRQs disabled
  */
-void platform_cpu_die(unsigned int cpu)
+void __ref platform_cpu_die(unsigned int cpu)
 {
 	unsigned int this_cpu;
 
-- 
1.7.4.1

