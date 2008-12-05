From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/6] ARM: OMAP2: skip unnecessary TLDR write during
	non-autoreload for gptimer
Date: Thu, 04 Dec 2008 18:41:53 -0800
Message-ID: <20081205024153.3868.52653.stgit@localhost>
References: <20081205023737.3868.78857.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51867 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755262AbYLEClz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 21:41:55 -0500
In-Reply-To: <20081205023737.3868.78857.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Richard Woodruff <r-woodruff2@ti.com>

From: Paul Walmsley <paul@pwsan.com>

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
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dmtimer.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 595e3d5..e4f0ce0 100644
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
 

