From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 11/11] ARM: OMAP2+: omap_hwmod: Don't call _init_mpu_rt_base if no sysc
Date: Tue, 19 Mar 2013 19:00:57 +0530
Message-ID: <1363699857-5505-12-git-send-email-santosh.shilimkar@ti.com>
References: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57884 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755744Ab3CSN3o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Mar 2013 09:29:44 -0400
In-Reply-To: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

OMAP hwmod layer does the reset of the IPs in early code so that
we have SOC in sane state. To do the soft-reset, it needs to ioremap()
the ip address space to be able to write to sysconfig registers.

But there are few hwmod which doesn't have sysconfig registers and hence
no need to ioremap() them in early init code.

So this patch makes prevet calling the _init_mpu_rt_base() conditional
based on sysc availability.

Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 4501038..1a1f0a4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2449,7 +2449,8 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 	if (oh->_state != _HWMOD_STATE_REGISTERED)
 		return 0;
 
-	_init_mpu_rt_base(oh, NULL);
+	if (oh->class->sysc)
+		_init_mpu_rt_base(oh, NULL);
 
 	r = _init_clocks(oh, NULL);
 	if (IS_ERR_VALUE(r)) {
-- 
1.7.9.5

