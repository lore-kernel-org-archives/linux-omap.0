From: Felipe Balbi <felipebalbi@users.sourceforge.net>
Subject: [PATCH] USB: Disable file_storage USB_CONFIG_ATT_WAKEUP
Date: Tue, 29 May 2007 15:02:32 +0300
Message-ID: <11804401651954-git-send-email-felipebalbi@users.sourceforge.net>
References: <11804401622277-git-send-email-felipebalbi@users.sourceforge.net>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11804401622277-git-send-email-felipebalbi@users.sourceforge.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

Disable file_storage USB_CONFIG_ATT_WAKEUP as it requires
user interaction during Chapter 9 tests.

Signed-off-by: Tony Lindgren <tony@atomide.com
Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---

diff --git a/drivers/usb/gadget/file_storage.c b/drivers/usb/gadget/file_storage.c
index c6b6479..de85c8b 100644
--- a/drivers/usb/gadget/file_storage.c
+++ b/drivers/usb/gadget/file_storage.c
@@ -3965,8 +3965,7 @@ static int __init fsg_bind(struct usb_gadget *gadget)
 #endif
 
 	if (gadget->is_otg) {
-		otg_desc.bmAttributes |= USB_OTG_HNP,
-		config_desc.bmAttributes |= USB_CONFIG_ATT_WAKEUP;
+		otg_desc.bmAttributes |= USB_OTG_HNP;
 	}
 
 	rc = -ENOMEM;
-- 
1.5.2.rc3.39.gaf9b
