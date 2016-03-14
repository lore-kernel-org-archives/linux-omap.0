From: Rajesh Bhagat <rajesh.bhagat-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH v2 0/2] usb: dwc3: add disable receiver detection in P3 quirk
Date: Mon, 14 Mar 2016 14:40:49 +0530
Message-ID: <1457946651-23381-1-git-send-email-rajesh.bhagat@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sriram.dash-3arQi8VN3Tc@public.gmane.org, Rajesh Bhagat <rajesh.bhagat-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Adds disable receiver detection in P3 quirk in DWC3 driver. 

Rajesh Bhagat (2):
  usb: dwc3: add disable receiver detection in P3 quirk
  Documentation: dt: dwc3: Add snps,dis_rxdet_inp3_quirk property

 Documentation/devicetree/bindings/usb/dwc3.txt | 2 ++
 drivers/usb/dwc3/core.c                        | 6 ++++++
 drivers/usb/dwc3/core.h                        | 2 ++
 drivers/usb/dwc3/platform_data.h               | 1 +
 4 files changed, 11 insertions(+)

-- 
2.6.2.198.g614a2ac

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
