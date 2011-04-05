From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH] usb: musb: omap2430: fix build failure
Date: Tue,  5 Apr 2011 19:50:34 +0200
Message-ID: <1302025834-25729-1-git-send-email-jhovold@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42041 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab1DERu4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Apr 2011 13:50:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Hema HK <hemahk@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Johan Hovold <jhovold@gmail.com>

=46ix build failure introduced by commit
7acc6197b76edd0b932a7cbcc6cfad0a8a87f026 (usb: musb: Idle path retentio=
n
and offmode support for OMAP3) when building without gadget
support.

  CC      drivers/usb/musb/omap2430.o
drivers/usb/musb/omap2430.c: In function =E2=80=98musb_otg_notification=
s=E2=80=99:
drivers/usb/musb/omap2430.c:262: error: =E2=80=98struct musb=E2=80=99 h=
as no member named =E2=80=98gadget_driver=E2=80=99

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/usb/musb/omap2430.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 25cb8b0..57a27fa 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -259,9 +259,10 @@ static int musb_otg_notifications(struct notifier_=
block *nb,
 	case USB_EVENT_VBUS:
 		DBG(4, "VBUS Connect\n");
=20
+#ifdef CONFIG_USB_GADGET_MUSB_HDRC
 		if (musb->gadget_driver)
 			pm_runtime_get_sync(musb->controller);
-
+#endif
 		otg_init(musb->xceiv);
 		break;
=20
--=20
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
