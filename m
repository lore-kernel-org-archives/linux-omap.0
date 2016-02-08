From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 3/3] pci: dra7xx: use pdata callbacks to perform
 reset
Date: Mon, 8 Feb 2016 02:48:30 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1602080208070.2182@utopia.booyaka.com>
References: <1452780672-14339-1-git-send-email-kishon@ti.com> <1452780672-14339-4-git-send-email-kishon@ti.com> <20160127173104.GQ19432@atomide.com> <56A90971.4020409@ti.com> <20160127185649.GV19432@atomide.com> <56A94FB7.6020903@ti.com> <20160128183156.GH19432@atomide.com>
 <56B087AD.4000505@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56B087AD.4000505@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Bjorn Helgaas <bhelgaas@google.com>, richardcochran@gmail.com, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Tue, 2 Feb 2016, Kishon Vijay Abraham I wrote:

> Paul, what do you think is the best way forward to perform reset?

Many of the IP blocks with PRM hardreset lines are processor IP blocks. 
Those often need special reset handling to ensure that WFI/HLT-like 
instructions are executed after reset.  This special handling ensures that 
the IP blocks' bus initiator interfaces indicate that they are in standby 
to the PRCM - thus allowing power management for the rest of the chip to 
work correctly.

But that doesn't seem to be the case with PCIe - and maybe others - 
possibly some of the MMUs?  So how about just creating a new hwmod flag to 
mark all of the initiator IP blocks that require driver-based special 
handling during _enable() - i.e., most of the processor IP blocks. Then 
for the rest, like PCIe, implement a default behavior in the hwmod code to 
automatically release the IP block's hardreset lines in 
omap_hwmod.c:_enable()?  Something similar to what's enclosed at the 
bottom of this message.  I've annotated what will be needed in the 
OMAP44xx file; similar flags will be needed in any other hwmod data file 
that contains IP blocks with hard reset lines defined.

Either that - or you could write custom reset handlers for all of the 
processor IP blocks that put them into WFI/HLT.

I leave it to you TI folks to write and test the actual patches, since as 
you probably know, I don't have any DRA7xx/AM57xx boards in the testbed.  

As far as reasserting hardreset in *remove(), there's already hwmod code 
to do that in omap_hwmod.c:_shutdown().  I don't recall any more if we 
currently have code in the stack that calls it.  Ideally the device model 
code should call that during or after a .remove() call.


- Paul


---
 arch/arm/mach-omap2/omap_hwmod.c           | 16 +++++++++++-----
 arch/arm/mach-omap2/omap_hwmod.h           | 12 ++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  6 ++++++
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e9f65fec55c0..ab66dd988709 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2077,7 +2077,7 @@ static int _enable_preprogram(struct omap_hwmod *oh)
  */
 static int _enable(struct omap_hwmod *oh)
 {
-	int r;
+	int r, i;
 	int hwsup = 0;
 
 	pr_debug("omap_hwmod: %s: enabling\n", oh->name);
@@ -2109,17 +2109,23 @@ static int _enable(struct omap_hwmod *oh)
 	}
 
 	/*
-	 * If an IP block contains HW reset lines and all of them are
-	 * asserted, we let integration code associated with that
-	 * block handle the enable.  We've received very little
+	 * If an IP block contains HW reset lines, all of them are
+	 * asserted, and the IP block is marked as requiring a custom
+	 * hardreset handler, we let integration code associated with
+	 * that block handle the enable.  We've received very little
 	 * information on what those driver authors need, and until
 	 * detailed information is provided and the driver code is
 	 * posted to the public lists, this is probably the best we
 	 * can do.
 	 */
-	if (_are_all_hardreset_lines_asserted(oh))
+	if ((oh->flags & HWMOD_CUSTOM_HARDRESET) &&
+	    _are_all_hardreset_lines_asserted(oh))
 		return 0;
 
+	/* If the IP block is an initiator, release it from hardreset */
+	for (i = 0; i < oh->rst_lines_cnt; i++)
+		_deassert_hardreset(oh, oh->rst_lines[i].name);
+
 	/* Mux pins for device runtime if populated */
 	if (oh->mux && (!oh->mux->enabled ||
 			((oh->_state == _HWMOD_STATE_IDLE) &&
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 76bce11c85a4..4198829551a4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -525,6 +525,17 @@ struct omap_hwmod_omap4_prcm {
  *     or idled.
  * HWMOD_OPT_CLKS_NEEDED: The optional clocks are needed for the module to
  *     operate and they need to be handled at the same time as the main_clk.
+ * HWMOD_CUSTOM_HARDRESET: By default, if a hwmod has PRCM hardreset
+ *     lines associated with it (i.e., a populated .rst_lines field in
+ *     the hwmod), the hwmod code will assert the hardreset lines when
+ *     the IP block is initially reset, deassert the hardreset lines
+ *     in _enable(), and reassert them in _shutdown().  If this flag
+ *     is set, the hwmod code will not deassert the hardreset lines in
+ *     _enable(), leaving this responsibility to the driver code.  This flag may
+ *     be needed for processor IP blocks that must be put into a WFI/HLT
+ *     state after reset is deasserted, lest the processor leave its MSTANDBY
+ *     signal deasserted, thus blocking the chip from entering a system-wide
+ *     low power state.
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -541,6 +552,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_SWSUP_SIDLE_ACT			(1 << 12)
 #define HWMOD_RECONFIG_IO_CHAIN			(1 << 13)
 #define HWMOD_OPT_CLKS_NEEDED			(1 << 14)
+#define HWMOD_CUSTOM_HARDRESET			(1 << 15)
 
 /*
  * omap_hwmod._int_flags definitions
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index dad871a4cd96..20501f0e3c6c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -553,6 +553,7 @@ static struct omap_hwmod omap44xx_dsp_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
+	.flags		= HWMOD_CUSTOM_HARDRESET,
 };
 
 /*
@@ -1433,6 +1434,7 @@ static struct omap_hwmod omap44xx_ipu_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
+	.flags		= HWMOD_CUSTOM_HARDRESET,
 };
 
 /*
@@ -1517,6 +1519,7 @@ static struct omap_hwmod omap44xx_iva_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
+	.flags		= HWMOD_CUSTOM_HARDRESET,
 };
 
 /*
@@ -2115,6 +2118,7 @@ static struct omap_hwmod omap44xx_mmu_ipu_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
+	.flags		= HWMOD_CUSTOM_HARDRESET, /* XXX doublecheck */
 };
 
 /* mmu dsp */
@@ -2147,6 +2151,7 @@ static struct omap_hwmod omap44xx_mmu_dsp_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
+	.flags		= HWMOD_CUSTOM_HARDRESET, /* XXX doublecheck */
 };
 
 /*
@@ -2299,6 +2304,7 @@ static struct omap_hwmod omap44xx_prm_hwmod = {
 	.class		= &omap44xx_prcm_hwmod_class,
 	.rst_lines	= omap44xx_prm_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_prm_resets),
+	.flags		= HWMOD_CUSTOM_HARDRESET,
 };
 
 /*
-- 
2.7.0
