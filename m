From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] ARM-OMAP2+: mux: Use seq_putc() in
 omap_mux_dbg_signal_show()
Date: Sat, 15 Oct 2016 22:53:27 +0200
Message-ID: <88deac82-1339-330c-3561-abd30dbaf6b1@users.sourceforge.net>
References: <e86a5ded-a6e9-1b40-be1a-98fffef0abb5@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e86a5ded-a6e9-1b40-be1a-98fffef0abb5@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 15 Oct 2016 22:24:29 +0200

A single character (line break) should be put into a sequence.
Thus use the corresponding function "seq_putc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-omap2/mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 4bdfa3d..e1fa39e 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -661,7 +661,7 @@ static int omap_mux_dbg_signal_show(struct seq_file *s, void *unused)
 			m->balls[1] ? m->balls[1] : none);
 	seq_puts(s, "mode: ");
 	omap_mux_decode(s, val);
-	seq_printf(s, "\n");
+	seq_putc(s, '\n');
 	seq_printf(s, "signals: %s | %s | %s | %s | %s | %s | %s | %s\n",
 			m->muxnames[0] ? m->muxnames[0] : none,
 			m->muxnames[1] ? m->muxnames[1] : none,
-- 
2.10.1
