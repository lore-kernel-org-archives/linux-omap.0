From: "Thang Q. Nguyen" <tqnguyen@apm.com>
Subject: RE: [PATCH v2 1/2] usb:dwc3: Enable support for 64-bit system
Date: Tue, 16 Feb 2016 17:56:01 +0700
Message-ID: <8dd0ee5befa7b1200878af7615e3b22d@mail.gmail.com>
References: <1453731985-13835-1-git-send-email-tqnguyen@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453731985-13835-1-git-send-email-tqnguyen@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org
Cc: Phong Vo <pvo@apm.com>, Loc Ho <lho@apm.com>, patches <patches@apm.com>
List-Id: linux-omap@vger.kernel.org

Hi,
Do you have any more feedback on this patch?

Thanks,
Thang Q. Nguyen -
-----Original Message-----
From: Thang Q. Nguyen [mailto:tqnguyen@apm.com]
Sent: Monday, January 25, 2016 9:26 PM
To: Felipe Balbi; Greg Kroah-Hartman; linux-usb@vger.kernel.org;
linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org;
linux-arm@lists.infradead.org
Cc: Thang Nguyen; Phong Vo; Loc Ho; patches@apm.com
Subject: [PATCH v2 1/2] usb:dwc3: Enable support for 64-bit system

Add 64-bit DMA operation support to the USB DWC3 driver.
First attempt to set the coherent DMA mask for 64-bit DMA.
If that failed, attempt again with 32-bit DMA.

Signed-off-by: Thang Q. Nguyen <tqnguyen@apm.com>
---
Changes from v1:
	- Remove WARN_ON if dma_mask is NULL

 drivers/usb/dwc3/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c index
de5e01f..2479c24 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -831,6 +831,21 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->mem = mem;
 	dwc->dev = dev;

+	/* Try to set 64-bit DMA first */
+	if (!pdev->dev.dma_mask)
+		/* Platform did not initialize dma_mask */
+		ret = dma_coerce_mask_and_coherent(&pdev->dev,
+						   DMA_BIT_MASK(64));
+	else
+		ret = dma_set_mask_and_coherent(&pdev->dev,
DMA_BIT_MASK(64));
+
+	/* If seting 64-bit DMA mask fails, fall back to 32-bit DMA mask
*/
+	if (ret) {
+		ret = dma_set_mask_and_coherent(&pdev->dev,
DMA_BIT_MASK(32));
+		if (ret)
+			return ret;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!res) {
 		dev_err(dev, "missing IRQ\n");
