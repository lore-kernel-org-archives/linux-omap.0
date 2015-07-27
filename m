From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 0/6] usb: dwc3: handle non maxpacket aligned transfers > 512
Date: Mon, 27 Jul 2015 12:25:26 +0530
Message-ID: <1437980132-20232-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, kishon@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Patch series first fixes memory corruption and then adds support to
handle non maxpacket aligned transfers.

Patch series adds support to handle non maxpacket aligned transfers
greater than bounce buffer size (512). It first adds chained TRB
support and then uses it to handle non maxpacket aligned transfers
greater than bounce buffer size.

Also included a cleanup patch to use 'roundup' macro.

Changes from v2:
*) fixed the "stable" mail address
*) Used "bool" for the argument instead of unsigned.

Changes from v1:
*) Included the patch to fix memory corruption in this series. (Also
   marked it for stable release).

Non maxpacket aligned transfers can be initiated by
"./testusb -t 14 -c 1 -s 520 -v 1"

Before this series: (Causes memory corruption)
unknown speed   /dev/bus/usb/010/009    0
/dev/bus/usb/010/009 test 14,    0.219638 secs

After the 1st patch of this series:
unknown speed   /dev/bus/usb/001/018    0
/dev/bus/usb/001/018 test 14 --> 110 (Connection timed out)

After this series: (No memory corruption)
unknown speed   /dev/bus/usb/001/023    0
/dev/bus/usb/001/023 test 14,    0.000486 secs

Tested this patch using USB3 Gen X CV (ch9 tests: usb2 and usb3,
link layer testing and MSC tests) and using USB2 X CV (ch9 tests,
MSC tests) and verified this doesn't cause additional failures.

Lecroy compliance tests fail even without this patch series so
deferred testing it. 

Kishon Vijay Abraham I (6):
  usb: dwc3: ep0: Fix mem corruption on OUT transfers of more than 512
    bytes
  usb: dwc3: ep0: use _roundup_ to calculate the transfer size
  usb: dwc3: ep0: preparation for handling non maxpacket aligned
    transfers > 512
  usb: dwc3; ep0: Modify _dwc3_ep0_start_trans_ API to take 'chain'
    parameter
  usb: dwc3: ep0: Add chained TRB support
  usb: dwc3: ep0: handle non maxpacket aligned transfers > 512

 drivers/usb/dwc3/ep0.c    |   92 ++++++++++++++++++++++++++++++++-------------
 drivers/usb/dwc3/gadget.c |    2 +-
 2 files changed, 67 insertions(+), 27 deletions(-)

-- 
1.7.9.5
