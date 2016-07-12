From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 2/4] ARM: OMAP2+: AM33XX: Add HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET
 flag to rtc hwmod
Date: Tue, 12 Jul 2016 12:50:32 -0500
Message-ID: <20160712175034.743-3-d-gerlach@ti.com>
References: <20160712175034.743-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160712175034.743-1-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Olof Johansson <olof@lixom.net>, Paul Walmsley <paul@pwsan.com>, Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

The RTC hwmod on AM335x family of SoCs is unique in that the
clkctrl_offs in the PRCM is 0. We rely on a clkctrl_offs of zero as
indicating no clkctrl is present so we must flag this hwmod with
HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET to indicate the 0 clkctrl_offs is in
fact valid in this case.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index 55c5878577f4..e2d84aa7f595 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -29,6 +29,7 @@
 #define CLKCTRL(oh, clkctrl) ((oh).prcm.omap4.clkctrl_offs = (clkctrl))
 #define RSTCTRL(oh, rstctrl) ((oh).prcm.omap4.rstctrl_offs = (rstctrl))
 #define RSTST(oh, rstst) ((oh).prcm.omap4.rstst_offs = (rstst))
+#define PRCM_FLAGS(oh, flag) ((oh).prcm.omap4.flags = (flag))
 
 /*
  * 'l3' class
@@ -1296,6 +1297,7 @@ static void omap_hwmod_am33xx_clkctrl(void)
 	CLKCTRL(am33xx_i2c1_hwmod, AM33XX_CM_WKUP_I2C0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_wd_timer1_hwmod, AM33XX_CM_WKUP_WDT1_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_rtc_hwmod, AM33XX_CM_RTC_RTC_CLKCTRL_OFFSET);
+	PRCM_FLAGS(am33xx_rtc_hwmod, HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_mmc2_hwmod, AM33XX_CM_PER_MMC2_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_gpmc_hwmod, AM33XX_CM_PER_GPMC_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_l4_ls_hwmod, AM33XX_CM_PER_L4LS_CLKCTRL_OFFSET);
-- 
2.9.0
