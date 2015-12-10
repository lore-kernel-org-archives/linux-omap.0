From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 46/58] mtd: nand: update the documentation to
 reflect framework changes
Date: Thu, 10 Dec 2015 09:00:30 +0100
Message-ID: <1449734442-18672-47-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBIHGUSZQKGQEV4VVQLI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Krzysztof Halasa <khalasa-NlWvg49iv0c@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Clouter <alex-L4GPcECwBoDe9xe1eoZjHA@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>a
List-Id: linux-omap@vger.kernel.org

The MTD device is now directly embedded in the nand_chip struct. Update the
mtdnand documentation to mention this aspect and fix the different
examples.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 Documentation/DocBook/mtdnand.tmpl | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/Documentation/DocBook/mtdnand.tmpl b/Documentation/DocBook/mtdnand.tmpl
index 403a7ab..b442921 100644
--- a/Documentation/DocBook/mtdnand.tmpl
+++ b/Documentation/DocBook/mtdnand.tmpl
@@ -162,12 +162,15 @@
 	<sect1 id="Basic_defines">
 		<title>Basic defines</title>
 		<para>
-			At least you have to provide a mtd structure and
-			a storage for the ioremap'ed chip address.
-			You can allocate the mtd structure using kmalloc
-			or you can allocate it statically.
-			In case of static allocation you have to allocate
-			a nand_chip structure too.
+			At least you have to provide a nand_chip structure
+			and a storage for the ioremap'ed chip address.
+			You can allocate the nand_chip structure using
+			kmalloc or you can allocate it statically.
+			The NAND chip structure embeds an mtd structure
+			which will be registered to the MTD subsystem.
+			You can extract a pointer to the mtd structure
+			from a nand_chip pointer using the nand_to_mtd()
+			helper.
 		</para>
 		<para>
 			Kmalloc based example
@@ -180,7 +183,6 @@ static void __iomem *baseaddr;
 			Static example
 		</para>
 		<programlisting>
-static struct mtd_info board_mtd;
 static struct nand_chip board_chip;
 static void __iomem *baseaddr;
 		</programlisting>
@@ -274,13 +276,15 @@ static int __init board_init (void)
 	int err = 0;
 
 	/* Allocate memory for MTD device structure and private data */
-	board_mtd = kzalloc(sizeof(struct mtd_info) + sizeof(struct nand_chip), GFP_KERNEL);
-	if (!board_mtd) {
+	this = kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
+	if (!this) {
 		printk ("Unable to allocate NAND MTD device structure.\n");
 		err = -ENOMEM;
 		goto out;
 	}
 
+	board_mtd = nand_to_mtd(this);
+
 	/* map physical address */
 	baseaddr = ioremap(CHIP_PHYSICAL_ADDRESS, 1024);
 	if (!baseaddr) {
@@ -289,11 +293,6 @@ static int __init board_init (void)
 		goto out_mtd;
 	}
 
-	/* Get pointer to private data */
-	this = (struct nand_chip *) ();
-	/* Link the private data with the MTD structure */
-	board_mtd->priv = this;
-
 	/* Set address of NAND IO lines */
 	this->IO_ADDR_R = baseaddr;
 	this->IO_ADDR_W = baseaddr;
@@ -317,7 +316,7 @@ static int __init board_init (void)
 out_ior:
 	iounmap(baseaddr);
 out_mtd:
-	kfree (board_mtd);
+	kfree (this);
 out:
 	return err;
 }
@@ -343,7 +342,7 @@ static void __exit board_cleanup (void)
 	iounmap(baseaddr);
 	
 	/* Free the MTD device structure */
-	kfree (board_mtd);
+	kfree (mtd_to_nand(board_mtd));
 }
 module_exit(board_cleanup);
 #endif
-- 
2.1.4
