From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v7 3/5] usb: dwc3: omap: Don't set POWERPRESENT
Date: Tue, 10 May 2016 12:51:57 +0300
Message-ID: <1462873919-20532-4-git-send-email-rogerq@ti.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462873919-20532-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

TRM [1] recommends that POWERPRESENT bit must not be
set and left at it's default value of 0.

[1] OMAP542x TRM - http://www.ti.com/lit/pdf/swpu249
Section 23.11.4.5.1 Mailbox VBUS/ID Management

"Because PIPE powerpresent has a different meaning in host and in device mode,
and because of the redundancy with the UTMI signals, the controller ORes
together the appropriate PIPE and UTMI inputs to create its internal
VBUS status. For that reason, it is recommended to leave field
USBOTGSS_UTMI_OTG_STATUS[9] POWERPRESENT at its default value (=0), and only to
fill in the USB2 VBUS status fields in the same register."

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/dwc3-omap.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index a30944d..1f7259d 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -234,8 +234,7 @@ static void dwc3_omap_set_mailbox(struct dwc3_omap *omap,
 		val &= ~(USBOTGSS_UTMI_OTG_CTRL_IDDIG
 				| USBOTGSS_UTMI_OTG_CTRL_VBUSVALID
 				| USBOTGSS_UTMI_OTG_CTRL_SESSEND);
-		val |= USBOTGSS_UTMI_OTG_CTRL_SESSVALID
-				| USBOTGSS_UTMI_OTG_CTRL_POWERPRESENT;
+		val |= USBOTGSS_UTMI_OTG_CTRL_SESSVALID;
 		dwc3_omap_write_utmi_ctrl(omap, val);
 		break;
 
@@ -244,8 +243,7 @@ static void dwc3_omap_set_mailbox(struct dwc3_omap *omap,
 		val &= ~USBOTGSS_UTMI_OTG_CTRL_SESSEND;
 		val |= USBOTGSS_UTMI_OTG_CTRL_IDDIG
 				| USBOTGSS_UTMI_OTG_CTRL_VBUSVALID
-				| USBOTGSS_UTMI_OTG_CTRL_SESSVALID
-				| USBOTGSS_UTMI_OTG_CTRL_POWERPRESENT;
+				| USBOTGSS_UTMI_OTG_CTRL_SESSVALID;
 		dwc3_omap_write_utmi_ctrl(omap, val);
 		break;
 
@@ -256,8 +254,7 @@ static void dwc3_omap_set_mailbox(struct dwc3_omap *omap,
 	case OMAP_DWC3_VBUS_OFF:
 		val = dwc3_omap_read_utmi_ctrl(omap);
 		val &= ~(USBOTGSS_UTMI_OTG_CTRL_SESSVALID
-				| USBOTGSS_UTMI_OTG_CTRL_VBUSVALID
-				| USBOTGSS_UTMI_OTG_CTRL_POWERPRESENT);
+				| USBOTGSS_UTMI_OTG_CTRL_VBUSVALID);
 		val |= USBOTGSS_UTMI_OTG_CTRL_SESSEND
 				| USBOTGSS_UTMI_OTG_CTRL_IDDIG;
 		dwc3_omap_write_utmi_ctrl(omap, val);
-- 
2.7.4
