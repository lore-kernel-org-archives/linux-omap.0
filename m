From: Jack Pham <jackp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH] usb: dwc3: debugfs: fix regdump offset
Date: Mon, 10 Dec 2012 14:28:13 -0800
Message-ID: <1355178493-16688-1-git-send-email-jackp@codeaurora.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jack Pham <jackp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

As with dwc_readl/writel, the global registers are specified as
offsets starting from the beginning of the xHCI address space,
but the memory region pointed to by dwc->regs already maps to
the start of the global addresses. Fix by offsetting each of the
regs relative to DWC3_GLOBALS_REGS_START.

Signed-off-by: Jack Pham <jackp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/usb/dwc3/debugfs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
index d4a30f1..be4eff7 100644
--- a/drivers/usb/dwc3/debugfs.c
+++ b/drivers/usb/dwc3/debugfs.c
@@ -56,7 +56,7 @@
 #define dump_register(nm)				\
 {							\
 	.name	= __stringify(nm),			\
-	.offset	= DWC3_ ##nm,				\
+	.offset	= DWC3_ ##nm - DWC3_GLOBALS_REGS_START,	\
 }
 
 static const struct debugfs_reg32 dwc3_regs[] = {
-- 
Employee of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
