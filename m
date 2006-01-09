From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: [patch 5/5] Add MMC password protection (lock/unlock) support V3
Date: Mon, 09 Jan 2006 18:17:10 -0400
Message-ID: <43C2E0E6.30600@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050803020203070408050701"
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
To: linux-kernel@vger.kernel.org, "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
Cc: linux@arm.linux.org.uk, "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>, drzeus-list@drzeus.cx
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------050803020203070408050701
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit







--------------050803020203070408050701
Content-Type: text/x-patch;
 name="mmc_omap_blklen.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_omap_blklen.diff"

The MMC_LOCK_UNLOCK command requires the block length to be exactly the
password length + 2 bytes, but hardware-specific drivers force a "power of 2"
block size.

This patch sends the exact block size (password + 2 bytes) to the host. OMAP
specific.

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Index: linux-2.6.15-rc4/drivers/mmc/omap.c
===================================================================
--- linux-2.6.15-rc4.orig/drivers/mmc/omap.c	2005-12-27 17:42:49.000000000 -0400
+++ linux-2.6.15-rc4/drivers/mmc/omap.c	2005-12-27 17:43:57.000000000 -0400
@@ -889,8 +889,12 @@ mmc_omap_prepare_data(struct mmc_omap_ho
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

--------------050803020203070408050701
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050803020203070408050701--
