From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 8/8] ARM: OMAP3: Fix HW SAVEANDRESTORE shift define
Date: Thu, 14 May 2009 10:52:40 -0700
Message-ID: <20090514175240.12080.19021.stgit@localhost>
References: <20090514174100.12080.9736.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62861 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbZENRwt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 13:52:49 -0400
In-Reply-To: <20090514174100.12080.9736.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Kalle Jokiniemi <kalle.jokiniemi@digia.com>

From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>

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
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/prm-regbits-34xx.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
index c6a7940..9fd03a2 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -409,7 +409,7 @@
 /* PM_PREPWSTST_CAM specific bits */
 
 /* PM_PWSTCTRL_USBHOST specific bits */
-#define OMAP3430ES2_SAVEANDRESTORE_SHIFT		(1 << 4)
+#define OMAP3430ES2_SAVEANDRESTORE_SHIFT		4
 
 /* RM_RSTST_PER specific bits */
 

