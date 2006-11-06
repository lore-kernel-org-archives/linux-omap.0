From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Add MMC_CAP_{MULTIWRITE,BYTEBLOCK} flags in omap.c
Date: Mon, 06 Nov 2006 15:22:29 -0400
Message-ID: <454F8B75.5030401@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090502090900090609010402"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com, Tony Lindgren <tony@atomide.com>, Juha Yrjola <juha.yrjola@solidboot.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------090502090900090609010402
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Tony and folks,

Following previous comments from Juha and Pierre, this patch add
MMC_CAP_{MULTIWRITE,BYTEBLOCK} flags in omap.c

BR,

Carlos.

-- 
Carlos Eduardo
Nokia Institute of Technology - INdT
Embedded Linux Laboratory - 10LE
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br


--------------090502090900090609010402
Content-Type: text/plain;
 name="mmc_omap_caps.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_omap_caps.diff"

Add MMC_CAP_{MULTIWRITE,BYTEBLOCK} flags

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>

Index: linux-omap-git/drivers/mmc/omap.c
===================================================================
--- linux-omap-git.orig/drivers/mmc/omap.c	2006-11-06 13:20:29.000000000 -0400
+++ linux-omap-git/drivers/mmc/omap.c	2006-11-06 13:50:28.000000000 -0400
@@ -1088,8 +1088,8 @@ static int __init mmc_omap_probe(struct 
 	mmc->ops = &mmc_omap_ops;
 	mmc->f_min = 400000;
 	mmc->f_max = 24000000;
-	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34 | MMC_CAP_MULTIWRITE
-				| MMC_CAP_BYTEBLOCK;
+	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+	mmc->caps = MMC_CAP_MULTIWRITE | MMC_CAP_BYTEBLOCK;
 
 	if (minfo->wire4)
 		 mmc->caps |= MMC_CAP_4_BIT_DATA;

--------------090502090900090609010402
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090502090900090609010402--
