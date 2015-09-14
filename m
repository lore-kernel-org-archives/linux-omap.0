From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/2] ARM: OMAP2+: Remove legacy mailbox device instantiation
Date: Mon, 14 Sep 2015 18:37:12 -0500
Message-ID: <1442273833-25013-2-git-send-email-s-anna@ti.com>
References: <1442273833-25013-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1442273833-25013-1-git-send-email-s-anna@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The legacy-style mailbox device creation is supported currently
only for OMAP3, as all other SoCs are DT-boot only. Even on this
SoC, there are no client drivers that utilize these mailbox devices.
So, clean up the legacy-style mailbox device instantiation logic.
The mailbox devices are already present and supported for the DT
boot on OMAP3.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/devices.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 9374da313e8e..f0f9901d90b0 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -18,7 +18,6 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/pinctrl/machine.h>
-#include <linux/platform_data/mailbox-omap.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
@@ -66,32 +65,6 @@ static int __init omap3_l3_init(void)
 }
 omap_postcore_initcall(omap3_l3_init);
 
-#if defined(CONFIG_OMAP2PLUS_MBOX) || defined(CONFIG_OMAP2PLUS_MBOX_MODULE)
-static inline void __init omap_init_mbox(void)
-{
-	struct omap_hwmod *oh;
-	struct platform_device *pdev;
-	struct omap_mbox_pdata *pdata;
-
-	oh = omap_hwmod_lookup("mailbox");
-	if (!oh) {
-		pr_err("%s: unable to find hwmod\n", __func__);
-		return;
-	}
-	if (!oh->dev_attr) {
-		pr_err("%s: hwmod doesn't have valid attrs\n", __func__);
-		return;
-	}
-
-	pdata = (struct omap_mbox_pdata *)oh->dev_attr;
-	pdev = omap_device_build("omap-mailbox", -1, oh, pdata, sizeof(*pdata));
-	WARN(IS_ERR(pdev), "%s: could not build device, err %ld\n",
-						__func__, PTR_ERR(pdev));
-}
-#else
-static inline void omap_init_mbox(void) { }
-#endif /* CONFIG_OMAP2PLUS_MBOX */
-
 static inline void omap_init_sti(void) {}
 
 #if defined(CONFIG_SND_SOC) || defined(CONFIG_SND_SOC_MODULE)
@@ -246,7 +219,6 @@ static int __init omap2_init_devices(void)
 	omap_init_audio();
 	/* If dtb is there, the devices will be created dynamically */
 	if (!of_have_populated_dt()) {
-		omap_init_mbox();
 		omap_init_mcspi();
 		omap_init_sham();
 		omap_init_aes();
-- 
2.5.0
