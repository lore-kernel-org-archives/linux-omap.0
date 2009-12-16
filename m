From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] USB ehci: replace mach header with plat
Date: Wed, 16 Dec 2009 11:10:06 -0800
Message-ID: <20091216191006.30032.75638.stgit@localhost>
References: <20091216190601.30032.91535.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50044 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762914AbZLPTKP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 14:10:15 -0500
In-Reply-To: <20091216190601.30032.91535.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Thomas Weber <weber@corscience.de>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, linux-usb-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>

From: Thomas Weber <weber@corscience.de>

Replace the mach/usb.h with plat/usb.h

Cc: linux-usb-devel@lists.sourceforge.net
Signed-off-by: Thomas Weber <weber@corscience.de>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/host/ehci-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 12f1ad2..74d07f4 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -37,7 +37,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
-#include <mach/usb.h>
+#include <plat/usb.h>
 
 /*
  * OMAP USBHOST Register addresses: VIRTUAL ADDRESSES

