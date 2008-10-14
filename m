From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] OMAP2/3 GPTIMER: drop redundant pending write check
Date: Tue, 14 Oct 2008 11:27:45 -0600
Message-ID: <20081014172743.5459.16367.stgit@localhost.localdomain>
References: <20081014172417.5459.36601.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49890 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970AbYJNRar (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 13:30:47 -0400
In-Reply-To: <20081014172417.5459.36601.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Richard Woodruff <r-woodruff2@ti.com>

omap_dm_timer_write_reg() already waits for pending writes to complete,
so the extra wait in omap_dm_timer_set_load() is superfluous.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 167ec2f..59be3aa 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -539,10 +539,6 @@ void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
 
-	/* REVISIT: hw feature, ttgr overtaking tldr? */
-	while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff)))
-		cpu_relax();
-
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
 }
 


