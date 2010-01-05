From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 1/4] OMAP2xxx clock: clk2xxx.c doesn't compile if CPUFREQ
	is enabled
Date: Tue, 05 Jan 2010 10:35:12 -0700
Message-ID: <20100105173508.15485.26838.stgit@localhost.localdomain>
References: <20100105173347.15485.42853.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32791 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041Ab0AERgt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 12:36:49 -0500
In-Reply-To: <20100105173347.15485.42853.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

if we enable CPUFREQ we can't build omap2 for two reasons,
one of them is fixed by the patch below.

It's failing because the __must_be_array() check in
ARRAY_SIZE() is failing and printing the following message:

arch/arm/mach-omap2/clock2xxx.c:453: error: negative width in bit-field '<anonymous>'

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
[paul@pwsan.com: commit message updated; changed rate variable name]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock2xxx.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index d0e3fb7..ce6742f 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -455,12 +455,15 @@ static struct cpufreq_frequency_table freq_table[ARRAY_SIZE(rate_table)];
 void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 {
 	struct prcm_config *prcm;
+	long sys_ck_rate;
 	int i = 0;
 
+	sys_ck_rate = clk_get_rate(sclk);
+
 	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
 		if (!(prcm->flags & cpu_mask))
 			continue;
-		if (prcm->xtal_speed != sys_ck.rate)
+		if (prcm->xtal_speed != sys_ck_rate)
 			continue;
 
 		/* don't put bypass rates in table */


