From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 3/4] power: isp1704_charger: Add callback function set_current
Date: Sun,  8 Sep 2013 10:50:38 +0200
Message-ID: <1378630239-10006-4-git-send-email-pali.rohar@gmail.com>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Anton Vorontsov <anton@enomsg.org>
Cc: Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

This patch add callback function set_current to platform data.
Driver will call this function when isp1704 change current
and board provided this callback funtion in platform data.

This patch is needed for Nokia RX-51 to tell bq2415x charging
chip about connected wallcharger events.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/power/isp1704_charger.c       |   16 ++++++++++++++++
 include/linux/power/isp1704_charger.h |    1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/power/isp1704_charger.c b/drivers/power/isp1704_ch=
arger.c
index f726cb6..4f20a1a 100644
--- a/drivers/power/isp1704_charger.c
+++ b/drivers/power/isp1704_charger.c
@@ -91,6 +91,18 @@ static void isp1704_charger_set_power(struct isp1704=
_charger *isp, bool on)
 }
=20
 /*
+ * Set charger current from isp1704 if a function for it
+ * has been provided with platform data.
+ */
+static void isp1704_charger_set_current(struct isp1704_charger *isp, i=
nt mA)
+{
+	struct isp1704_charger_data *board =3D isp->dev->platform_data;
+
+	if (board && board->set_current)
+		board->set_current(mA);
+}
+
+/*
  * Determine is the charging port DCP (dedicated charger) or CDP (Host=
/HUB
  * chargers).
  *
@@ -257,6 +269,7 @@ static void isp1704_charger_work(struct work_struct=
 *data)
 			if (isp1704_charger_detect_dcp(isp)) {
 				isp->psy.type =3D POWER_SUPPLY_TYPE_USB_DCP;
 				isp->current_max =3D 1800;
+				isp1704_charger_set_current(isp, 1800);
 			} else {
 				isp->psy.type =3D POWER_SUPPLY_TYPE_USB;
 				isp->current_max =3D 500;
@@ -277,6 +290,8 @@ static void isp1704_charger_work(struct work_struct=
 *data)
=20
 			if (isp->current_max > 100)
 				isp->psy.type =3D POWER_SUPPLY_TYPE_USB_CDP;
+
+			isp1704_charger_set_current(isp, isp->current_max);
 		}
 		break;
 	case USB_EVENT_NONE:
@@ -297,6 +312,7 @@ static void isp1704_charger_work(struct work_struct=
 *data)
 			usb_gadget_disconnect(isp->phy->otg->gadget);
=20
 		isp1704_charger_set_power(isp, 0);
+		isp1704_charger_set_current(isp, 0);
 		break;
 	default:
 		goto out;
diff --git a/include/linux/power/isp1704_charger.h b/include/linux/powe=
r/isp1704_charger.h
index 68096a6..d154b02 100644
--- a/include/linux/power/isp1704_charger.h
+++ b/include/linux/power/isp1704_charger.h
@@ -24,6 +24,7 @@
=20
 struct isp1704_charger_data {
 	void		(*set_power)(bool on);
+	void		(*set_current)(int mA);
 };
=20
 #endif
--=20
1.7.10.4
