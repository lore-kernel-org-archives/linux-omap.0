From: =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
Subject: [PATCH 1/8] ARM: etm: Don't require clock control
Date: Mon, 14 Feb 2011 22:11:09 -0800
Message-ID: <1297750276-12475-1-git-send-email-arve@android.com>
References: <1296701663-12168-1-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45219 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab1BOGLq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 01:11:46 -0500
In-Reply-To: <1296701663-12168-1-git-send-email-arve@android.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Russell King <linux@arm.linux.org.uk>, Alexander Shishkin <virtuoso@slind.org>, Jason Wessel <jason.wessel@windriver.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org

If clk_get fail, assume the etb does not need a separate clock.

Signed-off-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
---
 arch/arm/kernel/etm.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index 11db628..d4ec368 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -361,13 +361,12 @@ static int __init etb_probe(struct amba_device *d=
ev, struct amba_id *id)
 	if (ret)
 		goto out_unmap;
=20
+	/* Get optional clock. Currently used to select clock source on omap3=
 */
 	t->emu_clk =3D clk_get(&dev->dev, "emu_src_ck");
-	if (IS_ERR(t->emu_clk)) {
+	if (IS_ERR(t->emu_clk))
 		dev_dbg(&dev->dev, "Failed to obtain emu_src_ck.\n");
-		return -EFAULT;
-	}
-
-	clk_enable(t->emu_clk);
+	else
+		clk_enable(t->emu_clk);
=20
 	etb_unlock(t);
 	t->etb_bufsz =3D etb_readl(t, ETBR_DEPTH);
@@ -402,8 +401,10 @@ static int etb_remove(struct amba_device *dev)
 	iounmap(t->etb_regs);
 	t->etb_regs =3D NULL;
=20
-	clk_disable(t->emu_clk);
-	clk_put(t->emu_clk);
+	if (!IS_ERR(t->emu_clk)) {
+		clk_disable(t->emu_clk);
+		clk_put(t->emu_clk);
+	}
=20
 	amba_release_regions(dev);
=20
--=20
1.7.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
