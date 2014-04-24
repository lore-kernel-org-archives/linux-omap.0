From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 11/26] ARM: OMAP2+: timer: Add a powerup function
Date: Thu, 24 Apr 2014 16:43:54 -0500
Message-ID: <1398375849-6017-12-git-send-email-joelf@ti.com>
References: <1398375849-6017-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1398375849-6017-1-git-send-email-joelf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Joel Fernandes <joelf@ti.com>
List-Id: linux-omap@vger.kernel.org

In an effort to isolate the time power initialization for future purposes, add
a function to do the same. This primarily involves a hwmod lookup, setup and
enable.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/mach-omap2/timer.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index dfb19df..ec427e6 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -210,6 +210,31 @@ static void __init omap_dmtimer_init(void)
 	}
 }
 
+int __init omap_dmtimer_powerup(struct device_node *np)
+{
+	struct omap_hwmod *oh;
+	const char *oh_name = NULL;
+	int ret;
+
+	of_property_read_string_index(np, "ti,hwmods", 0, &oh_name);
+	if (!oh_name)
+		return -ENODEV;
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh)
+		return -ENODEV;
+
+	ret = omap_hwmod_setup_one(oh_name);
+	if (ret)
+		return ret;
+
+	ret = omap_hwmod_enable(oh);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 /**
  * omap_dm_timer_get_errata - get errata flags for a timer
  *
-- 
1.7.9.5
