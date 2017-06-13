From: Hoeun Ryu <hoeun.ryu@gmail.com>
Subject: [RESEND PATCH 2/2] arm:omap2+: drop dependence on DEBUG_OMAP2PLUS_UART for DEBUG_UNCOMPRESS
Date: Tue, 13 Jun 2017 10:09:49 +0900
Message-ID: <1497316206-11110-2-git-send-email-hoeun.ryu@gmail.com>
References: <1497316206-11110-1-git-send-email-hoeun.ryu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497316206-11110-1-git-send-email-hoeun.ryu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, Hoeun Ryu <hoeun.ryu@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

 With a patch 9a5151e1d1ba4df41bc4b8e8c0f17163247645ac, "arm:omap2+: put
omap_uart_phys/virt/lsr in .text section when ZIMAGE is true", the
dependence on DEBUG_OMAP2PLUS_UART for DEBUG_UNCOMPRESS can be dropped,
because all code of omap2+'s DEBUG_LL_INCLUDE file is in .text section when
it's included in the decompressor.

Signed-off-by: Hoeun Ryu <hoeun.ryu@gmail.com>
---
 * mail to relevant recipients, no response yet from them.
   - add TO=Tony Lindgren <tony@atomide.com>
   - add CC=linux-omap@vger.kernel.org
 * indentical to previous patch

 arch/arm/Kconfig.debug | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index ba2cb63..52eb0bf 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1735,8 +1735,7 @@ config DEBUG_UART_8250_FLOW_CONTROL
 config DEBUG_UNCOMPRESS
 	bool
 	depends on ARCH_MULTIPLATFORM || PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
-	default y if DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
-		     (!DEBUG_TEGRA_UART || !ZBOOT_ROM) && \
+	default y if DEBUG_LL && (!DEBUG_TEGRA_UART || !ZBOOT_ROM) && \
 		     !DEBUG_BRCMSTB_UART
 	help
 	  This option influences the normal decompressor output for
-- 
2.7.4
