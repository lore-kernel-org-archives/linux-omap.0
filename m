From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: 3430SDP: Crash on first UART keypress after boot
Date: Fri, 11 Sep 2009 14:54:46 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A09B280@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A0071C4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55127 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728AbZIKJYq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Sep 2009 05:24:46 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8B9Oma9001603
	for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2009 04:24:49 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n8B9OlRm015721
	for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2009 14:54:48 +0530 (IST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A0071C4@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Current linux-omap kernel boots up fine on 3430 SDP after
> adding Sergio's patch [1], but then I get the following crash
> on the first UART keypress.
> 
> This is new, it used to work okay a little while ago.
> 
> Regards,
> Anand

The crash still exists with current linux-omap kernel.

Disabling CONFIG_FB_OMAP makes the issue go away.

(Only disabled this one option - see diff between .config.old
and .config below)

- Anand

====CUT HERE====

--- .config.old	2009-09-11 14:54:57.000000000 +0530
+++ .config	2009-09-11 14:55:08.000000000 +0530
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.31-rc9-omap1
-# Fri Sep 11 14:54:57 2009
+# Fri Sep 11 14:55:08 2009
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -1154,9 +1154,9 @@ CONFIG_FB=y
 # CONFIG_FIRMWARE_EDID is not set
 # CONFIG_FB_DDC is not set
 # CONFIG_FB_BOOT_VESA_SUPPORT is not set
-CONFIG_FB_CFB_FILLRECT=y
-CONFIG_FB_CFB_COPYAREA=y
-CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_CFB_FILLRECT is not set
+# CONFIG_FB_CFB_COPYAREA is not set
+# CONFIG_FB_CFB_IMAGEBLIT is not set
 # CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
 # CONFIG_FB_SYS_FILLRECT is not set
 # CONFIG_FB_SYS_COPYAREA is not set
@@ -1177,12 +1177,8 @@ CONFIG_FB_CFB_IMAGEBLIT=y
 # CONFIG_FB_METRONOME is not set
 # CONFIG_FB_MB862XX is not set
 # CONFIG_FB_BROADSHEET is not set
-CONFIG_FB_OMAP=y
+# CONFIG_FB_OMAP is not set
 # CONFIG_FB_OMAP_LCD_VGA is not set
-# CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
-# CONFIG_FB_OMAP_LCD_MIPID is not set
-# CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
-CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #

