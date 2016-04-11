From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/2] usb: dwc3: fixes for v4.6-rc
Date: Mon, 11 Apr 2016 17:12:32 +0300
Message-ID: <1460383954-3240-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org
Cc: nsekhar@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

These are some dwc3 fixes that were done by Felipe.
I've just rebased and posted them.

cheers,
-roger

Felipe Balbi (2):
  usb: dwc3: omap: fix up error path on probe()
  usb: dwc3: core: fix PHY handling during suspend

 drivers/usb/dwc3/core.c      | 23 ++++++++++++++++++++++-
 drivers/usb/dwc3/dwc3-omap.c | 12 ++++--------
 2 files changed, 26 insertions(+), 9 deletions(-)

-- 
2.5.0
