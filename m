From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC] ARM: OMAP: MUSB: disable omap_device auto-suspend
Date: Mon, 28 Nov 2011 16:56:30 -0800
Message-ID: <1322528190-9274-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:53508 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752891Ab1K2A4a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Nov 2011 19:56:30 -0500
Received: by mail-yx0-f180.google.com with SMTP id l7so7538604yen.39
        for <linux-omap@vger.kernel.org>; Mon, 28 Nov 2011 16:56:26 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org

The MUSB driver does not currently implment suspend/resume callbacks,
seemingly because it does not support cutting power when devices are
connected in host mode.

Without a proper suspend/resume implementation, the OMAP PM domain
layer which automatically gates non runtime-suspended devices will
cause problems in suspend by the drivers ->runtime_suspend() callback
which will try to cut power.

Fix this by disabling PM domain auto suspending for MUSB until the
driver can be fixed to properly implement suspend/resume.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/usb-musb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 2679750..e19eb0a 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -110,6 +110,7 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
 						name, oh_name);
 		return;
 	}
+	omap_device_disable_idle_on_suspend(pdev);
 
 	dev = &pdev->dev;
 	get_device(dev);
-- 
1.7.6

