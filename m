From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/5] usb: dwc3: drd: Add support for DR detection through extcon
Date: Sat, 10 Nov 2018 20:11:01 +0200
Message-ID: <20181110181101.24557-5-andriy.shevchenko@linux.intel.com>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Roger Quadros <rogerq@ti.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

Allow extcon device, found by name, to provide DR status for USB.
This is needed, for example, in case of Intel Merrifield platform,
where the Intel Basin Cove PMIC provides an extcon device to communicate
the detected role.

Note, that the "linux,extcon-name" property name is only for kernel
internal use by X86/ACPI platform code and as such is not documented
in the device tree bindings.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/dwc3/drd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 5dc4cddd5b68..d6b47829fdca 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -485,10 +485,20 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 	struct device *dev = dwc->dev;
 	struct device_node *np_phy, *np_conn;
 	struct extcon_dev *edev;
+	const char *name;
 
 	if (device_property_read_bool(dev, "extcon"))
 		return extcon_get_edev_by_phandle(dev, 0);
 
+	/*
+	 * Device tree platforms should get extcon via phandle.
+	 * On ACPI platforms, we get the name from a device property.
+	 * This device property is for kernel internal use only and
+	 * is expected to be set by the glue code.
+	 */
+	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0)
+		return extcon_get_extcon_dev(name);
+
 	np_phy = of_parse_phandle(dev->of_node, "phys", 0);
 	np_conn = of_graph_get_remote_node(np_phy, -1, -1);
 
-- 
2.19.1
