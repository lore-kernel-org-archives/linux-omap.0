From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] ARM: scu: add missing errno include
Date: Tue,  4 Jul 2017 15:25:41 +0200
Message-ID: <20170704132542.27644-2-johan@kernel.org>
References: <20170704132542.27644-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170704132542.27644-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>, linux-omap@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-omap@vger.kernel.org

Add missing errno include to make the header self-contained and avoid
compilation breakage when compiling shared code without
CONFIG_HAVE_ARM_SCU.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/arm/include/asm/smp_scu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
index bfe163c40024..5983f6bc62d5 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -7,6 +7,7 @@
 
 #ifndef __ASSEMBLER__
 
+#include <linux/errno.h>
 #include <asm/cputype.h>
 
 static inline bool scu_a9_has_base(void)
-- 
2.13.2
