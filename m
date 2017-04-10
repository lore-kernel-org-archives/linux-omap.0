From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [balbi-usb:testing/next 46/49] undefined reference to `extcon_get_edev_by_phandle'
Date: Mon, 10 Apr 2017 11:02:10 +0300
Message-ID: <87zifoelml.fsf@linux.intel.com>
References: <201704090005.8IRIdzVM%fengguang.wu@intel.com> <f086a697-1065-50e1-799a-3a7b407ac0cf@infradead.org> <4d902467-2939-797c-0350-ee99aee07d49@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4d902467-2939-797c-0350-ee99aee07d49-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git t=
esting/next
>>> head:   9653f750a746d5abc4bc054d818eb32d1351eae9
>>> commit: d5a80bad699c94703a0306edd250f65cfd050580 [46/49] usb: dwc3: Add=
 dual-role support
>>> config: x86_64-randconfig-h0-04081918 (attached as .config)
>>> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
>>> reproduce:
>>>         git checkout d5a80bad699c94703a0306edd250f65cfd050580
>>>         # save the attached .config to linux build tree
>>>         make ARCH=3Dx86_64=20
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    drivers/built-in.o: In function `dwc3_drd_init':
>>>>> (.text+0x2aff13): undefined reference to `extcon_get_edev_by_phandle'
>>>    drivers/built-in.o: In function `dwc3_drd_init':
>>>>> (.text+0x2affb1): undefined reference to `extcon_register_notifier'
>>>    drivers/built-in.o: In function `dwc3_drd_init':
>>>>> (.text+0x2b0029): undefined reference to `extcon_get_state'
>>>    drivers/built-in.o: In function `dwc3_drd_exit':
>>>>> (.text+0x2b00e1): undefined reference to `extcon_unregister_notifier'
>>=20
>> EXTCON=3Dm in this config.
>>=20
>> DWC3_DUAL_ROLE needs to depend on EXTCON...
>>=20
>>=20
> Thanks for the analysis Randy.
>
> Felipe, let me know if you want me to resend the patch or you'll fix it l=
ocally.
> Thanks. :)

8<--------------------------------- cut here ------------------------------=
-----------

From=2028ea6be01e2cf244c461a40c8e9593816f894412 Mon Sep 17 00:00:00 2001
From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Date: Wed, 5 Apr 2017 13:39:31 +0300
Subject: [PATCH v2] usb: dwc3: Add dual-role support

If dr_mode is "otg" then support dual role mode of operation.
Currently this mode is only supported when an extcon handle is
present in the dwc3 device tree node. This is needed to
get the ID status events of the port.

We're using a workqueue to manage the dual-role state transitions
as the extcon notifier (dwc3_drd_notifier) is called in an atomic
context by extcon_sync() and this doesn't go well with
usb_del_gadget_udc() causing a lockdep and softirq warning.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Signed-off-by: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
=2D--

Add EXTCON dependency

 drivers/usb/dwc3/Kconfig  |  1 +
 drivers/usb/dwc3/Makefile |  4 +++
 drivers/usb/dwc3/core.c   | 11 +++---
 drivers/usb/dwc3/core.h   | 14 ++++++++
 drivers/usb/dwc3/drd.c    | 85 +++++++++++++++++++++++++++++++++++++++++++=
++++
 5 files changed, 111 insertions(+), 4 deletions(-)
 create mode 100644 drivers/usb/dwc3/drd.c

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index c5aa235863e8..aee55114d269 100644
=2D-- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -41,6 +41,7 @@ config USB_DWC3_GADGET
 config USB_DWC3_DUAL_ROLE
 	bool "Dual Role mode"
 	depends on ((USB=3Dy || USB=3DUSB_DWC3) && (USB_GADGET=3Dy || USB_GADGET=
=3DUSB_DWC3))
+	depends on (EXTCON=3Dy || EXTCON=3DUSB_DWC3)
 	help
 	  This is the default mode of working of DWC3 controller where
 	  both host and gadget features are enabled.
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index ffca34029b21..f15fabbd1e59 100644
=2D-- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -17,6 +17,10 @@ ifneq ($(filter y,$(CONFIG_USB_DWC3_GADGET) $(CONFIG_USB=
_DWC3_DUAL_ROLE)),)
 	dwc3-y				+=3D gadget.o ep0.o
 endif
=20
+ifneq ($(CONFIG_USB_DWC3_DUAL_ROLE),)
+	dwc3-y				+=3D drd.o
+endif
+
 ifneq ($(CONFIG_USB_DWC3_ULPI),)
 	dwc3-y				+=3D ulpi.o
 endif
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 458e7c6cc002..455d89a1cd6d 100644
=2D-- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -921,7 +921,12 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		break;
 	case USB_DR_MODE_OTG:
 		INIT_WORK(&dwc->drd_work, __dwc3_set_mode);
=2D		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+		ret =3D dwc3_drd_init(dwc);
+		if (ret) {
+			if (ret !=3D -EPROBE_DEFER)
+				dev_err(dev, "failed to initialize dual-role\n");
+			return ret;
+		}
 		break;
 	default:
 		dev_err(dev, "Unsupported mode of operation %d\n", dwc->dr_mode);
@@ -941,9 +946,7 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 		dwc3_host_exit(dwc);
 		break;
 	case USB_DR_MODE_OTG:
=2D		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
=2D		dwc3_gadget_exit(dwc);
=2D		flush_work(&dwc->drd_work);
+		dwc3_drd_exit(dwc);
 		break;
 	default:
 		/* do nothing */
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1fe23e36485f..981c77f5628e 100644
=2D-- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -785,6 +785,8 @@ struct dwc3_scratchpad_array {
  * @dr_mode: requested mode of operation
  * @current_dr_role: current role of operation when in dual-role mode
  * @desired_dr_role: desired role of operation when in dual-role mode
+ * @edev: extcon handle
+ * @edev_nb: extcon notifier
  * @hsphy_mode: UTMI phy mode, one of following:
  *		- USBPHY_INTERFACE_MODE_UTMI
  *		- USBPHY_INTERFACE_MODE_UTMIW
@@ -898,6 +900,8 @@ struct dwc3 {
 	enum usb_dr_mode	dr_mode;
 	u32			current_dr_role;
 	u32			desired_dr_role;
+	struct extcon_dev	*edev;
+	struct notifier_block	edev_nb;
 	enum usb_phy_interface	hsphy_mode;
=20
 	u32			fladj;
@@ -1218,6 +1222,16 @@ static inline int dwc3_send_gadget_generic_command(s=
truct dwc3 *dwc,
 { return 0; }
 #endif
=20
+#if IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
+int dwc3_drd_init(struct dwc3 *dwc);
+void dwc3_drd_exit(struct dwc3 *dwc);
+#else
+static inline int dwc3_drd_init(struct dwc3 *dwc)
+{ return 0; }
+static inline void dwc3_drd_exit(struct dwc3 *dwc)
+{ }
+#endif
+
 /* power management interface */
 #if !IS_ENABLED(CONFIG_USB_DWC3_HOST)
 int dwc3_gadget_suspend(struct dwc3 *dwc);
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
new file mode 100644
index 000000000000..2765c51c7ef5
=2D-- /dev/null
+++ b/drivers/usb/dwc3/drd.c
@@ -0,0 +1,85 @@
+/**
+ * drd.c - DesignWare USB3 DRD Controller Dual-role support
+ *
+ * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com
+ *
+ * Authors: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/extcon.h>
+
+#include "debug.h"
+#include "core.h"
+#include "gadget.h"
+
+static void dwc3_drd_update(struct dwc3 *dwc)
+{
+	int id;
+
+	id =3D extcon_get_state(dwc->edev, EXTCON_USB_HOST);
+	if (id < 0)
+		id =3D 0;
+
+	dwc3_set_mode(dwc, id ?
+		      DWC3_GCTL_PRTCAP_HOST :
+		      DWC3_GCTL_PRTCAP_DEVICE);
+}
+
+static int dwc3_drd_notifier(struct notifier_block *nb,
+			     unsigned long event, void *ptr)
+{
+	struct dwc3 *dwc =3D container_of(nb, struct dwc3, edev_nb);
+
+	dwc3_set_mode(dwc, event ?
+		      DWC3_GCTL_PRTCAP_HOST :
+		      DWC3_GCTL_PRTCAP_DEVICE);
+
+	return NOTIFY_DONE;
+}
+
+int dwc3_drd_init(struct dwc3 *dwc)
+{
+	int ret;
+
+	if (dwc->dev->of_node) {
+		if (of_property_read_bool(dwc->dev->of_node, "extcon"))
+			dwc->edev =3D extcon_get_edev_by_phandle(dwc->dev, 0);
+
+		if (IS_ERR(dwc->edev))
+			return PTR_ERR(dwc->edev);
+
+		dwc->edev_nb.notifier_call =3D dwc3_drd_notifier;
+		ret =3D extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
+					       &dwc->edev_nb);
+		if (ret < 0) {
+			dev_err(dwc->dev, "couldn't register cable notifier\n");
+			return ret;
+		}
+	}
+
+	dwc3_drd_update(dwc);
+
+	return 0;
+}
+
+void dwc3_drd_exit(struct dwc3 *dwc)
+{
+	extcon_unregister_notifier(dwc->edev, EXTCON_USB_HOST,
+				   &dwc->edev_nb);
+
+	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+	flush_work(&dwc->drd_work);
+	dwc3_gadget_exit(dwc);
+}
=2D-=20
2.11.0.295.gd7dffce1ce

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAljrPAIACgkQzL64meEa
mQZptBAAjKrpqCIXiz8mMq/HCSMZuWNMdIJb3NrRXc5pV265qzyBT6u6Jqy41IYX
jTRqlqGlbPzU+2RQ/Jz/wh4Bc7GqeGpfHFg9IJH4mMJZtD7XY9/k1AvupAquv5eg
prWBgv1rGGI3rAtxCziQgg3YJeXdKW6LmJV/K2Li39gb/lf83cTn4eGAd8+lZmoq
qQcbNmuMlt0eGzpWLP9n5jOifrbtkQ+12H4ri1+6G58N9jlr9KR/RRisjhC+v1Rc
lCJdLqTRq7gKx0jMgIM7k00EbHhIL4ftbQ668vM5MDCmpYo5FPOcoYdhWHn8Z2Xy
nCvaszyL+nRt/de+1v+TgxpYINdF6+lQDycmQwN0l/ya0up5tgOhyZlWUM1lK0zs
tWLMu+MRpHRV1Rpu2ztd2z7TEn0XJ4/8Jxir9xnFpRZonHioQtnWxMz8qedt/VPx
INNtr6rgRAV8mRNfZCAu73X0N8KX9RpRNDPVJrMy/UkzmWdiL+pTbPWKcYBlday+
CPPGG3f7l8nRgysP1QdvkO+YZ0hpY8fhfGyFVrxSbRPf7f++aVJrmRDJLEzUMKTk
8M7fL2kd5PYftf/TzlhjnYOScR3PEakw2C/c62BiRhaY1AhWbZv4zWKPQu/yWfC6
PblSkICy2phKX+Cx7wBTPtw+eYw3mqiN0x6IX0g2MpRNPsyc1XI=
=qQWK
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
