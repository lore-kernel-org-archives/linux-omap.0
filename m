From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH resend] omap: Fix linker error in
 drivers/video/omap/lcd_2430sdp.c
Date: Mon, 28 Feb 2011 16:47:15 +0200
Message-ID: <20110228164715.e34a965e.jhnikula@gmail.com>
References: <1298193466-29534-1-git-send-email-jhnikula@gmail.com>
	<1298232248-347-1-git-send-email-jhnikula@gmail.com>
	<20110224212644.GN20560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44346 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754245Ab1B1OqD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 09:46:03 -0500
Received: by eyx24 with SMTP id 24so1308788eyx.19
        for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 06:46:02 -0800 (PST)
In-Reply-To: <20110224212644.GN20560@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Thu, 24 Feb 2011 13:26:44 -0800
Tony Lindgren <tony@atomide.com> wrote:

> We should avoid selecting driver related things, otherwise we can never
> build a tiny kernel with initramfs with everything as modules.
> 
> Can you see if adding depends to the LCD panel option does the trick
> instead?
> 
True and as lcd_2430sdp.c is not compiled without CONFIG_FB_OMAP a hack
below should work a bit better.

What would you think Tomi?

diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
index 083c8fe..c981249 100644
--- a/drivers/video/omap/Kconfig
+++ b/drivers/video/omap/Kconfig
@@ -5,6 +5,7 @@ config FB_OMAP
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select TWL4030_CORE if MACH_OMAP_2430SDP
 	help
           Frame buffer driver for OMAP based boards.

-- 
Jarkko
