From: George Cherian <george.cherian@ti.com>
Subject: [PATCH v2 0/3] Adding AM437x support to dwc3-omap glue
Date: Wed, 12 Jun 2013 14:53:44 +0530
Message-ID: <1371029027-9100-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

Initial patch set to add support for dwc3 in am437x platform.
This patch series addresses the regiter map differences between
OMAP5 and AM437x, to re-use the same driver.

AM437x and OMAP5 dwc3 subsytem have different register map.
Major differences are as follows.

OMAP5 has one main interrupt and one misc interrupt
Aegis has four main interrupts and one misc interrupt.

Miscellanous Interrupt offsets are changed.
UTMI OTG Control and Status Registers offsets are changed.
DEBUG Configuration and Status Registers are changed.

The main intend of the patch is to re-use the same wrapper driver
for both OMAP5 and AM437x, by using the x_major in revision
register and adjusting the offsets.

changes from v1:
	- Added compatible for AM437X since x_major is same for OMAP5 and AM437x
	- Added proper wrappers to dwc3_omap_readl/writel 


George Cherian (3):
  usb: dwc3: omap: Adding am437x specific register map changes
  usb: dwc3: omap: Intialize the register offset values for OMAP5 and
    AM437x
  usb: dwc3: omap: Adds dwc3_omap_readl/writel wrappers

 drivers/usb/dwc3/dwc3-omap.c | 234 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 178 insertions(+), 56 deletions(-)

-- 
1.8.1.4
