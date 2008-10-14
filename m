From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] OMAP2/3 GPTIMER: skip unnecessary TLDR write during
	non-autoreload
Date: Tue, 14 Oct 2008 11:27:48 -0600
Message-ID: <20081014172745.5459.1893.stgit@localhost.localdomain>
References: <20081014172417.5459.36601.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49892 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbYJNRar (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 13:30:47 -0400
In-Reply-To: <20081014172417.5459.36601.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Richard Woodruff <r-woodruff2@ti.com>

The GPTIMER TLDR register does not need to be written if the GPTIMER
is not in autoreload mode.  This is the usual case for dynamic tick-enabled
kernels.

Simulation data indicate that skipping the read that occurs as part of
the write should save at least 300-320 ns for each GPTIMER1 timer
reprogram.  (This assumes L4-Wakeup is at 19MHz and GPTIMER write
posting is enabled.)  Skipping the write itself probably won't have
much impact since it should be posted on the OCP interconnect.

Tested on 2430SDP and 3430SDP.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 59be3aa..08028f6 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -549,14 +549,15 @@ void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 	u32 l;
 
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-	if (autoreload)
+	if (autoreload) {
 		l |= OMAP_TIMER_CTRL_AR;
-	else
+		omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
+	} else {
 		l &= ~OMAP_TIMER_CTRL_AR;
+	}
 	l |= OMAP_TIMER_CTRL_ST;
 
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG, load);
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 }
 


