From: Nicolas Kaiser <nikai@nikai.net>
Subject: [PATCH] arm/omap: simplify conditional
Date: Tue, 5 Oct 2010 20:31:54 +0200
Message-ID: <20101005203154.0ba412d2@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Simplify conditional: (a || (!a && !b)) => (a || !b)

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 arch/arm/plat-omap/fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index 0054b95..5c09095 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -126,7 +126,7 @@ static int set_fbmem_region_type(struct omapfb_mem_region *rg, int mem_type,
 	 * type = 0 && paddr = 0, a default don't care case maps to
 	 * the SDRAM type.
 	 */
-	if (rg->type || (!rg->type && !rg->paddr))
+	if (rg->type || !rg->paddr)
 		return 0;
 	if (ranges_overlap(rg->paddr, rg->size, mem_start, mem_size)) {
 		rg->type = mem_type;
-- 
1.7.2.2
