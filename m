From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: [PATCH v2 0/4] musb fixes and cleanups
Date: Mon, 19 Dec 2011 22:17:47 +0200
Message-ID: <1324325871-15137-1-git-send-email-felipe.contreras@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:51389 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610Ab1LSUUs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 15:20:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap <linux-omap@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Kosina <trivial@kernel.org>, Felipe Contreras <felipe.contreras@nokia.com>

Hi,

Here's a few cleanups and possible fixes. Nothing major.

In v2 I added comments from Alan Stern, and another possible fix by removing
some pm_runtime_disable() calls.

Felipe Contreras (4):
  usb: musb: fix pm_runtime mismatches
  usb: musb: trivial cleanup
  usb: musb: remove a bit of indentation
  musb: omap2430: avoid pm_runtime_disable()

 drivers/usb/musb/musb_gadget.c |    1 +
 drivers/usb/musb/omap2430.c    |   38 +++++++++++++++-----------------------
 2 files changed, 16 insertions(+), 23 deletions(-)

-- 
1.7.8

