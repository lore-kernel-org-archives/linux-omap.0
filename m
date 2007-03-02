From: "Kyungmin Park" <kmpark@infradead.org>
Subject: [PATCH] OneNAND driver update for N800 kernel
Date: Fri, 2 Mar 2007 09:48:04 +0900
Message-ID: <00aa01c75c64$718f4c10$c7a3580a@swcenter.sec.samsung.co.kr>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00AB_01C75CAF.E176F410"
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
Cc: 'Adrian Hunter' <ext-adrian.hunter@nokia.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_00AB_01C75CAF.E176F410
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit

Hi all,

Here's recent OneNAND driver update patch for N800.

This patch is generaged against N800 kernel.

Thank you,
Kyungmin Park

------=_NextPart_000_00AB_01C75CAF.E176F410
Content-Type: application/octet-stream;
	name="onenand-n800.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="onenand-n800.patch"

Index: drivers/mtd/onenand/onenand_base.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: =
/home/cvsroot/linux-2.6.18-n800/drivers/mtd/onenand/onenand_base.c,v=0A=
retrieving revision 1.1.1.1=0A=
diff -u -p -r1.1.1.1 onenand_base.c=0A=
--- drivers/mtd/onenand/onenand_base.c	27 Feb 2007 04:52:35 -0000	1.1.1.1=0A=
+++ drivers/mtd/onenand/onenand_base.c	28 Feb 2007 05:11:15 -0000=0A=
@@ -1,7 +1,7 @@=0A=
 /*=0A=
  *  linux/drivers/mtd/onenand/onenand_base.c=0A=
  *=0A=
- *  Copyright (C) 2005-2006 Samsung Electronics=0A=
+ *  Copyright (C) 2005-2007 Samsung Electronics=0A=
  *  Kyungmin Park <kyungmin.park@samsung.com>=0A=
  *=0A=
  * This program is free software; you can redistribute it and/or modify=0A=
@@ -90,16 +90,9 @@ static void onenand_writew(unsigned shor=0A=
  */=0A=
 static int onenand_block_address(struct onenand_chip *this, int block)=0A=
 {=0A=
-	if (this->device_id & ONENAND_DEVICE_IS_DDP) {=0A=
-		/* Device Flash Core select, NAND Flash Block Address */=0A=
-		int dfs =3D 0;=0A=
-=0A=
-		if (block & this->density_mask)=0A=
-			dfs =3D 1;=0A=
-=0A=
-		return (dfs << ONENAND_DDP_SHIFT) |=0A=
-			(block & (this->density_mask - 1));=0A=
-	}=0A=
+	/* Device Flash Core select, NAND Flash Block Address */=0A=
+	if (block & this->density_mask)=0A=
+		return ONENAND_DDP_CHIP1 | (block ^ this->density_mask);=0A=
 =0A=
 	return block;=0A=
 }=0A=
