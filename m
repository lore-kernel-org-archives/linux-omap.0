From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: clockdomain: Wait for powerdomain to be ON when
 using clockdomain force wakeup
Date: Tue, 16 Aug 2011 19:47:45 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108161946550.9948@utopia.booyaka.com>
References: <1310527588-13022-1-git-send-email-santosh.shilimkar@ti.com> <1310527588-13022-2-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1107150159580.16606@utopia.booyaka.com> <4E214267.2090700@ti.com> <4E43E23C.2080207@ti.com>
 <alpine.DEB.2.00.1108120730220.10963@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34498 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771Ab1HQBrq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Aug 2011 21:47:46 -0400
In-Reply-To: <alpine.DEB.2.00.1108120730220.10963@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org, khilman@ti.com, p-titiano@ti.com, b-cousson@ti.com


Hi everyone

I've updated this patch per my earlier comments and also to apply.  
Please let me know if you have any issues with it ASAP.


- Paul

From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Sat, 13 Aug 2011 08:56:28 +0530
Subject: [PATCH] [PATCH] OMAP: clockdomain: Wait for powerdomain to be ON
 when using clockdomain force wakeup

While using clockdomain force wakeup method, not waiting for powerdomain
to be effectively ON may end up locking the clockdomain FSM until a
next wakeup event occurs.

One such issue was seen on OMAP4430, where L4_PER was periodically
getting stuck in in-transition state when transitioning from from OSWR to ON.

This issue was reported and investigated by Patrick Titiano <p-titiano@ti.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Reported-by: Patrick Titiano <p-titiano@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
[paul@pwsan.com: updated to apply; added transition wait on clkdm_deny_idle();
 remove two superfluous pwrdm_wait_transition() calls]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomain.c |    2 ++
 arch/arm/mach-omap2/pm.c          |    2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index ab7db08..8f08906 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -747,6 +747,7 @@ int clkdm_wakeup(struct clockdomain *clkdm)
 	spin_lock_irqsave(&clkdm->lock, flags);
 	clkdm->_flags &= ~_CLKDM_FLAG_HWSUP_ENABLED;
 	ret = arch_clkdm->clkdm_wakeup(clkdm);
+	ret |= pwrdm_state_switch(clkdm->pwrdm.ptr);
 	spin_unlock_irqrestore(&clkdm->lock, flags);
 	return ret;
 }
@@ -818,6 +819,7 @@ void clkdm_deny_idle(struct clockdomain *clkdm)
 	spin_lock_irqsave(&clkdm->lock, flags);
 	clkdm->_flags &= ~_CLKDM_FLAG_HWSUP_ENABLED;
 	arch_clkdm->clkdm_deny_idle(clkdm);
+	pwrdm_state_switch(clkdm->pwrdm.ptr);
 	spin_unlock_irqrestore(&clkdm->lock, flags);
 }
 
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 3feb359..472bf22 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -130,7 +130,6 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 		} else {
 			hwsup = clkdm_in_hwsup(pwrdm->pwrdm_clkdms[0]);
 			clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
-			pwrdm_wait_transition(pwrdm);
 			sleep_switch = FORCEWAKEUP_SWITCH;
 		}
 	}
@@ -156,7 +155,6 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 		return ret;
 	}
 
-	pwrdm_wait_transition(pwrdm);
 	pwrdm_state_switch(pwrdm);
 err:
 	return ret;
-- 
1.7.5.4

