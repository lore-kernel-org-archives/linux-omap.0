From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] bus: ti-sysc: Fix missing force mstandby quirk handling
Date: Mon,  9 Dec 2019 13:55:40 -0800
Message-ID: <20191209215540.22801-1-tony@atomide.com>
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
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Commit 03856e928b0e ("bus: ti-sysc: Handle mstandby quirk and use it for
musb") added quirk handling for mstandby quirk but did not consider that
we also need a quirk variant for SYSC_QUIRK_FORCE_MSTANDBY.

We need to use forced idle mode for both SYSC_QUIRK_SWSUP_MSTANDBY and
SYSC_QUIRK_FORCE_MSTANDBY, but SYSC_QUIRK_SWSUP_MSTANDBY also need to
additionally also configure no-idle mode when enabled.

Fixes: 03856e928b0e ("bus: ti-sysc: Handle mstandby quirk and use it for musb")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c                 | 3 ++-
 include/linux/platform_data/ti-sysc.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -981,7 +981,8 @@ static int sysc_disable_module(struct device *dev)
 		return ret;
 	}
 
-	if (ddata->cfg.quirks & SYSC_QUIRK_SWSUP_MSTANDBY)
+	if (ddata->cfg.quirks & (SYSC_QUIRK_SWSUP_MSTANDBY) ||
+	    ddata->cfg.quirks & (SYSC_QUIRK_FORCE_MSTANDBY))
 		best_mode = SYSC_IDLE_FORCE;
 
 	reg &= ~(SYSC_IDLE_MASK << regbits->midle_shift);
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -49,6 +49,7 @@ struct sysc_regbits {
 	s8 emufree_shift;
 };
 
+#define SYSC_QUIRK_FORCE_MSTANDBY	BIT(20)
 #define SYSC_MODULE_QUIRK_AESS		BIT(19)
 #define SYSC_MODULE_QUIRK_SGX		BIT(18)
 #define SYSC_MODULE_QUIRK_HDQ1W		BIT(17)
-- 
2.24.0
