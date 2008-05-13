From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] CBUS: Fix retu mutex handling
Date: Mon, 12 May 2008 17:35:16 -0700
Message-ID: <1210638918-26644-2-git-send-email-tony@atomide.com>
References: retu-2008-05-12-173514
 <1210638918-26644-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62554 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755336AbYEMAfT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2008 20:35:19 -0400
In-Reply-To: <1210638918-26644-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Fix retu mutex handling. Also use mutex_lock instead of unhandled
mutex_lock_interruptible.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/cbus/retu-wdt.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cbus/retu-wdt.c b/drivers/cbus/retu-wdt.c
index 63194d8..85202ef 100644
--- a/drivers/cbus/retu-wdt.c
+++ b/drivers/cbus/retu-wdt.c
@@ -40,7 +40,7 @@
 #define RETU_WDT_MAX_TIMER 63
 
 static struct completion retu_wdt_completion;
-static DECLARE_MUTEX(retu_wdt_mutex);	/* Avoid simultaneous writes to watchdog register */
+static DEFINE_MUTEX(retu_wdt_mutex);
 
 static unsigned int period_val = RETU_WDT_DEFAULT_TIMER;	/* Current period of watchdog */
 static int counter_param = RETU_WDT_MAX_TIMER;
@@ -52,12 +52,12 @@ static int retu_modify_counter(unsigned int new)
 	if (new < RETU_WDT_MIN_TIMER || new > RETU_WDT_MAX_TIMER)
 		return -EINVAL;
 
-	down_interruptible(&retu_wdt_mutex);
+	mutex_lock(&retu_wdt_mutex);
 
 	period_val = new;
 	retu_write_reg(RETU_REG_WATCHDOG, (u16)period_val);
 
-	up(&retu_wdt_mutex);
+	mutex_unlock(&retu_wdt_mutex);
 	return ret;
 }
 
-- 
1.5.3.6

