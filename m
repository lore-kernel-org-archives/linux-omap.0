From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 3/3] ARM: OMAP2+: hwmod: Add default reset handling
Date: Mon, 8 Feb 2016 16:42:21 +0530
Message-ID: <1454929941-23949-4-git-send-email-kishon@ti.com>
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

Certain devices (like PCIe in DRA7xx) require default reset
handling where the reset line should be asserted and then
de-asserted. Other devices require special reset handling
and is indicated using HWMOD_CUSTOM_HARDRESET.
Add default reset handling here where the reset line is
asserted in _reset and deasserted in _enable.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e9f65fe..ab66dd9 100644
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
-- 
1.7.9.5
