From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] OMAP2xxx clock: set up clockdomain pointer in struct clk
Date: Wed, 14 Oct 2009 16:31:45 -0600
Message-ID: <20091014223140.5545.77829.stgit@localhost.localdomain>
References: <20091014222609.5545.7736.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51798 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756937AbZJNWeS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 18:34:18 -0400
In-Reply-To: <20091014222609.5545.7736.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Stefano Panella <Stefano.Panella@csr.com>, Carlos Aguiar <carlos.aguiar@indt.org.br>, linux-arm-kernel@lists.arm.linux.org.uk

clock24xx.c is missing a omap2_init_clk_clkdm() in its
omap2_clk_init() function.  Among other bad effects, this causes the
OMAP hwmod layer to oops on boot.

Thanks to Carlos Aguiar <carlos.aguiar@indt.org.br> and Stefano
Panella <Stefano.Panella@csr.com> for reporting this bug.  Thanks to Tony
Lindgren <tony@atomide.com> for N800 booting advice.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: Stefano Panella <Stefano.Panella@csr.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock24xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index bc5d3ac..e2dbedd 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -769,6 +769,7 @@ int __init omap2_clk_init(void)
 		if (c->cpu & cpu_mask) {
 			clkdev_add(&c->lk);
 			clk_register(c->lk.clk);
+			omap2_init_clk_clkdm(c->lk.clk);
 		}
 
 	/* Check the MPU rate set by bootloader */


