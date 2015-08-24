From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 04/13] otg-fsm: move usb_bus_start_enum into otg-fsm->ops
Date: Mon, 24 Aug 2015 16:21:15 +0300
Message-ID: <1440422484-4737-5-git-send-email-rogerq@ti.com>
References: <1440422484-4737-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440422484-4737-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, peter.chen@freescale.com
Cc: dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

This is to prevent missing symbol build error if OTG is
enabled (built-in) and HCD core (CONFIG_USB) is module.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/common/usb-otg-fsm.c | 6 ++++--
 drivers/usb/phy/phy-fsl-usb.c    | 2 ++
 include/linux/usb/otg-fsm.h      | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
index a46f29a..6e56c8c 100644
--- a/drivers/usb/common/usb-otg-fsm.c
+++ b/drivers/usb/common/usb-otg-fsm.c
@@ -165,8 +165,10 @@ static int otg_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
 		otg_loc_conn(fsm, 0);
 		otg_loc_sof(fsm, 1);
 		otg_set_protocol(fsm, PROTO_HOST);
-		usb_bus_start_enum(fsm->otg->host,
-				fsm->otg->host->otg_port);
+		if (fsm->ops->start_enum) {
+			fsm->ops->start_enum(fsm->otg->host,
+					     fsm->otg->host->otg_port);
+		}
 		break;
 	case OTG_STATE_A_IDLE:
 		otg_drv_vbus(fsm, 0);
diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
index ee3f2c2..19541ed 100644
--- a/drivers/usb/phy/phy-fsl-usb.c
+++ b/drivers/usb/phy/phy-fsl-usb.c
@@ -783,6 +783,8 @@ static struct otg_fsm_ops fsl_otg_ops = {
 
 	.start_host = fsl_otg_start_host,
 	.start_gadget = fsl_otg_start_gadget,
+
+	.start_enum = usb_bus_start_enum,
 };
 
 /* Initialize the global variable fsl_otg_dev and request IRQ for OTG */
diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
index 672551c..75e82cc 100644
--- a/include/linux/usb/otg-fsm.h
+++ b/include/linux/usb/otg-fsm.h
@@ -199,6 +199,7 @@ struct otg_fsm_ops {
 	void	(*del_timer)(struct otg_fsm *fsm, enum otg_fsm_timer timer);
 	int	(*start_host)(struct otg_fsm *fsm, int on);
 	int	(*start_gadget)(struct otg_fsm *fsm, int on);
+	int	(*start_enum)(struct usb_bus *bus, unsigned port_num);
 };
 
 
-- 
2.1.4
