From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [v2 0/2] usb: musb: off mode fixes
Date: Wed, 7 Sep 2011 09:19:22 -0700
Message-ID: <1315412364-21384-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49614 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756369Ab1IGQTa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Sep 2011 12:19:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>

From: Vikram Pandita <vikram.pandita@ti.com>

v1:
Recent tests with OFF mode on OMAP44xx brings out these bugs 
v2:
Fix review comments from: Sergei Shtylyov <sshtylyov@mvista.com>

Hema HK (1):
  usb: musb: omap2+: save and restore OTG_INTERFSEL

Vikram Pandita (1):
  usb: musb: omap2+: fix context api's

 drivers/usb/musb/musb_core.c |    2 ++
 drivers/usb/musb/musb_core.h |    1 +
 drivers/usb/musb/omap2430.c  |    6 ++++++
 3 files changed, 9 insertions(+), 0 deletions(-)

-- 
1.7.4.1

