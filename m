From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv3 06/13] iommu/omap: enable bus-error back on supported iommus
Date: Fri, 28 Feb 2014 14:42:37 -0600
Message-ID: <1393620164-14633-7-git-send-email-s-anna@ti.com>
References: <1393620164-14633-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1393620164-14633-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Subramaniam Chanderashekarapuram <subramaniam.ca-l0cyMroinI0@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The remoteproc MMUs in OMAP4+ SoCs have some additional debug
registers that can give out the PC value in addition to the
MMU fault address. The PC value can be extracted properly only
on the DSP cores, and is not available on the ARM processors
within the IPU sub-systems. Instead, the MMUs have been enhanced
to throw a bus-error response back to the IPU processors.

This functionality is programmable through the MMU_GP_REG register.
The cores are simply stalled if the MMU_GP_REG.BUS_ERR_BACK_EN bit
is not set. When set, a bus-error exception is raised allowing the
processor to handle it as a bus fault and provide additional debug
information. This feature is turned on by default by the driver on
iommus supporting it.

Signed-off-by: Subramaniam Chanderashekarapuram <subramaniam.ca-l0cyMroinI0@public.gmane.org>
Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 drivers/iommu/omap-iommu.c  | 2 ++
 drivers/iommu/omap-iommu.h  | 5 +++++
 drivers/iommu/omap-iommu2.c | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index eb73ef2..28bc631 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -961,6 +961,8 @@ static int omap_iommu_probe(struct platform_device *pdev)
 		 */
 		obj->da_start = 0;
 		obj->da_end = 0xfffff000;
+		if (of_find_property(of, "ti,iommu-bus-err-back", NULL))
+			obj->has_bus_err_back = MMU_GP_REG_BUS_ERR_BACK_EN;
 	} else {
 		obj->nr_tlb_entries = pdata->nr_tlb_entries;
 		obj->name = pdata->name;
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 1200842..ea920c3 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -52,6 +52,8 @@ struct omap_iommu {
 	void *ctx; /* iommu context: registres saved area */
 	u32 da_start;
 	u32 da_end;
+
+	int has_bus_err_back;
 };
 
 struct cr_regs {
@@ -130,6 +132,7 @@ static inline struct omap_iommu *dev_to_omap_iommu(struct device *dev)
 #define MMU_READ_CAM		0x68
 #define MMU_READ_RAM		0x6c
 #define MMU_EMU_FAULT_AD	0x70
+#define MMU_GP_REG		0x88
 
 #define MMU_REG_SIZE		256
 
@@ -163,6 +166,8 @@ static inline struct omap_iommu *dev_to_omap_iommu(struct device *dev)
 #define MMU_RAM_MIXED_MASK	(1 << MMU_RAM_MIXED_SHIFT)
 #define MMU_RAM_MIXED		MMU_RAM_MIXED_MASK
 
+#define MMU_GP_REG_BUS_ERR_BACK_EN	0x1
+
 /*
  * utilities for super page(16MB, 1MB, 64KB and 4KB)
  */
diff --git a/drivers/iommu/omap-iommu2.c b/drivers/iommu/omap-iommu2.c
index d745094..5e1ea3b 100644
--- a/drivers/iommu/omap-iommu2.c
+++ b/drivers/iommu/omap-iommu2.c
@@ -98,6 +98,9 @@ static int omap2_iommu_enable(struct omap_iommu *obj)
 
 	iommu_write_reg(obj, pa, MMU_TTB);
 
+	if (obj->has_bus_err_back)
+		iommu_write_reg(obj, MMU_GP_REG_BUS_ERR_BACK_EN, MMU_GP_REG);
+
 	__iommu_set_twl(obj, true);
 
 	return 0;
-- 
1.9.0
