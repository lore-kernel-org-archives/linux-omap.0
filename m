From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 0/2] musb runtime_pm fixes
Date: Sat,  4 Feb 2012 19:43:50 +0200
Message-ID: <1328377432-13563-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58575 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381Ab2BDRn7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Feb 2012 12:43:59 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>

These patches try address isp1704_charger crash in a different way
than 772aed45b604, which broke runtime_pm for me.

Felipe Contreras, oculd you test isp1704_charger with these?

Grazvydas Ignotas (2):
  usb: musb: fix some runtime_pm issues
  usb: musb: wake the device before ulpi transfers

 drivers/usb/musb/musb_core.c |   40 +++++++++++++++++++++++++++++++++-------
 drivers/usb/musb/omap2430.c  |    2 +-
 include/linux/usb/otg.h      |    1 +
 3 files changed, 35 insertions(+), 8 deletions(-)

