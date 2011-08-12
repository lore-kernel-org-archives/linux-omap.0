From: Kyle Manna <kyle@kylemanna.com>
Subject: [PATCH v2 0/4] Fixes to twl4030-madc and add BeagleBoard support
Date: Thu, 11 Aug 2011 22:33:11 -0500
Message-ID: <1313119995-15382-1-git-send-email-kyle@kylemanna.com>
References: <CANOLnOPB=wFMPwqGbu9ufh__iM7TquUx3-o95R=gyJcae+gENg@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caiajhbdcaib.dreamhost.com ([208.97.132.81]:59999 "EHLO
	homiemail-a35.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752560Ab1HLDeB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Aug 2011 23:34:01 -0400
In-Reply-To: <CANOLnOPB=wFMPwqGbu9ufh__iM7TquUx3-o95R=gyJcae+gENg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>
Cc: Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Kyle Manna <kyle@kylemanna.com>

These patches add basic functionality to the twl4030-madc driver to make
it work on the BeagleBoard xM.

Version 2 adds fixes per Grazvydas Ignotas and the check for NULL pointer patch.

Kyle Manna (4):
  mfd: twl4030-madc: copy the device pointer
  mfd: twl4030-madc: turn on the MADC clock
  mfd: twl4030-madc: check for NULL pointer
  arm: BeagleBoard: add support for the twl4030-madc

 arch/arm/mach-omap2/board-omap3beagle.c |    9 ++++++++-
 drivers/mfd/twl4030-madc.c              |   27 ++++++++++++++++++++++++++-
 include/linux/i2c/twl4030-madc.h        |    4 ++++
 3 files changed, 38 insertions(+), 2 deletions(-)

-- 
1.7.4.1

