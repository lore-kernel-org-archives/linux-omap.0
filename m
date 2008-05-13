From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFC PATCH 0/5] musb changes
Date: Tue, 13 May 2008 15:29:51 +0300
Message-ID: <1210681796-1984-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53991 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755381AbYEMMcI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2008 08:32:08 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4DCVgFm016204
	for <linux-omap@vger.kernel.org>; Tue, 13 May 2008 15:32:06 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

The following patches let musb keep vbus off as much as
we can.

Still under development but I'd like to get comments from
people who have been working on usb lately.

My current TODO would be turn off vbus as soon as we
"eject" device (in case of mass storage devices) and port
the same behavior to omap3.

Felipe Balbi (5):
  USB: MUSB: Switch to a_idle when micro/mini-a cable is attached
  USB: MUSB: Change srp sysfs entry to session
  USB: MUSB: Do not turn vbus on immediately
  USB: MUSB: Always allow musb to idle
  USB: MUSB: We already know the default timeout

 drivers/usb/musb/musb_core.c |   72 +++++++++++++----------------------------
 drivers/usb/musb/omap2430.c  |   28 ++--------------
 drivers/usb/musb/tusb6010.c  |   38 +++++-----------------
 3 files changed, 36 insertions(+), 102 deletions(-)

