From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 06/19] OMAP3: voltagedomain data: add wakeup domain
Date: Wed, 23 Mar 2011 17:00:20 -0700
Message-ID: <1300924833-26745-7-git-send-email-khilman@ti.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:47720 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933247Ab1CXAAX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Mar 2011 20:00:23 -0400
Received: by iwl42 with SMTP id 42so11899424iwl.0
        for <linux-omap@vger.kernel.org>; Wed, 23 Mar 2011 17:00:22 -0700 (PDT)
In-Reply-To: <1300924833-26745-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Add wakeup voltage domain so that the wakeup powerdomain can have an
associated powerdomain.  Note that the scalable flat is not set for
the this voltagedomain, so it will not be fully initialized like
scalable voltage domains.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index 2167ef4..b476ee6 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -69,9 +69,14 @@ static struct voltagedomain omap3_voltdm_core = {
 	.vdd = &omap3_vdd2_info,
 };
 
+static struct voltagedomain omap3_voltdm_wkup = {
+	.name = "wkup",
+};
+
 static struct voltagedomain *voltagedomains_omap3[] __initdata = {
 	&omap3_voltdm_mpu,
 	&omap3_voltdm_core,
+	&omap3_voltdm_wkup,
 	NULL,
 };
 
-- 
1.7.4

