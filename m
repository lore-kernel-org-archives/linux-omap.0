From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/4] usb: phy: omap-usb3: Decrease the number of transitions
 to recovery
Date: Wed, 19 Sep 2012 17:00:28 +0530
Message-ID: <1348054229-27362-4-git-send-email-kishon@ti.com>
References: <1348054229-27362-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1348054229-27362-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
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
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Power-cycling the PHY (partially) decreases the number of transitions to
"Recovery" state. Hence changed the power up sequence to a partial
power-up before a full power-up of the PHY.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Signed-off-by: Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/phy/omap-usb3.c  |   43 ++++++++++++++++++++++++++++++++++++------
 include/linux/usb/omap_usb.h |    1 +
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/phy/omap-usb3.c b/drivers/usb/phy/omap-usb3.c
index 26402d5..fb3c5e6 100644
--- a/drivers/usb/phy/omap-usb3.c
+++ b/drivers/usb/phy/omap-usb3.c
@@ -35,13 +35,15 @@ static struct usb_dpll_params omap_usb3_dpll_params[NUM_SYS_CLKS] = {
 };
 
 /**
- * omap5_usb_phy_power - power on/off the serializer using control module
+ * omap5_usb_phy_partial_powerup - power on the serializer using control module
  * @phy: struct omap_usb *
- * @on: 0 to off and 1 to on based on powering on or off the PHY
  *
- * omap_usb3 can call this API to power on or off the PHY.
+ * After the dwc3 module is disabled and enabled again the synchronization
+ * between dwc3 and phy goes bad and the device does not get enumerated
+ * in superspeed mode. After some trials it was found powering up TX and
+ * part of RX PHY helped to solve the issue.
  */
-static int omap5_usb_phy_power(struct omap_usb *phy, bool on)
+static int omap5_usb_phy_partial_powerup(struct omap_usb *phy)
 {
 	u32 val;
 	unsigned long rate;
@@ -58,10 +60,32 @@ static int omap5_usb_phy_power(struct omap_usb *phy, bool on)
 
 	val = readl(phy->control_dev);
 
+	val &= ~(USB_PWRCTL_CLK_CMD_MASK | USB_PWRCTL_CLK_FREQ_MASK);
+	val |= (USB3_PHY_PARTIAL_RX_POWERON | USB3_PHY_TX_RX_POWERON)
+		<< USB_PWRCTL_CLK_CMD_SHIFT;
+	val |= rate << USB_PWRCTL_CLK_FREQ_SHIFT;
+
+	writel(val, phy->control_dev);
+
+	return 0;
+}
+
+/**
+ * omap5_usb_phy_power - power on/off the serializer using control module
+ * @phy: struct omap_usb *
+ * @on: 0 to off and 1 to on based on powering on or off the PHY
+ *
+ * omap_usb3 can call this API to power on or off the PHY.
+ */
+static int omap5_usb_phy_power(struct omap_usb *phy, bool on)
+{
+	u32 val;
+
+	val = readl(phy->control_dev);
+
 	if (on) {
-		val &= ~(USB_PWRCTL_CLK_CMD_MASK | USB_PWRCTL_CLK_FREQ_MASK);
+		val &= ~USB_PWRCTL_CLK_CMD_MASK;
 		val |= USB3_PHY_TX_RX_POWERON << USB_PWRCTL_CLK_CMD_SHIFT;
-		val |= rate << USB_PWRCTL_CLK_FREQ_SHIFT;
 	} else {
 		val &= ~USB_PWRCTL_CLK_CMD_MASK;
 		val |= USB3_PHY_TX_RX_POWEROFF << USB_PWRCTL_CLK_CMD_SHIFT;
@@ -207,6 +231,13 @@ static int omap_usb3_init(struct usb_phy *x)
 	struct omap_usb	*phy = phy_to_omapusb(x);
 
 	omap_usb_dpll_lock(phy);
+	omap5_usb_phy_partial_powerup(phy);
+	/*
+	 * Give enough time for the PHY to partially power-up before
+	 * powering it up completely. delay value suggested by the HW
+	 * team.
+	 */
+	mdelay(100);
 	omap5_usb_phy_power(phy, 1);
 
 	return 0;
diff --git a/include/linux/usb/omap_usb.h b/include/linux/usb/omap_usb.h
index 01ed008..62b637c 100644
--- a/include/linux/usb/omap_usb.h
+++ b/include/linux/usb/omap_usb.h
@@ -92,6 +92,7 @@ struct omap_usb {
 
 #define	USB3_PHY_TX_RX_POWERON		0x3
 #define	USB3_PHY_TX_RX_POWEROFF		0x0
+#define	USB3_PHY_PARTIAL_RX_POWERON	(0x1 << 6)
 
 #define	phy_to_omapusb(x)	container_of((x), struct omap_usb, phy)
 
-- 
1.7.9.5
