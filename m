From: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] usb: dwc3: Set DWC3 context's mode based on selected mode.
Date: Sat, 02 Mar 2013 18:55:24 +0530
Message-ID: <1362230724-21017-1-git-send-email-gautam.vivek@samsung.com>
References: <CAFp+6iGGAY=nMg03-bqHz=XuNP+1t9mQR=M53HGoqCXv=t+f0Q@mail.gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <CAFp+6iGGAY=nMg03-bqHz=XuNP+1t9mQR=M53HGoqCXv=t+f0Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Now that machines may select the mode of working of DWC3 (HOST only,
GADGET only or DUAL_ROLE), lets set DWC3 mode based on that
rather than fixing it to whatever DWC3 hardware says.
This way we can skip initializing Gadget/Host in case
we are using Host-only/Gadget-only mode respectively.

Signed-off-by: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---

Changes from RFC patch "usb: dwc3: Set GCTL.PrtCapDir based on selected mode"
 - Setting the mode in dwc3 context structure based on
   selected mode in machine, rather than programming PrtCapDir

 drivers/usb/dwc3/core.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 79f335f..be0672f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -478,7 +478,12 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	mode = DWC3_MODE(dwc->hwparams.hwparams0);
+	if (IS_ENABLED(CONFIG_USB_DWC3_HOST))
+		mode = DWC3_MODE_HOST;
+	else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET))
+		mode = DWC3_MODE_DEVICE;
+	else
+		mode = DWC3_MODE_DRD;
 
 	switch (mode) {
 	case DWC3_MODE_DEVICE:
-- 
1.7.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
