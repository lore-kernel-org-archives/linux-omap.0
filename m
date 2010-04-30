From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Possible bug in onenand_base ?
Date: Fri, 30 Apr 2010 12:05:40 +0200
Message-ID: <u2v70c9a9111004300305n4c86774bm7ed70161ad72d830@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, kyungmin.park@samsung.com
List-Id: linux-omap@vger.kernel.org

Hello all,

After commit 5988af2319781bc8e0ce418affec4e09cfa77907 (mtd:
Flex-OneNAND support) the onenand support for my device is broken.

Before this commit when I run the nandtest program all is ok
---
# nandtest /dev/mtd3
ECC corrections: 0
ECC failures   : 0
Bad blocks     : 0
BBT blocks     : 0
002c0000: checking...
Finished pass 1 successfully
--

Introduced commit 5988af2319781bc8e0ce418affec4e09cfa7790 the nandtest
fails with:
---
# nandtest /dev/mtd3
ECC corrections: 0
ECC failures   : 0
Bad blocks     : 0
BBT blocks     : 0
00000000: reading...
[  299.092041] onenand_wait: ECC error = 0x8488
    ( ... lots of ECC errors ... )
[  299.092041] onenand_wait: ECC error = 0x8488
ECC failed at 00000000
00000000: checking...
compare failed. seed 1804289383
Byte 0x1 is 5a should be da
Byte 0x3 is 82 should be 92
Byte 0x4 is 10 should be 1a
    ( ... )
---

Investigating a little I see a significant difference introduced by
this patch. In line

347:        page = (int) (addr - onenand_addr(this, block)) >>
this->page_shift;   (patch applied)

instead of

347:        page = (int) (addr >> this->page_shift);  (without patch)

I applied commit 5988af2319781bc8e0ce418affec4e09cfa7790 and replaced
the line 347 and now works again. Fantastic, but I suspect this is not
the proper solution (probably this breaks other onenands devices, I
can't test).

I'm just introducing in OneNAND devices so anyone can help me to
understand and solve the problem ? Note that my device is a Numonyx
4-Gbit DDP (DUAL DIE PLAN) OneNAND flash memory ( 2 dice of 2Gb, 2KB
page )

Thanks in advance,

///:~Enric

---
diff --git a/drivers/mtd/onenand/onenand_base.c
b/drivers/mtd/onenand/onenand_base.c
index 081f97d..b1d50a3 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -344,7 +344,7 @@ static int onenand_command(struct mtd_info *mtd,
int cmd, loff_t addr, size_t le

 	default:
 		block = (int) onenand_block(this, addr);
-		page = (int) (addr - onenand_addr(this, block)) >> this->page_shift;
+		page = (int) (addr >> this->page_shift);

 		if (ONENAND_IS_2PLANE(this)) {
 			/* Make the even block number */
---

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
