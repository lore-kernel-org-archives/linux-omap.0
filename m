From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 10/12] OMAP3: clock: fix incorrect rate display when switching
	MPU rate at boot
Date: Mon, 13 Dec 2010 23:34:53 -0700
Message-ID: <20101214063452.21555.26259.stgit@twilight.localdomain>
References: <20101214063308.21555.76050.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50291 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859Ab0LNGf1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 01:35:27 -0500
In-Reply-To: <20101214063308.21555.76050.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Richard Woodruff <r-woodruff2@ti.com>, Bruno Guerin <br.guerin@free.fr>

The OMAP3 clock code contains some legacy code to allow the MPU rate
to be specified as a kernel command line parameter.  If the 'mpurate'
parameter is specified, the kernel will attempt to switch the MPU rate
to this rate during boot.  As part of this process, a short message
"Switched to new clocking rate" is generated -- and in this message,
the "Core" clock rate and "MPU" clock rate are transposed.

This patch ensures that the clock rates are displayed in the correct
order.

Thanks to Bruno Guerin <br_guerin@free.fr> for reporting this bug and
proposing a fix.  Thanks to Richard Woodruff <r-woodruff2@ti.com> for
reviewing the problem and passing the report on.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Bruno Guerin <br.guerin@free.fr>
Cc: Richard Woodruff <r-woodruff2@ti.com>
---
 arch/arm/mach-omap2/clock3xxx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xxx.c
index a447c4d..90b9477 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -94,7 +94,7 @@ static int __init omap3xxx_clk_arch_init(void)
 
 	ret = omap2_clk_switch_mpurate_at_boot("dpll1_ck");
 	if (!ret)
-		omap2_clk_print_new_rates("osc_sys_ck", "arm_fck", "core_ck");
+		omap2_clk_print_new_rates("osc_sys_ck", "core_ck", "arm_fck");
 
 	return ret;
 }


