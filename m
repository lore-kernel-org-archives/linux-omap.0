From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 4/4] ARM: OMAP2+: Fix sparse warnings in timer.c
Date: Wed, 28 Nov 2012 16:05:00 -0600
Message-ID: <1354140300-16825-5-git-send-email-jon-hunter@ti.com>
References: <1354140300-16825-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47922 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932507Ab2K1WFJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 17:05:09 -0500
In-Reply-To: <1354140300-16825-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Vaibhav Hiremath <hvaibhav@ti.com>, Jon Hunter <jon-hunter@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Sparse generates the following warnings when compiling mach-omap2/timer.c.

  CHECK   arch/arm/mach-omap2/timer.c
  arch/arm/mach-omap2/timer.c:193:13: warning: symbol 'omap_dmtimer_init'
  was not declared. Should it be static?
  arch/arm/mach-omap2/timer.c:213:12: warning: symbol
  'omap_dm_timer_get_errata' was not declared. Should it be static?

Add static to function declaration to fix warnings.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 79df809..c6d173f 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -190,7 +190,7 @@ static struct device_node * __init omap_get_timer_dt(struct of_device_id *match,
  * kernel registering these devices remove them dynamically from the device
  * tree on boot.
  */
-void __init omap_dmtimer_init(void)
+static void __init omap_dmtimer_init(void)
 {
 	struct device_node *np;
 
@@ -210,7 +210,7 @@ void __init omap_dmtimer_init(void)
  *
  * Get the timer errata flags that are specific to the OMAP device being used.
  */
-u32 __init omap_dm_timer_get_errata(void)
+static u32 __init omap_dm_timer_get_errata(void)
 {
 	if (cpu_is_omap24xx())
 		return 0;
-- 
1.7.10.4

