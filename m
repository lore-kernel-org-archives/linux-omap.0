From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [RFC 3/5] usb: xhci-plat: enable async suspend/resume
Date: Wed, 18 Dec 2013 16:09:32 +0530
Message-ID: <1387363174-25942-3-git-send-email-yuvaraj.cd@samsung.com>
References: <1387363174-25942-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1387363174-25942-1-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu, gregkh@linuxfoundation.org, kgene.kim@samsung.com, linux-usb@vger.kernel.org, sarah.a.sharp@linux.intel.com, balbi@ti.com, gautam.vivek@samsung.com, joshi@samsung.com
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Bresticker <abrestic@chromium.org>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-omap@vger.kernel.org

From: Andrew Bresticker <abrestic@chromium.org>

USB host controllers can take a significant amount of time to suspend
and resume, adding several hundred miliseconds to the kernel resume
time. Since the XHCI controller has no outside dependencies (other than
clocks, which are suspended late/resumed early), allow it to suspend and
resume asynchronously.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Reviewed-by: Julius Werner <jwerner@chromium.org>
Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 drivers/usb/host/xhci-plat.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 8abda5c..1bc1565 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -162,6 +162,8 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (ret)
 		goto put_usb3_hcd;
 
+	device_enable_async_suspend(&pdev->dev);
+
 	return 0;
 
 put_usb3_hcd:
-- 
1.7.9.5
