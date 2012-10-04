From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 2/5] ARM: omap: introduce .get_voltage callback
Date: Wed, 3 Oct 2012 18:16:02 -0700
Message-ID: <1349313365-5262-3-git-send-email-mturquette@ti.com>
References: <1349313365-5262-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46426 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933167Ab2JDBQv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Oct 2012 21:16:51 -0400
In-Reply-To: <1349313365-5262-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>, Mike Turquette <mturquette@ti.com>

From: Mike Turquette <mturquette@linaro.org>

Introduces a new callback to struct voltagedomain for retrieving the
voltage of the voltage domain from the hardware.  This will be used to
populate voltdm->nominal_volt during initialization of the voltage code
instead of waiting for the first call to voltdm_scale.

In the event of an error or the inability to determine voltage the
callback must return zero.  It is the callers responsibility to
gracefully degrade when presented with a voltage of zero.

Signed-off-by: Mike Turquette <mturquette@ti.com>
Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
 arch/arm/mach-omap2/voltage.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 0ac2caf..0ded54f 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -85,6 +85,7 @@ struct voltagedomain {
 		u32 rate;
 	} sys_clk;
 
+	unsigned long (*get_voltage) (struct voltagedomain *voltdm);
 	int (*scale) (struct voltagedomain *voltdm,
 		      unsigned long target_volt);
 
-- 
1.7.9.5

