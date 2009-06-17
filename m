From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] i2c-omap: Fix build breaking typo cpu_is_omap_2430
Date: Wed, 17 Jun 2009 03:20:21 -0700
Message-ID: <20090617102020.GJ6605@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ben,

Can you please queue this fix?

Thanks,

Tony

--vtzGhvizbBRQ85DL
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="i2c-omap-fix.patch"

>From ffe2b2cdf6283770b70a197e3748c6b40a1006be Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Date: Wed, 17 Jun 2009 13:14:23 +0300
Subject: [PATCH] i2c-omap: Fix build breaking typo in cpu_is_omap_2430

Commit 84bf2c86 introduced a typo, it should be cpu_is_omap2430
instead. The typo was probably caused by a mismerge.

Without this patch all omaps fail to build with:
error: implicit declaration of function 'cpu_is_omap_2430'

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index b606db8..ad8d201 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -339,7 +339,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 		 * to get longer filter period for better noise suppression.
 		 * The filter is iclk (fclk for HS) period.
 		 */
-		if (dev->speed > 400 || cpu_is_omap_2430())
+		if (dev->speed > 400 || cpu_is_omap2430())
 			internal_clk = 19200;
 		else if (dev->speed > 100)
 			internal_clk = 9600;

--vtzGhvizbBRQ85DL--
