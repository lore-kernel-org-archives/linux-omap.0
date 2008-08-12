From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] OMAP2 clock: associate clocks with clockdomains at startup
Date: Tue, 12 Aug 2008 15:31:44 -0600
Message-ID: <20080812213141.24628.45988.stgit@localhost.localdomain>
References: <20080812212919.24628.82229.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49195 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbYHLVdv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 17:33:51 -0400
In-Reply-To: <20080812212919.24628.82229.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, felipe.balbi@nokia.com

The OMAP2 clock code was missing code to associate clocks with clockdomains
at registration time; fix this.

Resolves "Unhandled fault: alignment exception (0x001) at 0xc02c1b4e" (address
may vary) panic during clock framework init on OMAP2.  The alignment error
was caused by an attempt to dereference a pointer to a string (1-byte aligned)
as if it were a pointer to a structure.

Thanks to Felipe Balbi <felipe.balbi@nokia.com> for originally reporting this
bug.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/clock24xx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 370f4f0..0d9d91f 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -567,11 +567,13 @@ int __init omap2_clk_init(void)
 
 		if ((*clkp)->flags & CLOCK_IN_OMAP242X && cpu_is_omap2420()) {
 			clk_register(*clkp);
+			omap2_init_clk_clkdm(*clkp);
 			continue;
 		}
 
 		if ((*clkp)->flags & CLOCK_IN_OMAP243X && cpu_is_omap2430()) {
 			clk_register(*clkp);
+			omap2_init_clk_clkdm(*clkp);
 			continue;
 		}
 	}


