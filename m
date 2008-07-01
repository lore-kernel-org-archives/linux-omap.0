From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/1] musb configs
Date: Tue,  1 Jul 2008 15:56:50 +0300
Message-ID: <1214917011-837-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:50872 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005AbYGAM6K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2008 08:58:10 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m61CvejC014212
	for <linux-omap@vger.kernel.org>; Tue, 1 Jul 2008 15:58:07 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

The following patch gets rid os hdrc_cnf.h and make
musb configuration details more dynamic by introducing
proper fields in the platform_data.

I tested the patch with n810 and omap3 beagle, but please
everyone interested, give it a good review and try it out.

Felipe Balbi (1):
  usb: musb: pass configuration specifics via pdata

 arch/arm/mach-omap2/board-n800-usb.c |   46 +++++++++-
 arch/arm/mach-omap2/usb-musb.c       |   51 +++++++++-
 arch/arm/mach-omap2/usb-tusb6010.c   |    1 -
 drivers/usb/musb/musb_core.c         |   37 +++----
 drivers/usb/musb/musb_core.h         |   14 +---
 drivers/usb/musb/tusb6010.h          |  169 --------------------------------
 include/asm-arm/arch-omap/hdrc_cnf.h |  177 ----------------------------------
 include/asm-arm/arch-omap/usb-musb.h |    3 +
 include/linux/usb/musb.h             |   38 +++++++-
 9 files changed, 147 insertions(+), 389 deletions(-)
 delete mode 100644 include/asm-arm/arch-omap/hdrc_cnf.h

