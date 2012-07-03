From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2] gpio/omap: fix invalid context restore of gpio bank-0
Date: Tue, 3 Jul 2012 11:05:50 -0500
Message-ID: <1341331550-21312-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36429 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081Ab2GCQG2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Jul 2012 12:06:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Franky Lin <frankyl@broadcom.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, NeilBrown <neilb@suse.de>

Currently the gpio _runtime_resume/suspend functions are calling the
get_context_loss_count() platform function if the function is populated for
a gpio bank. This function is used to determine if the gpio bank logic state
needs to be restored due to a power transition. This function will be populated
for all banks, but it should only be called for banks that have the
"loses_context" variable set. It is pointless to call this if loses_context is
false as we know the context will never be lost and will not need restoring.

For all OMAP2+ devices gpio bank-0 is in an always-on power domain and so will
never lose context. We found that the get_context_loss_count() was being called
for bank-0 during the probe and returning 1 instead of 0 indicating that the
context had been lost. This was causing the context restore function to be
called at probe time for this bank and because the context had never been saved,
was restoring an invalid state. This ultimately resulted in a crash [1].

This issue is a regression that was exposed by commit 1b1287032 (gpio/omap: fix
missing check in *_runtime_suspend()).

There are multiple bugs here that need to be addressed ...

1. Why the always-on power domain returns a context loss count of 1? This needs
   to be fixed in the power domain code [2]. However, the gpio driver should not
   assume the loss count is 0 to begin with.
2. The omap gpio driver should never be calling get_context_loss_count for a
   gpio bank in a always-on domain. This is pointless and adds unneccessary
   overhead.
3. The OMAP gpio driver assumes that the initial power domain context loss count
   will be 0 at the time the gpio driver is probed. However, it could be
   possible that this is not the case and an invalid context restore could be
   performed during the probe. To avoid this only populate the
   get_context_loss_count() function pointer after the initial call to
   pm_runtime_get() has occurred. This will ensure that the first
   pm_runtime_put() initialised the loss count correctly.

This patch addresses issues 2 and 3 above.

[1] http://marc.info/?l=linux-omap&m=134065775323775&w=2
[2] http://marc.info/?l=linux-omap&m=134100413303810&w=2

Cc: Kevin Hilman <khilman@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Franky Lin <frankyl@broadcom.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: NeilBrown <neilb@suse.de>

Reported-by: Franky Lin <frankyl@broadcom.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Franky Lin <frankyl@broadcom.com>
Tested-by: NeilBrown <neilb@suse.de>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 drivers/gpio/gpio-omap.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c4ed172..f13fc9c 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1081,7 +1081,6 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	bank->is_mpuio = pdata->is_mpuio;
 	bank->non_wakeup_gpios = pdata->non_wakeup_gpios;
 	bank->loses_context = pdata->loses_context;
-	bank->get_context_loss_count = pdata->get_context_loss_count;
 	bank->regs = pdata->regs;
 #ifdef CONFIG_OF_GPIO
 	bank->chip.of_node = of_node_get(node);
@@ -1135,6 +1134,9 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	omap_gpio_chip_init(bank);
 	omap_gpio_show_rev(bank);
 
+	if (bank->loses_context)
+		bank->get_context_loss_count = pdata->get_context_loss_count;
+
 	pm_runtime_put(bank->dev);
 
 	list_add_tail(&bank->node, &omap_gpio_list);
-- 
1.7.9.5

