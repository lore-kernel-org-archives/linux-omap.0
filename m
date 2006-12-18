From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [RFC][PATCH] Update MMC response types
Date: Mon, 18 Dec 2006 11:34:34 -0400
Message-ID: <4586B50A.9030700@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020606020307080803060408"
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
To: Tony Lindgren <tony@atomide.com>, Juha Yrjola <juha.yrjola@solidboot.com>, Pierre Ossman <drzeus-list@drzeus.cx>, linux-omap-open-source@linux.omap.com
Cc: Ilias Biris <ilias.biris@indt.org.br>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------020606020307080803060408
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi folks,

This patch is a fix in order to update MMC response types. This modification
is needed to allow SD card support in OMAP platforms.

It's based on previously work from Juha Yrjola.

This modification was tested in H2 and H3 OMAP platforms using an
Transcend SD card 512MB.

BR,

Carlos.

-- 
Carlos Eduardo
Software Engineer
Nokia Institute of Technology - INdT
Open Source Mobile Research Center - OSMRC
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br


--------------020606020307080803060408
Content-Type: text/plain;
 name="mmc_rsp.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_rsp.diff"

This patch is a fix in order to update MMC response types. This modification is 
needed to allow SD card support on OMAP platforms.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: Yuha Yrjola <juha.yrjola@solidboot.com>

Index: linux-omap-git/drivers/mmc/omap.c
===================================================================
--- linux-omap-git.orig/drivers/mmc/omap.c	2006-11-24 09:45:44.000000000 -0400
+++ linux-omap-git/drivers/mmc/omap.c	2006-12-18 06:02:53.000000000 -0400
@@ -92,7 +92,6 @@
 
 
 #define DRIVER_NAME "mmci-omap"
-#define RSP_TYPE(x)	((x) & ~(MMC_RSP_BUSY|MMC_RSP_OPCODE))
 
 /* Specifies how often in millisecs to poll for card status changes
  * when the cover switch is open */
@@ -205,18 +204,25 @@ mmc_omap_start_command(struct mmc_omap_h
 	cmdtype = 0;
 
 	/* Our hardware needs to know exact type */
-	switch (RSP_TYPE(mmc_resp_type(cmd))) {
-	case RSP_TYPE(MMC_RSP_R1):
+	switch (mmc_resp_type(cmd)) {
+	case MMC_RSP_NONE:
+		break;
+	case MMC_RSP_R1:
+	case MMC_RSP_R1B:
 		/* resp 1, resp 1b */
 		resptype = 1;
 		break;
-	case RSP_TYPE(MMC_RSP_R2):
+	case MMC_RSP_R2:
 		resptype = 2;
 		break;
-	case RSP_TYPE(MMC_RSP_R3):
+	case MMC_RSP_R3:
 		resptype = 3;
 		break;
+	case MMC_RSP_R6:
+		resptype = 6;
+		break;
 	default:
+		dev_err(mmc_dev(host->mmc), "Invalid response type: %04x\n", mmc_resp_type(cmd));
 		break;
 	}
 

--------------020606020307080803060408
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020606020307080803060408--
