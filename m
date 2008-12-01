From: Carlos Chinea <carlos.chinea@nokia.com>
Subject: [PATCH PM 1/1] OMAP3:PM: Update SSI omapdev record
Date: Mon,  1 Dec 2008 16:24:40 +0200
Message-ID: <1228141480-8356-1-git-send-email-carlos.chinea@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45054 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbYLAO0b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 09:26:31 -0500
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mB1EQF9I014034
	for <linux-omap@vger.kernel.org>; Mon, 1 Dec 2008 16:26:28 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


        -Adds the ssi platform_device name and id to the SSI omapdev record

Signed-off-by: Carlos Chinea <carlos.chinea@nokia.com>
---
 arch/arm/mach-omap2/omapdev3xxx.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omapdev3xxx.h b/arch/arm/mach-omap2/omapdev3xxx.h
index 199282f..dce87df 100644
--- a/arch/arm/mach-omap2/omapdev3xxx.h
+++ b/arch/arm/mach-omap2/omapdev3xxx.h
@@ -132,6 +132,8 @@ static struct omapdev sad2d_3xxx_omapdev = {
 static struct omapdev ssi_3xxx_omapdev = {
 	.name		= "ssi_omapdev",
 	.pwrdm		= { .name = "core_pwrdm" },
+	.pdev_name	= "omap_ssi",
+	.pdev_id	= -1,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
-- 
1.5.3.6

