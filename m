From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 2/2] OMAP: ams_delta_defconfig: enable LCD class device support
Date: Mon, 16 Nov 2009 03:49:13 +0100
Message-ID: <200911160349.15773.jkrzyszt@tis.icnet.pl>
References: <200911160340.13899.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:51182 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664AbZKPCt2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 15 Nov 2009 21:49:28 -0500
In-Reply-To: <200911160340.13899.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net, Imre Deak <imre.deak@nokia.com>, Tony Lindgren <tony@atomide.com>

The patch enables LCD class device support in ams_delta_defconfig in order to
get optional contrast control functional.

Created and tested against linux-omap for-next,
commit 155a75d9725e66e5ec8a383822957dee52427057.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
--- a/arch/arm/configs/ams_delta_defconfig	2009-11-14 23:48:40.000000000 +0100
+++ b/arch/arm/configs/ams_delta_defconfig	2009-11-16 01:06:12.000000000 +0100
@@ -836,7 +836,8 @@
 #
 # Graphics support
 #
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_LCD_CLASS_DEVICE=y
 
 #
 # Display device support



