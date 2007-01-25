From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH] MMC: OMAP R6 response support
Date: Thu, 25 Jan 2007 09:55:37 -0400
Message-ID: <45B8B6D9.90006@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050300000601090106010903"
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
To: Pierre Ossman <drzeus-list@drzeus.cx>, Tony Lindgren <tony@atomide.com>, Juha Yrjola <juha.yrjola@solidboot.com>, "linux- >> omap-linux" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------050300000601090106010903
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi folks,

Regarding the commit below

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=6f949909e8f9e5d7e5584dc48d9a5e060c52aed1
,

the definition of response type R6 is the same as R1 and case
MMC_RSP_R6 was removed on omap.c, causing a error when inserting a SD
card on OMAP platforms.

This error occur due following the MMC and SD specs, on CMD3, response
type is R6 to SD cards and R1 to MMC cards.

So, I'm proposing a patch that try to solve this problem. I've tested
it with SD and MMC cards and looks fine.

Please, comments and suggestions are welcome.

BR,

Carlos.

-- 
Carlos Eduardo
Nokia Institute of Technology - INdT
Open Source Mobile Research Center - OSMRC
E-mail: carlos.aguiar@indt.org.br


--------------050300000601090106010903
Content-Type: text/plain;
 name="omap_r6.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap_r6.diff"

On CMD3, response type is R6 to SD cards and R1 to MMC cards.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Index: linux-omap/drivers/mmc/omap.c
===================================================================
--- linux-omap.orig/drivers/mmc/omap.c	2007-01-24 16:02:58.000000000 -0400
+++ linux-omap/drivers/mmc/omap.c	2007-01-25 09:31:40.000000000 -0400
@@ -209,8 +209,13 @@ mmc_omap_start_command(struct mmc_omap_h
 		break;
 	case MMC_RSP_R1:
 	case MMC_RSP_R1B:
-		/* resp 1, resp 1b */
-		resptype = 1;
+		if ((host->mmc->mode == MMC_MODE_SD) &&
+			(host->cmd->opcode == SD_SEND_RELATIVE_ADDR))
+			/* resp 6 */
+			resptype = 6;
+		else
+			/* resp 1, 1b, 7 */
+			resptype = 1;
 		break;
 	case MMC_RSP_R2:
 		resptype = 2;

--------------050300000601090106010903
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050300000601090106010903--
