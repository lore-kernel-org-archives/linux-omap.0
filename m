From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 3/8] OMAP2+: hwmod: Enable module in shutdown to access sysconfig
Date: Fri, 1 Jul 2011 22:54:02 +0200
Message-ID: <1309553647-14624-4-git-send-email-b-cousson@ti.com>
References: <1309553647-14624-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58184 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757060Ab1GAUyW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 16:54:22 -0400
In-Reply-To: <1309553647-14624-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Miguel Vadillo <vadillo@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Miguel Vadillo <vadillo@ti.com>

When calling the shutdown, the module may be already in idle.
Accessing the sysconfig register will then lead to a crash.
In that case, re-enable the module in order to allow the access
to the sysconfig register.

Signed-off-by: Miguel Vadillo <vadillo@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 384d3c3..cbc2a8a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1396,8 +1396,11 @@ static int _shutdown(struct omap_hwmod *oh)
 		}
 	}
 
-	if (oh->class->sysc)
+	if (oh->class->sysc) {
+		if (oh->_state == _HWMOD_STATE_IDLE)
+			_enable(oh);
 		_shutdown_sysc(oh);
+	}
 
 	/*
 	 * If an IP contains only one HW reset line, then assert it
-- 
1.7.0.4

