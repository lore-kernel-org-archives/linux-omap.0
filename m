From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ARM-OMAP2+: mux: Replace three seq_printf() calls by
 seq_puts()
Date: Sat, 15 Oct 2016 22:52:06 +0200
Message-ID: <42ffbac1-4edc-1afe-4b3b-8552a7fa8c47@users.sourceforge.net>
References: <e86a5ded-a6e9-1b40-be1a-98fffef0abb5@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <e86a5ded-a6e9-1b40-be1a-98fffef0abb5@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 15 Oct 2016 22:22:09 +0200

Strings which did not contain data format specification should be put into
a sequence. Thus use the corresponding function "seq_puts".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-omap2/mux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 176eef6..4bdfa3d 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -561,7 +561,7 @@ static inline void omap_mux_decode(struct seq_file *s, u16 val)
 	do {
 		seq_printf(s, "%s", flags[i]);
 		if (i > 0)
-			seq_printf(s, " | ");
+			seq_puts(s, " | ");
 	} while (i-- > 0);
 }
 
@@ -602,7 +602,7 @@ static int omap_mux_dbg_board_show(struct seq_file *s, void *unused)
 		 */
 		seq_printf(s, "OMAP%d_MUX(%s, ", omap_gen, m0_def);
 		omap_mux_decode(s, val);
-		seq_printf(s, "),\n");
+		seq_puts(s, "),\n");
 	}
 
 	return 0;
@@ -659,7 +659,7 @@ static int omap_mux_dbg_signal_show(struct seq_file *s, void *unused)
 			partition->phys + m->reg_offset, m->reg_offset, val,
 			m->balls[0] ? m->balls[0] : none,
 			m->balls[1] ? m->balls[1] : none);
-	seq_printf(s, "mode: ");
+	seq_puts(s, "mode: ");
 	omap_mux_decode(s, val);
 	seq_printf(s, "\n");
 	seq_printf(s, "signals: %s | %s | %s | %s | %s | %s | %s | %s\n",
-- 
2.10.1

