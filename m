From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] ARM-OMAP2+: pm-debug: Use seq_putc() in two functions
Date: Sat, 15 Oct 2016 22:54:49 +0200
Message-ID: <3b54e75d-eeee-5cce-5733-89b2750ab8c7@users.sourceforge.net>
References: <e86a5ded-a6e9-1b40-be1a-98fffef0abb5@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <e86a5ded-a6e9-1b40-be1a-98fffef0abb5@users.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 15 Oct 2016 22:30:44 +0200

A single character (line break) should be put into a sequence at the end.
Thus use the corresponding function "seq_putc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-omap2/pm-debug.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 0b33986..003a6cb 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -114,8 +114,7 @@ static int pwrdm_dbg_show_counter(struct powerdomain *pwrdm, void *user)
 		seq_printf(s, ",RET-MEMBANK%d-OFF:%d", i + 1,
 				pwrdm->ret_mem_off_counter[i]);
 
-	seq_printf(s, "\n");
-
+	seq_putc(s, '\n');
 	return 0;
 }
 
@@ -138,7 +137,7 @@ static int pwrdm_dbg_show_timer(struct powerdomain *pwrdm, void *user)
 		seq_printf(s, ",%s:%lld", pwrdm_state_names[i],
 			pwrdm->state_timer[i]);
 
-	seq_printf(s, "\n");
+	seq_putc(s, '\n');
 	return 0;
 }
 
-- 
2.10.1
