From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Fix sar_base inititalization for HS omaps
Date: Fri,  9 Feb 2018 09:35:56 -0800
Message-ID: <20180209173556.29555-1-tony@atomide.com>
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
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, "Andrew F . Davis" <afd@ti.com>, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

HS omaps use irq_save_secure_context() instead of irq_save_context()
so sar_base will never get initialized and irq_sar_clear() gets called
with a wrong address for HS omaps from irq_restore_context().

Starting with commit f4b9f40ae95b ("ARM: OMAP4+: Initialize SAR RAM
base early for proper CPU1 reset for kexec") we have it available,
and this ideally would been fixed with that commit already.

Fixes: f4b9f40ae95b ("ARM: OMAP4+: Initialize SAR RAM base early for
proper CPU1 reset for kexec")
Cc: Andrew F. Davis <afd@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap-wakeupgen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -299,8 +299,6 @@ static void irq_save_context(void)
 	if (soc_is_dra7xx())
 		return;
 
-	if (!sar_base)
-		sar_base = omap4_get_sar_ram_base();
 	if (wakeupgen_ops && wakeupgen_ops->save_context)
 		wakeupgen_ops->save_context();
 }
@@ -598,6 +596,8 @@ static int __init wakeupgen_init(struct device_node *node,
 	irq_hotplug_init();
 	irq_pm_init();
 
+	sar_base = omap4_get_sar_ram_base();
+
 	return 0;
 }
 IRQCHIP_DECLARE(ti_wakeupgen, "ti,omap4-wugen-mpu", wakeupgen_init);
-- 
2.16.1
