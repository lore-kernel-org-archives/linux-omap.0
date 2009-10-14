From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/6] omap: headers: Add mach patch to include files
Date: Wed, 14 Oct 2009 14:48:45 -0700
Message-ID: <20091014214845.30227.51419.stgit@kaulin.muru.com>
References: <20091014213748.30227.71513.stgit@kaulin.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091014213748.30227.71513.stgit@kaulin.muru.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is to prepare for moving hardware.h to live under plat
instead of mach.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---

 arch/arm/plat-omap/include/mach/hardware.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
index 26c1fbf..f746c9d 100644
--- a/arch/arm/plat-omap/include/mach/hardware.h
+++ b/arch/arm/plat-omap/include/mach/hardware.h
@@ -280,11 +280,11 @@
  * ---------------------------------------------------------------------------
  */
 
-#include "omap730.h"
-#include "omap1510.h"
-#include "omap16xx.h"
-#include "omap24xx.h"
-#include "omap34xx.h"
-#include "omap44xx.h"
+#include <mach/omap730.h>
+#include <mach/omap1510.h>
+#include <mach/omap16xx.h>
+#include <mach/omap24xx.h>
+#include <mach/omap34xx.h>
+#include <mach/omap44xx.h>
 
 #endif	/* __ASM_ARCH_OMAP_HARDWARE_H */
