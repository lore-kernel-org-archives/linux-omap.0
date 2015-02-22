From: Sneeker Yeh <sneeker.yeh@gmail.com>
Subject: [PATCH v5 3/5] usb: dwc3: add revision number DWC3_REVISION_290A and DWC3_REVISION_300A
Date: Sun, 22 Feb 2015 12:25:38 +0800
Message-ID: <1424579140-30567-4-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
References: <1424579140-30567-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424579140-30567-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mathias Nyman <mathias.nyman@intel.com>, Grant Likely <grant.likely@linaro.org>, Huang Rui <ray.huang@amd.com>, Kishon Vijay Abraham I <kishon@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Andy Green <andy.green@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>, Sneeker Yeh <Sneeker.Yeh@tw.fujitsu.com>
List-Id: linux-omap@vger.kernel.org

Add the contstant for v2.90a and v3.00a dwc3 IP detection

Signed-off-by: Sneeker Yeh <Sneeker.Yeh@tw.fujitsu.com>
---
 drivers/usb/dwc3/core.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index d201910..0b3bb0f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -772,6 +772,8 @@ struct dwc3 {
 #define DWC3_REVISION_260A	0x5533260a
 #define DWC3_REVISION_270A	0x5533270a
 #define DWC3_REVISION_280A	0x5533280a
+#define DWC3_REVISION_290A	0x5533290a
+#define DWC3_REVISION_300A	0x5533300a
 
 	enum dwc3_ep0_next	ep0_next_event;
 	enum dwc3_ep0_state	ep0state;
-- 
1.7.9.5
