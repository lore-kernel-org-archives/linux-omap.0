From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/2] ARM: OMAP: fix section mismatch warning for omap4_hotplug_cpu()
Date: Thu, 23 Feb 2012 12:28:29 +0530
Message-ID: <1329980310-9007-2-git-send-email-santosh.shilimkar@ti.com>
References: <1329980310-9007-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48906 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533Ab2BWG6o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 01:58:44 -0500
In-Reply-To: <1329980310-9007-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

WARNING: arch/arm/mach-omap2/built-in.o(.text+0x8b80):
Section mismatch in reference from the function omap4_hotplug_cpu() to
the function .cpuinit.text:omap_secondary_startup()
The function omap4_hotplug_cpu() references
the function __cpuinit omap_secondary_startup().
This is often because omap4_hotplug_cpu lacks a __cpuinit
annotation or the annotation of omap_secondary_startup is wrong.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 1d5d010..fe9ab7c 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -300,7 +300,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
  * @cpu : CPU ID
  * @power_state: CPU low power state.
  */
-int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
+int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
 {
 	unsigned int cpu_state = 0;
 
-- 
1.7.4.1

