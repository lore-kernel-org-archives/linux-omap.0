From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH] ARM: OMAP2+: timer: initialize before using oh_name
Date: Tue, 28 May 2013 11:54:48 +0530
Message-ID: <1369722288-15592-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

of_property_read_string_index(...,&oh_name) in omap_dm_timer_init_one
does not alter the value of 'oh_name' even if the relevant function
fails and as 'oh_name' in stack may have a non-zero value, it would
be misunderstood by timer code that DT has specified "ti,hwmod"
property for timer. 'oh_name' in this scenario would be a junk value,
this would result in module not being enabled by hwmod API's for
timer, and in turn crash.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index f8b23b8..8e0c390 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -220,7 +220,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 					 int posted)
 {
 	char name[10]; /* 10 = sizeof("gptXX_Xck0") */
-	const char *oh_name;
+	const char *oh_name = NULL;
 	struct device_node *np;
 	struct omap_hwmod *oh;
 	struct resource irq, mem;
-- 
1.7.12
