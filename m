From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH] Revert "ARM: AM33xx: fix module_wait_ready without clkctrl
 register"
Date: Mon, 11 Jul 2016 16:39:38 -0500
Message-ID: <20160711213938.28385-1-d-gerlach@ti.com>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: Olof Johansson <olof@lixom.net>, Paul Walmsley <paul@pwsan.com>, Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

This reverts commit 183e2077d007aa4b697efba095ecfea7244a6107.

The original patch added a check to am33xx_cm_wait_module_ready for a
clkctrl offset of 0 as an invalid case, however, clkctrl offset of 0 is
perfectly valid for hwmods, in particular the rtc.

Without reverting this patch sometimes external aborts are seen on
am335x during boot. This is due to the am33xx_cm_wait_module_ready
function immediately returning 0 rather than waiting for the RTC_CLKCTRL
register to indicate it is actually ready before rtc register accesses
happen.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/cm33xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index c073fb57dd13..7b181f929525 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -220,9 +220,6 @@ static int am33xx_cm_wait_module_ready(u8 part, s16 inst, u16 clkctrl_offs,
 {
 	int i = 0;
 
-	if (!clkctrl_offs)
-		return 0;
-
 	omap_test_timeout(_is_module_ready(inst, clkctrl_offs),
 			  MAX_MODULE_READY_TIME, i);
 
-- 
2.9.0
