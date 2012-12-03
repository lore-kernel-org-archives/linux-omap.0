From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] ARM: omap: kill NEED_MACH_GPIO_H
Date: Tue,  4 Dec 2012 00:50:25 +0100
Message-ID: <1354578625-25760-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This does not appear to be used by the OMAP.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                        | 1 -
 arch/arm/mach-omap1/include/mach/gpio.h | 3 ---
 arch/arm/mach-omap2/include/mach/gpio.h | 3 ---
 3 files changed, 7 deletions(-)
 delete mode 100644 arch/arm/mach-omap1/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/gpio.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f456cf4..12deaec 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -938,7 +938,6 @@ config ARCH_OMAP
 	select CLKSRC_MMIO
 	select GENERIC_CLOCKEVENTS
 	select HAVE_CLK
-	select NEED_MACH_GPIO_H
 	help
 	  Support for TI's OMAP platform (OMAP1/2/3/4).
 
diff --git a/arch/arm/mach-omap1/include/mach/gpio.h b/arch/arm/mach-omap1/include/mach/gpio.h
deleted file mode 100644
index ebf86c0..0000000
--- a/arch/arm/mach-omap1/include/mach/gpio.h
+++ /dev/null
@@ -1,3 +0,0 @@
-/*
- * arch/arm/mach-omap1/include/mach/gpio.h
- */
diff --git a/arch/arm/mach-omap2/include/mach/gpio.h b/arch/arm/mach-omap2/include/mach/gpio.h
deleted file mode 100644
index 5621cc5..0000000
--- a/arch/arm/mach-omap2/include/mach/gpio.h
+++ /dev/null
@@ -1,3 +0,0 @@
-/*
- * arch/arm/mach-omap2/include/mach/gpio.h
- */
-- 
1.7.11.7
