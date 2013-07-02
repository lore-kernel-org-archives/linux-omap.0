From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [RFC 6/9] ARM: OMAP4: CM code: Remove the check for non-zero clkctrl_offs
Date: Tue, 2 Jul 2013 16:58:15 +0530
Message-ID: <1372764498-32503-7-git-send-email-vaibhav.bedia@ti.com>
References: <1372764498-32503-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41798 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676Ab3GBL3Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jul 2013 07:29:16 -0400
In-Reply-To: <1372764498-32503-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, rnayak@ti.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

AM335x which will migrate to the OMAP4 APIs in subsequent patches
has one CLKCTRL at offset 0. A similar check existed in the AM335x
custom APIs and that was removed to fix a crash on boot in commit
169c82a (ARM: OMAP2: am33xx-hwmod: Fix "register offset NULL check" bug).

Do the same in the OMAP4 API to avoid any regressions on AM335x
when it switches over to these APIs.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/cminst44xx.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 2d1d4ef..4ec9712 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -285,9 +285,6 @@ int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs,
 {
 	int i = 0;
 
-	if (!clkctrl_offs)
-		return 0;
-
 	omap_test_timeout(_is_module_ready(part, inst, cdoffs, clkctrl_offs),
 			  MAX_MODULE_READY_TIME, i);
 
@@ -310,9 +307,6 @@ int omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_off
 {
 	int i = 0;
 
-	if (!clkctrl_offs)
-		return 0;
-
 	omap_test_timeout((_clkctrl_idlest(part, inst, cdoffs, clkctrl_offs) ==
 			   CLKCTRL_IDLEST_DISABLED),
 			  MAX_MODULE_DISABLE_TIME, i);
-- 
1.8.1

