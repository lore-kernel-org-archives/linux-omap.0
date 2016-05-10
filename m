From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v7 4/5] usb: dwc3: omap: Pass VBUS and ID events transparently
Date: Tue, 10 May 2016 12:51:58 +0300
Message-ID: <1462873919-20532-5-git-send-email-rogerq@ti.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462873919-20532-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Don't make any decisions regarding VBUS session based on ID
status. That is best left to the OTG core.

Pass ID and VBUS events independent of each other so that OTG
core knows exactly what to do.

This makes dual-role with extcon work with OTG irq on OMAP platforms.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/dwc3-omap.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 1f7259d..c40d301 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -231,18 +231,14 @@ static void dwc3_omap_set_mailbox(struct dwc3_omap *omap,
 		}
 
 		val = dwc3_omap_read_utmi_ctrl(omap);
-		val &= ~(USBOTGSS_UTMI_OTG_CTRL_IDDIG
-				| USBOTGSS_UTMI_OTG_CTRL_VBUSVALID
-				| USBOTGSS_UTMI_OTG_CTRL_SESSEND);
-		val |= USBOTGSS_UTMI_OTG_CTRL_SESSVALID;
+		val &= ~USBOTGSS_UTMI_OTG_CTRL_IDDIG;
 		dwc3_omap_write_utmi_ctrl(omap, val);
 		break;
 
 	case OMAP_DWC3_VBUS_VALID:
 		val = dwc3_omap_read_utmi_ctrl(omap);
 		val &= ~USBOTGSS_UTMI_OTG_CTRL_SESSEND;
-		val |= USBOTGSS_UTMI_OTG_CTRL_IDDIG
-				| USBOTGSS_UTMI_OTG_CTRL_VBUSVALID
+		val |= USBOTGSS_UTMI_OTG_CTRL_VBUSVALID
 				| USBOTGSS_UTMI_OTG_CTRL_SESSVALID;
 		dwc3_omap_write_utmi_ctrl(omap, val);
 		break;
@@ -250,13 +246,15 @@ static void dwc3_omap_set_mailbox(struct dwc3_omap *omap,
 	case OMAP_DWC3_ID_FLOAT:
 		if (omap->vbus_reg)
 			regulator_disable(omap->vbus_reg);
+		val = dwc3_omap_read_utmi_ctrl(omap);
+		val |= USBOTGSS_UTMI_OTG_CTRL_IDDIG;
+		dwc3_omap_write_utmi_ctrl(omap, val);
 
 	case OMAP_DWC3_VBUS_OFF:
 		val = dwc3_omap_read_utmi_ctrl(omap);
 		val &= ~(USBOTGSS_UTMI_OTG_CTRL_SESSVALID
 				| USBOTGSS_UTMI_OTG_CTRL_VBUSVALID);
-		val |= USBOTGSS_UTMI_OTG_CTRL_SESSEND
-				| USBOTGSS_UTMI_OTG_CTRL_IDDIG;
+		val |= USBOTGSS_UTMI_OTG_CTRL_SESSEND;
 		dwc3_omap_write_utmi_ctrl(omap, val);
 		break;
 
-- 
2.7.4
