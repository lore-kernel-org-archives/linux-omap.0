From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFT/RFC/PATCH 08/10] cbus: separate into several MODULE_AUTHOR entries
Date: Thu,  3 Dec 2009 00:35:50 +0200
Message-ID: <1259793352-29864-9-git-send-email-felipe.balbi@nokia.com>
References: <1259793352-29864-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:51059 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755907AbZLBWgY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 17:36:24 -0500
In-Reply-To: <1259793352-29864-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

will look cleaner on modinfo.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/cbus.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index d73d0c9..145e760 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -291,4 +291,6 @@ subsys_initcall(cbus_bus_init);
=20
 MODULE_DESCRIPTION("CBUS serial protocol");
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Juha Yrj=F6l=E4, David Weinehall, and Mikko Ylinen");
+MODULE_AUTHOR("Juha Yrj=F6l=E4");
+MODULE_AUTHOR("David Weinehall");
+MODULE_AUTHOR("Mikko Ylinen");
--=20
1.6.6.rc0

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
