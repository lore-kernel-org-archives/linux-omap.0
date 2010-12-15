From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] omap2+: Initialize omap_irq_base for
 entry-macro.Sfrom platform code
Date: Tue, 14 Dec 2010 19:25:38 -0800
Message-ID: <20101215032538.GI3190@atomide.com>
References: <20101204001435.28853.29616.stgit@baageli.muru.com>
 <alpine.LFD.2.00.1012040040590.10437@xanadu.home>
 <20101204180541.GH17222@atomide.com>
 <alpine.LFD.2.00.1012042126350.10437@xanadu.home>
 <20101205031002.GP17222@atomide.com>
 <20101208014548.GJ17435@atomide.com>
 <20101208014921.GM17435@atomide.com>
 <774b6f8f3fa4cae7210bfdb317c68e12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26667 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754Ab0LODZl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 22:25:41 -0500
Content-Disposition: inline
In-Reply-To: <774b6f8f3fa4cae7210bfdb317c68e12@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [101213 03:57]:
> >
> > +static inline void omap_irq_base_init(void)
> > +{
> > +	extern void __iomem *omap_irq_base;
> > +
> > +#ifdef MULTI_OMAP2
> > +	if (cpu_is_omap242x())
> 
> Looks like this should be a cpu_is_omap24xx(). The
> current master is broken on a 2430sdp and a git-bisect
> pointed me to this patch.

Thanks, just noticed that too. Here's a fix for that.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Tue, 14 Dec 2010 19:17:31 -0800
Subject: [PATCH] omap: Fix setting omap_irq_base for 2430

We need to test for 24xx not 242x. Otherwise interrupts won't work.

Reported-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -320,7 +320,7 @@ static inline void omap_irq_base_init(void)
 	extern void __iomem *omap_irq_base;
 
 #ifdef MULTI_OMAP2
-	if (cpu_is_omap242x())
+	if (cpu_is_omap24xx())
 		omap_irq_base = OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE);
 	else if (cpu_is_omap34xx())
 		omap_irq_base = OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE);
