From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH] omap-hw: kill eccsize
Date: Mon, 05 Mar 2007 14:35:21 +0100
Message-ID: <851wk37qzq.fsf@orfeo.duckcorp.org>
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


mtd->eccsize has been removed in commit
mtd->64f60710568db5cec1a76c1d1e261b239f9ef809. Let's remove it in the
mtd->omap-hw driver.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=omap_hw_fix.patch

---
 drivers/mtd/nand/omap-hw.c |    1 	0 +	1 -	0 !
 1 file changed, 1 deletion(-)

Index: linux-omap-2.6/drivers/mtd/nand/omap-hw.c
===================================================================
--- linux-omap-2.6.orig/drivers/mtd/nand/omap-hw.c	2007-03-02 00:41:17.000000000 +0100
+++ linux-omap-2.6/drivers/mtd/nand/omap-hw.c	2007-03-02 01:01:30.000000000 +0100
@@ -824,7 +824,6 @@ static int __init omap_nand_init(void)
 		this->ecc.steps = 1;
 		this->ecc.size = 2048;
 		this->ecc.bytes = 12;
-		omap_mtd->eccsize = 2048;
 		nand_write_reg(NND_ECC_SELECT, 6);
 	}
 

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-=-=--
