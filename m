From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/1] mfd: omap-usb-host: Bug fix for 3.13 rc
Date: Fri, 29 Nov 2013 15:01:57 +0200
Message-ID: <1385730118-26402-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, sameo@linux.intel.com
Cc: tomi.valkeinen@ti.com, balbi@ti.com, sr@denx.de, ljkenny.mailinglists@gmail.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

This patch fixes USB device detection issues on OMAP4 Panda with
latest u-boot release v2013.10.

Please queue it for 3.13-rc cycle. Thanks.

cheers,
-roger

Roger Quadros (1):
  mfd: omap-usb-host: Fix USB device detection problems on OMAP4 Panda

 drivers/mfd/omap-usb-host.c | 115 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 109 insertions(+), 6 deletions(-)

-- 
1.8.3.2
