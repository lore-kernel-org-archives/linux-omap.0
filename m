From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFT 2/8] ARM: OMAP3: clock data: replace 3503/3517 flag with AM35x flag for UART4
Date: Thu, 26 Apr 2012 16:29:47 -0700
Message-ID: <1335482993-14035-3-git-send-email-khilman@ti.com>
References: <1335482993-14035-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:55476 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753398Ab2DZX3J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Apr 2012 19:29:09 -0400
Received: by pbcxa12 with SMTP id xa12so286789pbc.23
        for <linux-omap@vger.kernel.org>; Thu, 26 Apr 2012 16:29:05 -0700 (PDT)
In-Reply-To: <1335482993-14035-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

The AM35x UART4 is common to all AM35x devices, so use CK_AM35XX instead
of (CK_3505 | CK_3517), which is equivalent.

Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>
Tested-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index f4a626f..dac076a 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3419,7 +3419,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"per_48m_fck",	&per_48m_fck,	CK_3XXX),
 	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_3XXX),
 	CLK(NULL,	"uart4_fck",	&uart4_fck,	CK_36XX),
-	CLK(NULL,	"uart4_fck",	&uart4_fck_am35xx, CK_3505 | CK_3517),
+	CLK(NULL,	"uart4_fck",	&uart4_fck_am35xx, CK_AM35XX),
 	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_3XXX),
 	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_3XXX),
 	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_3XXX),
-- 
1.7.9.2

