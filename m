From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH 07/13] extcon: extcon-class: improve
 get_cable_state_()/set_cable_state_() functions
Date: Thu, 10 Apr 2014 15:16:45 +0200
Message-ID: <1397135811-12866-8-git-send-email-r.baldyga@samsung.com>
References: <1397135811-12866-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1397135811-12866-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, myungjoo.ham@samsung.com, cw00.choi@samsung.com, dbaryshkov@gmail.com, dwmw2@infradead.org, balbi@ti.com, gregkh@linuxfoundation.org, grant.likely@linaro.org, ldewangan@nvidia.com, kishon@ti.com, gg@slimlogic.co.uk, anton@enomsg.org, jonghwa3.lee@samsung.com, rongjun.ying@csr.com, linux@roeck-us.net, aaro.koskinen@iki.fi, tony@atomide.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-omap@vger.kernel.org

Added check if pointer to edev is not NULL, and updated documentation of index
parameter. Function extcon_find_cable_index() has been deleted and cannot be
used to retrieve cable number.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/extcon/extcon-class.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon-class.c b/drivers/extcon/extcon-class.c
index 2be0ac9..2659805 100644
--- a/drivers/extcon/extcon-class.c
+++ b/drivers/extcon/extcon-class.c
@@ -285,10 +285,12 @@ EXPORT_SYMBOL_GPL(extcon_set_state);
 /**
  * extcon_get_cable_state_() - Get the status of a specific cable.
  * @edev:	the extcon device that has the cable.
- * @index:	cable index that can be retrieved by extcon_find_cable_index().
+ * @index:	cable index in extcon device.
  */
 int extcon_get_cable_state_(struct extcon_dev *edev, int index)
 {
+	if (!edev)
+		return -ENODEV;
 	if (index < 0 || (edev->max_supported && edev->max_supported <= index))
 		return -EINVAL;
 
@@ -312,8 +314,7 @@ EXPORT_SYMBOL_GPL(extcon_get_cable_state);
 /**
  * extcon_set_cable_state_() - Set the status of a specific cable.
  * @edev:		the extcon device that has the cable.
- * @index:		cable index that can be retrieved by
- *			extcon_find_cable_index().
+ * @index:		cable index in extcon device.
  * @cable_state:	the new cable status. The default semantics is
  *			true: attached / false: detached.
  */
@@ -322,6 +323,8 @@ int extcon_set_cable_state_(struct extcon_dev *edev,
 {
 	u32 state;
 
+	if (!edev)
+		return -ENODEV;
 	if (index < 0 || (edev->max_supported && edev->max_supported <= index))
 		return -EINVAL;
 
-- 
1.7.9.5
