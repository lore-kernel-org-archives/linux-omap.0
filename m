From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC] ARM: OMAP: hwmod: wait for sysreset complete after enabling hwmod
Date: Tue, 23 Oct 2012 10:03:11 -0700
Message-ID: <87objt9l4g.fsf@deeprootsystems.com>
References: <1350922532-26338-1-git-send-email-t-kristo@ti.com>
	<alpine.DEB.2.00.1210230745160.32436@utopia.booyaka.com>
	<87txtlb6v7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51613 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757261Ab2JWRCo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 13:02:44 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2894617pad.19
        for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 10:02:44 -0700 (PDT)
In-Reply-To: <87txtlb6v7.fsf@deeprootsystems.com> (Kevin Hilman's message of
	"Tue, 23 Oct 2012 07:28:12 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Venkatraman S <svenkatr@ti.com>

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Paul Walmsley <paul@pwsan.com> writes:
>
>> Hi Tero,
>>
>> On Mon, 22 Oct 2012, Tero Kristo wrote:
>>
>>> When waking up from off-mode, some IP blocks are reset automatically by
>>> hardware. For this reason, software must wait until the reset has
>>> completed before attempting to access the IP block.
>>> 
>>> This patch fixes for example the bug introduced by commit
>>> 6c31b2150ff96755d24e0ab6d6fea08a7bf5c44c ("mmc: omap_hsmmc: remove access
>>> to SYSCONFIG register"), in which the MMC IP block is reset during
>>> off-mode entry, but the code expects the module to be already available
>>> during the execution of context restore.
>>> 
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>> Cc: Paul Walmsley <paul@pwsan.com>
>>> Cc: Benoit Cousson <b-cousson@ti.com>
>>> Cc: Venkatraman S <svenkatr@ti.com>
>>
>> What do you think about these modifications?  The code is quite similar to 
>> what was in the _ocp_softreset() function, so just moved it into a 
>> function.  Also moved the callsite from the end of _enable_sysc() to the 
>> beginning, which makes more sense to me, but would like to get your 
>> opinion.
>
> FYI, after some more testing with this patch, I noticed that this patch
> (and the original from Tero) cause some sluggishness on UART1 console my
> 37xx/EVM platform as soon as off-mode is enabled (even without the UART
> autosuspend timeouts enabled.)  I don't see this on any other OMAP3
> platform but all the others I have have UART3 console (in PER), the EVM
> is the only one with UART1 console (in CORE.)

OK, found it.

The reason for the sluggishness is that the GPIO blocks are timing
out in the omap_test_timout() calls added in this patch, suggesting that
they never detect reset done.

Looking at the other user of _wait_softreset_complete made me remember
that there modules that need their optional clocks enabled in order for
softreset to work.  It appears that the optional clocks are needed not
only to initiate a softrest, but also to check SYSS.RESETDONE.

The patch below on top of Paul's version makes the sluggishness disappear.

Kevin




diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index f9d8b2a..70267d2 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1320,7 +1320,11 @@ static void _enable_sysc(struct omap_hwmod *oh)
 	 * (off-mode for example), and the drivers require the
 	 * IP to be ready when they access it
 	 */
+	if (oh->flags & HWMOD_CONTROL_OPT_CLKS_IN_RESET)
+		_enable_optional_clocks(oh);
 	_wait_softreset_complete(oh);
+	if (oh->flags & HWMOD_CONTROL_OPT_CLKS_IN_RESET)
+		_disable_optional_clocks(oh);
 
 	v = oh->_sysc_cache;
 	sf = oh->class->sysc->sysc_flags;
