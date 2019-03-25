From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/14] bus: ti-sysc: Handle swsup idle mode quirks
Date: Mon, 25 Mar 2019 14:58:48 -0700
Message-ID: <20190325215849.13182-14-tony@atomide.com>
References: <20190325215849.13182-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325215849.13182-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

In preparation of dropping interconnect target module platform data in
favor of devicetree based data, we must pass swsup idle quirks to the
platform data functions.

For now, let's only tag the UART modules with the SWSUP_SIDLE_ACT quirk.
The other modules will get tagged with swsup quirks as we drop the
platform data and test the changes.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c      | 6 ++++++
 drivers/bus/ti-sysc.c                 | 6 +++---
 include/linux/platform_data/ti-sysc.h | 3 +++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3683,6 +3683,12 @@ int omap_hwmod_init_module(struct device *dev,
 		oh->flags |= HWMOD_INIT_NO_RESET;
 	if (data->cfg->quirks & SYSC_QUIRK_USE_CLOCKACT)
 		oh->flags |= HWMOD_SET_DEFAULT_CLOCKACT;
+	if (data->cfg->quirks & SYSC_QUIRK_SWSUP_SIDLE)
+		oh->flags |= HWMOD_SWSUP_SIDLE;
+	if (data->cfg->quirks & SYSC_QUIRK_SWSUP_SIDLE_ACT)
+		oh->flags |= HWMOD_SWSUP_SIDLE_ACT;
+	if (data->cfg->quirks & SYSC_QUIRK_SWSUP_MSTANDBY)
+		oh->flags |= HWMOD_SWSUP_MSTANDBY;
 
 	error = omap_hwmod_check_module(dev, oh, data, sysc_fields,
 					rev_offs, sysc_offs, syss_offs,
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -978,12 +978,12 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	SYSC_QUIRK("timer", 0, 0, 0x10, -1, 0x4fff1301, 0xffff00ff,
 		   0),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000052, 0xffffffff,
-		   SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 	/* Uarts on omap4 and later */
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x50411e03, 0xffff00ff,
-		   SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47422e03, 0xffffffff,
-		   SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 
 	/* Quirks that need to be set based on the module address */
 	SYSC_QUIRK("mcpdm", 0x40132000, 0, 0x10, -1, 0x50000800, 0xffffffff,
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -46,6 +46,9 @@ struct sysc_regbits {
 	s8 emufree_shift;
 };
 
+#define SYSC_QUIRK_SWSUP_MSTANDBY	BIT(13)
+#define SYSC_QUIRK_SWSUP_SIDLE_ACT	BIT(12)
+#define SYSC_QUIRK_SWSUP_SIDLE		BIT(11)
 #define SYSC_QUIRK_EXT_OPT_CLOCK	BIT(10)
 #define SYSC_QUIRK_LEGACY_IDLE		BIT(9)
 #define SYSC_QUIRK_RESET_STATUS		BIT(8)
-- 
2.21.0
