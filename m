From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/5] usb: dwc3: drd: Switch to device property for 'extcon' handling
Date: Sat, 10 Nov 2018 20:11:00 +0200
Message-ID: <20181110181101.24557-4-andriy.shevchenko@linux.intel.com>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Roger Quadros <rogerq@ti.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

Switch to device property for 'extcon' handling.
No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/dwc3/drd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index e7e421521a34..5dc4cddd5b68 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -10,6 +10,7 @@
 #include <linux/extcon.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 #include "debug.h"
 #include "core.h"
@@ -485,8 +486,8 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 	struct device_node *np_phy, *np_conn;
 	struct extcon_dev *edev;
 
-	if (of_property_read_bool(dev->of_node, "extcon"))
-		return extcon_get_edev_by_phandle(dwc->dev, 0);
+	if (device_property_read_bool(dev, "extcon"))
+		return extcon_get_edev_by_phandle(dev, 0);
 
 	np_phy = of_parse_phandle(dev->of_node, "phys", 0);
 	np_conn = of_graph_get_remote_node(np_phy, -1, -1);
-- 
2.19.1
