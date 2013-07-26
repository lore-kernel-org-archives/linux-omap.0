From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v10 4/8] arm: omap3: twl: add phy consumer data in
 twl4030_usb_data
Date: Fri, 26 Jul 2013 18:12:58 +0530
Message-ID: <1374842582-13242-5-git-send-email-kishon@ti.com>
References: <1374842582-13242-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1374842582-13242-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, kyungmin.park@samsung.com, balbi@ti.com, kishon@ti.com, jg1.han@samsung.com, s.nawrocki@samsung.com, kgene.kim@samsung.com, stern@rowland.harvard.edu, broonie@kernel.org, tomasz.figa@gmail.com, arnd@arndb.de
Cc: linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, swarren@nvidia.com, balajitk@ti.com, linux-doc@vger.kernel.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-usb@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, grant.likely@linaro.org, akpm@linux-foundation.org, linux-omap@vger.kernel.org, george.cherian@ti.com, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The PHY framework uses the phy consumer data populated in platform data in the
case of non-dt boot to return the reference to the PHY when the controller
(PHY consumer) requests for it. So populated the phy consumer data in the platform
data of twl usb.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/twl-common.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index c05898f..b0d54da 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -24,6 +24,7 @@
 #include <linux/i2c/twl.h>
 #include <linux/gpio.h>
 #include <linux/string.h>
+#include <linux/phy/phy.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
 
@@ -90,8 +91,18 @@ void __init omap_pmic_late_init(void)
 }
 
 #if defined(CONFIG_ARCH_OMAP3)
+struct phy_consumer consumers[] = {
+	PHY_CONSUMER("musb-hdrc.0", "usb"),
+};
+
+struct phy_init_data init_data = {
+	.consumers = consumers,
+	.num_consumers = ARRAY_SIZE(consumers),
+};
+
 static struct twl4030_usb_data omap3_usb_pdata = {
 	.usb_mode	= T2_USB_MODE_ULPI,
+	.init_data	= &init_data,
 };
 
 static int omap3_batt_table[] = {
-- 
1.7.10.4
