From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH] omap-hw: Fix build breakage
Date: Tue, 31 Oct 2006 13:45:02 +0100
Message-ID: <85odrspsc1.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
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

--=-=-=

Hi,

I've noticed that the omap-hw driver was never updated to take into
account the mtd changes. As the driver is afaik neither in the mtd tree
nor in Linus, I'm sending it there.
I've only brieftly tested it. It builds, detects my nand and allow me to
read my datas but as the changes are pretty simple, it should be fine.


Regards,
Arnaud Patard


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=nand_breakage_fix.patch

Update the omap-hw to take into account the "recent" changes in the mtd layer.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
---
 drivers/mtd/nand/omap-hw.c |   45 	24 +	21 -	0 !
 1 file changed, 24 insertions(+), 21 deletions(-)

Index: linux-omap-2.6/drivers/mtd/nand/omap-hw.c
===================================================================
--- linux-omap-2.6.orig/drivers/mtd/nand/omap-hw.c	2006-10-16 22:10:42.000000000 +0200
+++ linux-omap-2.6/drivers/mtd/nand/omap-hw.c	2006-10-16 22:12:02.000000000 +0200
@@ -425,9 +425,9 @@ static void omap_nand_command(struct mtd
 	if (command == NAND_CMD_SEQIN) {
 		int readcmd;
 
-		if (column >= mtd->oobblock) {
+		if (column >= mtd->writesize) {
 			/* OOB area */
-			column -= mtd->oobblock;
+			column -= mtd->writesize;
 			readcmd = NAND_CMD_READOOB;
 		} else if (column < 256) {
 			/* First 256 bytes --> READ0 */
@@ -458,7 +458,7 @@ static void omap_nand_command_lp(struct 
 	struct nand_chip *this = mtd->priv;
 
 	if (command == NAND_CMD_READOOB) {
-		column += mtd->oobblock;
+		column += mtd->writesize;
 		command = NAND_CMD_READ0;
 	}
 	switch (command) {
@@ -495,7 +495,8 @@ static int omap_nand_calculate_ecc(struc
 	int n;
 	struct nand_chip *this = mtd->priv;
 
-	if (this->eccmode == NAND_ECC_HW12_2048)
+	/* Ex NAND_ECC_HW12_2048 */
+	if ((this->ecc.mode == NAND_ECC_HW) && (this->ecc.size  == 2048))
 		n = 4;
 	else
 		n = 1;
@@ -642,7 +643,8 @@ static int omap_nand_correct_data(struct
 	int block_count = 0, i, r;
 
 	this = mtd->priv;
-	if (this->eccmode == NAND_ECC_HW12_2048)
+	/* Ex NAND_ECC_HW12_2048 */
+	if ((this->ecc.mode == NAND_ECC_HW) && (this->ecc.size  == 2048))
 		block_count = 4;
 	else
 		block_count = 1;
@@ -794,19 +796,20 @@ static int __init omap_nand_init(void)
 
 	/* Used from chip select and nand_command() */
 	this->read_byte = omap_nand_read_byte;
-	this->write_byte = omap_nand_write_byte;
 
-	this->select_chip = omap_nand_select_chip;
-	this->dev_ready = omap_nand_dev_ready;
-	this->chip_delay = 0;
-	this->eccmode = NAND_ECC_HW3_512; 
-	this->cmdfunc = omap_nand_command;
-	this->write_buf = omap_nand_write_buf;
-	this->read_buf = omap_nand_read_buf;
-	this->verify_buf = omap_nand_verify_buf;
-	this->calculate_ecc = omap_nand_calculate_ecc;
-	this->correct_data = omap_nand_correct_data;
-	this->enable_hwecc = omap_nand_enable_hwecc;
+	this->select_chip   = omap_nand_select_chip;
+	this->dev_ready     = omap_nand_dev_ready;
+	this->chip_delay    = 0;
+	this->ecc.mode      = NAND_ECC_HW;
+	this->ecc.bytes     = 3;
+	this->ecc.size      = 512;
+	this->cmdfunc       = omap_nand_command;
+	this->write_buf     = omap_nand_write_buf;
+	this->read_buf      = omap_nand_read_buf;
+	this->verify_buf    = omap_nand_verify_buf;
+	this->ecc.calculate = omap_nand_calculate_ecc;
+	this->ecc.correct   = omap_nand_correct_data;
+	this->ecc.hwctl     = omap_nand_enable_hwecc;
 
 	nand_write_reg(NND_SYSCFG, 0x1); /* Enable auto idle */
 	nand_write_reg(NND_PSC_CLK, 10);
@@ -822,10 +825,10 @@ static int __init omap_nand_init(void)
 		l = nand_read_reg(NND_CTRL);
 		l |= 1 << 4; /* Set the A8 bit in CTRL reg */
 		nand_write_reg(NND_CTRL, l);
-		this->eccmode = NAND_ECC_HW12_2048;
-		this->eccsteps = 1;
-		this->eccsize = 2048;
-		this->eccbytes = 12;
+		this->ecc.mode = NAND_ECC_HW;
+		this->ecc.steps = 1;
+		this->ecc.size = 2048;
+		this->ecc.bytes = 12;
 		omap_mtd->eccsize = 2048;
 		nand_write_reg(NND_ECC_SELECT, 6);
 	}

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-=-=--
