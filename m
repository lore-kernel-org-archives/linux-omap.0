From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v6 23/23] ARM: DRA7: clockdomain: Change the CLKTRCTRL of CM_PCIE_CLKSTCTRL to SW_WKUP
Date: Wed, 5 Apr 2017 14:22:43 +0530
Message-ID: <20170405085243.18123-24-kishon@ti.com>
References: <20170405085243.18123-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170405085243.18123-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: hch@infradead.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

The PCIe programming sequence in TRM suggests CLKSTCTRL of PCIe should be
set to SW_WKUP. There are no issues when CLKSTCTRL is set to HW_AUTO in RC
mode. However in EP mode, the host system is not able to access the
MEMSPACE and setting the CLKSTCTRL to SW_WKUP fixes it.

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm/mach-omap2/clockdomains7xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clockdomains7xx_data.c b/arch/arm/mach-omap2/clockdomains7xx_data.c
index 6c679659cda5..67ebff829cf2 100644
--- a/arch/arm/mach-omap2/clockdomains7xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains7xx_data.c
@@ -524,7 +524,7 @@ static struct clockdomain pcie_7xx_clkdm = {
 	.dep_bit	  = DRA7XX_PCIE_STATDEP_SHIFT,
 	.wkdep_srcs	  = pcie_wkup_sleep_deps,
 	.sleepdep_srcs	  = pcie_wkup_sleep_deps,
-	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
+	.flags		  = CLKDM_CAN_SWSUP,
 };
 
 static struct clockdomain atl_7xx_clkdm = {
-- 
2.11.0
