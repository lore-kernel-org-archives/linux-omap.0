From: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/2] OMAP4430: USB Host: Implement workaround for Errata i687
Date: Fri, 29 Jun 2012 12:11:05 +0300
Message-ID: <1340961065-26938-2-git-send-email-ruslan.bilovol@ti.com>
References: <1340961065-26938-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340961065-26938-1-git-send-email-ruslan.bilovol-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The OMAP4 EHCI controller has the following defect (errata ID i687):

Title:
	USB TLL Hold Timing Violation

Description:
	There is a timing hold violation on an internal logic on
	the clock USB TLL path resulting in a systematic connection
	failure on the TLL link

WORKAROUND:
	As part of workaround, next should be done:
	Set the I/O drive strength to 1.
	Depending which USB host subsystem is used,
	=E2=80=A2 Port B1 used: Set CONTROL.CONTROL_SMART2IO_PADCONF_2[11] USB=
B1_DR0_DS =3D 0x1
	=E2=80=A2 Port B2 used: Set CONTROL.CONTROL_SMART2IO_PADCONF_2[12] USB=
B2_DR0_DS =3D 0x1

All OMAP4430 devices are impacted.

Signed-off-by: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/usb-host.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-h=
ost.c
index dde8a11..3a6f2a2 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -30,6 +30,7 @@
 #include <plat/usb.h>
 #include <plat/omap_device.h>
=20
+#include "control.h"
 #include "mux.h"
=20
 #ifdef CONFIG_MFD_OMAP_USB_HOST
@@ -252,6 +253,14 @@ void __init setup_4430ehci_io_mux(const enum usbhs=
_omap_port_mode *port_mode)
 			OMAP_PIN_INPUT_PULLDOWN);
 		omap_mux_init_signal("usbb1_ulpitll_dat7",
 			OMAP_PIN_INPUT_PULLDOWN);
+
+		/* Errata i687: set I/O drive strength to 1 */
+		if (cpu_is_omap443x()) {
+			u32 val;
+			val =3D omap4_ctrl_pad_readl(OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_SMA=
RT2IO_PADCONF_2);
+			val |=3D OMAP4_USBB1_DR0_DS_MASK;
+			omap4_ctrl_pad_writel(val, OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_SMART=
2IO_PADCONF_2);
+		}
 			break;
 	case OMAP_USBHS_PORT_MODE_UNUSED:
 	default:
@@ -309,6 +318,14 @@ void __init setup_4430ehci_io_mux(const enum usbhs=
_omap_port_mode *port_mode)
 			OMAP_PIN_INPUT_PULLDOWN);
 		omap_mux_init_signal("usbb2_ulpitll_dat7",
 			OMAP_PIN_INPUT_PULLDOWN);
+
+		/* Errata i687: set I/O drive strength to 1 */
+		if (cpu_is_omap443x()) {
+			u32 val;
+			val =3D omap4_ctrl_pad_readl(OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_SMA=
RT2IO_PADCONF_2);
+			val |=3D OMAP4_USBB2_DR0_DS_MASK;
+			omap4_ctrl_pad_writel(val, OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_SMART=
2IO_PADCONF_2);
+		}
 			break;
 	case OMAP_USBHS_PORT_MODE_UNUSED:
 	default:
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
