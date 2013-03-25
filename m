From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 14/18] ARM: OMAP4: CPUidle: Make C-state description field more precise
Date: Mon, 25 Mar 2013 15:35:06 +0530
Message-ID: <1364205910-32392-15-git-send-email-santosh.shilimkar@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50679 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798Ab3CYKEK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Mar 2013 06:04:10 -0400
In-Reply-To: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

It is useful to know the CPU power state along with MPUSS power state
in a supported C-state. Since the data is available via sysfs, one can
avoid scrolling the source code for precise construction of C-state.

Reported-by: Nishanth Menon <nm@ti.com>
Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 908114d..b8a22f0 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -181,7 +181,7 @@ static struct cpuidle_driver omap4_idle_driver = {
 			.flags = CPUIDLE_FLAG_TIME_VALID,
 			.enter = omap4_enter_idle_simple,
 			.name = "C1",
-			.desc = "MPUSS ON"
+			.desc = "CPUx ON, MPUSS ON"
 		},
 		{
 			/* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
@@ -190,7 +190,7 @@ static struct cpuidle_driver omap4_idle_driver = {
 			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED,
 			.enter = omap4_enter_idle_coupled,
 			.name = "C2",
-			.desc = "MPUSS CSWR",
+			.desc = "CPUx OFF, MPUSS CSWR",
 		},
 		{
 			/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
@@ -199,7 +199,7 @@ static struct cpuidle_driver omap4_idle_driver = {
 			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED,
 			.enter = omap4_enter_idle_coupled,
 			.name = "C3",
-			.desc = "MPUSS OSWR",
+			.desc = "CPUx OFF, MPUSS OSWR",
 		},
 	},
 	.state_count = ARRAY_SIZE(omap4_idle_data),
-- 
1.7.9.5

