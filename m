From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mfd: omap-usb-tll: Replace zero-length array with
 flexible-array member
Date: Wed, 12 Feb 2020 17:56:42 -0600
Message-ID: <20200212235642.GA19206@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway30.websitewelcome.com ([50.116.127.1]:24100 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729256AbgBMARA (ORCPT
        <rfc822;linux-omap@vger.kernel.org>);
        Wed, 12 Feb 2020 19:17:00 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 32FF67279C
        for <linux-omap@vger.kernel.org>; Wed, 12 Feb 2020 17:56:46 -0600 (CST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mfd/omap-usb-tll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 265f5e350e1c..1cf259a48966 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -99,7 +99,7 @@
 struct usbtll_omap {
 	void __iomem	*base;
 	int		nch;		/* num. of channels */
-	struct clk	*ch_clk[0];	/* must be the last member */
+	struct clk	*ch_clk[];	/* must be the last member */
 };
 
 /*-------------------------------------------------------------------------*/
-- 
2.23.0
