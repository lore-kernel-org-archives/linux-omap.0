From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2] CLK: TI: consider the fact that of_clk_get() might return
 an error
Date: Wed, 17 Sep 2014 17:56:23 +0200
Message-ID: <20140917155623.GA28043@linutronix.de>
References: <1410451272-31068-1-git-send-email-bigeasy@linutronix.de>
 <54198411.1080706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49688 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755698AbaIQP4Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2014 11:56:25 -0400
Content-Disposition: inline
In-Reply-To: <54198411.1080706@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org

I "forgot" to update the dtb and the kernel crashed:
|Unable to handle kernel NULL pointer dereference at virtual address 00=
00002e
|PC is at __clk_get_flags+0x4/0xc
|LR is at ti_dt_clockdomains_setup+0x70/0xe8

because I did not have the clock nodes. of_clk_get() returns an error
pointer which is not checked here.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2:
    add "%s __func__" to the added pr_err

* Nishanth Menon | 2014-09-17 07:52:33 [-0500]:
>
>Could you add %s: __func__ as well - it kinda helps understand this
>is part of clockdomain setup and not some driver cribbing that it did
>not get some clock.

As you wish.

 drivers/clk/ti/clockdomain.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.=
c
index f1e0038d76ac..446481166ce9 100644
--- a/drivers/clk/ti/clockdomain.c
+++ b/drivers/clk/ti/clockdomain.c
@@ -36,6 +36,12 @@ static void __init of_ti_clockdomain_setup(struct de=
vice_node *node)
=20
 	for (i =3D 0; i < num_clks; i++) {
 		clk =3D of_clk_get(node, i);
+		if (IS_ERR(clk)) {
+			pr_err("%s: Failed get %s' clock nr %d (%ld)\n",
+					__func__, node->full_name, i,
+					PTR_ERR(clk));
+			continue;
+		}
 		if (__clk_get_flags(clk) & CLK_IS_BASIC) {
 			pr_warn("can't setup clkdm for basic clk %s\n",
 				__clk_get_name(clk));
--=20
2.1.0
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
