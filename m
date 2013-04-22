From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: [PATCH v3] gpio/omap: implement irq mask/disable with proper
Date: Mon, 22 Apr 2013 10:54:20 +0200
Message-ID: <1366620861-5489-1-git-send-email-andreas.fenkart@streamunlimited.com>
References: <51728BA6.1090800@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:50028 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753099Ab3DVIyg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Apr 2013 04:54:36 -0400
Received: from mailout-de.gmx.net ([10.1.76.34]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MY1JW-1TzHZo422C-00UuZt for
 <linux-omap@vger.kernel.org>; Mon, 22 Apr 2013 10:54:33 +0200
In-Reply-To: <51728BA6.1090800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com
Cc: khilman@deeprootsystems.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, balbi@ti.com, linux-omap@vger.kernel.org, daniel@zonque.org, jon-hunter@ti.com, Andreas Fenkart <andreas.fenkart@streamunlimited.com>

Added kernel doc for mask/unmask, disable/enable functions.

Andreas Fenkart (1):
  gpio/omap: implement irq mask/disable with proper semantic.

 drivers/gpio/gpio-omap.c |   69 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 60 insertions(+), 9 deletions(-)

-- 
1.7.10.4

