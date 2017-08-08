From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] usb: ehci-omap: fix error return code in
 ehci_hcd_omap_probe()
Date: Tue, 8 Aug 2017 17:26:13 -0500
Message-ID: <20170808222613.GA4796@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-omap@vger.kernel.org

platform_get_irq() returns an error code, but the ehci-omap driver
ignores it and always returns -ENODEV. This is not correct and,
prevents -EPROBE_DEFER from being propagated properly.

Also, notice that platform_get_irq() no longer returns 0 on error:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af

Print and propagate the return value of platform_get_irq on failure.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/usb/host/ehci-omap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 94ea9ff..4d30853 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -130,8 +130,8 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "EHCI irq failed\n");
-		return -ENODEV;
+		dev_err(dev, "EHCI irq failed: %d\n", irq);
+		return irq;
 	}
 
 	res =  platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.5.0
