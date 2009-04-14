From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/7] OMAP2xxx clock: init osc_ck, sys_ck internal lists early
Date: Tue, 14 Apr 2009 12:23:27 -0600
Message-ID: <20090414182324.22344.71159.stgit@localhost.localdomain>
References: <20090414182039.22344.49790.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45702 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755514AbZDNS1M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 14:27:12 -0400
In-Reply-To: <20090414182039.22344.49790.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Paul Walmsley <paul@pwsan.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org

Commit 3f0a820c4c0b4670fb5f164baa5582e23c2ef118 breaks OMAP2xxx boot
during initial propagate_rate() on osc_ck and sys_ck.  Fix by calling
clk_init_one() for these clocks first.

Resolves

<1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
<1>pgd = c0004000
<1>[00000000] *pgd=00000000
Internal error: Oops: 5 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.29-omap1 #37)
PC is at propagate_rate+0x10/0x60
LR is at omap2_clk_init+0x30/0x218
...

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Tested-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock24xx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 1e839c5..3b7ecc6 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -720,6 +720,8 @@ int __init omap2_clk_init(void)
 
 	clk_init(&omap2_clk_functions);
 
+	clk_init_one(&osc_ck);
+	clk_init_one(&sys_ck);
 	osc_ck.rate = omap2_osc_clk_recalc(&osc_ck);
 	propagate_rate(&osc_ck);
 	sys_ck.rate = omap2_sys_clk_recalc(&sys_ck);


