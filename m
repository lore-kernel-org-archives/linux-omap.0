From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: [patch 4/6] [RFC] Add MMC Password Protection (lock/unlock) support
 V6
Date: Fri, 17 Nov 2006 09:11:40 -0400
Message-ID: <455DB50C.3020209@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060409040509020606070903"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933585AbWKQNK1@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
Cc: linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>, ext David Brownell <david-b@pacbell.net>, Russell King <rmk+lkml@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>, "Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------060409040509020606070903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

OMAP platform specific patch.
- Add the host MMC lock/unlock capability support.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo <at> indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>

Index: linux-omap-2.6.git/drivers/mmc/omap.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/omap.c	2006-11-16 15:35:19.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/omap.c	2006-11-17 09:05:47.000000000 -0400
@@ -1094,6 +1094,9 @@ static int __init mmc_omap_probe(struct
  	if (minfo->wire4)
  		 mmc->caps |= MMC_CAP_4_BIT_DATA;

+	/* Sets the lock/unlock capability */
+	host->mmc->caps |= MMC_CAP_LOCK_UNLOCK;
+
  	/* Use scatterlist DMA to reduce per-transfer costs.
  	 * NOTE max_seg_size assumption that small blocks aren't
  	 * normally used (except e.g. for reading SD registers).


--------------060409040509020606070903
Content-Type: text/x-patch;
 name="mmc_omap_cap.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_omap_cap.diff"

OMAP platform specific patch.
- Add the host MMC lock/unlock capability support.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo <at> indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>

Index: linux-omap-2.6.git/drivers/mmc/omap.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/omap.c	2006-11-16 15:35:19.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/omap.c	2006-11-17 09:05:47.000000000 -0400
@@ -1094,6 +1094,9 @@ static int __init mmc_omap_probe(struct 
 	if (minfo->wire4)
 		 mmc->caps |= MMC_CAP_4_BIT_DATA;
 
+	/* Sets the lock/unlock capability */
+	host->mmc->caps |= MMC_CAP_LOCK_UNLOCK;
+
 	/* Use scatterlist DMA to reduce per-transfer costs.
 	 * NOTE max_seg_size assumption that small blocks aren't
 	 * normally used (except e.g. for reading SD registers).

--------------060409040509020606070903--
