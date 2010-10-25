From: Matthias Kaehlcke <matthias@kaehlcke.net>
Subject: [PATCH] USB ehci-omap: Remove second kfree() call on the same
 object
Date: Mon, 25 Oct 2010 22:56:54 +0200
Message-ID: <20101025205654.GN18700@darwin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:33870 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab0JYU7j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Oct 2010 16:59:39 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, David Brownell <dbrownell@users.sourceforge.net>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Remove second kfree() call on the same object in the error path of
ehci_hcd_omap_probe()

Signed-off-by: Matthias Kaehlcke <matthias@kaehlcke.net>
---
 drivers/usb/host/ehci-omap.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index e1da3c9..116ae28 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -734,7 +734,6 @@ err_uhh_ioremap:
 
 err_ioremap:
 	usb_put_hcd(hcd);
-	kfree(omap);
 
 err_create_hcd:
 	kfree(omap);
-- 
1.7.1

