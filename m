From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/2] omap3 beagle patches
Date: Mon, 10 Aug 2009 14:48:57 +0300
Message-ID: <1249904939-3213-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29531 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622AbZHJLro (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 07:47:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

Two patches that make linux-omap boot on beagle board again

Felipe Balbi (2):
  arm: omap: beagle: add missing twl4030 usb platform_data
  arm: omap: beagle: update defconfig

 arch/arm/configs/omap3_beagle_defconfig |  357 ++++++++++++++++++++-----------
 arch/arm/mach-omap2/board-omap3beagle.c |    5 +
 2 files changed, 238 insertions(+), 124 deletions(-)

