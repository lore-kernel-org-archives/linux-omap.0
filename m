From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [usb-next PATCH v11 8/8] usb: core: hcd: remove support for
 initializing a single PHY
Date: Sat,  3 Mar 2018 22:43:09 +0100
Message-ID: <20180303214309.25643-9-martin.blumenstingl@googlemail.com>
References: <20180303214309.25643-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20180303214309.25643-1-martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter.Chen-3arQi8VN3Tc@public.gmane.org, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

With the new PHY wrapper in place we can now handle multiple PHYs.
Remove the code which handles only one generic PHY as this is now
covered (with support for multiple PHYs as well as suspend/resume
support) by the new PHY wrapper.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
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
2.16.2
