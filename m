From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/5] OMAP: timers: Fix clock source names for OMAP4
Date: Tue, 11 May 2010 12:57:07 +0530
Message-ID: <1273562830-9758-3-git-send-email-rnayak@ti.com>
References: <1273562830-9758-1-git-send-email-rnayak@ti.com>
 <1273562830-9758-2-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40867 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757266Ab0EKH1Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 May 2010 03:27:16 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4B7RDwt019743
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 02:27:15 -0500
In-Reply-To: <1273562830-9758-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

The clock sources for timers on OMAP4 (system clock and 32k
clock) have their names wronly populated.
This patch fixes them so the omap_dm_timer_set_source
does not fail anymore.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 4d99dfb..c64875f 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -264,8 +264,8 @@ static struct omap_dm_timer omap4_dm_timers[] = {
 	{ .phys_base = 0x4a320000, .irq = OMAP44XX_IRQ_GPT12 },
 };
 static const char *omap4_dm_source_names[] __initdata = {
-	"sys_ck",
-	"omap_32k_fck",
+	"sys_clkin_ck",
+	"sys_32k_ck",
 	NULL
 };
 static struct clk *omap4_dm_source_clocks[2];
-- 
1.7.0.rc1.33.g07cf0f

