From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [patch 6/6] Add MMC password protection (lock/unlock) support V4
Date: Tue, 31 Jan 2006 16:16:42 -0400
Message-ID: <20060131202549.458006000@localhost.localdomain>
References: <20060131201636.264543000@localhost.localdomain>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751457AbWAaU0X@vger.kernel.org>
Content-Disposition: inline; filename=mmc_omap_cap.diff
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
Cc: linux@arm.linux.org.uk, David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Russell King <rmk+lkml@arm.linux.org.uk>, "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>, "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>, Anderson Briglia <anderson.briglia@indt.org.br>
List-Id: linux-omap@vger.kernel.org

Patch to add the host MMC lock/unlock capability support for OMAP platform.

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Index: linux-omap-2.6.git/drivers/mmc/omap.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/omap.c	2006-01-31 15:22:33.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/omap.c	2006-01-31 15:22:36.000000000 -0400
@@ -1235,6 +1235,9 @@ static int __init mmc_omap_probe(struct 
 
 	 if (minfo->wire4)
 		 mmc->caps |= MMC_CAP_4_BIT_DATA;
+	
+	/* Sets the lock/unlock capability */
+	host->mmc->caps |= MMC_CAP_LOCK_UNLOCK;
 
 	mmc->ops = &mmc_omap_ops;
 	mmc->f_min = 400000;

--
