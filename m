From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3] CLK: TI: consider the fact that of_clk_get() might return
 an error
Date: Thu, 18 Sep 2014 16:33:27 +0200
Message-ID: <20140918143327.GA4418@linutronix.de>
References: <1410451272-31068-1-git-send-email-bigeasy@linutronix.de>
 <54198411.1080706@ti.com>
 <20140917155623.GA28043@linutronix.de>
 <20140917163559.GA25790@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55224 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755694AbaIROd3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2014 10:33:29 -0400
Content-Disposition: inline
In-Reply-To: <20140917163559.GA25790@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org

I "forgot" to update the dtb and the kernel crashed:
|Unable to handle kernel NULL pointer dereference at virtual address 00=
00002e
|PC is at __clk_get_flags+0x4/0xc
|LR is at ti_dt_clockdomains_setup+0x70/0xe8

because I did not have the clock nodes. of_clk_get() returns an error
pointer which is not checked here.

Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 v2=E2=80=A6v3:
    - added acked by
    - fixed "CHECK: Alignment should match open parenthesis"
   =20
 v1=E2=80=A6v2:
     add "%s __func__" to the added pr_err

 drivers/clk/ti/clockdomain.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.=
c
index f1e0038d76ac..b4c5faccaece 100644
--- a/drivers/clk/ti/clockdomain.c
+++ b/drivers/clk/ti/clockdomain.c
@@ -36,6 +36,11 @@ static void __init of_ti_clockdomain_setup(struct de=
vice_node *node)
=20
 	for (i =3D 0; i < num_clks; i++) {
 		clk =3D of_clk_get(node, i);
+		if (IS_ERR(clk)) {
+			pr_err("%s: Failed get %s' clock nr %d (%ld)\n",
+			       __func__, node->full_name, i, PTR_ERR(clk));
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
