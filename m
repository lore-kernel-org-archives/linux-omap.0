From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 4/8] ARM: OMAP2+: Extend iommu pdata-quirks to DRA7 DSPs
Date: Mon, 21 Aug 2017 18:48:14 -0500
Message-ID: <20170821234818.4755-5-s-anna@ti.com>
References: <20170821234818.4755-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170821234818.4755-1-s-anna@ti.com>
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
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The DSP processor subsystem in DRA7xx SoCs has two MMUs, one
for the processor port and another for an EDMA port. Both
these MMUs share a common reset line, the MMU on the EDMA
port will always be mirror-programmed alongside the primary
MMU, with the reset handled once. The reset handling is the
same as on equivalent DSP subsystems on OMAP4/OMAP5 SoCs, so
extend the OMAP4 iommu pdata quirks for reset for the MMU
associated with the processor port only.

Add these pdata quirks for both the DSP1 and DSP2 processor
subsystems. Note that DSP2 subsystem is present only on the
DRA74x/DRA76x SoC variants and not on DRA72x/DRA71x SoCs.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 253315393a29..65e566f0c5ea 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -589,6 +589,10 @@ static struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 		       &dra7_hsmmc_data_mmc2),
 	OF_DEV_AUXDATA("ti,dra7-hsmmc", 0x480ad000, "480ad000.mmc",
 		       &dra7_hsmmc_data_mmc3),
+	OF_DEV_AUXDATA("ti,dra7-dsp-iommu", 0x40d01000, "40d01000.mmu",
+		       &omap4_iommu_pdata),
+	OF_DEV_AUXDATA("ti,dra7-dsp-iommu", 0x41501000, "41501000.mmu",
+		       &omap4_iommu_pdata),
 	OF_DEV_AUXDATA("ti,dra7-iommu", 0x55082000, "55082000.mmu",
 		       &omap4_iommu_pdata),
 	OF_DEV_AUXDATA("ti,dra7-iommu", 0x58882000, "58882000.mmu",
-- 
2.13.1
