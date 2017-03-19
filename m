From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] net: qmi_wwan: Add USB IDs for MDM6600 modem on Motorola Droid 4
Date: Sun, 19 Mar 2017 09:19:57 -0700
Message-ID: <20170319161957.6625-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
List-Id: linux-omap@vger.kernel.org

This gets qmicli working with the MDM6600 modem.

Cc: Bjørn Mork <bjorn@mork.no>
Reviewed-by: Sebastian Reichel <sre@kernel.org>
Tested-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/net/usb/qmi_wwan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -580,6 +580,10 @@ static const struct usb_device_id products[] = {
 		USB_VENDOR_AND_INTERFACE_INFO(HUAWEI_VENDOR_ID, USB_CLASS_VENDOR_SPEC, 0x01, 0x69),
 		.driver_info        = (unsigned long)&qmi_wwan_info,
 	},
+	{	/* Motorola Mapphone devices with MDM6600 */
+		USB_VENDOR_AND_INTERFACE_INFO(0x22b8, USB_CLASS_VENDOR_SPEC, 0xfb, 0xff),
+		.driver_info        = (unsigned long)&qmi_wwan_info,
+	},
 
 	/* 2. Combined interface devices matching on class+protocol */
 	{	/* Huawei E367 and possibly others in "Windows mode" */
-- 
2.11.1
