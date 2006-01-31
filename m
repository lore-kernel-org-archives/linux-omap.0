From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [patch 5/6] Add MMC password protection (lock/unlock) support V4
Date: Tue, 31 Jan 2006 16:16:41 -0400
Message-ID: <20060131202547.535444000@localhost.localdomain>
References: <20060131201636.264543000@localhost.localdomain>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=mmc_omap_blklen.diff
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-kernel@vger.kernel.org, "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux@arm.linux.org.uk, "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>
List-Id: linux-omap@vger.kernel.org

The MMC_LOCK_UNLOCK command requires the block length to be exactly the
password length + 2 bytes, but hardware-specific drivers force a "power of 2"
block size.

This patch sends the exact block size (password + 2 bytes) to the host. OMAP
specific.

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Index: linux-omap-2.6.git/drivers/mmc/omap.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/omap.c	2006-01-31 15:17:44.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/omap.c	2006-01-31 15:22:33.000000000 -0400
@@ -888,8 +888,12 @@ mmc_omap_prepare_data(struct mmc_omap_ho
 		return;
 	}
 
-
-	block_size = 1 << data->blksz_bits;
+	/*  password protection: we need to send the exact block size to the
+	 *  card (password + 2), not a 2-exponent. */
+	if (req->cmd->opcode == MMC_LOCK_UNLOCK)
+		block_size = data->sg[0].length;
+	else
+		block_size = 1 << data->blksz_bits;
 
 	OMAP_MMC_WRITE(host->base, NBLK, data->blocks - 1);
 	OMAP_MMC_WRITE(host->base, BLEN, block_size - 1);

--
