From: Tony Lindgren <tony@atomide.com>
Subject: Re: USB Modem support for Droid 4
Date: Thu, 18 Jul 2019 22:22:05 -0700
Message-ID: <20190719052205.GK5447@atomide.com>
References: <20190718201713.GA25103@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190718201713.GA25103@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@denx.de>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, johan@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Pavel Machek <pavel@denx.de> [190718 20:17]:
> From: Tony Lindgren <tony@atomide.com>
> 
> Droid starts to have useful support in linux-next. Modem is tricky to
> play with, but this is enough to get basic support.

Below is a better patch using option driver adding support for all
the ports. I'll send it out with a proper description after -rc1.

Regards,

Tony

8< ----------------
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -83,6 +83,12 @@ static void option_instat_callback(struct urb *urb);
 #define HUAWEI_PRODUCT_K4605			0x14C6
 #define HUAWEI_PRODUCT_E173S6			0x1C07
 
+#define MOTOROLA_VENDOR_ID			0x22b8
+#define MOTOROLA_PRODUCT_MDM6600		0x2a70
+#define MOTOROLA_PRODUCT_MDM9600		0x2e0a
+#define MOTOROLA_PRODUCT_MDM_RAM_DL		0x4281
+#define MOTOROLA_PRODUCT_MDM_QC_DL		0x900e
+
 #define QUANTA_VENDOR_ID			0x0408
 #define QUANTA_PRODUCT_Q101			0xEA02
 #define QUANTA_PRODUCT_Q111			0xEA03
@@ -968,6 +974,10 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_VENDOR_AND_INTERFACE_INFO(HUAWEI_VENDOR_ID, 0xff, 0x06, 0x7B) },
 	{ USB_VENDOR_AND_INTERFACE_INFO(HUAWEI_VENDOR_ID, 0xff, 0x06, 0x7C) },
 
+	{ USB_DEVICE_AND_INTERFACE_INFO(MOTOROLA_VENDOR_ID, MOTOROLA_PRODUCT_MDM6600, 0xff, 0xff, 0xff) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MOTOROLA_VENDOR_ID, MOTOROLA_PRODUCT_MDM9600, 0xff, 0xff, 0xff) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MOTOROLA_VENDOR_ID, MOTOROLA_PRODUCT_MDM_RAM_DL, 0x0a, 0x00, 0xfc) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MOTOROLA_VENDOR_ID, MOTOROLA_PRODUCT_MDM_QC_DL, 0xff, 0xff, 0xff) },
 
 	{ USB_DEVICE(NOVATELWIRELESS_VENDOR_ID, NOVATELWIRELESS_PRODUCT_V640) },
 	{ USB_DEVICE(NOVATELWIRELESS_VENDOR_ID, NOVATELWIRELESS_PRODUCT_V620) },
