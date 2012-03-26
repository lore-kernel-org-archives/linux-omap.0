From: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH] ARM: OMAP: fix section mismatches in usb-host.c
Date: Mon, 26 Mar 2012 16:51:10 +0200
Message-ID: <1332773470-22800-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Fix the below section mismatch warning and alike:

WARNING: vmlinux.o(.text+0x281d4): Section mismatch in reference from
the function setup_ehci_io_mux() to the function
.init.text:omap_mux_init_signal()
The function setup_ehci_io_mux() references
the function __init omap_mux_init_signal().
This is often because setup_ehci_io_mux lacks a __init
annotation or the annotation of omap_mux_init_signal is wrong.

Signed-off-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---
 arch/arm/mach-omap2/usb-host.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index f51348d..dde8a11 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -54,7 +54,7 @@ static struct omap_device_pm_latency omap_uhhtll_latency[] = {
 /*
  * setup_ehci_io_mux - initialize IO pad mux for USBHOST
  */
-static void setup_ehci_io_mux(const enum usbhs_omap_port_mode *port_mode)
+static void __init setup_ehci_io_mux(const enum usbhs_omap_port_mode *port_mode)
 {
 	switch (port_mode[0]) {
 	case OMAP_EHCI_PORT_MODE_PHY:
@@ -197,7 +197,8 @@ static void setup_ehci_io_mux(const enum usbhs_omap_port_mode *port_mode)
 	return;
 }
 
-static void setup_4430ehci_io_mux(const enum usbhs_omap_port_mode *port_mode)
+static
+void __init setup_4430ehci_io_mux(const enum usbhs_omap_port_mode *port_mode)
 {
 	switch (port_mode[0]) {
 	case OMAP_EHCI_PORT_MODE_PHY:
@@ -315,7 +316,7 @@ static void setup_4430ehci_io_mux(const enum usbhs_omap_port_mode *port_mode)
 	}
 }
 
-static void setup_ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
+static void __init setup_ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
 {
 	switch (port_mode[0]) {
 	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
@@ -412,7 +413,8 @@ static void setup_ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
 	}
 }
 
-static void setup_4430ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
+static
+void __init setup_4430ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
 {
 	switch (port_mode[0]) {
 	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
-- 
1.7.3.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
