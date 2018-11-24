From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 0/5] omap_udc bug fixes
Date: Sun, 25 Nov 2018 00:17:03 +0200
Message-ID: <20181124221708.31003-1-aaro.koskinen@iki.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Hello,

Some fixes for omap_udc making the driver usable again on Palm TE & 770.

	v2: Patch #2 rewritten, now usb_add_gadget_udc_release() should be
	    properly used.
	    Patch #5 added.

	v1: https://marc.info/?l=linux-usb&m=154258778216930&w=2
	    https://marc.info/?l=linux-usb&m=154258778316932&w=2
	    https://marc.info/?l=linux-usb&m=154258778316931&w=2
	    https://marc.info/?l=linux-usb&m=154258778216929&w=2

Aaro Koskinen (5):
  USB: omap_udc: use devm_request_irq()
  USB: omap_udc: fix crashes on probe error and module removal
  USB: omap_udc: fix omap_udc_start() on 15xx machines
  USB: omap_udc: fix USB gadget functionality on Palm Tungsten E
  USB: omap_udc: fix rejection of out transfers when DMA is used

 drivers/usb/gadget/udc/omap_udc.c | 88 +++++++++++--------------------
 1 file changed, 31 insertions(+), 57 deletions(-)

-- 
2.17.0
