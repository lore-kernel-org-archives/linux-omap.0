From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 4/4] arch/arm/mach-omap2/smartreflex.c: Add missing IS_ERR test
Date: Mon, 24 Jan 2011 20:55:22 +0100
Message-ID: <1295898922-18822-5-git-send-email-julia@diku.dk>
References: <1295898922-18822-1-git-send-email-julia@diku.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1295898922-18822-1-git-send-email-julia@diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kernel-janitors@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Function _sr_lookup, defined in the same file, returns ERR_PTR not NULL in
an error case.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
identifier f;
@@
f(...) { ... return ERR_PTR(...); }

@@
identifier r.f, fld;
expression x;
statement S1,S2;
@@
 x = f(...)
 ... when != IS_ERR(x)
(
 if (IS_ERR(x) ||...) S1 else S2
|
*x->fld
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 77ecebf..d7deadf 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -966,7 +966,7 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
 	}
 
 	sr_info = _sr_lookup(pdata->voltdm);
-	if (!sr_info) {
+	if (IS_ERR(sr_info)) {
 		dev_warn(&pdev->dev, "%s: omap_sr struct not found\n",
 			__func__);
 		return -EINVAL;
