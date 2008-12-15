From: "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2] MUSB: fix wrongly created sysfs entry
Date: Tue, 16 Dec 2008 01:25:58 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087025127B962@dbde02.ent.ti.com>
References: <1229356837.22285.239.camel@violet>
 <1229357553.12163.55.camel@localhost.localdomain>
 <20081215162505.4b11c9be@lxorguk.ukuu.org.uk>
 <1229359592.12163.80.camel@localhost.localdomain>
 <20081215171611.0b3877d5@lxorguk.ukuu.org.uk>
 <1229362427.12163.94.camel@localhost.localdomain>
 <1229363671.12163.109.camel@localhost.localdomain>
 <20081215180740.02ef1667@lxorguk.ukuu.org.uk>
 <FCCFB4CDC6E5564B9182F639FC356087025127B95B@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC356087025127B95C@dbde02.ent.ti.com>
 <20081215195136.GM23324@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081215195136.GM23324@frodo>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org" <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


>-----Original Message-----
>From: Felipe Balbi [mailto:me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org]
>
>On Tue, Dec 16, 2008 at 12:53:47AM +0530, Pandita, Vikram wrote:
>> From: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
>>
>> attr_srp is created wrongly for GADGET only mode of MUSB
>> The attribute is related to OTG mode only
>>
>> For Gadget mode, this attribute gets created on insmod but does
>> not get deleted. Fixing the bug.
>>
>> Signed-off-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
>
>NAK, any gadget is allowed to initiate SRP.
>See otg rev1.3 page 20:
>
>"Any B-device, including a standard USB peripheral, is allowed to
>initiate SRP"

Agreed. In that case, we still need the following patch:
Otherwise the srp entry does not get deleted on rmmod.

Signed-off-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 5280dba..824ea57 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1829,7 +1829,7 @@ static void musb_free(struct musb *musb)
 #ifdef CONFIG_SYSFS
 	device_remove_file(musb->controller, &dev_attr_mode);
 	device_remove_file(musb->controller, &dev_attr_vbus);
-#ifdef CONFIG_USB_MUSB_OTG
+#ifdef CONFIG_USB_GADGET_MUSB_HDRC
 	device_remove_file(musb->controller, &dev_attr_srp);
 #endif
 #endif
@@ -2060,7 +2060,7 @@ bad_config:
 	status = device_create_file(dev, &dev_attr_vbus);
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
 	status = device_create_file(dev, &dev_attr_srp);
-#endif /* CONFIG_USB_GADGET_MUSB_HDRC */
+#endif
 	status = 0;
 #endif
 	if (status)
@@ -2072,7 +2072,7 @@ fail2:
 #ifdef CONFIG_SYSFS
 	device_remove_file(musb->controller, &dev_attr_mode);
 	device_remove_file(musb->controller, &dev_attr_vbus);
-#ifdef CONFIG_USB_MUSB_OTG
+#ifdef CONFIG_USB_GADGET_MUSB_HDRC
 	device_remove_file(musb->controller, &dev_attr_srp);
 #endif
 #endif
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
