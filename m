From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCHv3] OMAP3: SDRC : Add comments on Errata i520 for Global
 SW reset
Date: Wed, 22 Dec 2010 09:56:15 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012220955410.21915@utopia.booyaka.com>
References: <1286287534-9160-1-git-send-email-vishwanath.bs@ti.com> <alpine.DEB.2.00.1010050917080.13816@utopia.booyaka.com> <f689bb3a487cd0df148a70449cc9ded5@mail.gmail.com> <alpine.DEB.2.00.1012220943370.21915@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55399 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab0LVQ4Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 11:56:16 -0500
In-Reply-To: <alpine.DEB.2.00.1012220943370.21915@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@deeprootsystems.com

On Wed, 22 Dec 2010, Paul Walmsley wrote:

> On Wed, 22 Dec 2010, Vishwanath Sripathy wrote:
> 
> > Do you intend to merge this patch for 2.6.38? I did not see this in your
> > pull request.

Here's the updated patch.


- Paul


From: Vishwanath BS <vishwanath.bs@ti.com>
Date: Tue, 5 Oct 2010 19:35:34 +0530
Subject: [PATCH] OMAP3: SDRC: Add comments on Errata i520 for Global SW reset

This patch adds comments on precaution to be taken if Global Warm reset is
used as the means to trigger system reset.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
[paul@pwsan.com: fixed typos, one mentioned by Sanjeev]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/prcm.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index c22e726..679bcd2 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -74,6 +74,34 @@ void omap_prcm_arch_reset(char mode, const char *cmd)
 		WARN_ON(1);
 	}
 
+	/*
+	 * As per Errata i520, in some cases, user will not be able to
+	 * access DDR memory after warm-reset.
+	 * This situation occurs while the warm-reset happens during a read
+	 * access to DDR memory. In that particular condition, DDR memory
+	 * does not respond to a corrupted read command due to the warm
+	 * reset occurrence but SDRC is waiting for read completion.
+	 * SDRC is not sensitive to the warm reset, but the interconnect is
+	 * reset on the fly, thus causing a misalignment between SDRC logic,
+	 * interconnect logic and DDR memory state.
+	 * WORKAROUND:
+	 * Steps to perform before a Warm reset is trigged:
+	 * 1. enable self-refresh on idle request
+	 * 2. put SDRC in idle
+	 * 3. wait until SDRC goes to idle
+	 * 4. generate SW reset (Global SW reset)
+	 *
+	 * Steps to be performed after warm reset occurs (in bootloader):
+	 * if HW warm reset is the source, apply below steps before any
+	 * accesses to SDRAM:
+	 * 1. Reset SMS and SDRC and wait till reset is complete
+	 * 2. Re-initialize SMS, SDRC and memory
+	 *
+	 * NOTE: Above work around is required only if arch reset is implemented
+	 * using Global SW reset(GLOBAL_SW_RST). DPLL3 reset does not need
+	 * the WA since it resets SDRC as well as part of cold reset.
+	 */
+
 	/* XXX should be moved to some OMAP2/3 specific code */
 	omap2_prm_set_mod_reg_bits(OMAP_RST_DPLL3_MASK, prcm_offs,
 				   OMAP2_RM_RSTCTRL);
-- 
1.7.2.3

