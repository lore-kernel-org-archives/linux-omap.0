From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: [patch 5/5] Add MMC password protection (lock/unlock) support
Date: Tue, 13 Dec 2005 18:49:57 -0400
Message-ID: <439F5015.7060900@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050105010103030201040508"
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
To: "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
Cc: "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------050105010103030201040508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



--------------050105010103030201040508
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

Index: linux-2.6.14-omap2/drivers/mmc/omap.c
===================================================================
--- linux-2.6.14-omap2.orig/drivers/mmc/omap.c	2005-12-09 11:31:50.000000000 -0400
+++ linux-2.6.14-omap2/drivers/mmc/omap.c	2005-12-12 14:56:08.000000000 -0400
@@ -891,8 +891,12 @@ mmc_omap_prepare_data(struct mmc_omap_ho
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
Anderson Briglia,
Anderson Lizardo,
Carlos Eduardo Aguiar

Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil



--------------050105010103030201040508
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050105010103030201040508--
