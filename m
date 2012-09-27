From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ARM: OMAP2+: PM: fix return value check in omap2_set_init_voltage()
Date: Thu, 27 Sep 2012 13:54:36 +0800
Message-ID: <CAPgLHd-q3rF822NrpJQcMgr2=BNAp=p_rbRdEXp-gSutnjuBFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:38591 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab2I0Fyh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Sep 2012 01:54:37 -0400
Received: by mail-qc0-f174.google.com with SMTP id d3so786900qch.19
        for <linux-omap@vger.kernel.org>; Wed, 26 Sep 2012 22:54:36 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com, tony@atomide.com, linux@arm.linux.org.uk
Cc: yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function voltdm_lookup() returns NULL
not ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap2/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 9cb5ced..ab15e5c 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -176,7 +176,7 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
 	}
 
 	voltdm = voltdm_lookup(vdd_name);
-	if (IS_ERR(voltdm)) {
+	if (!voltdm) {
 		pr_err("%s: unable to get vdd pointer for vdd_%s\n",
 			__func__, vdd_name);
 		goto exit;

