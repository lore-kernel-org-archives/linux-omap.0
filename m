From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Fix for dispc's error "omapfb omapfb: irq error status 4020"
Date: Thu, 13 Nov 2008 16:06:32 +0200
Message-ID: <1226585192.32348.3.camel@tubuntu>
References: <E1KyYMw-0003Ob-5e@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23651 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbYKMOGk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 09:06:40 -0500
In-Reply-To: <E1KyYMw-0003Ob-5e@amazonia.comcast.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rick@efn.org
Cc: imre.deak@nokia.com, linux-omap@vger.kernel.org

Hi,

On Fri, 2008-11-07 at 12:55 -0800, ext Rick Bronson wrote:
> Folks,
> 
>   Please take a look at this change to drivers/video/omap/dispc.c.  It
> addresses a problem seen on some boots of OMAP's.  On about 1 in 30
> boots one gets an endless stream of interrupts from the
> DISPC_IRQ_SYNC_LOST bit in the DISPC_IRQSTATUS register.  The
> following messages are printed.
> 
>  omapfb omapfb: irq error status 4020

Can you try the patch below if it fixes this problem for you? On my new
display subsystem adding a sleep between enabling clocks and doing the
soft reset removed the problem.

I tried a bit with different sleep times. With 1ms sleep I still got
sync losts. With 10ms I didn't, but I went safe and put 40ms.

 Tomi



diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index c140c21..bdfda0c 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -24,6 +24,7 @@
 #include <linux/vmalloc.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/delay.h>
 
 #include <mach/sram.h>
 #include <mach/omapfb.h>
@@ -1402,6 +1403,10 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
                /* Reset monitoring works only w/ the 54M clk */
                enable_digit_clocks(1);
 
+               /* We need to wait here a bit, otherwise we sometimes start to get
+                * synclost errors. */
+               msleep(40);
+
                /* Soft reset */
                MOD_REG_FLD(DISPC_SYSCONFIG, 1 << 1, 1 << 1);


