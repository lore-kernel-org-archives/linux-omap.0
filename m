From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH 1/2] ARM: OMAP: USB: Fixup ehci_hcd_omap_probe error path
Date: Thu, 21 Jun 2012 03:44:31 -0700
Message-ID: <1340275473-16374-1-git-send-email-Russ.Dill@ti.com>
References: <CA+Bv8XZ-g26_3Hv9xgDvwRooUeZwaKtZJwvnxxEZHcFx06es7Q@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41844 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986Ab2FUKol (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jun 2012 06:44:41 -0400
In-Reply-To: <CA+Bv8XZ-g26_3Hv9xgDvwRooUeZwaKtZJwvnxxEZHcFx06es7Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Anand Gadiyar <gadiyar@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vikram Pandita <vikram.pandita@ti.com>, Volodymyr Mieshkov <x0182794@ti.com>, Alan Stern <stern@rowland.harvard.edu>, yan-liu@ti.com, aparnab@ti.com, Russ Dill <Russ.Dill@ti.com>

A recent commit, [PATCH] Fix OMAP EHCI suspend/resume failure
(i693) '354ab856' causes ehci probe to fail on omap3xxx. This
exposed bugs in the ehci_hcd_omap_probe error path causing
an oops.

On the error path, call usb_remove_hcd if usb_add_hcd has been
called, and call usb_put_hcd if usb_alloc_hcd has been called.

Tested on BB-xM.

Signed-off-by: Russ.Dill@ti.com
---
 drivers/usb/host/ehci-omap.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 17cfb8a..6e15fc8 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -347,7 +347,7 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (ret) {
 		dev_err(dev, "failed to add hcd with err %d\n", ret);
-		goto err_add_hcd;
+		goto err_pm_runtime;
 	}
 
 	/* root ports should always stay powered */
@@ -424,8 +424,12 @@ err_utmi_p1_fck:
 	clk_put(utmi_p1_fck);
 
 err_add_hcd:
+	usb_remove_hcd(hcd);
+
+err_pm_runtime:
 	disable_put_regulator(pdata);
 	pm_runtime_put_sync(dev);
+	usb_put_hcd(hcd);
 
 err_io:
 	iounmap(regs);
-- 
1.7.10.4

