From: "Thang Q. Nguyen" <tqnguyen@apm.com>
Subject: [PATCH v1 0/2] usb:dwc3: Enable USB DWC3 support for 64-bit system
Date: Thu, 14 Jan 2016 12:08:43 +0700
Message-ID: <1452748125-31639-1-git-send-email-tqnguyen@apm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org
Cc: Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, Loc Ho <lho@apm.com>, patches@apm.com
List-Id: linux-omap@vger.kernel.org

When CONFIG_DMA_CMA is not set, the coherent mask is not set.
These patches enable the USB DWC3 driver to set the coherent mask
correctly by first set coherent DMA mask to 64-bit. If this
failed, attempt again with 32-bit.
In addition, pass the archdata to the xhci-hcd child so that
xhci-hcd can configure DMA operations correctly.

Thang Q. Nguyen (2):
  usb:dwc3: Enable support for 64-bit system
  usb:dwc3: pass arch data to xhci-hcd child

 drivers/usb/dwc3/core.c | 15 +++++++++++++++
 drivers/usb/dwc3/host.c |  1 +
 2 files changed, 16 insertions(+)

-- 
2.2.0
