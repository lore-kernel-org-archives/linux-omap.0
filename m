From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix section mismatch in board-n800.c
Date: Sat, 19 May 2007 17:12:53 +0200
Message-ID: <464F13F5.6050404@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000202060304020504030702"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

This is a multi-part message in MIME format.
--------------000202060304020504030702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix section mismatch in board-n800.c

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------000202060304020504030702
Content-Type: text/plain;
 name="fix_section_mismatch_board_n800.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_section_mismatch_board_n800.txt"

Index: linux-osk/arch/arm/mach-omap2/board-n800.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap2/board-n800.c
+++ linux-osk/arch/arm/mach-omap2/board-n800.c
@@ -285,7 +285,7 @@ static inline void n800_cam_init(void) {
 
 #endif
 
-static struct omap_board_config_kernel n800_config[] = {
+static struct omap_board_config_kernel n800_config[] __initdata = {
 	{ OMAP_TAG_UART,	                &n800_uart_config },
 #ifdef SUPPORT_SENSOR
 	{ OMAP_TAG_CAMERA_SENSOR,		&n800_sensor_config },

--------------000202060304020504030702
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000202060304020504030702--
