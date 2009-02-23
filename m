From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 12/23] usb: host: ehci: include <linux/gpio.h> instead
Date: Mon, 23 Feb 2009 20:52:40 +0200
Message-ID: <1235415171-17376-13-git-send-email-me@felipebalbi.com>
References: <1235415171-17376-1-git-send-email-me@felipebalbi.com>
 <1235415171-17376-2-git-send-email-me@felipebalbi.com>
 <1235415171-17376-3-git-send-email-me@felipebalbi.com>
 <1235415171-17376-4-git-send-email-me@felipebalbi.com>
 <1235415171-17376-5-git-send-email-me@felipebalbi.com>
 <1235415171-17376-6-git-send-email-me@felipebalbi.com>
 <1235415171-17376-7-git-send-email-me@felipebalbi.com>
 <1235415171-17376-8-git-send-email-me@felipebalbi.com>
 <1235415171-17376-9-git-send-email-me@felipebalbi.com>
 <1235415171-17376-10-git-send-email-me@felipebalbi.com>
 <1235415171-17376-11-git-send-email-me@felipebalbi.com>
 <1235415171-17376-12-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43048 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755073AbZBWS7q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:59:46 -0500
In-Reply-To: <1235415171-17376-12-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Syed Mohammed Khasim <x0khasim@ti.com>, Felipe Balbi <me@felipebalbi.com>

include <linux/gpio.h> instead of <mach/gpio.h>

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/usb/host/ehci-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 2fbf377..7f37b5f 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -27,7 +27,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/clk.h>
-#include <mach/gpio.h>
+#include <linux/gpio.h>
 
 #include "ehci-omap.h"
 
-- 
1.6.1.3

