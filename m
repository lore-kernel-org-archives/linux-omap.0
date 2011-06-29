From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 7/9] OMAP: hwmod: enable / disable pad wakeups for a module dynamically
Date: Wed, 29 Jun 2011 12:05:01 +0300
Message-ID: <1309338303-2086-8-git-send-email-t-kristo@ti.com>
References: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40695 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754162Ab1F2JFU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jun 2011 05:05:20 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5T95JSa019053
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:19 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep35.itg.ti.com (8.13.7/8.13.8) with ESMTP id p5T95J7s001811
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:19 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5T95GCT009169
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:19 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

PRCM chain interrupt registration is done now as part of
omap_hwmod_enable_wakeup() and omap_hwmod_disable_wakeup() calls. This
allows module ISR:s to be called when the module is idle but an IO_PAD
event is detected on the module input pads.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 293fa6c..f12fe89 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2123,6 +2123,7 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
 	v = oh->_sysc_cache;
 	_enable_wakeup(oh, &v);
 	_write_sysconfig(v, oh);
+	omap_prcm_register_pad_irqs(oh->mux, oh->mpu_irqs[0].irq);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
 	return 0;
@@ -2153,6 +2154,7 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
 	v = oh->_sysc_cache;
 	_disable_wakeup(oh, &v);
 	_write_sysconfig(v, oh);
+	omap_prcm_unregister_pad_irqs(oh->mux);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
 	return 0;
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

