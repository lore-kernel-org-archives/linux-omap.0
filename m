From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Subject: [PATCH 5/5] ARM: OMAP: kill omap_pmic_init
Date: Tue, 1 Nov 2016 13:36:46 +0200
Message-ID: <1478000206-10855-6-git-send-email-Nicolae_Rosia@mentor.com>
References: <1478000206-10855-1-git-send-email-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1478000206-10855-1-git-send-email-Nicolae_Rosia@mentor.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Nicolae Rosia <Nicolae_Rosia@mentor.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Remove dead code

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
---
 arch/arm/mach-omap2/twl-common.c | 13 -------------
 arch/arm/mach-omap2/twl-common.h |  2 --
 2 files changed, 15 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index cf3d81b..876772c 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -39,19 +39,6 @@ static struct i2c_board_info __initdata pmic_i2c_board_info = {
 	.flags		= I2C_CLIENT_WAKE,
 };
 
-void __init omap_pmic_init(int bus, u32 clkrate,
-			   const char *pmic_type, int pmic_irq,
-			   struct twl4030_platform_data *pmic_data)
-{
-	omap_mux_init_signal("sys_nirq", OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE);
-	strlcpy(pmic_i2c_board_info.type, pmic_type,
-		sizeof(pmic_i2c_board_info.type));
-	pmic_i2c_board_info.irq = pmic_irq;
-	pmic_i2c_board_info.platform_data = pmic_data;
-
-	omap_register_i2c_bus(bus, clkrate, &pmic_i2c_board_info, 1);
-}
-
 void __init omap_pmic_late_init(void)
 {
 	/* Init the OMAP TWL parameters (if PMIC has been registerd) */
diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl-common.h
index 5579bd6..44713bb 100644
--- a/arch/arm/mach-omap2/twl-common.h
+++ b/arch/arm/mach-omap2/twl-common.h
@@ -35,8 +35,6 @@ struct twl6040_platform_data;
 struct omap_tw4030_pdata;
 struct i2c_board_info;
 
-void omap_pmic_init(int bus, u32 clkrate, const char *pmic_type, int pmic_irq,
-		    struct twl4030_platform_data *pmic_data);
 void omap_pmic_late_init(void);
 
 void omap_twl4030_audio_init(char *card_name, struct omap_tw4030_pdata *pdata);
-- 
2.5.5
