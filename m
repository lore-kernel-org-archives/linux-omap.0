From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 6/8] staging: ti-soc-thermal: remove extrapolation rules from TODO
Date: Mon, 8 Apr 2013 08:19:12 -0400
Message-ID: <1365423555-2669-7-git-send-email-eduardo.valentin@ti.com>
References: <1365423555-2669-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43970 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935283Ab3DHMWJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Apr 2013 08:22:09 -0400
In-Reply-To: <1365423555-2669-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>

Extrapolation rules have been revisited.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/ti-soc-thermal/TODO |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/ti-soc-thermal/TODO b/drivers/staging/ti-soc-thermal/TODO
index b320388..7da787d 100644
--- a/drivers/staging/ti-soc-thermal/TODO
+++ b/drivers/staging/ti-soc-thermal/TODO
@@ -4,7 +4,6 @@ on ti-bandgap.c:
 - Revisit PM support
 
 on ti-thermal-common.c/ti-thermal.h:
-- Revisit extrapolation constants for O4/O5
 - Revisit need for locking
 
 generally:
-- 
1.7.7.1.488.ge8e1c

