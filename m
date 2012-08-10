From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH v2 0/3] ARM: OMAP: omap_device: track driver bound status
Date: Fri, 10 Aug 2012 11:39:10 -0700
Message-ID: <1344623953-26434-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:32902 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754697Ab2HJSjQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Aug 2012 14:39:16 -0400
Received: by pbbrp8 with SMTP id rp8so4786332pbb.1
        for <linux-omap@vger.kernel.org>; Fri, 10 Aug 2012 11:39:14 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Add support for the omap_device layer to keep track of driver bound status.

This will be used to track whether or not a driver is bound in order
to make intelligent omap_device enable/idle decisions (e.g. ensuring
omap_devices are idled when no driver is present, or driver probe
fails.)

Also, the omap_device layer implements PM domains for all
omap_devices, and knowing whether or not a driver is bound is needed
to know whether or not a drivers callbacks are valid, especially in
cases of failed driver probe.

Kevin Hilman (3):
  ARM: OMAP: omap_device: keep track of driver bound status
  ARM: OMAP: omap_device: don't attempt late suspend if no driver bound
  ARM: OMAP: omap_device: idle devices with no driver bound

 arch/arm/plat-omap/include/plat/omap_device.h |    2 +
 arch/arm/plat-omap/omap_device.c              |   56 ++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 5 deletions(-)

-- 
1.7.9.2

