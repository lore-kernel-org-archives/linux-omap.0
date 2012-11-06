From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH/RESEND 0/2] usb: musb: am335x support part-2
Date: Tue, 6 Nov 2012 20:44:59 +0530
Message-ID: <cover.1352213124.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58166 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575Ab2KFPPD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 10:15:03 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hi Balbi,

This is a resend of remaining changes to get am335x usb working. These
were sent on 31 Oct with subject, "usb: musb: dsps: fixes for -rc.

First one restores capability to support at least one instance of musb.
Without it, even a single instance can't be supported as change which
is reverted by it was made along with multi phy changes and nop
transciever dt support, both other changes didn't make it to mainline. 

Second one corrects binding document; changes were made in driver as
per review comments, but documentation was not updated.

This is made on top of your "musb" branch. To get USB0 functional on
am335x based boards like beagle bone, first one is required.

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

