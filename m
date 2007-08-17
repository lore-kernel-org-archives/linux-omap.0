From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [09/17 PATCH] MMC: OMAP: Using correct MMC_VDD flags of low-voltage
 cards.
Date: Fri, 17 Aug 2007 15:02:05 -0400
Message-ID: <46C5F0AD.2030802@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000801080709040109050902"
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
To: Tony Lindgren <tony@atomide.com>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------000801080709040109050902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Using correct MMC_VDD flags of low-voltage cards, according with commit
55556da01284af8c2174b786b3eca8e11301b656.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: Philip Langdale <philipl@overt.org>

--------------000801080709040109050902
Content-Type: text/plain;
	name="0009-MMC-OMAP-Using-correct-voltage-definitions.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0009-MMC-OMAP-Using-correct-voltage-definitions.diff"

Using correct MMC_VDD flags of low-voltage cards, according with commit
55556da01284af8c2174b786b3eca8e11301b656.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: Philip Langdale <philipl@overt.org>

Index: linux-omap/arch/arm/mach-omap2/board-n800-mmc.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/board-n800-mmc.c	2007-08-13 13:05:04.000000000 -0400
+++ linux-omap/arch/arm/mach-omap2/board-n800-mmc.c	2007-08-14 12:09:48.000000000 -0400
@@ -64,7 +64,7 @@ static int n800_mmc_set_power(struct dev
 		case MMC_VDD_28_29:
 			mV = 2800;
 			break;
-		case MMC_VDD_18_19:
+		case MMC_VDD_165_195:
 			mV = 1850;
 			break;
 		default:
@@ -96,17 +96,11 @@ static int n800_mmc_set_power(struct dev
 			mV = 2200;
 			break;
 		case MMC_VDD_20_21:
-		case MMC_VDD_19_20:
 			mV = 2000;
 			break;
-		case MMC_VDD_18_19:
-		case MMC_VDD_17_18:
+		case MMC_VDD_165_195:
 			mV = 1800;
 			break;
-		case MMC_VDD_150_155:
-		case MMC_VDD_145_150:
-			mV = 1500;
-			break;
 		default:
 			BUG();
 		}
@@ -235,7 +229,7 @@ static struct omap_mmc_platform_data n80
 		.set_bus_mode	= n800_mmc_set_bus_mode,
 		.get_ro		= NULL,
 		.get_cover_state= n800_mmc_get_cover_state,
-		.ocr_mask	= MMC_VDD_18_19 | MMC_VDD_28_29 | MMC_VDD_30_31 |
+		.ocr_mask	= MMC_VDD_165_195 | MMC_VDD_28_29 | MMC_VDD_30_31 |
 				  MMC_VDD_32_33 | MMC_VDD_33_34,
 		.name		= "internal",
 	},
@@ -244,12 +238,10 @@ static struct omap_mmc_platform_data n80
 		.set_bus_mode	= n800_mmc_set_bus_mode,
 		.get_ro		= NULL,
 		.get_cover_state= n800_mmc_get_cover_state,
-		.ocr_mask	= MMC_VDD_150_155 | MMC_VDD_145_150 | MMC_VDD_17_18 |
-				  MMC_VDD_18_19 | MMC_VDD_19_20 | MMC_VDD_20_21 |
-				  MMC_VDD_21_22 | MMC_VDD_22_23 | MMC_VDD_23_24 |
-				  MMC_VDD_24_25 | MMC_VDD_27_28 | MMC_VDD_28_29 |
-				  MMC_VDD_29_30 | MMC_VDD_30_31 | MMC_VDD_32_33 |
-				  MMC_VDD_33_34,
+		.ocr_mask	= MMC_VDD_165_195 | MMC_VDD_20_21 | MMC_VDD_21_22 |
+				  MMC_VDD_22_23 | MMC_VDD_23_24 | MMC_VDD_24_25 |
+				  MMC_VDD_27_28 | MMC_VDD_28_29 | MMC_VDD_29_30 |
+				  MMC_VDD_30_31 | MMC_VDD_32_33 | MMC_VDD_33_34,
 		.name		= "external",
 	},
 };

--------------000801080709040109050902
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000801080709040109050902--
