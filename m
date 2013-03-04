From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Remove duplicate omap4430_init_late()
 declaration
Date: Mon, 4 Mar 2013 10:19:07 -0800
Message-ID: <20130304181906.GN11806@atomide.com>
References: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com>
 <1360336306-18277-2-git-send-email-santosh.shilimkar@ti.com>
 <511E0167.8020700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:10111 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932115Ab3CDSTK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Mar 2013 13:19:10 -0500
Content-Disposition: inline
In-Reply-To: <511E0167.8020700@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130215 01:38]:
> Tony,
> 
> On Friday 08 February 2013 08:41 PM, Santosh Shilimkar wrote:
> >Commit bbd707ac {ARM: omap2: use machine specific hook for late init}
> >accidentally added two declarations for omap4430_init_late().
> >
> >Remove the duplicate declaration.
> >
> >Cc: Shawn Guo <shawn.guo@linaro.org>
> >Cc: Tony Lindgren <tony@atomide.com>
> >
> >Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >---
> >  arch/arm/mach-omap2/common.h |    1 -
> >  1 file changed, 1 deletion(-)
> >
> >diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> >index 948bcaa..e0f9ea7 100644
> >--- a/arch/arm/mach-omap2/common.h
> >+++ b/arch/arm/mach-omap2/common.h
> >@@ -108,7 +108,6 @@ void omap35xx_init_late(void);
> >  void omap3630_init_late(void);
> >  void am35xx_init_late(void);
> >  void ti81xx_init_late(void);
> >-void omap4430_init_late(void);
> >  int omap2_common_pm_late_init(void);
> >
> >  #if defined(CONFIG_SOC_OMAP2420) || defined(CONFIG_SOC_OMAP2430)
> >
> Can you pick this up ?

Thanks applying into omap-for-v3.9-rc1/fixes.

Regards,

Tony
