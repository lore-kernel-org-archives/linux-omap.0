From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 2/3] arm: fix compile error in mach-omap2/board-omap4panda.c
Date: Mon,  5 Mar 2012 17:41:49 -0500
Message-ID: <1330987310-8108-3-git-send-email-paul.gortmaker@windriver.com>
References: <1330987310-8108-1-git-send-email-paul.gortmaker@windriver.com>
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1330987310-8108-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-next-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

The commit 3c90c98a1ebbb08d95700ce8a3b7bce6286607bd (linux-next)

    "OMAP4: omap4panda: Enable audio support"

introduced population of a new struct, but chose the wrong (but
similarly named) struct that has none of the named fields.

Change it to the struct with those fields, to fix:

arch/arm/mach-omap2/board-omap4panda.c:284: error: unknown field 'hs_left_step' specified in initializer
arch/arm/mach-omap2/board-omap4panda.c:285: error: unknown field 'hs_right_step' specified in initializer
arch/arm/mach-omap2/board-omap4panda.c:286: error: unknown field 'hf_left_step' specified in initializer
arch/arm/mach-omap2/board-omap4panda.c:287: error: unknown field 'hf_right_step' specified in initializer
arch/arm/mach-omap2/board-omap4panda.c:287: warning: large integer implicitly truncated to unsigned type

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
CC: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
CC: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index c1a852d..e919153 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -279,7 +279,7 @@ static int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
 	return 0;
 }
 
-static struct twl4030_codec_data twl6040_codec = {
+static struct twl6040_codec_data twl6040_codec = {
 	/* single-step ramp for headset and handsfree */
 	.hs_left_step	= 0x0f,
 	.hs_right_step	= 0x0f,
-- 
1.7.9.1
