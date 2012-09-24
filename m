From: Matthias Kaehlcke <matthias@kaehlcke.net>
Subject: [PATCH v4 2/2] mfd: Add backlight as subdevice to the tps65217
Date: Mon, 24 Sep 2012 22:25:34 +0200
Message-ID: <20120924202534.GF26600@darwin>
References: <b340c1de3e6874156549a674ecf69aa52228809f.1348517680.git.matthias@kaehlcke.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:34862 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757947Ab2IXU0M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 16:26:12 -0400
Content-Disposition: inline
In-Reply-To: <b340c1de3e6874156549a674ecf69aa52228809f.1348517680.git.matthias@kaehlcke.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

mfd: Add backlight as subdevice to the tps65217

Signed-off-by: Matthias Kaehlcke <matthias@kaehlcke.net>
---
 drivers/mfd/tps65217.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index a95e942..3fb32e6 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -34,6 +34,9 @@ static struct mfd_cell tps65217s[] = {
 	{
 		.name = "tps65217-pmic",
 	},
+	{
+		.name = "tps65217-bl",
+	},
 };
 
 /**
-- 
1.7.10

