From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 2/3] ARM: OMAP1: USB: make omap_otg_init() static
Date: Mon,  2 Jan 2017 22:57:04 +0200
Message-ID: <20170102205705.19001-2-aaro.koskinen@iki.fi>
References: <20170102205705.19001-1-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170102205705.19001-1-aaro.koskinen@iki.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Make omap_otg_init() static.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/include/mach/usb.h | 2 --
 arch/arm/mach-omap1/usb.c              | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/include/mach/usb.h b/arch/arm/mach-omap1/include/mach/usb.h
index a7c5559..eb76628 100644
--- a/arch/arm/mach-omap1/include/mach/usb.h
+++ b/arch/arm/mach-omap1/include/mach/usb.h
@@ -10,8 +10,6 @@
 
 #include <linux/platform_data/usb-omap1.h>
 
-void omap_otg_init(struct omap_usb_config *config);
-
 #if IS_ENABLED(CONFIG_USB)
 void omap1_usb_init(struct omap_usb_config *pdata);
 #else
diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
index d4aa118..0b4ed94 100644
--- a/arch/arm/mach-omap1/usb.c
+++ b/arch/arm/mach-omap1/usb.c
@@ -58,7 +58,7 @@
 
 #ifdef	CONFIG_ARCH_OMAP_OTG
 
-void __init
+static void __init
 omap_otg_init(struct omap_usb_config *config)
 {
 	u32		syscon;
@@ -166,7 +166,7 @@ omap_otg_init(struct omap_usb_config *config)
 }
 
 #else
-void omap_otg_init(struct omap_usb_config *config) {}
+static void omap_otg_init(struct omap_usb_config *config) {}
 #endif
 
 #if IS_ENABLED(CONFIG_USB_OMAP)
-- 
2.9.2
