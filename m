From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.21-rc5-omap1-git] fix OMAP1 mpuio suspend/resume oops
Date: Mon, 2 Apr 2007 12:46:47 -0700
Message-ID: <200704021246.47873.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Fix oops in omap16xx mpuio suspend/resume code; field wasn't initialized 

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- osk2.orig/arch/arm/plat-omap/gpio.c	2007-04-01 09:46:56.000000000 -0700
+++ osk2/arch/arm/plat-omap/gpio.c	2007-04-01 22:13:35.000000000 -0700
@@ -1178,6 +1178,8 @@ static struct platform_device omap_mpuio
 
 static inline void mpuio_init(void)
 {
+	platform_set_drvdata(&omap_mpuio_device, &gpio_bank_1610[0]);
+
 	if (platform_driver_register(&omap_mpuio_driver) == 0)
 		(void) platform_device_register(&omap_mpuio_device);
 }
