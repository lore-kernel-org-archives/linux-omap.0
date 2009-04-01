From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH] ARM: OMAP3: Fix HW SAVEANDRESTORE shift define
Date: Wed, 1 Apr 2009 09:42:54 +0300
Message-ID: <1238568174-28291-2-git-send-email-kalle.jokiniemi@digia.com>
References: <>
 <1238568174-28291-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:31727 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009AbZDAGm5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Apr 2009 02:42:57 -0400
In-Reply-To: <1238568174-28291-1-git-send-email-kalle.jokiniemi@digia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, Kalle Jokiniemi <kalle.jokiniemi@digia.com>

The OMAP3430ES2_SAVEANDRESTORE_SHIFT macro is used
by powerdomain code in
"1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT" manner, but
the definition was also (1 << 4), meaning we actually
modified bit 16. So the definition needs to be 4.

This fixes also a cold reset HW bug in OMAP3430 ES3.x
where some of the efuse bits are not isolated during
wake-up from off mode. This can cause randomish
cold resets with off mode. Enabling the USBTLL hardware
SAVEANDRESTORE causes the core power up assert to be
delayed in a way that we will not get faulty values
when boot ROM is reading the unisolated registers.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
---
 arch/arm/mach-omap2/prm-regbits-34xx.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
index d73eee8..d792c29 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -409,7 +409,7 @@
 /* PM_PREPWSTST_CAM specific bits */
 
 /* PM_PWSTCTRL_USBHOST specific bits */
-#define OMAP3430ES2_SAVEANDRESTORE_SHIFT		(1 << 4)
+#define OMAP3430ES2_SAVEANDRESTORE_SHIFT		4
 
 /* RM_RSTST_PER specific bits */
 
-- 
1.5.4.3

