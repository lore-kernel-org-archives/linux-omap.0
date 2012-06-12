From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 05/20] OMAP4: PM: clockdomain: workaround for l4_secure_clkdm HWSUP
Date: Tue, 12 Jun 2012 18:31:20 +0300
Message-ID: <1339515095-9908-6-git-send-email-t-kristo@ti.com>
References: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52896 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914Ab2FLPb7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jun 2012 11:31:59 -0400
In-Reply-To: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

On HS/EMU devices the modules from l4_secure_clkdm are used. Few modules from
L4_SEC clockdomain are not accessible without putting l4_secure_clkdm in
force software wakeup.

Follow the recommended sequence across secure API calls.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap-secure.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
index 36ec5a5..eeb8114 100644
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -24,7 +24,10 @@
 
 #include "common.h"
 
+#include "clockdomain.h"
+
 static phys_addr_t omap_secure_memblock_base;
+static struct clockdomain *l4_secure_clkdm;
 
 /**
  * omap_sec_dispatcher: Routine to dispatch low power secure
@@ -48,6 +51,11 @@ u32 omap_secure_dispatcher(u32 idx, u32 flag, u32 nargs, u32 arg1, u32 arg2,
 	param[3] = arg3;
 	param[4] = arg4;
 
+	if (!l4_secure_clkdm)
+		l4_secure_clkdm = clkdm_lookup("l4_secure_clkdm");
+
+	clkdm_wakeup(l4_secure_clkdm);
+
 	/*
 	 * Secure API needs physical address
 	 * pointer for the parameters
@@ -56,6 +64,8 @@ u32 omap_secure_dispatcher(u32 idx, u32 flag, u32 nargs, u32 arg1, u32 arg2,
 	outer_clean_range(__pa(param), __pa(param + 5));
 	ret = omap_smc2(idx, flag, __pa(param));
 
+	clkdm_allow_idle(l4_secure_clkdm);
+
 	return ret;
 }
 
-- 
1.7.4.1