@@ -114,17 +107,11 @@ static int onenand_block_address(struct =0A=
  */=0A=
 static int onenand_bufferram_address(struct onenand_chip *this, int =
block)=0A=
 {=0A=
-	if (this->device_id & ONENAND_DEVICE_IS_DDP) {=0A=
-		/* Device BufferRAM Select */=0A=
-		int dbs =3D 0;=0A=
-=0A=
-		if (block & this->density_mask)=0A=
-			dbs =3D 1;=0A=
+	/* Device BufferRAM Select */=0A=
+	if (block & this->density_mask)=0A=
+		return ONENAND_DDP_CHIP1;=0A=
 =0A=
-		return (dbs << ONENAND_DDP_SHIFT);=0A=
-	}=0A=
-=0A=
-	return 0;=0A=
+	return ONENAND_DDP_CHIP0;=0A=
 }=0A=
 =0A=
 /**=0A=
@@ -188,8 +175,6 @@ static int onenand_command(struct mtd_in=0A=
 	struct onenand_chip *this =3D mtd->priv;=0A=
 	int value, readcmd =3D 0, block_cmd =3D 0;=0A=
 	int block, page;=0A=
-	/* Now we use page size operation */=0A=
-	int sectors =3D 4, count =3D 4;=0A=
 =0A=
 	/* Address translation */=0A=
 	switch (cmd) {=0A=
@@ -241,6 +226,8 @@ static int onenand_command(struct mtd_in=0A=
 	}=0A=
 =0A=
 	if (page !=3D -1) {=0A=
+		/* Now we use page size operation */=0A=
+		int sectors =3D 4, count =3D 4;=0A=
 		int dataram;=0A=
 =0A=
 		switch (cmd) {=0A=
@@ -294,7 +281,7 @@ static int onenand_wait(struct mtd_info =0A=
 	unsigned long timeout;=0A=
 	unsigned int flags =3D ONENAND_INT_MASTER;=0A=
 	unsigned int interrupt =3D 0;=0A=
-	unsigned int ctrl, ecc;=0A=
+	unsigned int ctrl;=0A=
 =0A=
 	/* The 20 msec is enough */=0A=
 	timeout =3D jiffies + msecs_to_jiffies(20);=0A=
@@ -306,7 +293,6 @@ static int onenand_wait(struct mtd_info =0A=
 =0A=
 		if (state !=3D FL_READING)=0A=
 			cond_resched();=0A=
-		touch_softlockup_watchdog();=0A=
 	}=0A=
 	/* To get correct interrupt status in timeout case */=0A=
 	interrupt =3D this->read_word(this->base + ONENAND_REG_INTERRUPT);=0A=
@@ -314,23 +300,25 @@ static int onenand_wait(struct mtd_info =0A=
 	ctrl =3D this->read_word(this->base + ONENAND_REG_CTRL_STATUS);=0A=
 =0A=
 	if (ctrl & ONENAND_CTRL_ERROR) {=0A=
-		/* It maybe occur at initial bad block */=0A=
-		DEBUG(MTD_DEBUG_LEVEL0, "onenand_wait: controller error =3D =
0x%04x\n", ctrl);=0A=
-		/* Clear other interrupt bits for preventing ECC error */=0A=
-		interrupt &=3D ONENAND_INT_MASTER;=0A=
-	}=0A=
-=0A=
-	if (ctrl & ONENAND_CTRL_LOCK) {=0A=
-		DEBUG(MTD_DEBUG_LEVEL0, "onenand_wait: it's locked error =3D =
0x%04x\n", ctrl);=0A=
-		return -EACCES;=0A=
+		printk(KERN_ERR "onenand_wait: controller error =3D 0x%04x\n", ctrl);=0A=
+		if (ctrl & ONENAND_CTRL_LOCK)=0A=
+			printk(KERN_ERR "onenand_wait: it's locked error.\n");=0A=
+		return ctrl;=0A=
 	}=0A=
 =0A=
 	if (interrupt & ONENAND_INT_READ) {=0A=
-		ecc =3D this->read_word(this->base + ONENAND_REG_ECC_STATUS);=0A=
-		if (ecc & ONENAND_ECC_2BIT_ALL) {=0A=
-			DEBUG(MTD_DEBUG_LEVEL0, "onenand_wait: ECC error =3D 0x%04x\n", ecc);=0A=
-			return -EBADMSG;=0A=
-		}=0A=
+		int ecc =3D this->read_word(this->base + ONENAND_REG_ECC_STATUS);=0A=
+		if (ecc) {=0A=
+			printk(KERN_ERR "onenand_wait: ECC error =3D 0x%04x\n", ecc);=0A=
+			if (ecc & ONENAND_ECC_2BIT_ALL) {=0A=
+				mtd->ecc_stats.failed++;=0A=
+				return ecc;=0A=
+			} else if (ecc & ONENAND_ECC_1BIT_ALL)=0A=
+				mtd->ecc_stats.corrected++;=0A=
+		}=0A=
+	} else if (state =3D=3D FL_READING) {=0A=
+		printk(KERN_ERR "onenand_wait: read timeout! ctrl=3D0x%04x =
intr=3D0x%04x\n", ctrl, interrupt);=0A=
+		return -EIO;=0A=
 	}=0A=
 =0A=
 	return 0;=0A=
@@ -486,22 +474,32 @@ static int onenand_write_bufferram(struc=0A=
 static int onenand_check_bufferram(struct mtd_info *mtd, loff_t addr)=0A=
 {=0A=
 	struct onenand_chip *this =3D mtd->priv;=0A=
-	int block, page;=0A=
-	int i;=0A=
+	int blockpage, found =3D 0;=0A=
+	unsigned int i;=0A=
 =0A=
-	block =3D (int) (addr >> this->erase_shift);=0A=
-	page =3D (int) (addr >> this->page_shift);=0A=
-	page &=3D this->page_mask;=0A=
+	blockpage =3D (int) (addr >> this->page_shift);=0A=
 =0A=
+	/* Is there valid data? */=0A=
 	i =3D ONENAND_CURRENT_BUFFERRAM(this);=0A=
+	if (this->bufferram[i].blockpage =3D=3D blockpage)=0A=
+		found =3D 1;=0A=
+	else {=0A=
+		/* Check another BufferRAM */=0A=
+		i =3D ONENAND_NEXT_BUFFERRAM(this);=0A=
+		if (this->bufferram[i].blockpage =3D=3D blockpage) {=0A=
+			ONENAND_SET_NEXT_BUFFERRAM(this);=0A=
+			found =3D 1;=0A=
+		}=0A=
+	}=0A=
 =0A=
-	/* Is there valid data? */=0A=
-	if (this->bufferram[i].block =3D=3D block &&=0A=
-	    this->bufferram[i].page =3D=3D page &&=0A=
-	    this->bufferram[i].valid)=0A=
-		return 1;=0A=
+	if (found && ONENAND_IS_DDP(this)) {=0A=
+		/* Select DataRAM for DDP */=0A=
+		int block =3D (int) (addr >> this->erase_shift);=0A=
+		int value =3D onenand_bufferram_address(this, block);=0A=
+		this->write_word(value, this->base + ONENAND_REG_START_ADDRESS2);=0A=
+	}=0A=
 =0A=
-	return 0;=0A=
+	return found;=0A=
 }=0A=
 =0A=
 /**=0A=
@@ -512,31 +510,49 @@ static int onenand_check_bufferram(struc=0A=
  *=0A=
  * Update BufferRAM information=0A=
  */=0A=
-static int onenand_update_bufferram(struct mtd_info *mtd, loff_t addr,=0A=
+static void onenand_update_bufferram(struct mtd_info *mtd, loff_t addr,=0A=
 		int valid)=0A=
 {=0A=
 	struct onenand_chip *this =3D mtd->priv;=0A=
-	int block, page;=0A=
-	int i;=0A=
+	int blockpage;=0A=
+	unsigned int i;=0A=
 =0A=
-	block =3D (int) (addr >> this->erase_shift);=0A=
-	page =3D (int) (addr >> this->page_shift);=0A=
-	page &=3D this->page_mask;=0A=
+	blockpage =3D (int) (addr >> this->page_shift);=0A=
 =0A=
-	/* Invalidate BufferRAM */=0A=
-	for (i =3D 0; i < MAX_BUFFERRAM; i++) {=0A=
-		if (this->bufferram[i].block =3D=3D block &&=0A=
-		    this->bufferram[i].page =3D=3D page)=0A=
-			this->bufferram[i].valid =3D 0;=0A=
-	}=0A=
+	/* Invalidate another BufferRAM */=0A=
+	i =3D ONENAND_NEXT_BUFFERRAM(this);=0A=
+	if (this->bufferram[i].blockpage =3D=3D blockpage)=0A=
+		this->bufferram[i].blockpage =3D -1;=0A=
 =0A=
 	/* Update BufferRAM */=0A=
 	i =3D ONENAND_CURRENT_BUFFERRAM(this);=0A=
-	this->bufferram[i].block =3D block;=0A=
-	this->bufferram[i].page =3D page;=0A=
-	this->bufferram[i].valid =3D valid;=0A=
+	if (valid)=0A=
+		this->bufferram[i].blockpage =3D blockpage;=0A=
+	else=0A=
+		this->bufferram[i].blockpage =3D -1;=0A=
+}=0A=
 =0A=
-	return 0;=0A=
+/**=0A=
+ * onenand_invalidate_bufferram - [GENERIC] Invalidate BufferRAM =
information=0A=
+ * @param mtd		MTD data structure=0A=
+ * @param addr		start address to invalidate=0A=
+ * @param len		length to invalidate=0A=
+ *=0A=
+ * Invalidate BufferRAM information=0A=
+ */=0A=
+static void onenand_invalidate_bufferram(struct mtd_info *mtd, loff_t =
addr,=0A=
+		unsigned int len)=0A=
+{=0A=
+	struct onenand_chip *this =3D mtd->priv;=0A=
+	int i;=0A=
+	loff_t end_addr =3D addr + len;=0A=
+=0A=
+	/* Invalidate BufferRAM */=0A=
+	for (i =3D 0; i < MAX_BUFFERRAM; i++) {=0A=
+		loff_t buf_addr =3D this->bufferram[i].blockpage << this->page_shift;=0A=
+		if (buf_addr >=3D addr && buf_addr < end_addr)=0A=
+			this->bufferram[i].blockpage =3D -1;=0A=
+	}=0A=
 }=0A=
 =0A=
 /**=0A=
@@ -606,15 +622,16 @@ static int onenand_read(struct mtd_info =0A=
 	size_t *retlen, u_char *buf)=0A=
 {=0A=
 	struct onenand_chip *this =3D mtd->priv;=0A=
+	struct mtd_ecc_stats stats;=0A=
 	int read =3D 0, column;=0A=
 	int thislen;=0A=
-	int ret =3D 0;=0A=
+	int ret =3D 0, boundary =3D 0;=0A=
 =0A=
 	DEBUG(MTD_DEBUG_LEVEL3, "onenand_read: from =3D 0x%08x, len =3D %i\n", =
(unsigned int) from, (int) len);=0A=
 =0A=
 	/* Do not allow reads past end of device */=0A=
 	if ((from + len) > mtd->size) {=0A=
-		DEBUG(MTD_DEBUG_LEVEL0, "onenand_read: Attempt read beyond end of =
device\n");=0A=
+		printk(KERN_ERR "onenand_read: Attempt read beyond end of device\n");=0A=
 		*retlen =3D 0;=0A=
 		return -EINVAL;=0A=
 	}=0A=
@@ -622,40 +639,60 @@ static int onenand_read(struct mtd_info =0A=
 	/* Grab the lock and see if the device is available */=0A=
 	onenand_get_device(mtd, FL_READING);=0A=
 =0A=
-	/* TODO handling oob */=0A=
-=0A=
-	while (read < len) {=0A=
-		thislen =3D min_t(int, mtd->writesize, len - read);=0A=
-=0A=
-		column =3D from & (mtd->writesize - 1);=0A=
-		if (column + thislen > mtd->writesize)=0A=
-			thislen =3D mtd->writesize - column;=0A=
+	stats =3D mtd->ecc_stats;=0A=
+	/* Read-while-load method */=0A=
 =0A=
+	/* Do first load to bufferRAM */=0A=
+	if (read < len) {=0A=
 		if (!onenand_check_bufferram(mtd, from)) {=0A=
 			this->command(mtd, ONENAND_CMD_READ, from, mtd->writesize);=0A=
-=0A=
 			ret =3D this->wait(mtd, FL_READING);=0A=
-			/* First copy data and check return value for ECC handling */=0A=
-			onenand_update_bufferram(mtd, from, 1);=0A=
+			onenand_update_bufferram(mtd, from, !ret);=0A=
 		}=0A=
+	}=0A=
 =0A=
-		this->read_bufferram(mtd, ONENAND_DATARAM, buf, column, thislen);=0A=
+	thislen =3D min_t(int, mtd->writesize, len - read);=0A=
+	column =3D from & (mtd->writesize - 1);=0A=
+	if (column + thislen > mtd->writesize)=0A=
+		thislen =3D mtd->writesize - column;=0A=
 =0A=
+	while (!ret) {=0A=
+		/* If there is more to load then start next load */=0A=
+		from +=3D thislen;=0A=
+		if (read + thislen < len) {=0A=
+			this->command(mtd, ONENAND_CMD_READ, from, mtd->writesize);=0A=
+			/*=0A=
+			 * Chip boundary handling in DDP=0A=
+			 * Now we issued chip 1 read and pointed chip 1=0A=
+			 * bufferam so we have to point chip 0 bufferam.=0A=
+			 */=0A=
+			if (ONENAND_IS_DDP(this) &&=0A=
+			    unlikely(from =3D=3D (this->chipsize >> 1))) {=0A=
+				this->write_word(ONENAND_DDP_CHIP0, this->base + =
ONENAND_REG_START_ADDRESS2);=0A=
+				boundary =3D 1;=0A=
+			} else=0A=
+				boundary =3D 0;=0A=
+			ONENAND_SET_PREV_BUFFERRAM(this);=0A=
+		}=0A=
+		/* While load is going, read from last bufferRAM */=0A=
+		this->read_bufferram(mtd, ONENAND_DATARAM, buf, column, thislen);=0A=
+		/* See if we are done */=0A=
 		read +=3D thislen;=0A=
-=0A=
 		if (read =3D=3D len)=0A=
 			break;=0A=
-=0A=
-		if (ret) {=0A=
-			DEBUG(MTD_DEBUG_LEVEL0, "onenand_read: read failed =3D %d\n", ret);=0A=
-			goto out;=0A=
-		}=0A=
-=0A=
-		from +=3D thislen;=0A=
+		/* Set up for next read from bufferRAM */=0A=
+		if (unlikely(boundary))=0A=
+			this->write_word(ONENAND_DDP_CHIP1, this->base + =
ONENAND_REG_START_ADDRESS2);=0A=
+		ONENAND_SET_NEXT_BUFFERRAM(this);=0A=
 		buf +=3D thislen;=0A=
+		thislen =3D min_t(int, mtd->writesize, len - read);=0A=
+		column =3D 0;=0A=
+		cond_resched();=0A=
+		/* Now wait for load */=0A=
+		ret =3D this->wait(mtd, FL_READING);=0A=
+		onenand_update_bufferram(mtd, from, !ret);=0A=
 	}=0A=
 =0A=
-out:=0A=
 	/* Deselect and wake up anyone waiting on the device */=0A=
 	onenand_release_device(mtd);=0A=
 =0A=
@@ -665,7 +702,52 @@ out:=0A=
 	 * retlen =3D=3D desired len and result =3D=3D -EBADMSG=0A=
 	 */=0A=
 	*retlen =3D read;=0A=
-	return ret;=0A=
+=0A=
+	if (mtd->ecc_stats.failed - stats.failed)=0A=
+		return -EBADMSG;=0A=
+=0A=
+	if (ret)=0A=
+		return ret;=0A=
+=0A=
+	return mtd->ecc_stats.corrected - stats.corrected ? -EUCLEAN : 0;=0A=
+}=0A=
+=0A=
+/**=0A=
+ * onenand_transfer_auto_oob - [Internal] oob auto-placement transfer=0A=
+ * @param mtd		MTD device structure=0A=
+ * @param buf		destination address=0A=
+ * @param column	oob offset to read from=0A=
+ * @param thislen	oob length to read=0A=
+ */=0A=
+static int onenand_transfer_auto_oob(struct mtd_info *mtd, uint8_t =
*buf, int column,=0A=
+				int thislen)=0A=
+{=0A=
+	struct onenand_chip *this =3D mtd->priv;=0A=
+	struct nand_oobfree *free;=0A=
+	int readcol =3D column;=0A=
+	int readend =3D column + thislen;=0A=
+	int lastgap =3D 0;=0A=
+	uint8_t *oob_buf =3D this->page_buf + mtd->writesize;=0A=
+=0A=
+	for (free =3D this->ecclayout->oobfree; free->length; ++free) {=0A=
+		if (readcol >=3D lastgap)=0A=
+			readcol +=3D free->offset - lastgap;=0A=
+		if (readend >=3D lastgap)=0A=
+			readend +=3D free->offset - lastgap;=0A=
+		lastgap =3D free->offset + free->length;=0A=
+	}=0A=
+	this->read_bufferram(mtd, ONENAND_SPARERAM, oob_buf, 0, mtd->oobsize);=0A=
+	for (free =3D this->ecclayout->oobfree; free->length; ++free) {=0A=
+		int free_end =3D free->offset + free->length;=0A=
+		if (free->offset < readend && free_end > readcol) {=0A=
+			int st =3D max_t(int,free->offset,readcol);=0A=
+			int ed =3D min_t(int,free_end,readend);=0A=
+			int n =3D ed - st;=0A=
+			memcpy(buf, oob_buf + st, n);=0A=
+			buf +=3D n;=0A=
+		}=0A=
+	}=0A=
+	return 0;=0A=
 }=0A=
 =0A=
 /**=0A=
@@ -675,14 +757,15 @@ out:=0A=
  * @param len		number of bytes to read=0A=
  * @param retlen	pointer to variable to store the number of read bytes=0A=
  * @param buf		the databuffer to put data=0A=
+ * @param mode		operation mode=0A=
  *=0A=
  * OneNAND read out-of-band data from the spare area=0A=
  */=0A=
-int onenand_do_read_oob(struct mtd_info *mtd, loff_t from, size_t len,=0A=
-			size_t *retlen, u_char *buf)=0A=
+static int onenand_do_read_oob(struct mtd_info *mtd, loff_t from, =
size_t len,=0A=
+			size_t *retlen, u_char *buf, mtd_oob_mode_t mode)=0A=
 {=0A=
 	struct onenand_chip *this =3D mtd->priv;=0A=
-	int read =3D 0, thislen, column;=0A=
+	int read =3D 0, thislen, column, oobsize;=0A=
 	int ret =3D 0;=0A=
 =0A=
 	DEBUG(MTD_DEBUG_LEVEL3, "onenand_read_oob: from =3D 0x%08x, len =3D =
%i\n", (unsigned int) from, (int) len);=0A=
@@ -690,19 +773,33 @@ int onenand_do_read_oob(struct mtd_info =0A=
 	/* Initialize return length value */=0A=
 	*retlen =3D 0;=0A=
 =0A=
+	if (mode =3D=3D MTD_OOB_AUTO)=0A=
+		oobsize =3D this->ecclayout->oobavail;=0A=
+	else=0A=
+		oobsize =3D mtd->oobsize;=0A=
+=0A=
+	column =3D from & (mtd->oobsize - 1);=0A=
+=0A=
+	if (unlikely(column >=3D oobsize)) {=0A=
+		printk(KERN_ERR "onenand_read_oob: Attempted to start read outside =
oob\n");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
 	/* Do not allow reads past end of device */=0A=
-	if (unlikely((from + len) > mtd->size)) {=0A=
-		DEBUG(MTD_DEBUG_LEVEL0, "onenand_read_oob: Attempt read beyond end of =
device\n");=0A=
+	if (unlikely(from >=3D mtd->size ||=0A=
+		     column + len > ((mtd->size >> this->page_shift) -=0A=
+				     (from >> this->page_shift)) * oobsize)) {=0A=
+		printk(KERN_ERR "onenand_read_oob: Attempted to read beyond end of =
device\n");=0A=
 		return -EINVAL;=0A=
 	}=0A=
 =0A=
 	/* Grab the lock and see if the device is available */=0A=
 	onenand_get_device(mtd, FL_READING);=0A=
 =0A=
-	column =3D from & (mtd->oobsize - 1);=0A=
-=0A=
 	while (read < len) {=0A=
-		thislen =3D mtd->oobsize - column;=0A=
+		cond_resched();=0A=
+=0A=
+		thislen =3D oobsize - column;=0A=
 		thislen =3D min_t(int, thislen, len);=0A=
 =0A=
 		this->command(mtd, ONENAND_CMD_READOOB, from, mtd->oobsize);=0A=
@@ -712,18 +809,21 @@ int onenand_do_read_oob(struct mtd_info =0A=
 		ret =3D this->wait(mtd, FL_READING);=0A=
 		/* First copy data and check return value for ECC handling */=0A=
 =0A=
-		this->read_bufferram(mtd, ONENAND_SPARERAM, buf, column, thislen);=0A=
+		if (mode =3D=3D MTD_OOB_AUTO)=0A=
+			onenand_transfer_auto_oob(mtd, buf, column, thislen);=0A=
+		else=0A=
+			this->read_bufferram(mtd, ONENAND_SPARERAM, buf, column, thislen);=0A=
+=0A=
+		if (ret) {=0A=
+			printk(KERN_ERR "onenand_read_oob: read failed =3D 0x%x\n", ret);=0A=
+			break;=0A=
+		}=0A=
 =0A=
 		read +=3D thislen;=0A=
 =0A=
 		if (read =3D=3D len)=0A=
 			break;=0A=
 =0A=
-		if (ret) {=0A=
-			DEBUG(MTD_DEBUG_LEVEL0, "onenand_read_oob: read failed =3D %d\n", =
ret);=0A=
-			goto out;=0A=
-		}=0A=
-=0A=
 		buf +=3D thislen;=0A=
 =0A=
 		/* Read more? */=0A=
@@ -734,7 +834,6 @@ int onenand_do_read_oob(struct mtd_info =0A=
 		}=0A=
 	}=0A=
 =0A=
-out:=0A=
 	/* Deselect and wake up anyone waiting on the device */=0A=
 	onenand_release_device(mtd);=0A=
 =0A=
@@ -744,17 +843,140 @@ out:=0A=
 =0A=
 /**=0A=
  * onenand_read_oob - [MTD Interface] NAND write data and/or out-of-band=0A=
- * @mtd:	MTD device structure=0A=
- * @from:	offset to read from=0A=
- * @ops:	oob operation description structure=0A=
+ * @param mtd:		MTD device structure=0A=
+ * @param from:		offset to read from=0A=
+ * @param ops:		oob operation description structure=0A=
  */=0A=
 static int onenand_read_oob(struct mtd_info *mtd, loff_t from,=0A=
 			    struct mtd_oob_ops *ops)=0A=
 {=0A=
-	BUG_ON(ops->mode !=3D MTD_OOB_PLACE);=0A=
+	switch (ops->mode) {=0A=
+	case MTD_OOB_PLACE:=0A=
+	case MTD_OOB_AUTO:=0A=
+		break;=0A=
+	case MTD_OOB_RAW:=0A=
+		/* Not implemented yet */=0A=
+	default:=0A=
+		return -EINVAL;=0A=
+	}=0A=
 =0A=
 	return onenand_do_read_oob(mtd, from + ops->ooboffs, ops->len,=0A=
-				   &ops->retlen, ops->oobbuf);=0A=
+				   &ops->retlen, ops->oobbuf, ops->mode);=0A=
+}=0A=
+=0A=
+/**=0A=
+ * onenand_bbt_wait - [DEFAULT] wait until the command is done=0A=
+ * @param mtd		MTD device structure=0A=
+ * @param state		state to select the max. timeout value=0A=
+ *=0A=
+ * Wait for command done.=0A=
+ */=0A=
+static int onenand_bbt_wait(struct mtd_info *mtd, int state)=0A=
+{=0A=
+	struct onenand_chip *this =3D mtd->priv;=0A=
+	unsigned long timeout;=0A=
+	unsigned int interrupt;=0A=
+	unsigned int ctrl;=0A=
+=0A=
+	/* The 20 msec is enough */=0A=
+	timeout =3D jiffies + msecs_to_jiffies(20);=0A=
+	while (time_before(jiffies, timeout)) {=0A=
+		interrupt =3D this->read_word(this->base + ONENAND_REG_INTERRUPT);=0A=
+		if (interrupt & ONENAND_INT_MASTER)=0A=
+			break;=0A=
+	}=0A=
+	/* To get correct interrupt status in timeout case */=0A=
+	interrupt =3D this->read_word(this->base + ONENAND_REG_INTERRUPT);=0A=
+	ctrl =3D this->read_word(this->base + ONENAND_REG_CTRL_STATUS);=0A=
+=0A=
+	if (ctrl & ONENAND_CTRL_ERROR) {=0A=
+		printk(KERN_DEBUG "onenand_bbt_wait: controller error =3D 0x%04x\n", =
ctrl);=0A=
+		/* Initial bad block case */=0A=
+		if (ctrl & ONENAND_CTRL_LOAD)=0A=
+			return ONENAND_BBT_READ_ERROR;=0A=
+		return ONENAND_BBT_READ_FATAL_ERROR;=0A=
+	}=0A=
+=0A=
+	if (interrupt & ONENAND_INT_READ) {=0A=
+		int ecc =3D this->read_word(this->base + ONENAND_REG_ECC_STATUS);=0A=
+		if (ecc & ONENAND_ECC_2BIT_ALL)=0A=
+			return ONENAND_BBT_READ_ERROR;=0A=
+	} else {=0A=
+		printk(KERN_ERR "onenand_bbt_wait: read timeout!"=0A=
+			"ctrl=3D0x%04x intr=3D0x%04x\n", ctrl, interrupt);=0A=
+		return ONENAND_BBT_READ_FATAL_ERROR;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/**=0A=
+ * onenand_bbt_read_oob - [MTD Interface] OneNAND read out-of-band for =
bbt scan=0A=
+ * @param mtd		MTD device structure=0A=
+ * @param from		offset to read from=0A=
+ * @param ops		oob operation description structure=0A=
+ *=0A=
+ * OneNAND read out-of-band data from the spare area for bbt scan=0A=
+ */=0A=
+int onenand_bbt_read_oob(struct mtd_info *mtd, loff_t from,=0A=
+			struct mtd_oob_ops *ops)=0A=
+{=0A=
+	struct onenand_chip *this =3D mtd->priv;=0A=
+	int read =3D 0, thislen, column;=0A=
+	int ret =3D 0;=0A=
+	size_t len =3D ops->ooblen;=0A=
+	u_char *buf =3D ops->oobbuf;=0A=
+=0A=
+	DEBUG(MTD_DEBUG_LEVEL3, "onenand_bbt_read_oob: from =3D 0x%08x, len =
=3D %i\n", (unsigned int) from, len);=0A=
+=0A=
+	/* Initialize return value */=0A=
+	ops->retlen =3D 0;=0A=
+=0A=
+	/* Do not allow reads past end of device */=0A=
+	if (unlikely((from + len) > mtd->size)) {=0A=
+		printk(KERN_ERR "onenand_bbt_read_oob: Attempt read beyond end of =
device\n");=0A=
+		return ONENAND_BBT_READ_FATAL_ERROR;=0A=
+	}=0A=
+=0A=
+	/* Grab the lock and see if the device is available */=0A=
+	onenand_get_device(mtd, FL_READING);=0A=
+=0A=
+	column =3D from & (mtd->oobsize - 1);=0A=
+=0A=
+	while (read < len) {=0A=
+		cond_resched();=0A=
+=0A=
+		thislen =3D mtd->oobsize - column;=0A=
+		thislen =3D min_t(int, thislen, len);=0A=
+=0A=
+		this->command(mtd, ONENAND_CMD_READOOB, from, mtd->oobsize);=0A=
+=0A=
+		onenand_update_bufferram(mtd, from, 0);=0A=
+=0A=
+		ret =3D onenand_bbt_wait(mtd, FL_READING);=0A=
+		if (ret)=0A=
+			break;=0A=
+=0A=
+		this->read_bufferram(mtd, ONENAND_SPARERAM, buf, column, thislen);=0A=
+		read +=3D thislen;=0A=
+		if (read =3D=3D len)=0A=
+			break;=0A=
+=0A=
+		buf +=3D thislen;=0A=
+=0A=
+		/* Read more? */=0A=
+		if (read < len) {=0A=
+			/* Update Page size */=0A=
+			from +=3D mtd->writesize;=0A=
+			column =3D 0;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	/* Deselect and wake up anyone waiting on the device */=0A=
+	onenand_release_device(mtd);=0A=
+=0A=
+	ops->retlen =3D read;=0A=
+	return ret;=0A=
 }=0A=
 =0A=
 #ifdef CONFIG_MTD_ONENAND_VERIFY_WRITE=0A=
@@ -763,14 +985,12 @@ static int onenand_read_oob(struct mtd_i=0A=
  * @param mtd		MTD device structure=0A=
  * @param buf		the databuffer to verify=0A=
  * @param to		offset to read from=0A=
- * @param len		number of bytes to read and compare=0A=
  *=0A=
  */=0A=
-static int onenand_verify_oob(struct mtd_info *mtd, const u_char *buf, =
loff_t to, int len)=0A=
+static int onenand_verify_oob(struct mtd_info *mtd, const u_char *buf, =
loff_t to)=0A=
 {=0A=
 	struct onenand_chip *this =3D mtd->priv;=0A=
-	char *readp =3D this->page_buf;=0A=
-	int column =3D to & (mtd->oobsize - 1);=0A=
+	char oobbuf[64];=0A=
 	int status, i;=0A=
 =0A=
 	this->command(mtd, ONENAND_CMD_READOOB, to, mtd->oobsize);=0A=
@@ -779,47 +999,60 @@ static int onenand_verify_oob(struct mtd=0A=
 	if (status)=0A=
 		return status;=0A=
 =0A=
-	this->read_bufferram(mtd, ONENAND_SPARERAM, readp, column, len);=0A=
-=0A=
-	for(i =3D 0; i < len; i++)=0A=
-		if (buf[i] !=3D 0xFF && buf[i] !=3D readp[i])=0A=
+	this->read_bufferram(mtd, ONENAND_SPARERAM, oobbuf, 0, mtd->oobsize);=0A=
+	for (i =3D 0; i < mtd->oobsize; i++)=0A=
+		if (buf[i] !=3D 0xFF && buf[i] !=3D oobbuf[i])=0A=
 			return -EBADMSG;=0A=
 =0A=
 	return 0;=0A=
 }=0A=
 =0A=
 /**=0A=
- * onenand_verify_page - [GENERIC] verify the chip contents after a =
write=0A=
+ * onenand_verify - [GENERIC] verify the chip contents after a write=0A=
  * @param mtd		MTD device structure=0A=
  * @param buf		the databuffer to verify=0A=
+ * @param addr		offset to read from=0A=
+ * @param len		number of bytes to read and compare=0A=
  *=0A=
- * Check DataRAM area directly=0A=
  */=0A=
-static int onenand_verify_page(struct mtd_info *mtd, u_char *buf, =
loff_t addr)=0A=
+static int onenand_verify(struct mtd_info *mtd, const u_char *buf, =
loff_t addr, size_t len)=0A=
 {=0A=
 	struct onenand_chip *this =3D mtd->priv;=0A=
-	void __iomem *dataram0, *dataram1;=0A=
+	void __iomem *dataram;=0A=
 	int ret =3D 0;=0A=
+	int thislen, column;=0A=
 =0A=
-	this->command(mtd, ONENAND_CMD_READ, addr, mtd->writesize);=0A=
+	while (len !=3D 0) {=0A=
+		thislen =3D min_t(int, mtd->writesize, len);=0A=
+		column =3D addr & (mtd->writesize - 1);=0A=
+		if (column + thislen > mtd->writesize)=0A=
+			thislen =3D mtd->writesize - column;=0A=
 =0A=
-	ret =3D this->wait(mtd, FL_READING);=0A=
-	if (ret)=0A=
-		return ret;=0A=
+		this->command(mtd, ONENAND_CMD_READ, addr, mtd->writesize);=0A=
 =0A=
-	onenand_update_bufferram(mtd, addr, 1);=0A=
+		onenand_update_bufferram(mtd, addr, 0);=0A=
 =0A=
-	/* Check, if the two dataram areas are same */=0A=
-	dataram0 =3D this->base + ONENAND_DATARAM;=0A=
-	dataram1 =3D dataram0 + mtd->writesize;=0A=
+		ret =3D this->wait(mtd, FL_READING);=0A=
+		if (ret)=0A=
+			return ret;=0A=
 =0A=
-	if (memcmp(dataram0, dataram1, mtd->writesize))=0A=
-		return -EBADMSG;=0A=
+		onenand_update_bufferram(mtd, addr, 1);=0A=
+=0A=
+		dataram =3D this->base + ONENAND_DATARAM;=0A=
+		dataram +=3D onenand_bufferram_offset(mtd, ONENAND_DATARAM);=0A=
+=0A=
+		if (memcmp(buf, dataram + column, thislen))=0A=
+			return -EBADMSG;=0A=
+=0A=
+		len -=3D thislen;=0A=
+		buf +=3D thislen;=0A=
+		addr +=3D thislen;=0A=
+	}=0A=
 =0A=
 	return 0;=0A=
 }=0A=
 #else=0A=
-#define onenand_verify_page(...)	(0)=0A=
+#define onenand_verify(...)		(0)=0A=
 #define onenand_verify_oob(...)		(0)=0A=
 #endif=0A=
 =0A=
@@ -841,6 +1074,7 @@ static int onenand_write(struct mtd_info=0A=
 	struct onenand_chip *this =3D mtd->priv;=0A=
 	int written =3D 0;=0A=
 	int ret =3D 0;=0A=
+	int column, subpage;=0A=
 =0A=
 	DEBUG(MTD_DEBUG_LEVEL3, "onenand_write: to =3D 0x%08x, len =3D %i\n", =
(unsigned int) to, (int) len);=0A=
 =0A=
@@ -849,55 +1083,70 @@ static int onenand_write(struct mtd_info=0A=
 =0A=
 	/* Do not allow writes past end of device */=0A=
 	if (unlikely((to + len) > mtd->size)) {=0A=
-		DEBUG(MTD_DEBUG_LEVEL0, "onenand_write: Attempt write to past end of =
device\n");=0A=
+		printk(KERN_ERR "onenand_write: Attempt write to past end of =
device\n");=0A=
 		return -EINVAL;=0A=
 	}=0A=
 =0A=
 	/* Reject writes, which are not page aligned */=0A=
         if (unlikely(NOTALIGNED(to)) || unlikely(NOTALIGNED(len))) {=0A=
-                DEBUG(MTD_DEBUG_LEVEL0, "onenand_write: Attempt to =
write not page aligned data\n");=0A=
+                printk(KERN_ERR "onenand_write: Attempt to write not =
page aligned data\n");=0A=
                 return -EINVAL;=0A=
         }=0A=
 =0A=
+	column =3D to & (mtd->writesize - 1);=0A=
+=0A=
 	/* Grab the lock and see if the device is available */=0A=
 	onenand_get_device(mtd, FL_WRITING);=0A=
 =0A=
 	/* Loop until all data write */=0A=
 	while (written < len) {=0A=
-		int thislen =3D min_t(int, mtd->writesize, len - written);=0A=
+		int thislen =3D min_t(int, mtd->writesize - column, len - written);=0A=
+		u_char *wbuf =3D (u_char *) buf;=0A=
+=0A=
+		cond_resched();=0A=
 =0A=
-		this->command(mtd, ONENAND_CMD_BUFFERRAM, to, mtd->writesize);=0A=
+		this->command(mtd, ONENAND_CMD_BUFFERRAM, to, thislen);=0A=
 =0A=
-		this->write_bufferram(mtd, ONENAND_DATARAM, buf, 0, thislen);=0A=
+		/* Partial page write */=0A=
+		subpage =3D thislen < mtd->writesize;=0A=
+		if (subpage) {=0A=
+			memset(this->page_buf, 0xff, mtd->writesize);=0A=
+			memcpy(this->page_buf + column, buf, thislen);=0A=
+			wbuf =3D this->page_buf;=0A=
+		}=0A=
+=0A=
+		this->write_bufferram(mtd, ONENAND_DATARAM, wbuf, 0, mtd->writesize);=0A=
 		this->write_bufferram(mtd, ONENAND_SPARERAM, ffchars, 0, =
mtd->oobsize);=0A=
 =0A=
 		this->command(mtd, ONENAND_CMD_PROG, to, mtd->writesize);=0A=
 =0A=
-		onenand_update_bufferram(mtd, to, 1);=0A=
-=0A=
 		ret =3D this->wait(mtd, FL_WRITING);=0A=
+=0A=
+		/* In partial page write we don't update bufferram */=0A=
+		onenand_update_bufferram(mtd, to, !ret && !subpage);=0A=
+=0A=
 		if (ret) {=0A=
-			DEBUG(MTD_DEBUG_LEVEL0, "onenand_write: write filaed %d\n", ret);=0A=
-			goto out;=0A=
+			printk(KERN_ERR "onenand_write: write filaed %d\n", ret);=0A=
+			break;=0A=
 		}=0A=
 =0A=
-		written +=3D thislen;=0A=
-=0A=
 		/* Only check verify write turn on */=0A=
-		ret =3D onenand_verify_page(mtd, (u_char *) buf, to);=0A=
+		ret =3D onenand_verify(mtd, (u_char *) wbuf, to, thislen);=0A=
 		if (ret) {=0A=
-			DEBUG(MTD_DEBUG_LEVEL0, "onenand_write: verify failed %d\n", ret);=0A=
-			goto out;=0A=
+			printk(KERN_ERR "onenand_write: verify failed %d\n", ret);=0A=
+			break;=0A=
 		}=0A=
 =0A=
+		written +=3D thislen;=0A=
+=0A=
 		if (written =3D=3D len)=0A=
 			break;=0A=
 =0A=
+		column =3D 0;=0A=
 		to +=3D thislen;=0A=
 		buf +=3D thislen;=0A=
 	}=0A=
 =0A=
-out:=0A=
 	/* Deselect and wake up anyone waiting on the device */=0A=
 	onenand_release_device(mtd);=0A=
 =0A=
@@ -907,49 +1156,114 @@ out:=0A=
 }=0A=
 =0A=
 /**=0A=
+ * onenand_fill_auto_oob - [Internal] oob auto-placement transfer=0A=
+ * @param mtd		MTD device structure=0A=
+ * @param oob_buf	oob buffer=0A=
+ * @param buf		source address=0A=
+ * @param column	oob offset to write to=0A=
+ * @param thislen	oob length to write=0A=
+ */=0A=
+static int onenand_fill_auto_oob(struct mtd_info *mtd, u_char *oob_buf,=0A=
+				const u_char *buf, int column, int thislen)=0A=
+{=0A=
+	struct onenand_chip *this =3D mtd->priv;=0A=
+	struct nand_oobfree *free;=0A=
+	int writecol =3D column;=0A=
+	int writeend =3D column + thislen;=0A=
+	int lastgap =3D 0;=0A=
+=0A=
+	for (free =3D this->ecclayout->oobfree; free->length; ++free) {=0A=
+		if (writecol >=3D lastgap)=0A=
+			writecol +=3D free->offset - lastgap;=0A=
+		if (writeend >=3D lastgap)=0A=
+			writeend +=3D free->offset - lastgap;=0A=
+		lastgap =3D free->offset + free->length;=0A=
+	}=0A=
+	for (free =3D this->ecclayout->oobfree; free->length; ++free) {=0A=
+		int free_end =3D free->offset + free->length;=0A=
+		if (free->offset < writeend && free_end > writecol) {=0A=
+			int st =3D max_t(int,free->offset,writecol);=0A=
+			int ed =3D min_t(int,free_end,writeend);=0A=
+			int n =3D ed - st;=0A=
+			memcpy(oob_buf + st, buf, n);=0A=
+			buf +=3D n;=0A=
+		}=0A=
+	}=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/**=0A=
  * onenand_do_write_oob - [Internal] OneNAND write out-of-band=0A=
  * @param mtd		MTD device structure=0A=
  * @param to		offset to write to=0A=
  * @param len		number of bytes to write=0A=
  * @param retlen	pointer to variable to store the number of written =
bytes=0A=
  * @param buf		the data to write=0A=
+ * @param mode		operation mode=0A=
  *=0A=
  * OneNAND write out-of-band=0A=
  */=0A=
 static int onenand_do_write_oob(struct mtd_info *mtd, loff_t to, size_t =
len,=0A=
-				size_t *retlen, const u_char *buf)=0A=
+				size_t *retlen, const u_char *buf, mtd_oob_mode_t mode)=0A=
 {=0A=
 	struct onenand_chip *this =3D mtd->priv;=0A=
-	int column, ret =3D 0;=0A=
+	int column, ret =3D 0, oobsize;=0A=
 	int written =3D 0;=0A=
+	u_char *oobbuf;=0A=
 =0A=
 	DEBUG(MTD_DEBUG_LEVEL3, "onenand_write_oob: to =3D 0x%08x, len =3D =
%i\n", (unsigned int) to, (int) len);=0A=
 =0A=
 	/* Initialize retlen, in case of early exit */=0A=
 	*retlen =3D 0;=0A=
 =0A=
-	/* Do not allow writes past end of device */=0A=
-	if (unlikely((to + len) > mtd->size)) {=0A=
-		DEBUG(MTD_DEBUG_LEVEL0, "onenand_write_oob: Attempt write to past end =
of device\n");=0A=
+	if (mode =3D=3D MTD_OOB_AUTO)=0A=
+		oobsize =3D this->ecclayout->oobavail;=0A=
+	else=0A=
+		oobsize =3D mtd->oobsize;=0A=
+=0A=
+	column =3D to & (mtd->oobsize - 1);=0A=
+=0A=
+	if (unlikely(column >=3D oobsize)) {=0A=
+		printk(KERN_ERR "onenand_write_oob: Attempted to start write outside =
oob\n");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	/* For compatibility with NAND: Do not allow write past end of page */=0A=
+	if (unlikely(column + len > oobsize)) {=0A=
+		printk(KERN_ERR "onenand_write_oob: "=0A=
+			"Attempt to write past end of page\n");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	/* Do not allow reads past end of device */=0A=
+	if (unlikely(to >=3D mtd->size ||=0A=
+		    column + len > ((mtd->size >> this->page_shift) -=0A=
+			    (to >> this->page_shift)) * oobsize)) {=0A=
+		printk(KERN_ERR "onenand_write_oob: Attempted to write past end of =
device\n");=0A=
 		return -EINVAL;=0A=
 	}=0A=
 =0A=
 	/* Grab the lock and see if the device is available */=0A=
 	onenand_get_device(mtd, FL_WRITING);=0A=
 =0A=
+	oobbuf =3D this->page_buf + mtd->writesize;=0A=
+=0A=
 	/* Loop until all data write */=0A=
 	while (written < len) {=0A=
-		int thislen =3D min_t(int, mtd->oobsize, len - written);=0A=
+		int thislen =3D min_t(int, oobsize, len - written);=0A=
 =0A=
-		column =3D to & (mtd->oobsize - 1);=0A=
+		cond_resched();=0A=
 =0A=
 		this->command(mtd, ONENAND_CMD_BUFFERRAM, to, mtd->oobsize);=0A=
 =0A=
 		/* We send data to spare ram with oobsize=0A=
 		 * to prevent byte access */=0A=
-		memset(this->page_buf, 0xff, mtd->oobsize);=0A=
-		memcpy(this->page_buf + column, buf, thislen);=0A=
-		this->write_bufferram(mtd, ONENAND_SPARERAM, this->page_buf, 0, =
mtd->oobsize);=0A=
+		memset(oobbuf, 0xff, mtd->oobsize);=0A=
+		if (mode =3D=3D MTD_OOB_AUTO)=0A=
+			onenand_fill_auto_oob(mtd, oobbuf, buf, column, thislen);=0A=
+		else=0A=
+			memcpy(oobbuf + column, buf, thislen);=0A=
+		this->write_bufferram(mtd, ONENAND_SPARERAM, oobbuf, 0, mtd->oobsize);=0A=
 =0A=
 		this->command(mtd, ONENAND_CMD_PROGOOB, to, mtd->oobsize);=0A=
 =0A=
@@ -957,26 +1271,25 @@ static int onenand_do_write_oob(struct m=0A=
 =0A=
 		ret =3D this->wait(mtd, FL_WRITING);=0A=
 		if (ret) {=0A=
-			DEBUG(MTD_DEBUG_LEVEL0, "onenand_write_oob: write filaed %d\n", ret);=0A=
-			goto out;=0A=
+			printk(KERN_ERR "onenand_write_oob: write failed %d\n", ret);=0A=
+			break;=0A=
 		}=0A=
 =0A=
-		ret =3D onenand_verify_oob(mtd, buf, to, thislen);=0A=
+		ret =3D onenand_verify_oob(mtd, oobbuf, to);=0A=
 		if (ret) {=0A=
-			DEBUG(MTD_DEBUG_LEVEL0, "onenand_write_oob: verify failed %d\n", =
ret);=0A=
-			goto out;=0A=
+			printk(KERN_ERR "onenand_write_oob: verify failed %d\n", ret);=0A=
+			break;=0A=
 		}=0A=
 =0A=
 		written +=3D thislen;=0A=
-=0A=
 		if (written =3D=3D len)=0A=
 			break;=0A=
 =0A=
-		to +=3D thislen;=0A=
+		to +=3D mtd->writesize;=0A=
 		buf +=3D thislen;=0A=
+		column =3D 0;=0A=
 	}=0A=
 =0A=
-out:=0A=
 	/* Deselect and wake up anyone waiting on the device */=0A=
 	onenand_release_device(mtd);=0A=
 =0A=
@@ -994,10 +1307,18 @@ out:=0A=
 static int onenand_write_oob(struct mtd_info *mtd, loff_t to,=0A=
 			     struct mtd_oob_ops *ops)=0A=
 {=0A=
-	BUG_ON(ops->mode !=3D MTD_OOB_PLACE);=0A=
+	switch (ops->mode) {=0A=
+	case MTD_OOB_PLACE:=0A=
+	case MTD_OOB_AUTO:=0A=
+		break;=0A=
+	case MTD_OOB_RAW:=0A=
+		/* Not implemented yet */=0A=
+	default:=0A=
+		return -EINVAL;=0A=
+	}=0A=
 =0A=
 	return onenand_do_write_oob(mtd, to + ops->ooboffs, ops->len,=0A=
-				    &ops->retlen, ops->oobbuf);=0A=
+				    &ops->retlen, ops->oobbuf, ops->mode);=0A=
 }=0A=
 =0A=
 /**=0A=
@@ -1040,19 +1361,19 @@ static int onenand_erase(struct mtd_info=0A=
 =0A=
 	/* Start address must align on block boundary */=0A=
 	if (unlikely(instr->addr & (block_size - 1))) {=0A=
-		DEBUG(MTD_DEBUG_LEVEL0, "onenand_erase: Unaligned address\n");=0A=
+		printk(KERN_ERR "onenand_erase: Unaligned address\n");=0A=
 		return -EINVAL;=0A=
 	}=0A=
 =0A=
 	/* Length must align on block boundary */=0A=
 	if (unlikely(instr->len & (block_size - 1))) {=0A=
-		DEBUG(MTD_DEBUG_LEVEL0, "onenand_erase: Length not block aligned\n");=0A=
+		printk(KERN_ERR "onenand_erase: Length not block aligned\n");=0A=
 		return -EINVAL;=0A=
 	}=0A=
 =0A=
 	/* Do not allow erase past end of device */=0A=
 	if (unlikely((instr->len + instr->addr) > mtd->size)) {=0A=
-		DEBUG(MTD_DEBUG_LEVEL0, "onenand_erase: Erase past end of device\n");=0A=
+		printk(KERN_ERR "onenand_erase: Erase past end of device\n");=0A=
 		return -EINVAL;=0A=
 	}=0A=
 =0A=
@@ -1068,6 +1389,7 @@ static int onenand_erase(struct mtd_info=0A=
 	instr->state =3D MTD_ERASING;=0A=
 =0A=
 	while (len) {=0A=
+		cond_resched();=0A=
 =0A=
 		/* Check if we have a bad block, we do not erase bad blocks */=0A=
 		if (onenand_block_checkbad(mtd, addr, 0, 0)) {=0A=
@@ -1078,13 +1400,12 @@ static int onenand_erase(struct mtd_info=0A=
 =0A=
 		this->command(mtd, ONENAND_CMD_ERASE, addr, block_size);=0A=
 =0A=
+		onenand_invalidate_bufferram(mtd, addr, block_size);=0A=
+=0A=
 		ret =3D this->wait(mtd, FL_ERASING);=0A=
 		/* Check, if it is write protected */=0A=
 		if (ret) {=0A=
-			if (ret =3D=3D -EPERM)=0A=
-				DEBUG(MTD_DEBUG_LEVEL0, "onenand_erase: Device is write =
protected!!!\n");=0A=
-			else=0A=
-				DEBUG(MTD_DEBUG_LEVEL0, "onenand_erase: Failed erase, block %d\n", =
(unsigned) (addr >> this->erase_shift));=0A=
+			printk(KERN_ERR "onenand_erase: Failed erase, block %d\n", =
(unsigned) (addr >> this->erase_shift));=0A=
 			instr->state =3D MTD_ERASE_FAILED;=0A=
 			instr->fail_addr =3D addr;=0A=
 			goto erase_exit;=0A=
@@ -1166,7 +1487,7 @@ static int onenand_default_block_markbad=0A=
 =0A=
         /* We write two bytes, so we dont have to mess with 16 bit =
access */=0A=
         ofs +=3D mtd->oobsize + (bbm->badblockpos & ~0x01);=0A=
-        return onenand_do_write_oob(mtd, ofs , 2, &retlen, buf);=0A=
+        return onenand_do_write_oob(mtd, ofs , 2, &retlen, buf, =
MTD_OOB_PLACE);=0A=
 }=0A=
 =0A=
 /**=0A=
@@ -1282,7 +1603,6 @@ static int onenand_lock(struct mtd_info =0A=
 	return onenand_do_lock_cmd(mtd, ofs, len, ONENAND_CMD_LOCK);=0A=
 }=0A=
 =0A=
-=0A=
 /**=0A=
  * onenand_unlock - [MTD Interface] Unlock block(s)=0A=
  * @param mtd		MTD device structure=0A=
@@ -1336,6 +1656,8 @@ static int onenand_unlock_all(struct mtd=0A=
 	struct onenand_chip *this =3D mtd->priv;=0A=
 =0A=
 	if (this->options & ONENAND_HAS_UNLOCK_ALL) {=0A=
+		/* Set start block address */=0A=
+		this->write_word(0, this->base + ONENAND_REG_START_BLOCK_ADDRESS);=0A=
 		/* Write unlock command */=0A=
 		this->command(mtd, ONENAND_CMD_UNLOCK_ALL, 0, 0);=0A=
 =0A=
@@ -1348,13 +1670,10 @@ static int onenand_unlock_all(struct mtd=0A=
 			continue;=0A=
 =0A=
 		/* Workaround for all block unlock in DDP */=0A=
-		if (this->device_id & ONENAND_DEVICE_IS_DDP) {=0A=
-			loff_t ofs;=0A=
-			size_t len;=0A=
-=0A=
+		if (ONENAND_IS_DDP(this)) {=0A=
 			/* 1st block on another chip */=0A=
-			ofs =3D this->chipsize >> 1;=0A=
-			len =3D 1 << this->erase_shift;=0A=
+			loff_t ofs =3D this->chipsize >> 1;=0A=
+			size_t len =3D mtd->erasesize;=0A=
 =0A=
 			onenand_unlock(mtd, ofs, len);=0A=
 		}=0A=
@@ -1462,7 +1781,7 @@ static int do_otp_lock(struct mtd_info *=0A=
 	this->command(mtd, ONENAND_CMD_OTP_ACCESS, 0, 0);=0A=
 	this->wait(mtd, FL_OTPING);=0A=
 =0A=
-	ret =3D onenand_do_write_oob(mtd, from, len, retlen, buf);=0A=
+	ret =3D onenand_do_write_oob(mtd, from, len, retlen, buf, =
MTD_OOB_PLACE);=0A=
 =0A=
 	/* Exit OTP access mode */=0A=
 	this->command(mtd, ONENAND_CMD_RESET, 0, 0);=0A=
@@ -1668,12 +1987,13 @@ static int onenand_lock_user_prot_reg(st=0A=
 #endif	/* CONFIG_MTD_ONENAND_OTP */=0A=
 =0A=
 /**=0A=
- * onenand_lock_scheme - Check and set OneNAND lock scheme=0A=
+ * onenand_check_features - Check and set OneNAND features=0A=
  * @param mtd		MTD data structure=0A=
  *=0A=
- * Check and set OneNAND lock scheme=0A=
+ * Check and set OneNAND features=0A=
+ * - lock scheme=0A=
  */=0A=
-static void onenand_lock_scheme(struct mtd_info *mtd)=0A=
+static void onenand_check_features(struct mtd_info *mtd)=0A=
 {=0A=
 	struct onenand_chip *this =3D mtd->priv;=0A=
 	unsigned int density, process;=0A=
@@ -1792,7 +2112,7 @@ static int onenand_probe(struct mtd_info=0A=
 	/* Read manufacturer and device IDs from Register */=0A=
 	maf_id =3D this->read_word(this->base + ONENAND_REG_MANUFACTURER_ID);=0A=
 	dev_id =3D this->read_word(this->base + ONENAND_REG_DEVICE_ID);=0A=
-	ver_id=3D this->read_word(this->base + ONENAND_REG_VERSION_ID);=0A=
+	ver_id =3D this->read_word(this->base + ONENAND_REG_VERSION_ID);=0A=
 =0A=
 	/* Check OneNAND device */=0A=
 	if (maf_id !=3D bram_maf_id || dev_id !=3D bram_dev_id)=0A=
@@ -1806,26 +2126,28 @@ static int onenand_probe(struct mtd_info=0A=
 	density =3D dev_id >> ONENAND_DEVICE_DENSITY_SHIFT;=0A=
 	this->chipsize =3D (16 << density) << 20;=0A=
 	/* Set density mask. it is used for DDP */=0A=
-	this->density_mask =3D (1 << (density + 6));=0A=
+	if (ONENAND_IS_DDP(this))=0A=
+		this->density_mask =3D (1 << (density + 6));=0A=
+	else=0A=
+		this->density_mask =3D 0;=0A=
 =0A=
 	/* OneNAND page size & block size */=0A=
 	/* The data buffer size is equal to page size */=0A=
 	mtd->writesize =3D this->read_word(this->base + =
ONENAND_REG_DATA_BUFFER_SIZE);=0A=
 	mtd->oobsize =3D mtd->writesize >> 5;=0A=
-	/* Pagers per block is always 64 in OneNAND */=0A=
+	/* Pages per a block are always 64 in OneNAND */=0A=
 	mtd->erasesize =3D mtd->writesize << 6;=0A=
 =0A=
 	this->erase_shift =3D ffs(mtd->erasesize) - 1;=0A=
 	this->page_shift =3D ffs(mtd->writesize) - 1;=0A=
-	this->ppb_shift =3D (this->erase_shift - this->page_shift);=0A=
-	this->page_mask =3D (mtd->erasesize / mtd->writesize) - 1;=0A=
+	this->page_mask =3D (1 << (this->erase_shift - this->page_shift)) - 1;=0A=
 =0A=
 	/* REVIST: Multichip handling */=0A=
 =0A=
 	mtd->size =3D this->chipsize;=0A=
 =0A=
-	/* Check OneNAND lock scheme */=0A=
-	onenand_lock_scheme(mtd);=0A=
+	/* Check OneNAND features */=0A=
+	onenand_check_features(mtd);=0A=
 =0A=
 	return 0;=0A=
 }=0A=
@@ -1866,6 +2188,7 @@ static void onenand_resume(struct mtd_in=0A=
  */=0A=
 int onenand_scan(struct mtd_info *mtd, int maxchips)=0A=
 {=0A=
+	int i;=0A=
 	struct onenand_chip *this =3D mtd->priv;=0A=
 =0A=
 	if (!this->read_word)=0A=
@@ -1913,6 +2236,9 @@ int onenand_scan(struct mtd_info *mtd, i=0A=
 	init_waitqueue_head(&this->wq);=0A=
 	spin_lock_init(&this->chip_lock);=0A=
 =0A=
+	/*=0A=
+	 * Allow subpage writes up to oobsize.=0A=
+	 */=0A=
 	switch (mtd->oobsize) {=0A=
 	case 64:=0A=
 		this->ecclayout =3D &onenand_oob_64;=0A=
@@ -1930,6 +2256,15 @@ int onenand_scan(struct mtd_info *mtd, i=0A=
 		break;=0A=
 	}=0A=
 =0A=
+	/*=0A=
+	 * The number of bytes available for a client to place data into=0A=
+	 * the out of band area=0A=
+	 */=0A=
+	this->ecclayout->oobavail =3D 0;=0A=
+	for (i =3D 0; this->ecclayout->oobfree[i].length; i++)=0A=
+		this->ecclayout->oobavail +=3D=0A=
+			this->ecclayout->oobfree[i].length;=0A=
+=0A=
 	mtd->ecclayout =3D this->ecclayout;=0A=
 =0A=
 	/* Fill in remaining MTD driver data */=0A=
@@ -1982,8 +2317,11 @@ void onenand_release(struct mtd_info *mt=0A=
 	del_mtd_device (mtd);=0A=
 =0A=
 	/* Free bad block table memory, if allocated */=0A=
-	if (this->bbm)=0A=
+	if (this->bbm) {=0A=
+		struct bbm_info *bbm =3D this->bbm;=0A=
+		kfree(bbm->bbt);=0A=
 		kfree(this->bbm);=0A=
+	}=0A=
 	/* Buffer allocated by onenand_scan */=0A=
 	if (this->options & ONENAND_PAGEBUF_ALLOC)=0A=
 		kfree(this->page_buf);=0A=
Index: drivers/mtd/onenand/onenand_bbt.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: =
/home/cvsroot/linux-2.6.18-n800/drivers/mtd/onenand/onenand_bbt.c,v=0A=
retrieving revision 1.1.1.1=0A=
diff -u -p -r1.1.1.1 onenand_bbt.c=0A=
--- drivers/mtd/onenand/onenand_bbt.c	27 Feb 2007 04:52:35 -0000	1.1.1.1=0A=
+++ drivers/mtd/onenand/onenand_bbt.c	28 Feb 2007 05:06:02 -0000=0A=
@@ -17,8 +17,8 @@=0A=
 #include <linux/mtd/onenand.h>=0A=
 #include <linux/mtd/compatmac.h>=0A=
 =0A=
-extern int onenand_do_read_oob(struct mtd_info *mtd, loff_t from, =
size_t len,=0A=
-			       size_t *retlen, u_char *buf);=0A=
+extern int onenand_bbt_read_oob(struct mtd_info *mtd, loff_t from,=0A=
+		struct mtd_oob_ops *ops);=0A=
 =0A=
 /**=0A=
  * check_short_pattern - [GENERIC] check if a pattern is in the buffer=0A=
@@ -65,10 +65,11 @@ static int create_bbt(struct mtd_info *m=0A=
 	int startblock;=0A=
 	loff_t from;=0A=
 	size_t readlen, ooblen;=0A=
+	struct mtd_oob_ops ops;=0A=
 =0A=
 	printk(KERN_INFO "Scanning device for bad blocks\n");=0A=
 =0A=
-	len =3D 1;=0A=
+	len =3D 2;=0A=
 =0A=
 	/* We need only read few bytes from the OOB area */=0A=
 	scanlen =3D ooblen =3D 0;=0A=
@@ -82,24 +83,29 @@ static int create_bbt(struct mtd_info *m=0A=
 	startblock =3D 0;=0A=
 	from =3D 0;=0A=
 =0A=
+	ops.mode =3D MTD_OOB_PLACE;=0A=
+	ops.ooblen =3D readlen;=0A=
+	ops.oobbuf =3D buf;=0A=
+	ops.len =3D ops.ooboffs =3D ops.retlen =3D 0;=0A=
+=0A=
 	for (i =3D startblock; i < numblocks; ) {=0A=
 		int ret;=0A=
 =0A=
 		for (j =3D 0; j < len; j++) {=0A=
-			size_t retlen;=0A=
 =0A=
 			/* No need to read pages fully,=0A=
 			 * just read required OOB bytes */=0A=
-			ret =3D onenand_do_read_oob(mtd, from + j * mtd->writesize + =
bd->offs,=0A=
-						  readlen, &retlen, &buf[0]);=0A=
+			ret =3D onenand_bbt_read_oob(mtd, from + j * mtd->writesize + =
bd->offs, &ops);=0A=
 =0A=
-			if (ret)=0A=
-				return ret;=0A=
+			/* If it is a initial bad block, just ignore it */=0A=
+			if (ret =3D=3D ONENAND_BBT_READ_FATAL_ERROR)=0A=
+				return -EIO;=0A=
 =0A=
-			if (check_short_pattern(&buf[j * scanlen], scanlen, mtd->writesize, =
bd)) {=0A=
+			if (ret || check_short_pattern(&buf[j * scanlen], scanlen, =
mtd->writesize, bd)) {=0A=
 				bbm->bbt[i >> 3] |=3D 0x03 << (i & 0x6);=0A=
 				printk(KERN_WARNING "Bad eraseblock %d at 0x%08x\n",=0A=
 					i >> 1, (unsigned int) from);=0A=
+				mtd->ecc_stats.badblocks++;=0A=
 				break;=0A=
 			}=0A=
 		}=0A=
@@ -166,8 +172,8 @@ static int onenand_isbad_bbt(struct mtd_=0A=
  * marked good / bad blocks and writes the bad block table(s) to=0A=
  * the selected place.=0A=
  *=0A=
- * The bad block table memory is allocated here. It must be freed=0A=
- * by calling the onenand_free_bbt function.=0A=
+ * The bad block table memory is allocated here. It is freed=0A=
+ * by the onenand_release function.=0A=
  *=0A=
  */=0A=
 int onenand_scan_bbt(struct mtd_info *mtd, struct nand_bbt_descr *bd)=0A=
Index: fs/jffs2/scan.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvsroot/linux-2.6.18-n800/fs/jffs2/scan.c,v=0A=
retrieving revision 1.1.1.1=0A=
diff -u -p -r1.1.1.1 scan.c=0A=
--- fs/jffs2/scan.c	27 Feb 2007 04:52:39 -0000	1.1.1.1=0A=
+++ fs/jffs2/scan.c	28 Feb 2007 05:13:00 -0000=0A=
@@ -139,6 +139,8 @@ int jffs2_scan_medium(struct jffs2_sb_in=0A=
 	for (i=3D0; i<c->nr_blocks; i++) {=0A=
 		struct jffs2_eraseblock *jeb =3D &c->blocks[i];=0A=
 =0A=
+		cond_resched();=0A=
+=0A=
 		/* reset summary info for next eraseblock scan */=0A=
 		jffs2_sum_reset_collected(s);=0A=
 =0A=
Index: fs/jffs2/summary.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvsroot/linux-2.6.18-n800/fs/jffs2/summary.c,v=0A=
retrieving revision 1.1.1.1=0A=
diff -u -p -r1.1.1.1 summary.c=0A=
--- fs/jffs2/summary.c	27 Feb 2007 04:52:39 -0000	1.1.1.1=0A=
+++ fs/jffs2/summary.c	28 Feb 2007 05:13:16 -0000=0A=
@@ -398,6 +398,8 @@ static int jffs2_sum_process_sum_data(st=0A=
 	for (i=3D0; i<je32_to_cpu(summary->sum_num); i++) {=0A=
 		dbg_summary("processing summary index %d\n", i);=0A=
 =0A=
+		cond_resched();=0A=
+=0A=
 		/* Make sure there's a spare ref for dirty space */=0A=
 		err =3D jffs2_prealloc_raw_node_refs(c, jeb, 2);=0A=
 		if (err)=0A=
Index: include/linux/mtd/bbm.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvsroot/linux-2.6.18-n800/include/linux/mtd/bbm.h,v=0A=
retrieving revision 1.1.1.1=0A=
diff -u -p -r1.1.1.1 bbm.h=0A=
--- include/linux/mtd/bbm.h	27 Feb 2007 04:53:12 -0000	1.1.1.1=0A=
+++ include/linux/mtd/bbm.h	28 Feb 2007 03:19:20 -0000=0A=
@@ -92,6 +92,13 @@ struct nand_bbt_descr {=0A=
  */=0A=
 #define ONENAND_BADBLOCK_POS	0=0A=
 =0A=
+/*=0A=
+ * Bad block scanning errors=0A=
+ */=0A=
+#define ONENAND_BBT_READ_ERROR		1=0A=
+#define ONENAND_BBT_READ_ECC_ERROR	2=0A=
+#define ONENAND_BBT_READ_FATAL_ERROR	4=0A=
+=0A=
 /**=0A=
  * struct bbm_info - [GENERIC] Bad Block Table data structure=0A=
  * @bbt_erase_shift:	[INTERN] number of address bits in a bbt entry=0A=
Index: include/linux/mtd/onenand.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvsroot/linux-2.6.18-n800/include/linux/mtd/onenand.h,v=0A=
retrieving revision 1.1.1.1=0A=
diff -u -p -r1.1.1.1 onenand.h=0A=
--- include/linux/mtd/onenand.h	27 Feb 2007 04:53:12 -0000	1.1.1.1=0A=
+++ include/linux/mtd/onenand.h	28 Feb 2007 03:12:02 -0000=0A=
@@ -1,7 +1,7 @@=0A=
 /*=0A=
  *  linux/include/linux/mtd/onenand.h=0A=
  *=0A=
- *  Copyright (C) 2005-2006 Samsung Electronics=0A=
+ *  Copyright (C) 2005-2007 Samsung Electronics=0A=
  *  Kyungmin Park <kyungmin.park@samsung.com>=0A=
  *=0A=
  * This program is free software; you can redistribute it and/or modify=0A=
@@ -41,14 +41,10 @@ typedef enum {=0A=
 =0A=
 /**=0A=
  * struct onenand_bufferram - OneNAND BufferRAM Data=0A=
- * @block:		block address in BufferRAM=0A=
- * @page:		page address in BufferRAM=0A=
- * @valid:		valid flag=0A=
+ * @blockpage:		block & page address in BufferRAM=0A=
  */=0A=
 struct onenand_bufferram {=0A=
-	int block;=0A=
-	int page;=0A=
-	int valid;=0A=
+	int	blockpage;=0A=
 };=0A=
 =0A=
 /**=0A=
@@ -62,7 +58,6 @@ struct onenand_bufferram {=0A=
  *			partly be set to inform onenand_scan about=0A=
  * @erase_shift:	[INTERN] number of address bits in a block=0A=
  * @page_shift:		[INTERN] number of address bits in a page=0A=
- * @ppb_shift:		[INTERN] number of address bits in a pages per block=0A=
  * @page_mask:		[INTERN] a page per block mask=0A=
  * @bufferram_index:	[INTERN] BufferRAM index=0A=
  * @bufferram:		[INTERN] BufferRAM info=0A=
@@ -87,6 +82,7 @@ struct onenand_bufferram {=0A=
  *			operation is in progress=0A=
  * @state:		[INTERN] the current state of the OneNAND device=0A=
  * @page_buf:		data buffer=0A=
+ * @subpagesize:	[INTERN] holds the subpagesize=0A=
  * @ecclayout:		[REPLACEABLE] the default ecc placement scheme=0A=
  * @bbm:		[REPLACEABLE] pointer to Bad Block Management=0A=
  * @priv:		[OPTIONAL] pointer to private chip date=0A=
@@ -101,7 +97,6 @@ struct onenand_chip {=0A=
 =0A=
 	unsigned int		erase_shift;=0A=
 	unsigned int		page_shift;=0A=
-	unsigned int		ppb_shift;	/* Pages per block shift */=0A=
 	unsigned int		page_mask;=0A=
 =0A=
 	unsigned int		bufferram_index;=0A=
@@ -124,6 +119,7 @@ struct onenand_chip {=0A=
 	onenand_state_t		state;=0A=
 	unsigned char		*page_buf;=0A=
 =0A=
+	int			subpagesize;=0A=
 	struct nand_ecclayout	*ecclayout;=0A=
 =0A=
 	void			*bbm;=0A=
@@ -137,12 +133,16 @@ struct onenand_chip {=0A=
 #define ONENAND_CURRENT_BUFFERRAM(this)		(this->bufferram_index)=0A=
 #define ONENAND_NEXT_BUFFERRAM(this)		(this->bufferram_index ^ 1)=0A=
 #define ONENAND_SET_NEXT_BUFFERRAM(this)	(this->bufferram_index ^=3D 1)=0A=
+#define ONENAND_SET_PREV_BUFFERRAM(this)	(this->bufferram_index ^=3D 1)=0A=
 =0A=
 #define ONENAND_GET_SYS_CFG1(this)					\=0A=
 	(this->read_word(this->base + ONENAND_REG_SYS_CFG1))=0A=
 #define ONENAND_SET_SYS_CFG1(v, this)					\=0A=
 	(this->write_word(v, this->base + ONENAND_REG_SYS_CFG1))=0A=
 =0A=
+#define ONENAND_IS_DDP(this)						\=0A=
+	(this->device_id & ONENAND_DEVICE_IS_DDP)=0A=
+=0A=
 /* Check byte access in OneNAND */=0A=
 #define ONENAND_CHECK_BYTE_ACCESS(addr)		(addr & 0x1)=0A=
 =0A=
Index: include/linux/mtd/onenand_regs.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: =
/home/cvsroot/linux-2.6.18-n800/include/linux/mtd/onenand_regs.h,v=0A=
retrieving revision 1.1.1.1=0A=
diff -u -p -r1.1.1.1 onenand_regs.h=0A=
--- include/linux/mtd/onenand_regs.h	27 Feb 2007 04:53:12 -0000	1.1.1.1=0A=
+++ include/linux/mtd/onenand_regs.h	28 Feb 2007 00:51:46 -0000=0A=
@@ -3,7 +3,8 @@=0A=
  *=0A=
  *  OneNAND Register header file=0A=
  *=0A=
- *  Copyright (C) 2005-2006 Samsung Electronics=0A=
+ *  Copyright (C) 2005-2007 Samsung Electronics=0A=
+ *  Kyungmin Park <kyungmin.park@samsung.com>=0A=
  *=0A=
  * This program is free software; you can redistribute it and/or modify=0A=
  * it under the terms of the GNU General Public License version 2 as=0A=
@@ -80,9 +81,11 @@=0A=
 #define ONENAND_VERSION_PROCESS_SHIFT	(8)=0A=
 =0A=
 /*=0A=
- * Start Address 1 F100h (R/W)=0A=
+ * Start Address 1 F100h (R/W) & Start Address 2 F101h (R/W)=0A=
  */=0A=
 #define ONENAND_DDP_SHIFT		(15)=0A=
+#define ONENAND_DDP_CHIP0		(0)=0A=
+#define ONENAND_DDP_CHIP1		(1 << ONENAND_DDP_SHIFT)=0A=
 =0A=
 /*=0A=
  * Start Address 8 F107h (R/W)=0A=
@@ -179,6 +182,7 @@=0A=
  * ECC Status Reigser FF00h (R)=0A=
  */=0A=
 #define ONENAND_ECC_1BIT		(1 << 0)=0A=
+#define ONENAND_ECC_1BIT_ALL		(0x5555)=0A=
 #define ONENAND_ECC_2BIT		(1 << 1)=0A=
 #define ONENAND_ECC_2BIT_ALL		(0xAAAA)=0A=
 =0A=

------=_NextPart_000_00AB_01C75CAF.E176F410
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_00AB_01C75CAF.E176F410--
