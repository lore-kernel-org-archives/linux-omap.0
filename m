From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 1/8] staging: omap-thermal: fix return value
Date: Mon, 18 Mar 2013 10:59:09 -0400
Message-ID: <1363618756-15851-2-git-send-email-eduardo.valentin@ti.com>
References: <1363618756-15851-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56589 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753379Ab3CRPAY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Mar 2013 11:00:24 -0400
In-Reply-To: <1363618756-15851-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, Dan Carpenter <dan.carpenter@oracle.com>

Return the proper error value in _omap_bandgap_read_threshold.

Cc: Dan Carpenter <dan.carpenter@oracle.com>

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>

diff --git a/drivers/staging/omap-thermal/omap-bandgap.c b/drivers/staging/omap-thermal/omap-bandgap.c
index 33bfe3b..cb7aa35 100644
--- a/drivers/staging/omap-thermal/omap-bandgap.c
+++ b/drivers/staging/omap-thermal/omap-bandgap.c
@@ -566,7 +566,7 @@ int _omap_bandgap_read_threshold(struct omap_bandgap *bg_ptr, int id,
 	*val = temp;
 
 exit:
-	return 0;
+	return ret;
 }
 
 /***   Exposed APIs   ***/
-- 
1.7.7.1.488.ge8e1c

