From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [PATCH 0/5] arm: omap: usb: Runtime PM support for EHCI and OHCI drivers
Date: Wed, 11 May 2011 19:34:31 +0530
Message-ID: <1305122676-27236-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56368 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754256Ab1EKPlD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 May 2011 11:41:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, gadiyar@ti.com, parthab@india.ti.com, Keshava Munegowda <Keshava_mgowda@ti.com>

From: Keshava Munegowda <Keshava_mgowda@ti.com>

The Hwmod structures and Runtime PM features are implemented 
For EHCI and OHCI drivers of OMAP3 and OMAP4.
The global suspend/resume of EHCI and OHCI 
is validated on OMAP3430 sdp board with these patches.

Keshava Munegowda (5):
  arm: omap: usb: ehci and ohci hwmod structures for omap3 and omap4
  arm: omap: usb: register hwmods of usbhs
  arm: omap: usb: device name change for the clk names of usbhs
  arm: omap: usb: Runtime PM support
  arm: omap: usb: global Suspend and resume support of ehci and ohci

 arch/arm/mach-omap2/clock3xxx_data.c       |   28 ++--
 arch/arm/mach-omap2/clock44xx_data.c       |   10 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  184 ++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  153 ++++++++++++++++++
 arch/arm/mach-omap2/usb-host.c             |   99 ++++--------
 drivers/mfd/omap-usb-host.c                |  236 +++++++++++++---------------
 6 files changed, 504 insertions(+), 206 deletions(-)

