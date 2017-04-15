From: Tony Lindgren <tony@atomide.com>
Subject: [PATCHv2 0/2] mfd: omap-usb-tll: Fixes for USB TLL mode
Date: Sat, 15 Apr 2017 10:05:07 -0700
Message-ID: <20170415170509.17364-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi

Here's v2 of this that move the enabling of ULPIAUTOIDLE bit into a
separate patch as suggested by Roger Quadros <rogerq@ti.com>.

Both patches can wait for v4.12.

Regards,

Tony


Tony Lindgren (2):
  mfd: omap-usb-tll: Fix inverted bit use for USB TLL mode
  mfd: omap-usb-tll: Configure ULPIAUTOIDLE

 drivers/mfd/omap-usb-tll.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.12.2
