From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 12/12] usb: chipidea: move from CONFIG_USB_OTG_FSM to CONFIG_USB_OTG
Date: Wed, 8 Jul 2015 13:23:14 +0300
Message-ID: <559CFA12.5080400@ti.com>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436350777-28056-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, peter.chen@freescale.com
Cc: dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

CONFIG_USB_OTG_FSM no longer exists and the OTG FSM
is available if CONFIG_USB_OTG is defined so move
to using CONFIG_USB_OTG.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/usb/chipidea.txt | 2 +-
 drivers/usb/chipidea/Makefile  | 2 +-
 drivers/usb/chipidea/ci.h      | 2 +-
 drivers/usb/chipidea/otg_fsm.h | 2 +-
 drivers/usb/phy/Kconfig        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/usb/chipidea.txt b/Documentation/usb/chipidea.txt
index 3f848c1..e7f97da 100644
--- a/Documentation/usb/chipidea.txt
+++ b/Documentation/usb/chipidea.txt
@@ -5,7 +5,7 @@ with 2 Freescale i.MX6Q sabre SD boards.
 
 1.1 How to enable OTG FSM in menuconfig
 ---------------------------------------
-Select CONFIG_USB_OTG_FSM, rebuild kernel Image and modules.
+Select CONFIG_USB_OTG, rebuild kernel Image and modules.
 If you want to check some internal variables for otg fsm,
 select CONFIG_USB_CHIPIDEA_DEBUG, there are 2 files which
 can show otg fsm variables and some controller registers value:
diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
index 4decb12..63f2394 100644
--- a/drivers/usb/chipidea/Makefile
+++ b/drivers/usb/chipidea/Makefile
@@ -6,7 +6,7 @@ ci_hdrc-y				:= core.o otg.o
 ci_hdrc-$(CONFIG_USB_CHIPIDEA_UDC)	+= udc.o
 ci_hdrc-$(CONFIG_USB_CHIPIDEA_HOST)	+= host.o
 ci_hdrc-$(CONFIG_USB_CHIPIDEA_DEBUG)	+= debug.o
-ci_hdrc-$(CONFIG_USB_OTG_FSM)		+= otg_fsm.o
+ci_hdrc-$(CONFIG_USB_OTG)		+= otg_fsm.o
 
 # Glue/Bridge layers go here
 
diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index 6d6200e..c04305e 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -405,7 +405,7 @@ static inline u32 hw_test_and_write(struct ci_hdrc *ci, enum ci_hw_regs reg,
  */
 static inline bool ci_otg_is_fsm_mode(struct ci_hdrc *ci)
 {
-#ifdef CONFIG_USB_OTG_FSM
+#ifdef CONFIG_USB_OTG
 	return ci->is_otg && ci->roles[CI_ROLE_HOST] &&
 					ci->roles[CI_ROLE_GADGET];
 #else
diff --git a/drivers/usb/chipidea/otg_fsm.h b/drivers/usb/chipidea/otg_fsm.h
index 2689375..fb66695 100644
--- a/drivers/usb/chipidea/otg_fsm.h
+++ b/drivers/usb/chipidea/otg_fsm.h
@@ -62,7 +62,7 @@
 /* SSEND time before SRP */
 #define TB_SSEND_SRP         (1500)	/* minimum 1.5 sec, section:5.1.2 */
 
-#ifdef CONFIG_USB_OTG_FSM
+#ifdef CONFIG_USB_OTG
 
 int ci_hdrc_otg_fsm_init(struct ci_hdrc *ci);
 int ci_otg_fsm_work(struct ci_hdrc *ci);
diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 869c0cfcad..7e3459f 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -20,7 +20,7 @@ config AB8500_USB
 
 config FSL_USB2_OTG
 	bool "Freescale USB OTG Transceiver Driver"
-	depends on USB_EHCI_FSL && USB_FSL_USB2 && USB_OTG_FSM && PM
+	depends on USB_EHCI_FSL && USB_FSL_USB2 && PM
 	select USB_OTG
 	select USB_PHY
 	help
-- 
2.1.4
