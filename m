From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH] arm: omap2: clk2xxx.c doesn't compile if CPUFREQ is enabled
Date: Wed, 30 Dec 2009 14:30:13 +0200
Message-ID: <1262176213-16912-1-git-send-email-me@felipebalbi.com>
References: <1261784154-18550-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:45026 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395AbZL3MaV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Dec 2009 07:30:21 -0500
In-Reply-To: <1261784154-18550-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

if we enable CPUFREQ we can't build omap2 for two reasons,
one of them is fixed by the patch below but the other one
it seems like it'll need more invasive changes to the code
so I'll leave it for you to decide how to do it.

It's failing because the __must_be_array() check in
ARRAY_SIZE() is failing and printing the following message:

arch/arm/mach-omap2/clock2xxx.c:453: error: negative width in bit-field '<anonymous>'

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/clock2xxx.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index d0e3fb7..4e2bdfe 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -455,12 +455,15 @@ static struct cpufreq_frequency_table freq_table[ARRAY_SIZE(rate_table)];
 void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 {
 	struct prcm_config *prcm;
+	long rate;
 	int i = 0;
 
+	rate = clk_get_rate(sclk);
+
 	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
 		if (!(prcm->flags & cpu_mask))
 			continue;
-		if (prcm->xtal_speed != sys_ck.rate)
+		if (prcm->xtal_speed != rate)
 			continue;
 
 		/* don't put bypass rates in table */
-- 
1.6.6.35.g1d85d

