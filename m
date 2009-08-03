From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP: PM: warn if CONFIG_CPU_IDLE is not enabled
Date: Mon, 3 Aug 2009 01:39:02 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908030138020.19529@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46133 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbZHCHjC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Aug 2009 03:39:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com


For MPU latency constraints to work, CONFIG_CPU_IDLE must be enabled,
since CPUIdle is where the constraints are evaluated.  Warn during
compilation if CONFIG_CPU_IDLE is not defined.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/resource34xx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index 25535a3..1693e9b 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -28,6 +28,10 @@
 #include "cm.h"
 #include "cm-regbits-34xx.h"
 
+#ifndef CONFIG_CPU_IDLE
+#warning MPU latency constraints require CONFIG_CPU_IDLE to function!
+#endif
+
 /**
  * init_latency - Initializes the mpu/core latency resource.
  * @resp: Latency resource to be initalized
-- 
1.6.3.GIT

