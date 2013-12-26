From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 0/2] musb: Rework USB and USB_GADGET config
Date: Thu, 26 Dec 2013 09:24:51 -0300
Message-ID: <1388060693-2716-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:56683 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752881Ab3LZMYt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Dec 2013 07:24:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

I'm resending this configuration rework to include one more patch in the
series, prior to the config change. The first patch removes the usb_disable()
usage, allowing the build the module for gadget-only mode usage.

Without the first patch, the build breaks when building for !USB && USB_GADGET.
Hope it looks better now.

Ezequiel Garcia (2):
  usb: musb: Remove usb_disable() check in module_init()
  usb: musb: Rework USB and USB_GADGET dependency

 drivers/usb/Kconfig          |  4 ++--
 drivers/usb/musb/Kconfig     |  8 ++++----
 drivers/usb/musb/musb_core.c | 17 +----------------
 3 files changed, 7 insertions(+), 22 deletions(-)

-- 
1.8.1.5

