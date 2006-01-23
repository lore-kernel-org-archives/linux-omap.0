From: Paul Mundt <paul.mundt@nokia.com>
Subject: [PATCH] ARM: OMAP: Trivial warning fixups.
Date: Mon, 23 Jan 2006 16:13:42 +0200
Message-ID: <20060123141342.GB25124@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Bogus type for vfree() in __ioremap_pfn() (should probably use
remove_vm_area() anyways), and some type mismatches in the OMAP MMC
driver.

Signed-off-by: Paul Mundt <paul.mundt@nokia.com>

---

 arch/arm/mm/ioremap.c |    2 +-
 drivers/mmc/omap.c    |    5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

dfe121170f696b2557e3c43a5aceffa66b739c9c
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index de3ce1e..c45bfea 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -142,7 +142,7 @@ __ioremap_pfn(unsigned long pfn, unsigne
  		return NULL;
  	addr = (unsigned long)area->addr;
  	if (remap_area_pages(addr, pfn, size, flags)) {
- 		vfree(addr);
+		vfree((void *)addr);
  		return NULL;
  	}
  	return (void __iomem *) (offset + (char *)addr);
diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
index f76efee..1eb3a58 100644
--- a/drivers/mmc/omap.c
+++ b/drivers/mmc/omap.c
@@ -678,7 +678,7 @@ mmc_omap_prepare_dma(struct mmc_omap_hos
 	int dst_port = 0;
 	int sync_dev = 0;
 
-	data_addr = io_v2p((void __force *) host->base) + OMAP_MMC_REG_DATA;
+	data_addr = (unsigned long)io_v2p((void __force *) host->base) + OMAP_MMC_REG_DATA;
 	frame = 1 << data->blksz_bits;
 	count = (u32)sg_dma_len(sg);
 
@@ -1306,7 +1306,8 @@ static int __init mmc_omap_probe(struct 
 	}
 
 	if (omap_has_menelaus())
-		menelaus_mmc_register(mmc_omap_switch_callback, &host);
+		menelaus_mmc_register(mmc_omap_switch_callback,
+				      (unsigned long)&host);
 
 no_switch:
 	return 0;
