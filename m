From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 0/2] usb: musb: dsps: fixes for -rc
Date: Wed, 31 Oct 2012 19:54:21 +0530
Message-ID: <cover.1351691448.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35091 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935666Ab2JaOY1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Oct 2012 10:24:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Afzal Mohammed <afzal@ti.com>

Hi Balbi,

This series contains a couple of fixes for musb dsps wrapper.

First one restores capability to support at least one instance of musb.
Without it, even a single instance can't be supported as change which
is reverted by it was made along with multi phy changes and nop
transciever dt support, both other changes didn't make it in during
previous merge window.

Second one corrects binding document; changes were made in driver as
per review comments, but documentation was not updated.

Please consider this series for inclusion in the next -rc cycle.

To support usb on beagle bone, further changes to handle control
module registers for phy has to be made, they will be posted as
a seperate series.


Regards
Afzal

Afzal Mohammed (2):
  Revert "usb: musb: dsps: remove explicit NOP device creation"
  usb: musb: dsps: document dt bindings properly

 Documentation/devicetree/bindings/usb/am33xx-usb.txt | 8 ++++----
 drivers/usb/musb/musb_dsps.c                         | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
1.7.12

