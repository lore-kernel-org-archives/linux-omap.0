From: Nicolas Kaiser <nikai@nikai.net>
Subject: [PATCH] video/omap: remove mux.h include
Date: Mon, 4 Oct 2010 20:38:42 +0200
Message-ID: <20101004203842.088b0cb2@absol.kitzblitz>
References: <20101004174344.21577085@absol.kitzblitz>
	<20101004175429.GW3117@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from webhosting01.bon.m2soft.com ([195.38.20.32]:57817 "EHLO
	webhosting01.bon.m2soft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755029Ab0JDSkt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 14:40:49 -0400
In-Reply-To: <20101004175429.GW3117@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Including mux.h should no longer be needed for omap2/3/4 SoCs
outside arch/arm/mach-omap2 files.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 drivers/video/omap/lcd_omap3beagle.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap/lcd_omap3beagle.c b/drivers/video/omap/lcd_omap3beagle.c
index ca75cc2..d7c6c3e 100644
--- a/drivers/video/omap/lcd_omap3beagle.c
+++ b/drivers/video/omap/lcd_omap3beagle.c
@@ -25,8 +25,6 @@
 #include <linux/gpio.h>
 #include <linux/i2c/twl.h>
 
-#include <plat/mux.h>
-#include <plat/mux.h>
 #include <asm/mach-types.h>
 
 #include "omapfb.h"
-- 
1.7.2.2
