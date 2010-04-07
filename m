From: felipe.balbi@nokia.com
Subject: [RFC PATCH 20/37] cbus: tahvo: split MODULE_AUTHOR into several entries
Date: Wed,  7 Apr 2010 19:04:11 +0300
Message-ID: <1270656268-7034-21-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42746 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932860Ab0DGQFV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:21 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G5992030675
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 19:05:19 +0300
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

=46rom: Felipe Balbi <felipe.balbi@nokia.com>

it's easier to read. No functional changes.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/tahvo.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index d8fa90a..20b6f15 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -450,4 +450,6 @@ module_exit(tahvo_exit);
=20
 MODULE_DESCRIPTION("Tahvo ASIC control");
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Juha Yrj=F6l=E4, David Weinehall, and Mikko Ylinen");
+MODULE_AUTHOR("Juha Yrj=F6l=E4");
+MODULE_AUTHOR("David Weinehall");
+MODULE_AUTHOR("Mikko Ylinen");
--=20
1.7.0.rc0.33.g7c3932

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
