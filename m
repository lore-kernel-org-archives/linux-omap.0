From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 7/7] ARM: OMAP4: PM: put all domains to OSWR during suspend
Date: Mon, 11 Jun 2012 18:26:27 +0300
Message-ID: <1339428387-4800-8-git-send-email-t-kristo@ti.com>
References: <1339428387-4800-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53198 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755797Ab2FKP0x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 11:26:53 -0400
In-Reply-To: <1339428387-4800-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 1e845e8..eb3e073 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -105,7 +105,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	pwrst->pwrdm = pwrdm;
 	pwrst->next_state = pwrdm_get_achievable_func_pwrst(
 						pwrdm,
-						PWRDM_FUNC_PWRST_CSWR);
+						PWRDM_FUNC_PWRST_OSWR);
 	list_add(&pwrst->node, &pwrst_list);
 
 	return omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
-- 
1.7.4.1

