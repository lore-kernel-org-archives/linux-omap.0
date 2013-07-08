From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 1/4] arm: omap: Add phy binding info for musb in plat data
Date: Mon, 8 Jul 2013 16:44:14 +0530
Message-ID: <1373282057-20181-2-git-send-email-kishon@ti.com>
References: <1373282057-20181-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1373282057-20181-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: kishon@ti.com, tony@atomide.com, balbi@ti.com
Cc: linux@arm.linux.org.uk, eballetbo@gmail.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, javier@dowhile0.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

In order for controllers to get PHY in case of non dt boot, the phy
binding information (phy label) should be added in the platform
data of the controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
Tested-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/usb-musb.c |    3 +++
 include/linux/usb/musb.h       |    3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 8c4de27..20b42de 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -85,6 +85,9 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
 	musb_plat.mode = board_data->mode;
 	musb_plat.extvbus = board_data->extvbus;
 
+	if (cpu_is_omap34xx())
+		musb_plat.phy_name = "twl4030";
+
 	if (soc_is_am35xx()) {
 		oh_name = "am35x_otg_hs";
 		name = "musb-am35x";
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index 053c268..c05d46d 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -104,6 +104,9 @@ struct musb_hdrc_platform_data {
 	/* for clk_get() */
 	const char	*clock;
 
+	/* phy device label */
+	const char	*phy_name;
+
 	/* (HOST or OTG) switch VBUS on/off */
 	int		(*set_vbus)(struct device *dev, int is_on);
 
-- 
1.7.10.4
