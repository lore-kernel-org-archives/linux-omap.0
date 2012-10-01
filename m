From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 4/7] usb: dwc3-omap: Remove explicit writes to SYSCONFIG
 register
Date: Mon, 1 Oct 2012 15:55:04 +0530
Message-ID: <1349087107-18229-5-git-send-email-kishon@ti.com>
References: <1349087107-18229-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1349087107-18229-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The runtime API's takes care of setting the SYSCONFIG register with
appropriate values. Hence explicit writes to SYSCONFIG register is
removed.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/dwc3/dwc3-omap.c |   26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 850a0cf..d417bec 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -77,23 +77,6 @@
 
 /* SYSCONFIG REGISTER */
 #define USBOTGSS_SYSCONFIG_DMADISABLE		(1 << 16)
-#define USBOTGSS_SYSCONFIG_STANDBYMODE(x)	((x) << 4)
-
-#define USBOTGSS_STANDBYMODE_FORCE_STANDBY	0
-#define USBOTGSS_STANDBYMODE_NO_STANDBY		1
-#define USBOTGSS_STANDBYMODE_SMART_STANDBY	2
-#define USBOTGSS_STANDBYMODE_SMART_WAKEUP	3
-
-#define USBOTGSS_STANDBYMODE_MASK		(0x03 << 4)
-
-#define USBOTGSS_SYSCONFIG_IDLEMODE(x)		((x) << 2)
-
-#define USBOTGSS_IDLEMODE_FORCE_IDLE		0
-#define USBOTGSS_IDLEMODE_NO_IDLE		1
-#define USBOTGSS_IDLEMODE_SMART_IDLE		2
-#define USBOTGSS_IDLEMODE_SMART_WAKEUP		3
-
-#define USBOTGSS_IDLEMODE_MASK			(0x03 << 2)
 
 /* IRQ_EOI REGISTER */
 #define USBOTGSS_IRQ_EOI_LINE_NUMBER		(1 << 0)
@@ -309,15 +292,6 @@ static int __devinit dwc3_omap_probe(struct platform_device *pdev)
 	reg = dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
 	omap->dma_status = !!(reg & USBOTGSS_SYSCONFIG_DMADISABLE);
 
-	/* Set No-Idle and No-Standby */
-	reg &= ~(USBOTGSS_STANDBYMODE_MASK
-			| USBOTGSS_IDLEMODE_MASK);
-
-	reg |= (USBOTGSS_SYSCONFIG_STANDBYMODE(USBOTGSS_STANDBYMODE_NO_STANDBY)
-		| USBOTGSS_SYSCONFIG_IDLEMODE(USBOTGSS_IDLEMODE_NO_IDLE));
-
-	dwc3_omap_writel(omap->base, USBOTGSS_SYSCONFIG, reg);
-
 	ret = devm_request_irq(dev, omap->irq, dwc3_omap_interrupt, 0,
 			"dwc3-omap", omap);
 	if (ret) {
-- 
1.7.9.5
