From: Shawn RONG <shawn.rong@st.com>
Subject: question about nand_do_read_oob/nand_do_read_ops
 when "mtd_oob_ops.mode==MTD_OOB_PLACE"?
Date: Thu, 12 Jul 2007 09:48:40 +0800 (HKT)
Message-ID: <20070712094840.CJS07601@mail1.sha.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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

Hi all,

Based on doc "[MTD] Rework the out of band handling completely", I think when MTD_OOB_PLACE is selected, the read length should have nothing to do with value of mtd_oob_ops.oobavail, which is only related with MTD_OOB_AUTO mode.(See reference in the end)

while in function nand_do_read_oob() and nand_do_read_ops() in nand_base.c, the read length is affected by value of mtd_oob_ops.oobavail, e.g.
========================================================
nand_do_read_oob():
if (ops->mode == MTD_OOB_RAW)
len = mtd->oobsize;
else
len = chip->ecc.layout->oobavail;
========================================================
nand_do_read_ops():
if (ops->mode != MTD_OOB_RAW) {
int toread = min(oobreadlen,
chip->ecc.layout->oobavail);
if (toread) {
oob = nand_transfer_oob(chip,
oob, ops, toread);
oobreadlen -= toread;
}
} else
buf = nand_transfer_oob(chip,
buf, ops, mtd->oobsize);
========================================================

Could anyone tell me why? I think handle above for mode MTD_OOB_PLACE should be same to MTD_OOB_RAW, not MTD_OOB_AUTO.

Someone has also the same question: http://lists.infradead.org/pipermail/linux-mtd/2007-February/017469.html

In his test, maybe this is a bug?

Any feedback would be appreciated, thanks!

Reference:
========================================================
http://lists.infradead.org/pipermail/linux-mtd-cvs/2006-May/005519.html

MTD_OOB_PLACE puts/gets the given oob data exactly to/from the place which is described by the ooboffs and ooblen fields of the mtd_oob_ops strcuture. It's up to the caller to make sure that the byte positions are not used by the ECC placement algorithms.
========================================================
