From: green@linuxhacker.ru
Subject: Regulator cleanups in mach-omap2, take three
Date: Mon,  6 Jun 2011 14:57:06 -0400
Message-ID: <1307386628-1153-1-git-send-email-green@linuxhacker.ru>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from c-71-228-165-73.hsd1.tn.comcast.net ([71.228.165.73]:50081 "EHLO
	fatbox1.localnet" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753427Ab1FFS6V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 14:58:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hello!

  This is yet another attempt at some regulator cleanups in mach-omap2 code:
  Convert all users to REGULATOR_SUPPLY init style and drop the old-style
  .dev assignment common ins hs_mmc init.

  I made a test compile and all the individual board files changed compile
  (I don't have the devices themselves, but similar changes to my
   device board file are working).

  For the pandaboard changes - I am not sure what the proper names for those
  devices would be, so only converted the regulator to array.

  Big changes since v2:
  Per Felipe Balbi request converted all regulator supplies to arrays
  just in case.
  Also nuked an unneeded comment in cm-t35 board left after mmc.dev
  assignment removal.

