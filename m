From: "Maksim A. Boyko" <maksim.a.boyko@gmail.com>
Subject: n810 video
Date: Sat, 30 Oct 2010 12:40:53 +0400
Message-ID: <AANLkTinV0PK=77MYkVQF2RRG4g2w_U==pbiO++j7jst-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52416 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275Ab0J3Ikz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Oct 2010 04:40:55 -0400
Received: by iwn10 with SMTP id 10so4749250iwn.19
        for <linux-omap@vger.kernel.org>; Sat, 30 Oct 2010 01:40:55 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I try to switch on "OMAP2/3 Display Subsystem Support" and "Omap frame
buffer support" on n810  (commit 8b4b01).

In OMAP2/3 Display Subsystem Support I used:
CONFIG_OMAP2_VRAM_SIZE=4
CONFIG_OMAP2_DSS_DEBUG_SUPPORT=y
CONFIG_OMAP2_DSS_DPI=y
CONFIG_OMAP2_DSS_VENC=y
CONFIG_PANEL_GENERIC=y

In Omap frame buffer support I used:
CONFIG_FB=y
CONFIG_FB_OMAP_LCDC_EXTERNAL=y
CONFIG_FB_OMAP_LCDC_BLIZZARD=y
CONFIG_FB_OMAP_LCD_MIPID=y
CONFIG_FB_OMAP_BOOTLOADER_INIT=y
CONFIG_FB_OMAP=y
CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2

I create fb device:
#mknod /dev/fb0 c 29 0
#chgrp video  /dev/fb0
#chmod 660  /dev/fb0

But XServer 1.7.7-8 from debian squeeze armel don't work in both
cases. Tail of Xorg.0.log

(II) LoadModule: "omapfb"
(II) Loading /usr/lib/xorg/modules/drivers/omapfb_drv.so
(II) Module omapfb: vendor="X.Org Foundation"
        compiled for 1.7.4, module version = 0.1.1
        ABI class: X.Org Video Driver, version 6.0
(II) omapfb: Driver for OMAP framebuffer (omapfb) and external LCD controllers:
        omap1/2/3, S1D13745, HWA742
(WW) Falling back to old probe method for OMAPFB
(WW) Could not open '/dev/fb0': No such device or address(EE) No
devices detected

How to correct enable support video on n810?

Thanks.

-- 
Best regards, Maksim A. Boyko
