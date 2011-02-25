From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/9] omap4: prcm: Fix the CPUx clockdomain offsets
Date: Fri, 25 Feb 2011 13:07:46 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102251304240.6198@utopia.booyaka.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com> <1296813544-25170-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56889 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932778Ab1BYUHr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Feb 2011 15:07:47 -0500
In-Reply-To: <1296813544-25170-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

On Fri, 4 Feb 2011, Santosh Shilimkar wrote:

> CPU0 and CPU1 clockdomain is at the offset of 0x18 from the LPRM base.
> The header file has set it wrongly to 0x0. Offset 0x0 is for CPUx power
> domain control register
> 
> Fix the same.
> 
> The autogen scripts is fixed thanks to Benoit Cousson
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>

Will submit this one for -rc series, since this could result in writes to 
an incorrect register.  Updated patch below.


- Paul

From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Fri, 4 Feb 2011 15:28:57 +0530
Subject: [PATCH] omap4: prcm: Fix the CPUx clockdomain offsets

CPU0 and CPU1 clockdomain is at the offset of 0x18 from the LPRM base.
The header file has set it wrongly to 0x0. Offset 0x0 is for CPUx power
domain control register

Fix the same.

The autogen scripts is fixed thanks to Benoit Cousson

With the old value, the clockdomain code would access the
*_PWRSTCTRL.POWERSTATE field when it thought it was accessing the
*_CLKSTCTRL.CLKTRCTRL field.  In the worst case, this could cause
system power management to behave incorrectly.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
[paul@pwsan.com: added second paragraph to commit message]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prcm_mpu44xx.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm_mpu44xx.h b/arch/arm/mach-omap2/prcm_mpu44xx.h
index 729a644..3300ff6 100644
--- a/arch/arm/mach-omap2/prcm_mpu44xx.h
+++ b/arch/arm/mach-omap2/prcm_mpu44xx.h
@@ -38,8 +38,8 @@
 #define OMAP4430_PRCM_MPU_CPU1_INST		0x0800
 
 /* PRCM_MPU clockdomain register offsets (from instance start) */
-#define OMAP4430_PRCM_MPU_CPU0_MPU_CDOFFS	0x0000
-#define OMAP4430_PRCM_MPU_CPU1_MPU_CDOFFS	0x0000
+#define OMAP4430_PRCM_MPU_CPU0_MPU_CDOFFS	0x0018
+#define OMAP4430_PRCM_MPU_CPU1_MPU_CDOFFS	0x0018
 
 
 /*
-- 
1.7.2.3

