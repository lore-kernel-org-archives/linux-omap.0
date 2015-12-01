From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 11/25] coccinelle: nand: detect and correct
 drivers embedding an mtd_info object
Date: Tue,  1 Dec 2015 12:03:08 +0100
Message-ID: <1448967802-25796-12-git-send-email-boris.brezillon@free-electrons.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBD756WZAKGQE5BBHV6Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1448967802-25796-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
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

Add nand-priv-no-mtd.cocci to detect and correct NAND controller drivers
directly embedding an mtd_info struct in their private struct.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
---
Hi Julia,

Not sure this is the correct way to detect and fix offending drivers,
but I get some warnings when launching coccicheck in org or report mode:

"warning: fix2: inherited metavariable __chipfield not used in the -, +,
or context code"

Note that I don't get those warnings when running in patch mode.

Any idea (feel free to propose a better solution to detect and fix those
offending drivers)?

Best Regards,

Boris
---
 scripts/coccinelle/api/nand-priv-no-mtd.cocci | 91 +++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 scripts/coccinelle/api/nand-priv-no-mtd.cocci

diff --git a/scripts/coccinelle/api/nand-priv-no-mtd.cocci b/scripts/coccinelle/api/nand-priv-no-mtd.cocci
new file mode 100644
index 0000000..b2c0c22
--- /dev/null
+++ b/scripts/coccinelle/api/nand-priv-no-mtd.cocci
@@ -0,0 +1,91 @@
+/// Fix NAND controller drivers declaring their own mtd_info struct instead
+/// of the one provided in struct nand_chip.
+///
+// Confidence: Low
+// Copyright: (C) 2015 Boris Brezillon GPL v2.
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+@match1@
+identifier __chipfield, __mtdfield;
+type __type;
+@@
+(
+	__type {
+		...
+		struct nand_chip __chipfield;
+		...
+		struct mtd_info __mtdfield;
+		...
+	};
+|
+	__type {
+		...
+		struct mtd_info __mtdfield;
+		...
+		struct nand_chip __chipfield;
+		...
+	};
+)
+
+@fix1 depends on match1 && patch && !context && !org && !report@
+identifier match1.__mtdfield;
+type match1.__type;
+@@
+	__type {
+		...
+-		struct mtd_info __mtdfield;
+		...
+	};
+
+@fix2 depends on match1 && patch && !context && !org && !report@
+identifier match1.__chipfield, match1.__mtdfield;
+identifier __subfield;
+type match1.__type;
+__type *__priv;
+@@
+<...
+(
+-	__priv->__mtdfield.__subfield
++	nand_to_mtd(&__priv->__chipfield)->__subfield
+|
+-	&(__priv->__mtdfield)
++	nand_to_mtd(&__priv->__chipfield)
+)
+...>
+
+// ----------------------------------------------------------------------------
+
+@fix1_context depends on match1 && !patch && (context || org || report)@
+identifier match1.__mtdfield;
+type match1.__type;
+position j0;
+@@
+
+	__type {
+		...
+*		struct mtd_info __mtdfield@j0;
+		...
+	};
+
+// ----------------------------------------------------------------------------
+
+@script:python fix1_org depends on org@
+j0 << fix1_context.j0;
+@@
+
+msg = "struct nand_chip already embeds an mtd_info object (use nand_to_mtd())."
+coccilib.org.print_todo(j0[0], msg)
+
+// ----------------------------------------------------------------------------
+
+@script:python fix1_report depends on report@
+j0 << fix1_context.j0;
+@@
+
+msg = "struct nand_chip already embeds an mtd_info object (use nand_to_mtd())."
+coccilib.report.print_report(j0[0], msg)
+
-- 
2.1.4
