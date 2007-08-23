From: Trilok Soni <trilok_soni@yahoo.co.in>
Subject: Re: [PATCH 2/2] ov9640: Add H4 board entries for platform data.
Date: Thu, 23 Aug 2007 05:31:14 -0700 (PDT)
Message-ID: <363692.6770.qm@web8504.mail.in.yahoo.com>
References: <5d5443650708180137g4258d331se0fb53bceecedc08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-997888109-1187872274=:6770"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <5d5443650708180137g4258d331se0fb53bceecedc08@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
Cc: Sakari Ailus <sakari.ailus@nokia.com>
List-Id: linux-omap@vger.kernel.org

--0-997888109-1187872274=:6770
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,
--- Trilok Soni <soni.trilok@gmail.com> wrote:

> -- 
> --Trilok Soni
> > From b13634e7f7534523851df7cc5c108cf340240a4b Mon
> Sep 17 00:00:00 2001
> From: Trilok Soni <soni.trilok@gmail.com>
> Date: Fri, 17 Aug 2007 21:28:54 +0530
> Subject: [PATCH 2/2] ov9640: Add H4 board entries
> for platform data.
> 

Attached incremental patch with v4l2_ifparm pdata
support for H4 with ov9640.

---Trilok Soni


       
____________________________________________________________________________________
Take the Internet to Go: Yahoo!Go puts the Internet in your pocket: mail, news, photos & more. 
http://mobile.yahoo.com/go?refer=1GNXIC
--0-997888109-1187872274=:6770
Content-Type: text/x-patch;
	name="0002-ov9640-Add-v4l2_ifparm-platform-data-in-board-h4.c.patch"
Content-Description: 273520847-0002-ov9640-Add-v4l2_ifparm-platform-data-in-board-h4.c.patch
Content-Disposition: inline;
	filename="0002-ov9640-Add-v4l2_ifparm-platform-data-in-board-h4.c.patch"

>From b97cbdfb3bf8f1d73a422888bf491a1afccd8272 Mon Sep 17 00:00:00 2001
From: Trilok Soni <soni.trilok@gmail.com>
Date: Wed, 22 Aug 2007 17:07:31 +0530
Subject: [PATCH] ov9640: Add v4l2_ifparm platform data in board-h4.c

Signed-off-by: Trilok Soni <soni.trilok@gmail.com>
---
 arch/arm/mach-omap2/board-h4.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 3844825..e9957ac 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -25,6 +25,8 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/tsc210x.h>
 
+#include <media/v4l2-int-device.h>
+
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -621,13 +623,33 @@ static int ov9640_sensor_power_set(int power)
 
 	return err;
 }
+
+static struct v4l2_ifparm ifparm = {
+	.if_type = V4L2_IF_TYPE_PARALLEL,
+	.u = {
+		.parallel = {
+			 .frame_start_on_rising_vs = 1,
+			 .nobt_vs_inv = 1,
+			 .mode = V4L2_IF_TYPE_PARALLEL_MODE_NOBT_8BIT,
+		 },
+	},
+};
+
+static int ov9640_ifparm(struct v4l2_ifparm *p)
+{
+	*p = ifparm;
+
+	return 0;
+}
 #else
 static int ov9640_sensor_power_set(int power) { return 0; }
+static int ov9640_ifparm(struct v4l2_ifparm *p) { return 0; }
 #endif
 
 static struct ov9640_platform_data h4_ov9640_platform_data = {
-	.power_set = ov9640_sensor_power_set,
-	.default_regs = ov9640_common,
+	.power_set	= ov9640_sensor_power_set,
+	.default_regs	= ov9640_common,
+	.ifparm		= ov9640_ifparm,
 };
 
 static struct i2c_board_info __initdata h4_i2c_board_info[] = {
-- 
1.5.0


--0-997888109-1187872274=:6770
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-997888109-1187872274=:6770--
