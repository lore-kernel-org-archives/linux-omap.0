From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 4/9] ARM: OMAP2: Update for new MCBSP Kconfig
	option
Date: Thu, 8 Nov 2018 10:37:49 +0200
Message-ID: <20181108083754.1746-5-peter.ujfalusi@ti.com>
References: <20181108083754.1746-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181108083754.1746-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com, tony@atomide.com, nsekhar@ti.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, jsarha@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The MCBSP config option has been changed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/Makefile       | 2 +-
 arch/arm/mach-omap2/pdata-quirks.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 01377c292db4..899c60fac159 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -24,7 +24,7 @@ obj-$(CONFIG_SOC_OMAP5)	 += $(hwmod-common) $(secure-common)
 obj-$(CONFIG_SOC_AM43XX) += $(hwmod-common) $(secure-common)
 obj-$(CONFIG_SOC_DRA7XX) += $(hwmod-common) $(secure-common)
 
-ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
+ifneq ($(CONFIG_SND_SOC_OMAP_MCBSP),)
 obj-y += mcbsp.o
 endif
 
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 9fec5f84bf77..8a5b6ed4ec36 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -524,7 +524,7 @@ void omap_auxdata_legacy_init(struct device *dev)
 	dev->platform_data = &twl_gpio_auxdata;
 }
 
-#if IS_ENABLED(CONFIG_SND_OMAP_SOC_MCBSP)
+#if IS_ENABLED(CONFIG_SND_SOC_OMAP_MCBSP)
 static struct omap_mcbsp_platform_data mcbsp_pdata;
 static void __init omap3_mcbsp_init(void)
 {
@@ -572,7 +572,7 @@ static struct of_dev_auxdata omap_auxdata_lookup[] = {
 	OF_DEV_AUXDATA("ti,am3517-emac", 0x5c000000, "davinci_emac.0",
 		       &am35xx_emac_pdata),
 	/* McBSP modules with sidetone core */
-#if IS_ENABLED(CONFIG_SND_OMAP_SOC_MCBSP)
+#if IS_ENABLED(CONFIG_SND_SOC_OMAP_MCBSP)
 	OF_DEV_AUXDATA("ti,omap3-mcbsp", 0x49022000, "49022000.mcbsp", &mcbsp_pdata),
 	OF_DEV_AUXDATA("ti,omap3-mcbsp", 0x49024000, "49024000.mcbsp", &mcbsp_pdata),
 #endif
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
