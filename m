From: Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 03/37] usb: gadget: add endpoint capabilities helper macros
Date: Wed, 08 Jul 2015 13:08:47 +0200
Message-ID: <1436353761-7107-4-git-send-email-r.baldyga@samsung.com>
References: <1436353761-7107-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1436353761-7107-1-git-send-email-r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: Peter.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, johnyoun-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, dahlmann.thomas-KvP5wT2u2U0@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, leoli-KZfg59tc24xl57MIdRCFDg@public.gmane.org, daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org, haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-geode-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add macros useful while initializing array of endpoint capabilities
structures. These macros makes structure initialization more compact
to decrease number of code lines and increase readability of code.

Signed-off-by: Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 include/linux/usb/gadget.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 6f3e0fb..e6cbc25 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -158,6 +158,26 @@ struct usb_ep_caps {
 	unsigned dir_out:1;
 };
 
+#define USB_EP_CAPS_TYPE_CONTROL     0x01
+#define USB_EP_CAPS_TYPE_ISO         0x02
+#define USB_EP_CAPS_TYPE_BULK        0x04
+#define USB_EP_CAPS_TYPE_INT         0x08
+#define USB_EP_CAPS_TYPE_ALL \
+	(USB_EP_CAPS_TYPE_ISO | USB_EP_CAPS_TYPE_BULK | USB_EP_CAPS_TYPE_INT)
+#define USB_EP_CAPS_DIR_IN           0x01
+#define USB_EP_CAPS_DIR_OUT          0x02
+#define USB_EP_CAPS_DIR_ALL  (USB_EP_CAPS_DIR_IN | USB_EP_CAPS_DIR_OUT)
+
+#define USB_EP_CAPS(_type, _dir) \
+	{ \
+		.type_control = !!(_type & USB_EP_CAPS_TYPE_CONTROL), \
+		.type_iso = !!(_type & USB_EP_CAPS_TYPE_ISO), \
+		.type_bulk = !!(_type & USB_EP_CAPS_TYPE_BULK), \
+		.type_int = !!(_type & USB_EP_CAPS_TYPE_INT), \
+		.dir_in = !!(_dir & USB_EP_CAPS_DIR_IN), \
+		.dir_out = !!(_dir & USB_EP_CAPS_DIR_OUT), \
+	}
+
 /**
  * struct usb_ep - device side representation of USB endpoint
  * @name:identifier for the endpoint, such as "ep-a" or "ep9in-bulk"
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
