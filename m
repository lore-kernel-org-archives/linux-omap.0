From: Kyle Manna <kyle@kylemanna.com>
Subject: [PATCH 0/3] Fixes to twl4030-madc and add BeagleBoard support
Date: Wed, 10 Aug 2011 22:27:49 -0500
Message-ID: <1313033272-16774-1-git-send-email-kyle@kylemanna.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hapkido.dreamhost.com ([66.33.216.122]:41783 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987Ab1HKD17 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Aug 2011 23:27:59 -0400
Received: from homiemail-a73.g.dreamhost.com (caiajhbdcbbj.dreamhost.com [208.97.132.119])
	by hapkido.dreamhost.com (Postfix) with ESMTP id E4AB517E580
	for <linux-omap@vger.kernel.org>; Wed, 10 Aug 2011 20:27:58 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kyle Manna <kyle@kylemanna.com>

These patches add basic functionality to the twl4030-madc driver to make
it work on the BeagleBoard xM.  These patches were also tested on a OMAP3EVM.

Kyle Manna (3):
  twl4030-madc: copy the device pointer
  twl4030-madc: turn on the MADC clock
  BeagleBoard: add support for the twl4030-madc

 arch/arm/mach-omap2/board-omap3beagle.c |   11 +++++++++++
 drivers/mfd/twl4030-madc.c              |   27 ++++++++++++++++++++++++++-
 include/linux/i2c/twl4030-madc.h        |    4 ++++
 3 files changed, 41 insertions(+), 1 deletions(-)

-- 
1.7.4.1

