From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCHv2 2/4] mach-omap2: Add SoC info data for OMAP2,3,4 into
 /proc/cpuinfo
Date: Wed, 28 Apr 2010 08:43:34 +0300
Message-ID: <20100428054334.GD332@besouro.research.nokia.com>
References: <1272374055-9656-1-git-send-email-eduardo.valentin@nokia.com>
 <1272374055-9656-3-git-send-email-eduardo.valentin@nokia.com>
 <20100427150129.GA8600@nokia.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40336 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549Ab0D1FnP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 01:43:15 -0400
Content-Disposition: inline
In-Reply-To: <20100427150129.GA8600@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, "De-Schrijver Peter (Nokia-D/Helsinki)" <Peter.De-Schrijver@nokia.com>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>

On Tue, Apr 27, 2010 at 05:01:30PM +0200, Balbi Felipe (Nokia-D/Helsinki) wrote:
> On Tue, Apr 27, 2010 at 03:14:13PM +0200, Valentin Eduardo (Nokia-D/Helsinki) wrote:
> >From: Eduardo Valentin <eduardo.valentin@nokia.com>
> >
> >Report OMAP2,3,4 data into system_soc_info. Now we get omap
> >information under /proc/cpuinfo.
> >
> >Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> >---
> > arch/arm/mach-omap2/id.c |   21 +++++++++++++++------
> > 1 files changed, 15 insertions(+), 6 deletions(-)
> >
> >diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> >index 37b8a1a..75e36a5 100644
> >--- a/arch/arm/mach-omap2/id.c
> >+++ b/arch/arm/mach-omap2/id.c
> >@@ -152,10 +152,15 @@ void __init omap24xx_check_revision(void)
> > 		j = i;
> > 	}
> >
> >-	pr_info("OMAP%04x", omap_rev() >> 16);
> >-	if ((omap_rev() >> 8) & 0x0f)
> >-		pr_info("ES%x", (omap_rev() >> 12) & 0xf);
> >-	pr_info("\n");
> >+	snprintf(system_soc_info, SYSTEM_SOC_INFO_SIZE, "OMAP%04x",
> >+							omap_rev() >> 16);
> >+	if ((omap_rev() >> 8) & 0x0f) {
> >+		int sz = strlen(system_soc_info);
> 
> how about you use the return of the first snprintf instead of asking 
> strlen() here ? I mean:

Yeah,

> 
> int sz = snprintf(system_soc_info, SYSTEM_SOC_INFO_SIZE, "OMAP%04x",
> 		omap_rev() >> 16);
> 
> if ((omap_rev() >> 8) & 0x0f)
> 	snprintf(system_soc_info + sz, SYSTEM_SOC_INFO_SIZE - sz,
> 			"ES%x", (omap_rev() >> 12) & 0x0f);
> 
> would that work ???

I think so, yeah. No need to recompute the string length twice. Will resend soon.

> 
> -- 
> balbi
> 
> DefectiveByDesign.org
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
