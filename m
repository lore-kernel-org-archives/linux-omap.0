From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ARM: OMAP: fix return value check in realtime_counter_init()
Date: Sun, 7 Oct 2012 21:58:55 +0800
Message-ID: <CAPgLHd_X+vT-AtkHCAmmieEtdQbVz6RcUWogY83qZyvzK_tidA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:63983 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760Ab2JGN6z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Oct 2012 09:58:55 -0400
Received: by mail-qc0-f180.google.com with SMTP id v28so2212847qcm.11
        for <linux-omap@vger.kernel.org>; Sun, 07 Oct 2012 06:58:55 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk
Cc: yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function clk_get() returns ERR_PTR()
and never returns NULL. The NULL test in the return value
check should be replaced with IS_ERR().

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap2/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 8847d6e..44f9aa7 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -378,7 +378,7 @@ static void __init realtime_counter_init(void)
 		return;
 	}
 	sys_clk = clk_get(NULL, "sys_clkin_ck");
-	if (!sys_clk) {
+	if (IS_ERR(sys_clk)) {
 		pr_err("%s: failed to get system clock handle\n", __func__);
 		iounmap(base);
 		return;

