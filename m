From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PM-WIP-OPP][PATCH] OMAP3 PM: Fix issue with opp_find_freq_floor
Date: Wed,  7 Apr 2010 01:56:36 +0800
Message-ID: <1270576596-8761-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57445 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754030Ab0DFMSz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Apr 2010 08:18:55 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o36CIq1l012511
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 6 Apr 2010 07:18:54 -0500
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>

opp_find_freq_floor should return the lower "enabled* OPP from a starting freq
from a start opp list. But current code returns next lower opp. This patch fixes
this issue.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index bb8120e..13da451
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -208,7 +208,7 @@ struct omap_opp *opp_find_freq_floor(enum opp_t opp_type, unsigned long *freq)
 
 	*freq = prev_opp->rate;
 
-	return oppl;
+	return prev_opp;
 }
 
 /* wrapper to reuse converting opp_def to opp struct */
