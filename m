From: Raphael Assenat <raph@8d.com>
Subject: [PATCH] AM35xx: Add missing hwmod entry for the HDQ/1-Wire present
 in AM3505/3517 CPUs.
Date: Mon, 17 Sep 2012 10:56:14 -0400
Message-ID: <20120917145614.GD22993@renkinjitsu.usine.8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:56102 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755436Ab2IQO4S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Sep 2012 10:56:18 -0400
Received: from raph.usine.8d.com ([192.168.142.55] helo=renkinjitsu.usine.8d.com)
	by roc.holo.8d.com with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <raph@8d.com>)
	id 1TDckB-0006tx-H1
	for linux-omap@vger.kernel.org; Mon, 17 Sep 2012 10:56:17 -0400
Received: from raph by renkinjitsu.usine.8d.com with local (Exim 4.80)
	(envelope-from <raph@8d.com>)
	id 1TDckA-0002HL-TR
	for linux-omap@vger.kernel.org; Mon, 17 Sep 2012 10:56:14 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch adds a missing hwmod entry for the HDQ/1-Wire module present 
in the AM3505/17 CPUs.

This restores 1-Wire support to our AM3505 boards. We think it probably
stopped working with commit 96b1b29d37b0ca3ecd424a1fe301406cf525fc04
ARM: OMAP2+: HDQ1W: use omap_device

Signed-off-by: Raphael Assenat <raph@8d.com>

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index ce7e606..59a0d81 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3405,6 +3405,7 @@ static struct omap_hwmod_ocp_if *am35xx_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_core__usb_tll_hs,
 	&omap3xxx_l4_core__es3plus_mmc1,
 	&omap3xxx_l4_core__es3plus_mmc2,
+	&omap3xxx_l4_core__hdq1w,
 	&am35xx_mdio__l3,
 	&am35xx_l4_core__mdio,
 	&am35xx_emac__l3,
