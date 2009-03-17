From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] ARM: OMAP2: possible division by 0
Date: Tue, 17 Mar 2009 12:43:40 +0100
Message-ID: <49BF8CEC.1000901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: rmk+kernel@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Linux-arm <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

In linus' git tree the functions can be found at:
vi arch/arm/mach-omap2/usb-tusb6010.c +200	- tusb6010_platform_retime()
vi arch/arm/mach-omap2/gpmc.c +94		- gpmc_get_fclk_period()
vi arch/arm/mach-omap2/usb-tusb6010.c +53	- tusb_set_async_mode()
vi arch/arm/mach-omap2/usb-tusb6010.c +111	- tusb_set_sync_mode()

is -ENODEV appropriate when sysclk_ps == 0?

This was found by code analysis, please review.
------------------------------>8-------------8<---------------------------------
gpmc_get_fclk_period() may return 0 when gpmc_l3_clk is not enabled. This is
not checked in tusb6010_platform_retime() nor in tusb_set_async_mode() it
seems. In tusb_set_sync_mode() this may result in a division by zero.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index 15e5090..8df55f4 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -187,7 +187,7 @@ int tusb6010_platform_retime(unsigned is_refclk)
 	unsigned	sysclk_ps;
 	int		status;
 
-	if (!refclk_psec)
+	if (!refclk_psec || sysclk_ps == 0)
 		return -ENODEV;
 
 	sysclk_ps = is_refclk ? refclk_psec : TUSB6010_OSCCLK_60;

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
