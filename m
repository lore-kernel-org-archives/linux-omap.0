From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH] bus: ti-sysc: Drop MMU quirks
Date: Thu, 12 Dec 2019 14:47:51 +0200
Message-ID: <20191212124751.3400-1-t-kristo@ti.com>
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
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: s-anna@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The OMAP IOMMU driver no longer uses the pm_runtime_irq_safe() API
after commit 1432ebbd6003 ("iommu/omap: remove pm_runtime_irq_safe
flag for OMAP IOMMUs"), so the SYSC_QUIRK_LEGACY_IDLE quirk is no
longer needed for MMU devices. Drop the same.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/bus/ti-sysc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 56887c6877a7..1c74f38110ac 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1209,10 +1209,6 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	/* These drivers need to be fixed to not use pm_runtime_irq_safe() */
 	SYSC_QUIRK("gpio", 0, 0, 0x10, 0x114, 0x50600801, 0xffff00ff,
 		   SYSC_QUIRK_LEGACY_IDLE | SYSC_QUIRK_OPT_CLKS_IN_RESET),
-	SYSC_QUIRK("mmu", 0, 0, 0x10, 0x14, 0x00000020, 0xffffffff,
-		   SYSC_QUIRK_LEGACY_IDLE),
-	SYSC_QUIRK("mmu", 0, 0, 0x10, 0x14, 0x00000030, 0xffffffff,
-		   SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("sham", 0, 0x100, 0x110, 0x114, 0x40000c03, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("smartreflex", 0, -1, 0x24, -1, 0x00000000, 0xffffffff,
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
