From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 14/14] arm: omap: pm: wait for domain wakeup if changing state of idle domain
Date: Tue, 21 Feb 2012 16:04:58 +0200
Message-ID: <1329833098-19900-15-git-send-email-t-kristo@ti.com>
References: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35695 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755421Ab2BUOGJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 09:06:09 -0500
In-Reply-To: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

If we are switching the state of an idle powerdomain, we must wait for
the wakeup to complete before attempting to switch to the new state,
otherwise the powerdomain may not be ready for the switch and will fail.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 2402e8e..7a669f3 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -126,6 +126,7 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 		} else {
 			hwsup = clkdm_in_hwsup(pwrdm->pwrdm_clkdms[0]);
 			clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
+			pwrdm_wait_transition(pwrdm);
 			sleep_switch = FORCEWAKEUP_SWITCH;
 		}
 	}
-- 
1.7.4.1

