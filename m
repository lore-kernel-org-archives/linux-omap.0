From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 0/2] OMAP: omap_device: Add a method to build an omap_device from a DT node
Date: Fri, 16 Sep 2011 16:43:17 +0200
Message-ID: <1316184199-12599-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60097 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751820Ab1IPOn2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 10:43:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, Benoit Cousson <b-cousson@ti.com>

Hi Kevin,

This is the updated version of the initial series that introduced a
notifier in order to create an omap_device from a platform_device bound
to DT node as suggested by Grant.

For the moment, the informations are all extracted from the hwmod data.
The idea is to focus first on the devices / board static init removal.
The other issue is that some bindings, like dma, are still not present
in the DT core code. The reg and irq bindings are there, but cannot
be used by some drivers due to the lack of named resources in DT for
the moment.
We agreed with Grant about the strategy to introduce the name without
breaking the compatibility and the default assumption about the order.

I'll update that in another series after 3.2 and then these informations
will be moved from hwmod to DT.

Patches are based on my for_3.2/1_omap_device_cleanup branch and are
available here:
git://gitorious.org/omap-pm/linux.git for_3.2/2_omap_device_dt

It is tested on OMAP4 SDP, Panda and Beagle-xM with and without CONFIG_OF.

Regards,
Benoit


Changes since v1: http://www.spinics.net/lists/linux-omap/msg55814.html
 - delete omap_device structure during BUS_NOTIFY_DEL_DEVICE callback
   as suggested by Kevin
 - merge previous patches 2&3 as suggested by Kevin
 - delete pm_lats in omap_device_delete since this is now kmalloc-ed
 - use kmemdup instead of kzalloc + memcopy for hmwods creation
 - Fix the wrong usage of of_*.h includes to build properly without
   CONFIG_OF.


Benoit Cousson (2):
  OMAP: omap_device: Add omap_device_[alloc|delete] for DT integration
  OMAP: omap_device: Add a method to build an omap_device from a DT node


 arch/arm/plat-omap/omap_device.c |  321 +++++++++++++++++++++++++++++++-------
 1 files changed, 263 insertions(+), 58 deletions(-)

