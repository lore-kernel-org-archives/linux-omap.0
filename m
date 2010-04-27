From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCHv2 2/4] mach-omap2: Add SoC info data for OMAP2,3,4 into
 /proc/cpuinfo
Date: Tue, 27 Apr 2010 18:01:30 +0300
Message-ID: <20100427150129.GA8600@nokia.com>
References: <1272374055-9656-1-git-send-email-eduardo.valentin@nokia.com>
 <1272374055-9656-3-git-send-email-eduardo.valentin@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26298 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254Ab0D0PCz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 11:02:55 -0400
Content-Disposition: inline
In-Reply-To: <1272374055-9656-3-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, "De-Schrijver Peter (Nokia-D/Helsinki)" <Peter.De-Schrijver@nokia.com>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>

On Tue, Apr 27, 2010 at 03:14:13PM +0200, Valentin Eduardo (Nokia-D/Helsinki) wrote:
>From: Eduardo Valentin <eduardo.valentin@nokia.com>
>
>Report OMAP2,3,4 data into system_soc_info. Now we get omap
>information under /proc/cpuinfo.
>
>Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
>---
> arch/arm/mach-omap2/id.c |   21 +++++++++++++++------
> 1 files changed, 15 insertions(+), 6 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
>index 37b8a1a..75e36a5 100644
>--- a/arch/arm/mach-omap2/id.c
>+++ b/arch/arm/mach-omap2/id.c
>@@ -152,10 +152,15 @@ void __init omap24xx_check_revision(void)
> 		j = i;
> 	}
>
>-	pr_info("OMAP%04x", omap_rev() >> 16);
>-	if ((omap_rev() >> 8) & 0x0f)
>-		pr_info("ES%x", (omap_rev() >> 12) & 0xf);
>-	pr_info("\n");
>+	snprintf(system_soc_info, SYSTEM_SOC_INFO_SIZE, "OMAP%04x",
>+							omap_rev() >> 16);
>+	if ((omap_rev() >> 8) & 0x0f) {
>+		int sz = strlen(system_soc_info);

how about you use the return of the first snprintf instead of asking 
strlen() here ? I mean:

int sz = snprintf(system_soc_info, SYSTEM_SOC_INFO_SIZE, "OMAP%04x",
		omap_rev() >> 16);

if ((omap_rev() >> 8) & 0x0f)
	snprintf(system_soc_info + sz, SYSTEM_SOC_INFO_SIZE - sz,
			"ES%x", (omap_rev() >> 12) & 0x0f);

would that work ???

-- 
balbi

DefectiveByDesign.org
