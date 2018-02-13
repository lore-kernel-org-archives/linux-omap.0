From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/9] dmaengine: omap-dma: include header for bool type
Date: Mon, 12 Feb 2018 19:32:35 -0600
Message-ID: <20180213013243.8378-2-s-anna@ti.com>
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
Cc: Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The omap-dmaengine.h header file uses a bool type, so include
the linux types.h header file so that it is self-contained.
The lack of this header caused some build errors while cleaning
up some header files from various omap_hwmod data files.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 include/linux/omap-dmaengine.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/omap-dmaengine.h b/include/linux/omap-dmaengine.h
index 8e6906c72e90..fc245bafb3ea 100644
--- a/include/linux/omap-dmaengine.h
+++ b/include/linux/omap-dmaengine.h
@@ -8,6 +8,8 @@
 #ifndef __LINUX_OMAP_DMAENGINE_H
 #define __LINUX_OMAP_DMAENGINE_H
 
+#include <linux/types.h>
+
 struct dma_chan;
 
 #if defined(CONFIG_DMA_OMAP) || (defined(CONFIG_DMA_OMAP_MODULE) && defined(MODULE))
-- 
2.15.1
