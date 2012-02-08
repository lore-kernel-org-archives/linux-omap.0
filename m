From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 06/16] ARM: omap: fix uninformative vc/i2c configuration
 error message
Date: Wed, 08 Feb 2012 16:37:49 +0000
Message-ID: <E1RvAWj-0006HB-7D@rmk-PC.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39327 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755839Ab2BHQhx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 11:37:53 -0500
In-Reply-To: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org

On my OMAP4 platform, I'm getting this error message repeated several
times at boot:

omap_vc_i2c_init: I2C config for all channels must match.
omap_vc_i2c_init: I2C config for all channels must match.

This doesn't help identify what the problem is.  Fix this message to
be more informative:

omap_vc_i2c_init: I2C config for vdd_iva does not match other channels (0).
omap_vc_i2c_init: I2C config for vdd_mpu does not match other channels (0).

This allows us to identify which voltage domains have a problem, and
what the I2C configuration state (a boolean, i2c_high_speed) setting
being used actually is.

omap4_iva_pmic and omap4_mpu_pmic both have it set true.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/vc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index ce45695..ff58dc9 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -265,8 +265,8 @@ static void __init omap_vc_i2c_init(struct voltagedomain *voltdm)
 
 	if (initialized) {
 		if (voltdm->pmic->i2c_high_speed != i2c_high_speed)
-			pr_warn("%s: I2C config for all channels must match.",
-				__func__);
+			pr_warn("%s: I2C config for vdd_%s does not match other channels (%u).",
+				__func__, voltdm->name, i2c_high_speed);
 		return;
 	}
 
-- 
1.7.4.4

