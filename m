From: Jonathan McDowell <noodles@earth.li>
Subject: [PATCH] ARM: OMAP: Fix lcd_ams_delta to use new PWL defines
Date: Fri, 4 Aug 2006 14:20:35 +0100
Message-ID: <20060804132035.GG17406@earth.li>
References: <20060803111721.GH8661@atomide.com>
	<20060803120858.53676.qmail@web37909.mail.mud.yahoo.com>
	<20060804110530.GC26416@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jozmn01XJZjDjM3N"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060804110530.GC26416@atomide.com>
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


--jozmn01XJZjDjM3N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 04, 2006 at 02:05:31PM +0300, Tony Lindgren wrote:
 
> I've pushed some patches. Does anybody else have patches that should go in
> before I tag 2.6.17-omap2?

The attached is necessary to move the Amstrad Delta LCD driver over to
the new PWL defines that have been pushed.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

J.

-- 
/-\                             |   noodles is a quick meal that is
|@/  Debian GNU/Linux Developer |               healthy
\-                              |

--jozmn01XJZjDjM3N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ams-delta-lcd-pwl-fix.diff"

--- drivers/video/omap/lcd_ams_delta.c.orig	2006-08-04 14:16:22.000000000 +0100
+++ drivers/video/omap/lcd_ams_delta.c	2006-08-04 14:17:59.000000000 +0100
@@ -29,7 +29,7 @@
 #include <asm/io.h>
 
 #include <asm/arch/board-ams-delta.h>
-#include <asm/arch/omap16xx.h>
+#include <asm/arch/hardware.h>
 #include <asm/arch/omapfb.h>
 
 #define AMS_DELTA_DEFAULT_CONTRAST	112
@@ -51,8 +51,8 @@ static int ams_delta_panel_enable(struct
 	ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_VBLEN,
 			AMS_DELTA_LATCH2_LCD_VBLEN);
 
-	omap_writeb(1, OMAP16XX_PWL_CLK_ENABLE);
-	omap_writeb(AMS_DELTA_DEFAULT_CONTRAST, OMAP16XX_PWL_ENABLE);
+	omap_writeb(1, OMAP_PWL_CLK_ENABLE);
+	omap_writeb(AMS_DELTA_DEFAULT_CONTRAST, OMAP_PWL_ENABLE);
 
 	return 0;
 }

--jozmn01XJZjDjM3N
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--jozmn01XJZjDjM3N--
