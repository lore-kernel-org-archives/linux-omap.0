From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 1/3] ARM: omap2+: omap_hwmod: introduce hwmod flag for custom reset handling
Date: Mon, 8 Feb 2016 16:42:19 +0530
Message-ID: <1454929941-23949-2-git-send-email-kishon@ti.com>
References: <1454929941-23949-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454929941-23949-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, bhelgaas@google.com, richardcochran@gmail.com, s-anna@ti.com
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, kishon@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

Many of the IP blocks with PRM hardreset lines are processor IP blocks
and need special reset handling to ensure that WFI/HLT-like
instructions are executed after reset. Introduce a new hwmod flag
_HWMOD_CUSTOM_HARDRESET_ to indicate if the IP block requires
special reset handling.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 76bce11..4198829 100644
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
-- 
1.7.9.5
