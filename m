From: Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 2/2] mfd: twl6030: Disable IRQ during suspend
Date: Mon, 26 Sep 2011 16:44:24 -0700
Message-ID: <1317080664-28096-2-git-send-email-toddpoynor@google.com>
References: <1317080664-28096-1-git-send-email-toddpoynor@google.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:36741 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740Ab1IZXoo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Sep 2011 19:44:44 -0400
In-Reply-To: <1317080664-28096-1-git-send-email-toddpoynor@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Todd Poynor <toddpoynor@google.com>

Module IRQs may still be disabled by DPM at the time the TWL6030
ISR runs, causing handle_simple_irq() to silently do nothing.
This may result in missing TWL RTC alarm wakeups, for example,
since the RTC child module ISR is not called to ack the IRQ.

Disable the TWL6030 IRQ during suspend, enable it at DPM resume
time, at which time the child module IRQs will be re-enabled.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/mfd/twl6030-irq.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index 7d6553c..5c08ecd 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -109,7 +109,13 @@ static int twl6030_irq_pm_notifier(struct notifier_block *notifier,
 			twl_irq_wake_enabled = false;
 		}
 
+		disable_irq(twl_irq);
 		break;
+
+	case PM_POST_SUSPEND:
+		enable_irq(twl_irq);
+		break;
+
 	default:
 		break;
 	}
-- 
1.7.3.1

