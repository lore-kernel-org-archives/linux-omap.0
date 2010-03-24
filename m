From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 0/9] OMAP: Devkit8000: Fix problems with package and usb
Date: Wed, 24 Mar 2010 13:52:09 +0100
Message-ID: <1269435138-27192-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:50125 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755858Ab0CXMxB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 08:53:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Thomas Weber <weber@corscience.de>

These patches fix problems coming from choosing the wrong package in the
configuration and initializing the wrong usb port. The defconfig is updated
to reflect these changes. Furthermore some typos in pin names corrected. 

Thomas Weber (9):
  OMAP: Devkit8000: Fix typo in supplies
  OMAP: Devkit8000: Add missing package selection
  OMAP: Devkit8000: Fix typo in pin name
  OMAP: Devkit8000: Remove unnecessary include file
  OMAP: Devkit8000: Change position of init calls
  OMAP: Devkit8000: Remove unused pins
  OMAP: Devkit8000: Fix wrong usb port on Devkit8000
  OMAP: Devkit8000: Add mux initialization
  OMAP: Devkit8000: Update default configuration

 arch/arm/configs/devkit8000_defconfig  |  157 +++++++++++++++-----------
 arch/arm/mach-omap2/Kconfig            |    6 +-
 arch/arm/mach-omap2/board-devkit8000.c |  194 +++++++++++++++++++++++++++-----
 3 files changed, 259 insertions(+), 98 deletions(-)

