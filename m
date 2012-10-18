From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 7/8] ARM: OMAP: PM: update target fpwrst to what pwrdm can reach
Date: Thu, 18 Oct 2012 12:20:09 +0300
Message-ID: <1350552010-28760-8-git-send-email-t-kristo@ti.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43249 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754884Ab2JRJUo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 05:20:44 -0400
In-Reply-To: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

As the code within pwrdm_set_fpwrst is updating powerstate and logic
states according to powerdomain capabilities, it may alter the target
fpwrst also. Update the target fpwrst status according to these checks,
otherwise rest of the code in this function will malfunction.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index f5786b4..f92a867 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -711,6 +711,9 @@ int pwrdm_set_fpwrst(struct powerdomain *pwrdm, enum pwrdm_func_state fpwrst)
 		return -EINVAL;
 	}
 
+	/* Refresh target fprwst according to what we can reach */
+	fpwrst = _pwrdm_pwrst_to_fpwrst(pwrdm, pwrst, logic);
+
 	pr_debug("%s: set fpwrst %0x to pwrdm %s\n",
 		 __func__, fpwrst, pwrdm->name);
 
-- 
1.7.4.1

