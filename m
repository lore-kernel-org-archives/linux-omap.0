From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 09/13] usb: chipidea: move from CONFIG_USB_OTG_FSM to CONFIG_USB_OTG
Date: Mon, 24 Aug 2015 16:21:20 +0300
Message-ID: <1440422484-4737-10-git-send-email-rogerq@ti.com>
References: <1440422484-4737-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1440422484-4737-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Cc: dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

CONFIG_USB_OTG_FSM no longer exists and the OTG FSM
is available if CONFIG_USB_OTG is defined so move
to using CONFIG_USB_OTG.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
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
index 41d7cf6..438818c 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -407,7 +407,7 @@ static inline u32 hw_test_and_write(struct ci_hdrc *ci, enum ci_hw_regs reg,
  */
 static inline bool ci_otg_is_fsm_mode(struct ci_hdrc *ci)
 {
-#ifdef CONFIG_USB_OTG_FSM
+#ifdef CONFIG_USB_OTG
 	struct usb_otg_caps *otg_caps = &ci->platdata->ci_otg_caps;
 
 	return ci->is_otg && ci->roles[CI_ROLE_HOST] &&
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
index 7d3beee..664cacb 100644
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
