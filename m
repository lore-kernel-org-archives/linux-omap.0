From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 0/3] dspbridge: minor mbox cleanups
Date: Tue, 23 Mar 2010 16:48:27 -0600
Message-ID: <1269384510-1526-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58459 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753712Ab0CWWdJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Mar 2010 18:33:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Fix obvious coding style issues not seen during review.

And now bridge driver will auto select mailbox driver.

Omar Ramirez Luna (3):
  DSPBRIDGE: fix checkpatch error introduced with mailbox patches
  DSPBRIDGE: Fix obvious wrong comment formats in mbox migration
  DSPBRIDGE: auto select mailbox when compiling bridge

 drivers/dsp/bridge/Kconfig          |    1 +
 drivers/dsp/bridge/wmd/_tiomap.h    |    4 ++--
 drivers/dsp/bridge/wmd/tiomap3430.c |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

