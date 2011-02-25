From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] PM: OPP: opp_find_freq_exact documentation fix
Date: Fri, 25 Feb 2011 12:44:04 +0530
Message-ID: <1298618044-8292-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:43230 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753462Ab1BYHOW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 02:14:22 -0500
Received: by mail-gw0-f48.google.com with SMTP id 20so717069gwj.21
        for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 23:14:20 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm <linux-pm@lists.linux-foundation.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

opp_find_freq_exact documentation has is_available instead
of available. This also fixes warning with the kernel-doc:
scripts/kernel-doc drivers/base/power/opp.c >/dev/null
Warning(drivers/base/power/opp.c:246): No description found for parameter 'available'
Warning(drivers/base/power/opp.c:246): Excess function parameter 'is_available' description in 'opp_find_freq_exact'

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/base/power/opp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 2bb9b4c..56a6899 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -222,7 +222,7 @@ int opp_get_opp_count(struct device *dev)
  * opp_find_freq_exact() - search for an exact frequency
  * @dev:		device for which we do this operation
  * @freq:		frequency to search for
- * @is_available:	true/false - match for available opp
+ * @available:		true/false - match for available opp
  *
  * Searches for exact match in the opp list and returns pointer to the matching
  * opp if found, else returns ERR_PTR in case of error and should be handled
-- 
1.7.1

