From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/3] OMAP: hwmod: add read/write API for SYSCONFIG
Date: Thu, 14 Jan 2010 16:19:06 -0800
Message-ID: <877hrk5if9.fsf@deeprootsystems.com>
References: <1262993213-19866-1-git-send-email-khilman@deeprootsystems.com>
	<1262993213-19866-2-git-send-email-khilman@deeprootsystems.com>
	<1262993213-19866-3-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.1001131822440.4769@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f194.google.com ([209.85.223.194]:47830 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757407Ab0AOATP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jan 2010 19:19:15 -0500
Received: by iwn32 with SMTP id 32so192129iwn.33
        for <linux-omap@vger.kernel.org>; Thu, 14 Jan 2010 16:19:14 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1001131822440.4769@utopia.booyaka.com> (Paul Walmsley's message of "Wed\, 13 Jan 2010 18\:26\:04 -0700 \(MST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin, 
>
> On Fri, 8 Jan 2010, Kevin Hilman wrote:
>
>> Some HW blocks have errata which requires selective enabling/disabling
>> of SYSCONFIG bits.  In particular, some blocks have known issues with
>> smart-idle so smart-idle has to be disabled under certain conditions.
>
> ...
>
>> RFC: would an API to only touch smart-idle be more appropriate? Maybe 
>> omap_hwmod_smart_idle_enable(oh, bool enable)?
>
> This idea sounds good.  Since the SYSCONFIG bit fields can change and move 
> around depending on the chip and IP, some type of higher-level API seems 
> necessary to preserve sanity.
>
> Maybe omap_hwmod_smart_idle_enable() and omap_hwmod_smart_idle_disable(), 
> mimicking API styles like clk_enable()/clk_disable(), etc.?  Care to spin 
> something like that?

Turns out I needed more than just smart-idle enable/disable.  There
are UART errata that also require force-idle (when DMA is in use.)

So, instead I added an API for simply setting slave idle mode (patch
below.)

Here's the UART code that is using this function:
{
	u8 idlemode;

	if (enable) {
		/**
		 * Errata 2.15: [UART]:Cannot Acknowledge Idle Requests
		 * in Smartidle Mode When Configured for DMA Operations.
		 */
		if (uart->dma_enabled)
			idlemode = HWMOD_IDLEMODE_FORCE;
		else
			idlemode = HWMOD_IDLEMODE_SMART;
	} else {
		idlemode = HWMOD_IDLEMODE_NO;
	}

	omap_hwmod_set_slave_idlemode(uart->oh, idlemode);
}


>From fb0387e2747e2c0b1eff99bc842cad5026e96283 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@deeprootsystems.com>
Date: Mon, 23 Nov 2009 09:41:54 -0800
Subject: [PATCH 2/2] OMAP: hwmod: add API for slave idlemode setting

Some HW blocks have errata which requires specific slave idle mode
under certain conditions.

This patch adds an hwmod API to allow setting slave idlemode
ensuring that any SYSCONFIG register updates go through hwmod.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   17 +++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 ++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index d8c8545..3bc47dc 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -993,6 +993,23 @@ void omap_hwmod_writel(u32 v, struct omap_hwmod *oh, u16 reg_offs)
 	__raw_writel(v, oh->_rt_va + reg_offs);
 }
 
+int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode)
+{
+	u32 v;
+	int retval = 0;
+
+	if (!oh)
+		return -EINVAL;
+
+	v = oh->_sysc_cache;
+
+	retval = _set_slave_idlemode(oh, idlemode, &v);
+	if (!retval)
+		_write_sysconfig(v, oh);
+
+	return retval;
+}
+
 /**
  * omap_hwmod_register - register a struct omap_hwmod
  * @oh: struct omap_hwmod *
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 007935a..1f57330 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -440,6 +440,8 @@ int omap_hwmod_shutdown(struct omap_hwmod *oh);
 int omap_hwmod_enable_clocks(struct omap_hwmod *oh);
 int omap_hwmod_disable_clocks(struct omap_hwmod *oh);
 
+int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode);
+
 int omap_hwmod_reset(struct omap_hwmod *oh);
 void omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
 
-- 
1.6.6

