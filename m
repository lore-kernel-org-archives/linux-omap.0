From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 0/2] usb: musb: off mode fixes
Date: Tue, 6 Sep 2011 17:49:31 -0700
Message-ID: <1315356573-1057-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42622 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438Ab1IGAtv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Sep 2011 20:49:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>

From: Vikram Pandita <vikram.pandita@ti.com>

Recent tests with OFF mode on OMAP44xx brings out these bugs

Hema HK (1):
  usb: musb: omap2+: save and restore OTG_INTERFSEL

Vikram Pandita (1):
  usb: musb: omap2+: fix context api's

 drivers/usb/musb/musb_core.c |    4 ++--
 drivers/usb/musb/musb_core.h |    1 +
 drivers/usb/musb/omap2430.c  |    6 ++++++
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
1.7.4.1

