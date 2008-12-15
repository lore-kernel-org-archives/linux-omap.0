From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: [PATCH] MUSB: fix wrongly created sysfs entry
Date: Tue, 16 Dec 2008 00:49:33 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087025127B95B@dbde02.ent.ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44852 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbYLOTTl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 14:19:41 -0500
In-Reply-To: <20081215180740.02ef1667@lxorguk.ukuu.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: linux-omap <linux-omap@vger.kernel.org>

From: Vikram Pandita <vikram.pandita@ti.com>

attr_srp is created wrongly for GADGET only mode of MUSB
The attribute is related to OTG mode only

For Gadget mode, this attribute gets created on insmod but does
not get deleted. Fixing this bug.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 drivers/usb/musb/musb_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 5280dba..e7a5759 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2058,7 +2058,7 @@ bad_config:
 #ifdef CONFIG_SYSFS
 	status = device_create_file(dev, &dev_attr_mode);
 	status = device_create_file(dev, &dev_attr_vbus);
-#ifdef CONFIG_USB_GADGET_MUSB_HDRC
+#ifdef CONFIG_USB_MUSB_OTG
 	status = device_create_file(dev, &dev_attr_srp);
 #endif /* CONFIG_USB_GADGET_MUSB_HDRC */
 	status = 0;
-- 
1.6.0.3.613.g9f8f13

