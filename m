From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: [PATCH v3] MUSB: fix srp sysfs entry deletion
Date: Tue, 16 Dec 2008 01:35:05 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087025127B964@dbde02.ent.ti.com>
References: <20081215162505.4b11c9be@lxorguk.ukuu.org.uk>
 <1229359592.12163.80.camel@localhost.localdomain>
 <20081215171611.0b3877d5@lxorguk.ukuu.org.uk>
 <1229362427.12163.94.camel@localhost.localdomain>
 <1229363671.12163.109.camel@localhost.localdomain>
 <20081215180740.02ef1667@lxorguk.ukuu.org.uk>
 <FCCFB4CDC6E5564B9182F639FC356087025127B95B@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC356087025127B95C@dbde02.ent.ti.com>
 <20081215195136.GM23324@frodo>
 <FCCFB4CDC6E5564B9182F639FC356087025127B962@dbde02.ent.ti.com>
 <20081215195941.GA28753@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48468 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753222AbYLOUFS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 15:05:18 -0500
In-Reply-To: <20081215195941.GA28753@frodo>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: linux-omap <linux-omap@vger.kernel.org>

From: Vikram Pandita <vikram.pandita@ti.com>

srp sysfs attribute is dependent on gadget mode

the entry was not getting deleted in rmmod case,
fixing the bug

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
CC: Felipe Balbi <me@felipebalbi.com>
---
 drivers/usb/musb/musb_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 5280dba..4cc2638 100644
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
1.6.0.3.613.g9f8f13

