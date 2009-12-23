From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH] OMAP3: hwmod: Adding flag to prevent caching of
 sysconfig register.
Date: Wed, 23 Dec 2009 16:32:43 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031DF2E171@dbde02.ent.ti.com>
References: <1260098674-27143-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57040 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754763AbZLWLCu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Dec 2009 06:02:50 -0500
In-Reply-To: <1260098674-27143-1-git-send-email-thara@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Paul Walmsley <paul@pwsan.com>



>>-----Original Message-----
>>From: Gopinath, Thara
>>Sent: Sunday, December 06, 2009 4:55 PM
>>To: linux-omap@vger.kernel.org
>>Cc: Gopinath, Thara; Paul Walmsley
>>Subject: [PATCH] OMAP3: hwmod: Adding flag to prevent caching of sysconfig register.
>>
>>In the current implementation the sysconfig value is read into
>> _sysc_cache once and an actual update to the sysconfig register
>>happens only if the new value paased is differnt from the one in _sysc_cache.
>>_sysc_cache is updated only if _HWMOD_SYSCONFIG_LOADED is not set.
>>This can lead to the follwing issue if off mode is enabled in modules
>>which employs "always-retore" mechanism of context save and restore.
>>
>>	a. The module sets the sysconfig register through omap_device_enable.
>>	   Here _sysc_cache is updated with the value written to the sysconfig
>>	   register and left.
>>	b. The power domain containig the module enters off mode and the
>>	   module context is lost.
>>	c. The module in use becomes active and calls omap_device_enable to
>>	   enable itself. Here a read of sysconfig register does not happen
>>	   as _HWMOD_SYSCONFIG_LOADED flag is set. The value to be written
>>	   to the sysconfig register will be same as the one written in step a.
>>	   Since _sysc_cache reflects the previous written value an update
>>	   of the sysconfig register does not happen.
>>This means in modules which employs "always-restore" mechanism
>>after off , the sysconfig regsiters will never get updated.
>>
>>This patch introduces a flag SYSC_NO_CACHE which if set ensures that the
>>sysconfig register is always read into _sysc_cache before an update is
>>attempted.
>>
>>This flags need to be set only by modules which does not do a context save
>>but re-initializes the registers every time the module is accessed. This
>>includes modules like i2c, smartreflex etc.
>>
>>Signed-off-by: Thara Gopinath <thara@ti.com>
>>Cc: Paul Walmsley <paul@pwsan.com>
>>---
>>This patch depends on
>>		http://patchwork.kernel.org/patch/63383/
>>		http://patchwork.kernel.org/patch/65140/
>>
>> arch/arm/mach-omap2/omap_hwmod.c             |    3 ++-
>> arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
>> 2 files changed, 3 insertions(+), 1 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>>index 3edc387..786bf2e 100644
>>--- a/arch/arm/mach-omap2/omap_hwmod.c
>>+++ b/arch/arm/mach-omap2/omap_hwmod.c
>>@@ -93,7 +93,8 @@ static int _update_sysc_cache(struct omap_hwmod *oh)
>>
>> 	oh->_sysc_cache = omap_hwmod_readl(oh, oh->sysconfig->sysc_offs);
>>
>>-	oh->_int_flags |= _HWMOD_SYSCONFIG_LOADED;
>>+	if (!(oh->sysconfig->sysc_flags & SYSC_NO_CACHE))
>>+		oh->_int_flags |= _HWMOD_SYSCONFIG_LOADED;
>>
>> 	return 0;
>> }
>>diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-
>>omap/include/plat/omap_hwmod.h
>>index 1f83495..a3298ca 100644
>>--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>>+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>>@@ -228,6 +228,7 @@ struct omap_hwmod_ocp_if {
>> #define SYSC_HAS_MIDLEMODE		(1 << 6)
>> #define SYSS_MISSING			(1 << 7)
>> #define SYSC_CHANGE_CLKACT_OFFSET	(1 << 8)
>>+#define SYSC_NO_CACHE			(1 << 9)
>>
>> /* omap_hwmod_sysconfig.clockact flags */
>> #define CLOCKACT_TEST_BOTH	0x0
>>--
Hi Paul,Kevin.. Does this patch look ok?

>>1.5.4.7

