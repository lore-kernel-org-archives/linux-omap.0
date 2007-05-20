From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix section mismatch in board-2430sdp.c
Date: Sun, 20 May 2007 09:50:27 +0200
Message-ID: <464FFDC3.8040301@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050505050005080805020506"
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
--------------050505050005080805020506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix section mismatch in board-2430sdp.c

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------050505050005080805020506
Content-Type: text/plain;
 name="fix_section_mismatch_board_2430sdp.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="fix_section_mismatch_board_2430sdp.txt"

Index: linux-osk/arch/arm/mach-omap2/board-2430sdp.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap2/board-2430sdp.c
+++ linux-osk/arch/arm/mach-omap2/board-2430sdp.c
@@ -276,7 +276,7 @@ static struct omap_uart_config sdp2430_u
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
-static struct omap_board_config_kernel sdp2430_config[] = {
+static struct omap_board_config_kernel sdp2430_config[] __initdata = {
 	{OMAP_TAG_UART, &sdp2430_uart_config},
 };
 


--------------050505050005080805020506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050505050005080805020506--
