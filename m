From: Brian Hutchinson <b.hutchman@gmail.com>
Subject: [RESEND PATCH] Add timer_32k_ck alias for dm816x in clk-816x.c
Date: Mon, 15 Jun 2015 14:59:12 -0400
Message-ID: <CAFZh4h-bdz4Q1fKXNVRYWNwp7wmvUrQmuWEwMjBtYwGtgk9-qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:35469 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756149AbbFOS7N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jun 2015 14:59:13 -0400
Received: by obbgp2 with SMTP id gp2so70670890obb.2
        for <linux-omap@vger.kernel.org>; Mon, 15 Jun 2015 11:59:12 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Resend of patch since it was kicked back ... probably got out of plain
text mode somehow.

dm816x needs timer_32k_ck alias to use dual mode timers in dmtimers.c

This adds a timer_32k_ck alias for sys_32_ck in clk-816x.c so
omap_dm_timer_set_source will work for dm816x.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Brian Hutchinson <b.hutchman@gmail.com>

--- drivers/clk/ti/clk-816x.c_
orig      2015-06-15 13:46:53.058128064 -0400
+++ drivers/clk/ti/clk-816x.c   2015-06-15 13:47:28.966306123 -0400
@@ -18,6 +18,7 @@ static struct ti_dt_clk dm816x_clks[] =
        DT_CLK(NULL, "sys_clkin", "sys_clkin_ck"),
        DT_CLK(NULL, "timer_sys_ck", "sys_clkin_ck"),
        DT_CLK(NULL, "sys_32k_ck", "sys_32k_ck"),
+       DT_CLK(NULL, "timer_32k_ck", "sys_32k_ck"),
        DT_CLK(NULL, "mpu_ck", "mpu_ck"),
        DT_CLK(NULL, "timer1_fck", "timer1_fck"),
        DT_CLK(NULL, "timer2_fck", "timer2_fck"),
