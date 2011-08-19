From: "Bhandiwad, Hrishikesh" <hrishikesh.b@ti.com>
Subject: RE: [PATCH v2] OMAP3: NAND: Adding NAND support and specifying NAND
	partitions.
Date: Fri, 19 Aug 2011 15:47:17 +0530
Message-ID: <ADF30F4D7BDE934D9B632CE7D5C7ACA4047C4D08A0BA@dbde03.ent.ti.com>
References: <1311943396-16710-1-git-send-email-hrishikesh.b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1311943396-16710-1-git-send-email-hrishikesh.b@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: "Bhandiwad, Hrishikesh" <hrishikesh.b@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kerne
Cc: "Premi, Sanjeev" <premi@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

As this patch is trivial can it be upstreamed ?
Thanks & Regards,
Hrishikesh
________________________________________
From: Bhandiwad, Hrishikesh
Sent: Friday, July 29, 2011 6:13 PM
To: linux-mtd@lists.infradead.org; linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org
Cc: Bhandiwad, Hrishikesh; Hiremath, Vaibhav; Premi, Sanjeev
Subject: [PATCH v2] OMAP3: NAND: Adding NAND support and specifying NAND partitions.

This patch adds the NAND support on OMAP3EVM board and also allocates
five partitions  on NAND.
Referred to file: arch/arm/mach-omap2/board-omap3beagle.c

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Sanjeev Premi <premi@ti.com>
Signed-off-by: Hrishikesh Bhandiwad <hrishikesh.b@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   37 ++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b4d4346..3ac96d4 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -30,6 +30,9 @@
 #include <linux/usb/otg.h>
 #include <linux/smsc911x.h>

+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
+
 #include <linux/wl12xx.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
@@ -101,6 +104,37 @@ static void __init omap3_evm_get_revision(void)
        }
 }

+static struct mtd_partition omap3evm_nand_partitions[] = {
+       /* All the partition sizes are listed in terms of NAND block size */
+       {
+               .name           = "X-Loader",
+               .offset         = 0,
+               .size           = 4 * NAND_BLOCK_SIZE,
+               .mask_flags     = MTD_WRITEABLE,        /* force read-only */
+       },
+       {
+               .name           = "U-Boot",
+               .offset         = 0x80000,
+               .size           = 15 * NAND_BLOCK_SIZE,
+               .mask_flags     = MTD_WRITEABLE,        /* force read-only */
+       },
+       {
+               .name           = "U-Boot Env",
+               .offset         = 0x260000,
+               .size           = 1 * NAND_BLOCK_SIZE,
+       },
+       {
+               .name           = "Kernel",
+               .offset         = 0x280000,
+               .size           = 32 * NAND_BLOCK_SIZE,
+       },
+       {
+               .name           = "File System",
+               .offset         = 0x680000,
+               .size           = MTDPART_SIZ_FULL,
+       },
+};
+
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 #include <plat/gpmc-smsc911x.h>

@@ -696,6 +730,9 @@ static void __init omap3_evm_init(void)

        omap_serial_init();

+       omap_nand_flash_init(NAND_BUSWIDTH_16, omap3evm_nand_partitions,
+                       ARRAY_SIZE(omap3evm_nand_partitions));
+
        /* OMAP3EVM uses ISP1504 phy and so register nop transceiver */
        usb_nop_xceiv_register();

--
1.6.2.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
