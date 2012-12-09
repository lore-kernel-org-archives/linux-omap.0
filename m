From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 02/10] ARM: OMAP2+: clockdomain: add pwrdm_state_switch()
 call to clkdm_sleep()
Date: Sat, 08 Dec 2012 18:23:37 -0700
Message-ID: <20121209012337.19716.98362.stgit@dusk.lan>
References: <20121209011755.19716.25244.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38990 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756435Ab2LIBYb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Dec 2012 20:24:31 -0500
In-Reply-To: <20121209011755.19716.25244.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

In clkdm_sleep(), the powerdomain should be eligible to switch power
states right after the call to the low-level clockdomain sleep
function.  We should have been tracking that with the
pwrdm_state_switch() code, but we weren't, for whatever reason.  Fix that.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomain.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 64e5046..18f65fd 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -763,6 +763,7 @@ int clkdm_sleep(struct clockdomain *clkdm)
 	spin_lock_irqsave(&clkdm->lock, flags);
 	clkdm->_flags &= ~_CLKDM_FLAG_HWSUP_ENABLED;
 	ret = arch_clkdm->clkdm_sleep(clkdm);
+	ret |= pwrdm_state_switch(clkdm->pwrdm.ptr);
 	spin_unlock_irqrestore(&clkdm->lock, flags);
 	return ret;
 }


