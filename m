From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: board-generic: Replace #if defined by
 #ifdef for consistency
Date: Wed, 21 Dec 2011 11:19:15 -0800
Message-ID: <20111221191915.GF24444@atomide.com>
References: <y>
 <1323190149-6492-4-git-send-email-b-cousson@ti.com>
 <4EF08B8B.2040400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:40685 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751649Ab1LUTTU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Dec 2011 14:19:20 -0500
Content-Disposition: inline
In-Reply-To: <4EF08B8B.2040400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Cousson, Benoit <b-cousson@ti.com> [111220 04:48]:
> Hi Tony,
> 
> What about that patch?
> 
> This is the only one that is missing in lo.
> I know it is not a big deal, but it will make things a little bit cleaner.

I think we should wait on this one and combine it later on into
some other clean-up patch.

Regards,

Tony
 
> Thanks,
> Benoit
> 
> On 12/6/2011 5:49 PM, Benoit Cousson wrote:
> >The file contains a mix of #ifdef and #if defined().
> >Replace the #if... by #ifdef.
> >
> >Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> >Cc: Tony Lindgren<tony@atomide.com>
> >---
> >  arch/arm/mach-omap2/board-generic.c |    8 ++++----
> >  1 files changed, 4 insertions(+), 4 deletions(-)
> >
> >diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> >index fb55fa3..09f44e0 100644
> >--- a/arch/arm/mach-omap2/board-generic.c
> >+++ b/arch/arm/mach-omap2/board-generic.c
> >@@ -92,7 +92,7 @@ static void __init omap3_init(void)
> >  }
> >  #endif
> >
> >-#if defined(CONFIG_SOC_OMAP2420)
> >+#ifdef CONFIG_SOC_OMAP2420
> >  static const char *omap242x_boards_compat[] __initdata = {
> >  	"ti,omap2420",
> >  	NULL,
> >@@ -110,7 +110,7 @@ DT_MACHINE_START(OMAP242X_DT, "Generic OMAP2420 (Flattened Device Tree)")
> >  MACHINE_END
> >  #endif
> >
> >-#if defined(CONFIG_SOC_OMAP2430)
> >+#ifdef CONFIG_SOC_OMAP2430
> >  static const char *omap243x_boards_compat[] __initdata = {
> >  	"ti,omap2430",
> >  	NULL,
> >@@ -128,7 +128,7 @@ DT_MACHINE_START(OMAP243X_DT, "Generic OMAP2430 (Flattened Device Tree)")
> >  MACHINE_END
> >  #endif
> >
> >-#if defined(CONFIG_ARCH_OMAP3)
> >+#ifdef CONFIG_ARCH_OMAP3
> >  static const char *omap3_boards_compat[] __initdata = {
> >  	"ti,omap3",
> >  	NULL,
> >@@ -146,7 +146,7 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
> >  MACHINE_END
> >  #endif
> >
> >-#if defined(CONFIG_ARCH_OMAP4)
> >+#ifdef CONFIG_ARCH_OMAP4
> >  static const char *omap4_boards_compat[] __initdata = {
> >  	"ti,omap4",
> >  	NULL,
> 
