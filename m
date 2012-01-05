From: Kevin Hilman <khilman@ti.com>
Subject: [RFC/PATCH 2/7] ARM: OMAP3: clock data: replace 3503/3517 flag with AM35x flag for UART4
Date: Wed,  4 Jan 2012 17:16:41 -0800
Message-ID: <1325726206-11199-3-git-send-email-khilman@ti.com>
References: <1325726206-11199-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:33349 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751923Ab2AEBRb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jan 2012 20:17:31 -0500
Received: by ggnq1 with SMTP id q1so12638ggn.39
        for <linux-omap@vger.kernel.org>; Wed, 04 Jan 2012 17:16:53 -0800 (PST)
In-Reply-To: <1325726206-11199-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Vaibhav Hiremath <hvaibhav@ti.com>

The AM35x UART4 is common to all AM35x devices, so use CK_AM35XX instead
of (CK_3505 | CK_3517), which is equivalent.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d75e5f6..e09e506 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3411,7 +3411,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"per_48m_fck",	&per_48m_fck,	CK_3XXX),
 	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_3XXX),
 	CLK(NULL,	"uart4_fck",	&uart4_fck,	CK_36XX),
-	CLK(NULL,	"uart4_fck",	&uart4_fck_am35xx, CK_3505 | CK_3517),
+	CLK(NULL,	"uart4_fck",	&uart4_fck_am35xx, CK_AM35XX),
 	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_3XXX),
 	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_3XXX),
 	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_3XXX),
-- 
1.7.8.2

