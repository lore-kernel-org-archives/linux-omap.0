From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PM-SR][PATCH 10/12] omap3: sr: export sr_dbg_dir
Date: Fri, 6 Aug 2010 10:26:17 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032401CD29@dbde02.ent.ti.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com>
 <1281047052-21346-11-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43653 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691Ab0HFE4W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 00:56:22 -0400
In-Reply-To: <1281047052-21346-11-git-send-email-nm@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>



>>-----Original Message-----
>>From: Menon, Nishanth
>>Sent: Friday, August 06, 2010 3:54 AM
>>To: linux-omap
>>Cc: Menon, Nishanth; Kevin Hilman; Gopinath, Thara
>>Subject: [PM-SR][PATCH 10/12] omap3: sr: export sr_dbg_dir
>>
>>sr_dbg_dir is currently used privately in smartreflex.c, however,
>>smartreflex class drivers could store their own debugfs entries there
>>as well.
>>
>>This also fixes the sparse warning:
>>arch/arm/mach-omap2/smartreflex.c:44:15: warning: symbol 'sr_dbg_dir' was not declared. Should it be
>>static?
>>
>>Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>Cc: Thara Gopinath <thara@ti.com>
>>
>>Signed-off-by: Nishanth Menon <nm@ti.com>
>>---
>> arch/arm/plat-omap/include/plat/smartreflex.h |    5 +++++
>> 1 files changed, 5 insertions(+), 0 deletions(-)
>>
>>diff --git a/arch/arm/plat-omap/include/plat/smartreflex.h b/arch/arm/plat-
>>omap/include/plat/smartreflex.h
>>index 1105db0..df58026 100644
>>--- a/arch/arm/plat-omap/include/plat/smartreflex.h
>>+++ b/arch/arm/plat-omap/include/plat/smartreflex.h
>>@@ -263,6 +263,11 @@ int omap_sr_register_class(struct omap_smartreflex_class_data *class_data);
>>
>> /* API to register the pmic specific data with the smartreflex driver. */
>> void omap_sr_register_pmic(struct omap_smartreflex_pmic_data *pmic_data);
>>+
>>+#ifdef CONFIG_PM_DEBUG
>>+extern struct dentry *sr_dbg_dir;
>>+#endif

Will take this in

Regards
Thara

>>+
>> #else
>> static inline void omap_smartreflex_enable(int srid) {}
>> static inline void omap_smartreflex_disable(int srid) {}
>>--
>>1.6.3.3

