From: green@linuxhacker.ru
Subject: Initial B&N Nook Color support, take five
Date: Mon,  6 Jun 2011 02:05:02 -0400
Message-ID: <1307340305-1252-1-git-send-email-green@linuxhacker.ru>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from c-71-228-165-73.hsd1.tn.comcast.net ([71.228.165.73]:56996 "EHLO
	fatbox1.localnet" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752137Ab1FFGFy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 02:05:54 -0400
Received: from fatbox1.localnet (fatbox1.localnet [127.0.0.1])
	by fatbox1.localnet (8.14.4/8.14.4) with ESMTP id p5665rNk001294
	for <linux-omap@vger.kernel.org>; Mon, 6 Jun 2011 02:05:53 -0400
Received: (from green@localhost)
	by fatbox1.localnet (8.14.4/8.14.4/Submit) id p5665r6p001292
	for linux-omap@vger.kernel.org; Mon, 6 Jun 2011 02:05:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello!

 Next attempt at B&N Nook Color board file submission.
 USB peripheral mode is fully operational as is serial console and
 MMC/SDCard.

 Changes
 since v4:
 Rebased to devel-fixes
 A few more style fixes with regulators
 dropped board_mux define if CONFIG_OMAP_MUX is not set
 since v3:
 Separated mach-types change into a separate patch (already got RMK approval)
 Dramatically cut number of includes in the board file again.
 No longer set voltage regulator dev, just device name in the supply.
 Style fixes
 Serial in uncompress.h sorted by name
 Corrected MUX package to CBP in board file.
 omap_i2c_init now has no return since it's unused anyway.
 Fixed keypad definition.

 since v2:
 rebased on devel-cleanup branch

 since v1:
 Threw away all the android stuff as suggested 
 Cleaned up voltage regulators and removed the ones our twl chip actually
   does not have
 Changed the split of the patches to board file + twl update

Bye,
  Oleg

