From: Marek =?iso-8859-2?q?Va=B9ut?= <marek.vasut@gmail.com>
Subject: [PATCH] PalmZ71 extra brace fix
Date: Sat, 28 Oct 2006 20:35:28 +0200
Message-ID: <200610282035.28310.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wL6QFvi5NVTDNR4"
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

--Boundary-00=_wL6QFvi5NVTDNR4
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
there is one extra brace in z71 board file, this patch fixes it.

Signed-off-by: Marek Va=B9ut <marek.vasut@gmail.com>

--Boundary-00=_wL6QFvi5NVTDNR4
Content-Type: text/x-diff; charset="us-ascii";
	name="palmz71-board-extra-brace-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="palmz71-board-extra-brace-fix.patch"

--- linux-omap-dev/arch/arm/mach-omap1/board-palmz71.c	2006-10-28 01:36:48.000000000 +0200
+++ linux-omap/arch/arm/mach-omap1/board-palmz71.c	2006-10-28 20:07:30.000000000 +0200
@@ -251,7 +251,7 @@
 	.get_pendown_state	= palmz71_get_pendown_state,
 };
 
-static struct spi_board_info __initdata palmz71_boardinfo[] = { {
+static struct spi_board_info __initdata palmz71_boardinfo[] = {
 {
 	/* MicroWire (bus 2) CS0 has an ads7846e */
 	.modalias	= "ads7846",

--Boundary-00=_wL6QFvi5NVTDNR4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_wL6QFvi5NVTDNR4--
