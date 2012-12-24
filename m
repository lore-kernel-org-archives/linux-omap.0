From: Omar Ramirez Luna <omar.ramirez@copitl.com>
Subject: [PATCH 1/2] staging: tidspbridge: fix breakages due to CM
 reorganization
Date: Mon, 24 Dec 2012 08:10:24 -0600
Message-ID: <1356358225-25557-1-git-send-email-omar.ramirez@copitl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel/>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: "devel" <devel-bounces@linuxdriverproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tony Lindgren <tony@atomide.com>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

3.8-rc1 introduced changes in the clock management header files,
this resulted in compilation breakages for this driver.

Define this locally while APIs are made available, given that driver
code shouldn't include mach header files.

This fixes:
drivers/staging/tidspbridge/core/tiomap3430.c:550:13: error:
'OMAP3430_CM_AUTOIDLE_PLL' undeclared (first use in this function)
drivers/staging/tidspbridge/core/tiomap_io.c:416:13: error:
'OMAP3430_CM_CLKEN_PLL' undeclared (first use in this function)

Reported-by: Chen Gang <gang.chen@asianux.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@copitl.com>
---
 drivers/staging/tidspbridge/core/_tiomap.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/_tiomap.h b/drivers/staging/tidspbridge/core/_tiomap.h
index 543a127..61ea135 100644
--- a/drivers/staging/tidspbridge/core/_tiomap.h
+++ b/drivers/staging/tidspbridge/core/_tiomap.h
@@ -40,6 +40,14 @@
 #include <dspbridge/sync.h>
 #include <dspbridge/clk.h>
 
+/*
+ * XXX These mach-omap2/ defines are wrong and should be removed.  No
+ * driver should read or write to PRM/CM registers directly; they
+ * should rely on OMAP core code to do this.
+ */
+#define OMAP3430_CM_AUTOIDLE_PLL	0x0034
+#define OMAP3430_CM_CLKEN_PLL		0x0004
+
 struct map_l4_peripheral {
 	u32 phys_addr;
 	u32 dsp_virt_addr;
-- 
1.7.4.4
