From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH usb-next v10 8/8] usb: core: hcd: remove support for
 initializing a single PHY
Date: Sun, 18 Feb 2018 19:45:04 +0100
Message-ID: <20180218184504.3331-9-martin.blumenstingl@googlemail.com>
References: <20180218184504.3331-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180218184504.3331-1-martin.blumenstingl@googlemail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-usb@vger.kernel.org, mathias.nyman@intel.com, arnd@arndb.de, gregkh@linuxfoundation.org, felipe.balbi@linux.intel.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Peter.Chen@nxp.com, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, narmstrong@baylibre.com, yixun.lan@amlogic.com, robh+dt@kernel.org, jonathanh@nvidia.com, linux@prisktech.co.nz, matthias.bgg@gmail.com, thierry.reding@gmail.com, linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-tegra@vger.kernel.org, stern@rowland.harvard.edu, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

With the new PHY wrapper in place we can now handle multiple PHYs.
Remove the code which handles only one generic PHY as this is now
covered (with support for multiple PHYs as well as suspend/resume
support) by the new PHY wrapper.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/usb/core/hcd.c  | 37 -------------------------------------
 include/linux/usb/hcd.h |  1 -
 2 files changed, 38 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 32797c25ac3b..5a92d8f7c484 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2757,30 +2757,6 @@ int usb_add_hcd(struct usb_hcd *hcd,
 		}
 	}
 
-	if (IS_ENABLED(CONFIG_GENERIC_PHY) && !hcd->skip_phy_initialization) {
-		struct phy *phy = phy_get(hcd->self.sysdev, "usb");
-
-		if (IS_ERR(phy)) {
-			retval = PTR_ERR(phy);
-			if (retval == -EPROBE_DEFER)
-				goto err_phy;
-		} else {
-			retval = phy_init(phy);
-			if (retval) {
-				phy_put(phy);
-				goto err_phy;
-			}
-			retval = phy_power_on(phy);
-			if (retval) {
-				phy_exit(phy);
-				phy_put(phy);
-				goto err_phy;
-			}
-			hcd->phy = phy;
-			hcd->remove_phy = 1;
-		}
-	}
-
 	if (!hcd->skip_phy_initialization) {
 		hcd->phy_roothub = usb_phy_roothub_init(hcd->self.sysdev);
 		if (IS_ERR(hcd->phy_roothub)) {
@@ -2961,13 +2937,6 @@ int usb_add_hcd(struct usb_hcd *hcd,
 err_usb_phy_roothub_power_on:
 	usb_phy_roothub_exit(hcd->phy_roothub);
 err_phy_roothub_init:
-	if (IS_ENABLED(CONFIG_GENERIC_PHY) && hcd->remove_phy && hcd->phy) {
-		phy_power_off(hcd->phy);
-		phy_exit(hcd->phy);
-		phy_put(hcd->phy);
-		hcd->phy = NULL;
-	}
-err_phy:
 	if (hcd->remove_phy && hcd->usb_phy) {
 		usb_phy_shutdown(hcd->usb_phy);
 		usb_put_phy(hcd->usb_phy);
@@ -3048,12 +3017,6 @@ void usb_remove_hcd(struct usb_hcd *hcd)
 	usb_phy_roothub_power_off(hcd->phy_roothub);
 	usb_phy_roothub_exit(hcd->phy_roothub);
 
-	if (IS_ENABLED(CONFIG_GENERIC_PHY) && hcd->remove_phy && hcd->phy) {
-		phy_power_off(hcd->phy);
-		phy_exit(hcd->phy);
-		phy_put(hcd->phy);
-		hcd->phy = NULL;
-	}
 	if (hcd->remove_phy && hcd->usb_phy) {
 		usb_phy_shutdown(hcd->usb_phy);
 		usb_put_phy(hcd->usb_phy);
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index a042675e03ba..aef50cb2ed1b 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -103,7 +103,6 @@ struct usb_hcd {
 	 * other external phys should be software-transparent
 	 */
 	struct usb_phy		*usb_phy;
-	struct phy		*phy;
 	struct usb_phy_roothub	*phy_roothub;
 
 	/* Flags that need to be manipulated atomically because they can
-- 
2.16.1
