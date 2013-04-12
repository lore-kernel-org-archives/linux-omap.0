From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: [PATCH v2] gpio/omap: implement irq_enable/disable using mask/unmask.
Date: Fri, 12 Apr 2013 11:13:20 +0200
Message-ID: <1365758001-15562-1-git-send-email-andreas.fenkart@streamunlimited.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:49759 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750836Ab3DLJNf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Apr 2013 05:13:35 -0400
Received: from mailout-de.gmx.net ([10.1.76.29]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0M9tl0-1UK1Wm1ZJA-00B598 for
 <linux-omap@vger.kernel.org>; Fri, 12 Apr 2013 11:13:32 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com
Cc: khilman@deeprootsystems.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, linux-omap@vger.kernel.org, daniel@zonque.org, jon-hunter@ti.com, Andreas Fenkart <andreas.fenkart@streamunlimited.com>

This is a resend. The single change is the added changelog
https://patchwork.kernel.org/patch/1886421/

Andreas Fenkart (1):
  gpio/omap: implement irq_enable/disable using mask/unmask.

 drivers/gpio/gpio-omap.c |    2 ++
 1 file changed, 2 insertions(+)

-- 
1.7.10.4

