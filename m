From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 2/5] ARM: OMAP: Force dmtimer restore if context loss is not detectable
Date: Tue, 19 Mar 2013 12:38:16 -0500
Message-ID: <1363714699-29622-3-git-send-email-jon-hunter@ti.com>
References: <1363714699-29622-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35223 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622Ab3CSRia (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Mar 2013 13:38:30 -0400
In-Reply-To: <1363714699-29622-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

When booting with device-tree the function pointer for detecting context
loss is not populated. Ideally, the pm_runtime framework should be
enhanced to allow a means for reporting context/state loss and we could
avoid populating such function pointers altogether. In the interim until
a generic non-device specific solution is in place, force a restore of
the dmtimer when enabling the timer.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 5cae1dd..725d972 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -326,6 +326,8 @@ void omap_dm_timer_enable(struct omap_dm_timer *timer)
 				omap_timer_restore_context(timer);
 				timer->ctx_loss_count = c;
 			}
+		} else {
+			omap_timer_restore_context(timer);
 		}
 	}
 }
-- 
1.7.10.4

