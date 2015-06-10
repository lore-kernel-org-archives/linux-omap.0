From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/5] usb: dwc3: handle non maxpacket aligned transfers > 512
Date: Wed, 10 Jun 2015 14:48:47 +0530
Message-ID: <1433927932-32395-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: nsekhar-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Patch series adds support to handle non maxpacket aligned transfers
greater than bounce buffer size (512). It first adds chained TRB
support and then uses it to handle non maxpacket aligned transfers
greater than bounce buffer size.

Also included a cleanup patch to use 'roundup' macro.

This series is created after applying [1]

Non maxpacket aligned transfers can be initiated by
"./testusb -t 14 -c 1 -s 520 -v 1"

Before this series:
unknown speed	/dev/bus/usb/001/018	0
/dev/bus/usb/001/018 test 14 --> 110 (Connection timed out)

After this series:
unknown speed	/dev/bus/usb/001/023	0
/dev/bus/usb/001/023 test 14,    0.000486 secs

Tested this patch using USB3 Gen X CV (ch9 tests: usb2 and usb3,
link layer testing and MSC tests) and using USB2 X CV (ch9 tests,
MSC tests) and verified this doesn't cause additional failures.

Lecroy compliance tests fail even without this patch series so
deferred testing it.

[1] -> http://permalink.gmane.org/gmane.linux.kernel/1972684

Kishon Vijay Abraham I (5):
  usb: dwc3: ep0: use _roundup_ to calculate the transfer size
  usb: dwc3: ep0: preparation for handling non maxpacket aligned
    transfers > 512
  usb: dwc3; ep0: Modify _dwc3_ep0_start_trans_ API to take 'chain'
    parameter
  usb: dwc3: ep0: Add chained TRB support
  usb: dwc3: ep0: handle non maxpacket aligned transfers > 512

 drivers/usb/dwc3/ep0.c    |   94 ++++++++++++++++++++++++++++++---------------
 drivers/usb/dwc3/gadget.c |    2 +-
 2 files changed, 64 insertions(+), 32 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
