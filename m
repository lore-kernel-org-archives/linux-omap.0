From: "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2] MUSB: fix wrongly created sysfs entry
Date: Tue, 16 Dec 2008 00:53:47 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087025127B95C@dbde02.ent.ti.com>
References: <1229272442.6775.3.camel@localhost.localdomain>
	<49462232.10308@option.com>	<1229352834.12163.9.camel@localhost.localdomain>
	<1229354799.22285.234.camel@violet>
	<20081215154937.6e1bf0e1@lxorguk.ukuu.org.uk>
	<1229356837.22285.239.camel@violet>
	<1229357553.12163.55.camel@localhost.localdomain>
	<20081215162505.4b11c9be@lxorguk.ukuu.org.uk>
	<1229359592.12163.80.camel@localhost.localdomain>
	<20081215171611.0b3877d5@lxorguk.ukuu.org.uk>
	<1229362427.12163.94.camel@localhost.localdomain>
	<1229363671.12163.109.camel@localhost.localdomain>
 <20081215180740.02ef1667@lxorguk.ukuu.org.uk>
 <FCCFB4CDC6E5564B9182F639FC356087025127B95B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087025127B95B-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>

attr_srp is created wrongly for GADGET only mode of MUSB
The attribute is related to OTG mode only

For Gadget mode, this attribute gets created on insmod but does
not get deleted. Fixing the bug.

Signed-off-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
---

Fixing the comment-line in v2 of this patch

 drivers/usb/musb/musb_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 5280dba..6b42667 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2058,9 +2058,9 @@ bad_config:
 #ifdef CONFIG_SYSFS
 	status = device_create_file(dev, &dev_attr_mode);
 	status = device_create_file(dev, &dev_attr_vbus);
-#ifdef CONFIG_USB_GADGET_MUSB_HDRC
+#ifdef CONFIG_USB_MUSB_OTG
 	status = device_create_file(dev, &dev_attr_srp);
-#endif /* CONFIG_USB_GADGET_MUSB_HDRC */
+#endif /* CONFIG_USB_MUSB_OTG */
 	status = 0;
 #endif
 	if (status)
-- 
1.6.0.3.613.g9f8f13

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
