From: Hema HK <hemahk@ti.com>
Subject: [PATCH 0/4]usb: musb:USB driver changes to use hwmod+ omap-device apis
Date: Mon, 28 Jun 2010 17:39:51 +0530
Message-ID: <1277726991-5426-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34085 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193Ab0F1MKE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Jun 2010 08:10:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, tony@atomide.com

From: Hema HK  <hemahk@ti.com>

Series of patches to port musb driver to use hwmod and omap-device apis 
for omap4 and omap3.Omap3 HWMOD data structures are poulated.
These patches are tested on omap4 and omap3 SDPs.

The first 2 patches are the prerequisites for the hwmod changes.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com> ,tony@atomide.com
---

