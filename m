From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [patch-2.6.34-rc2+] ehci: omap: fix kernel panic with rmmod
Date: Wed, 24 Mar 2010 14:45:34 +0200
Message-ID: <1269434734-23524-2-git-send-email-felipe.balbi@nokia.com>
References: <1269434734-23524-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1269434734-23524-1-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

Sets the regulator values to NULL if they are not defined. This
is required to fix the kernel panic in exit path when EHCI module
is removed on the platforms where EHCI regulator are not set.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/host/ehci-omap.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index f0282d6..c45ee0b 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -628,11 +628,13 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		}
 		snprintf(supply, sizeof(supply), "hsusb%d", i);
 		omap->regulator[i] = regulator_get(omap->dev, supply);
-		if (IS_ERR(omap->regulator[i]))
+		if (IS_ERR(omap->regulator[i])) {
+			omap->regulator[i] = NULL;
 			dev_dbg(&pdev->dev,
 			"failed to get ehci port%d regulator\n", i);
-		else
+		} else {
 			regulator_enable(omap->regulator[i]);
+		}
 	}
 
 	ret = omap_start_ehc(omap, hcd);
-- 
1.7.0.rc0.33.g7c3932

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
