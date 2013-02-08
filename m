From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] ARM: OMAP4: PM: Avoid expensive cpu_suspend() path for all CPU power states except off
Date: Fri, 8 Feb 2013 20:41:46 +0530
Message-ID: <1360336306-18277-3-git-send-email-santosh.shilimkar@ti.com>
References: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47787 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945976Ab3BHPLH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Feb 2013 10:11:07 -0500
In-Reply-To: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Current CPU PM code code make use of common cpu_suspend() path for all the
CPU power states which is not optimal. In fact cpu_suspend() path is needed
only when we put CPU power domain to off state where the CPU context is lost.

Update the code accordingly so that the expensive cpu_suspend() path
can be avoided for the shallow CPU power states like CPU PD INA/CSWR.

Cc: Kevin Hilman <khilman@deeprootsystems.com>

Reported-by: Richard Woodruff <r-woodruff2@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index aac46bf..abdd0f6 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -276,7 +276,10 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	/*
 	 * Call low level function  with targeted low power state.
 	 */
-	cpu_suspend(save_state, omap4_finish_suspend);
+	if (save_state)
+		cpu_suspend(save_state, omap4_finish_suspend);
+	else
+		omap4_finish_suspend(save_state);
 
 	/*
 	 * Restore the CPUx power state to ON otherwise CPUx
-- 
1.7.9.5

