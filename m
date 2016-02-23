From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/3] ARM: omap1: avoid unused variable warning
Date: Tue, 23 Feb 2016 14:57:52 +0100
Message-ID: <1456235876-4088840-3-git-send-email-arnd@arndb.de>
References: <1456235876-4088840-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456235876-4088840-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The osk_mistral_init() contains code that is only compiled when
CONFIG_PM is set, but it uses a variable that is declared outside
of the #ifdef:

arch/arm/mach-omap1/board-osk.c: In function 'osk_mistral_init':
arch/arm/mach-omap1/board-osk.c:513:7: warning: unused variable 'ret' [-Wunused-variable]

This puts the variable in the same #ifdef to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap1/board-osk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 209aecb0df68..fcc5c0650429 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -510,7 +510,9 @@ static void __init osk_mistral_init(void)
 	 */
 	omap_cfg_reg(N15_1610_MPUIO2);
 	if (gpio_request(OMAP_MPUIO(2), "wakeup") == 0) {
+#ifdef	CONFIG_PM
 		int ret = 0;
+#endif
 		int irq = gpio_to_irq(OMAP_MPUIO(2));
 
 		gpio_direction_input(OMAP_MPUIO(2));
-- 
2.7.0
