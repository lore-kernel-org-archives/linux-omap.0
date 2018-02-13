From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/9] mmc: hsmmc_omap: include types.h and provide header
 inclusion guard
Date: Mon, 12 Feb 2018 19:32:36 -0600
Message-ID: <20180213013243.8378-3-s-anna@ti.com>
References: <20180213013243.8378-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180213013243.8378-1-s-anna@ti.com>
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The hsmmc-omap platform data header file uses some u8/u16/u32 types,
so include the linux types.h header file so that it is self-contained.
The lack of this header caused some build errors while cleaning up some
other header files from various omap_hwmod data files.

While at this, also add the missing header inclusion guard.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
Hi Ulf,

This patch is part of a hwmod cleanup series, and is needed before I
can do the cleanup in those files. So prefer to have this patch go
through Tony as part of the series.

regards
Suman

 include/linux/platform_data/hsmmc-omap.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/platform_data/hsmmc-omap.h b/include/linux/platform_data/hsmmc-omap.h
index 73d9098ada2d..9573b87dae14 100644
--- a/include/linux/platform_data/hsmmc-omap.h
+++ b/include/linux/platform_data/hsmmc-omap.h
@@ -24,6 +24,12 @@
  *    Operation Issue" in _OMAP3530/3525/3515/3503 Silicon Errata_
  *    Revision F (October 2010) (SPRZ278F).
  */
+
+#ifndef __LINUX_PLATFORM_DATA_OMAP_HSMMC_H__
+#define __LINUX_PLATFORM_DATA_OMAP_HSMMC_H__
+
+#include <linux/types.h>
+
 #define OMAP_HSMMC_SUPPORTS_DUAL_VOLT		BIT(0)
 #define OMAP_HSMMC_BROKEN_MULTIBLOCK_READ	BIT(1)
 #define OMAP_HSMMC_SWAKEUP_MISSING		BIT(2)
@@ -79,3 +85,5 @@ struct omap_hsmmc_platform_data {
 	const char *name;
 	u32 ocr_mask;
 };
+
+#endif
-- 
2.15.1
