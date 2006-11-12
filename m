From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH] board-nokia770: correct lcd name
Date: Sun, 12 Nov 2006 15:31:30 +0100
Message-ID: <858xig3fel.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
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

--=-=-=

Hi, 

(Sorry, I forgot to send this patch while sending the others)

Some time ago, the 'lcd_lph8923' device was renamed to 'lcd_mipid' but
the board-nokia770.c file was not updated accordingly, leading to not
working lcd.
This one-liner fixe the trouble.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
---


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=n770_correct_lcd_name.patch

---
 arch/arm/mach-omap1/board-nokia770.c |    2 	1 +	1 -	0 !
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-omap-2.6/arch/arm/mach-omap1/board-nokia770.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap1/board-nokia770.c	2006-11-12 15:15:27.000000000 +0100
+++ linux-omap-2.6/arch/arm/mach-omap1/board-nokia770.c	2006-11-12 15:16:21.000000000 +0100
@@ -146,7 +146,7 @@ static struct ads7846_platform_data noki
 
 static struct spi_board_info nokia770_spi_board_info[] __initdata = {
 	[0] = {
-		.modalias       = "lcd_lph8923",
+		.modalias       = "lcd_mipid",
 		.bus_num        = 2,
 		.chip_select    = 3,
 		.max_speed_hz   = 12000000,

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-=-=--
