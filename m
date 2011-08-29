From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 06/22] OMAP3: voltagedomain data: add wakeup domain
Date: Mon, 29 Aug 2011 10:35:39 -0700
Message-ID: <1314639355-12713-7-git-send-email-khilman@ti.com>
References: <1314639355-12713-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:43039 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754521Ab1H2Rfm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 13:35:42 -0400
Received: by mail-yw0-f52.google.com with SMTP id 7so6887377ywo.11
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 10:35:41 -0700 (PDT)
In-Reply-To: <1314639355-12713-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Add wakeup voltage domain so that the wakeup powerdomain can have an
associated powerdomain.  Note that the scalable flat is not set for
the this voltagedomain, so it will not be fully initialized like
scalable voltage domains.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index 2167ef4..42d0b11 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -69,9 +69,14 @@ static struct voltagedomain omap3_voltdm_core = {
 	.vdd = &omap3_vdd2_info,
 };
 
+static struct voltagedomain omap3_voltdm_wkup = {
+	.name = "wakeup",
+};
+
 static struct voltagedomain *voltagedomains_omap3[] __initdata = {
 	&omap3_voltdm_mpu,
 	&omap3_voltdm_core,
+	&omap3_voltdm_wkup,
 	NULL,
 };
 
-- 
1.7.6

