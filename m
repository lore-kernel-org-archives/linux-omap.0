From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/6] cpufreq: OMAP: remove unnecessary include of
 plat/clock.h
Date: Thu, 27 Sep 2012 10:33:32 -0600
Message-ID: <20120927163331.21755.69249.stgit@dusk.lan>
References: <20120927162800.21755.62891.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46750 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725Ab2I0Qf4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Sep 2012 12:35:56 -0400
In-Reply-To: <20120927162800.21755.62891.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Remove an unnecessary include of arch/arm/plat-omap/include/plat/clock.h
to facilitate the ARM single kernel image work.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 drivers/cpufreq/omap-cpufreq.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index b47034e..1c9eff6 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -30,7 +30,6 @@
 #include <asm/smp_plat.h>
 #include <asm/cpu.h>
 
-#include <plat/clock.h>
 #include <plat/omap-pm.h>
 #include <plat/common.h>
 #include <plat/omap_device.h>


