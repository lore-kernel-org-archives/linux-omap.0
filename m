From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix undefined reference to set_cntfreq
Date: Mon, 18 Nov 2013 15:21:47 -0800
Message-ID: <20131118232145.GX10317@atomide.com>
References: <20131118215855.GW10317@atomide.com>
 <528A9E8C.9040903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36877 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420Ab3KRXVt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Nov 2013 18:21:49 -0500
Content-Disposition: inline
In-Reply-To: <528A9E8C.9040903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [131118 15:11]:
> On Monday 18 November 2013 04:58 PM, Tony Lindgren wrote:
> > If CONFIG_SOC_HAS_REALTIME_COUNTER is not selected for omap5
> > or dra7xx, we can get the following error:
> > 
> > arch/arm/mach-omap2/built-in.o: In function `omap4_secondary_init':
> > :(.text+0x7ab0): undefined reference to `set_cntfreq'
> > 
> > Fix the issue by not trying to initalize the realtime counter
> > unles CONFIG_SOC_HAS_REALTIME_COUNTER is selected.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> >
> How about a dummy inline function of set_cntfreq() ?
> Having #ifdef in middle of the code looks pretty ugly.

Sure, here's an updated version.

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Mon, 18 Nov 2013 13:56:48 -0800
Subject: [PATCH] ARM: OMAP2+: Fix undefined reference to set_cntfreq

If CONFIG_SOC_HAS_REALTIME_COUNTER is not selected for omap5
or dra7xx, we can get the following error:

arch/arm/mach-omap2/built-in.o: In function `omap4_secondary_init':
:(.text+0x7ab0): undefined reference to `set_cntfreq'

Fix the issue by not trying to initalize the realtime counter
unles CONFIG_SOC_HAS_REALTIME_COUNTER is selected.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -76,6 +76,13 @@ static inline void omap_barrier_reserve_memblock(void)
 { }
 #endif
 
+#ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
 void set_cntfreq(void);
+#else
+static inline void set_cntfreq(void)
+{
+}
+#endif
+
 #endif /* __ASSEMBLER__ */
 #endif /* OMAP_ARCH_OMAP_SECURE_H */
