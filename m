From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 4/5] ARM: OMAP4: PM: put all domains to OSWR during suspend
Date: Thu, 13 Sep 2012 19:36:48 +0300
Message-ID: <1347554209-23378-5-git-send-email-t-kristo@ti.com>
References: <1347554209-23378-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44059 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932130Ab2IMQhH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 12:37:07 -0400
In-Reply-To: <1347554209-23378-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Currently OMAP4 suspend puts all power domains to CSWR. OSWR is a deeper
state that saves more power, but has higher latencies also. As suspend
is considered a high-latency operation, OSWR is appropriate here.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index c8965a2..2bd557f 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -101,7 +101,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 		return -ENOMEM;
 
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_FUNC_PWRST_CSWR;
+	pwrst->next_state = PWRDM_FUNC_PWRST_OSWR;
 	list_add(&pwrst->node, &pwrst_list);
 
 	return pwrdm_set_fpwrst(pwrst->pwrdm, pwrst->next_state);
-- 
1.7.4.1

