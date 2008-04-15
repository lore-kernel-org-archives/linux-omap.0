From: Francisco Alecrim <francisco.alecrim@indt.org.br>
Subject: Re: Missing mmc debounce clock (??)
Date: Tue, 15 Apr 2008 16:51:17 +0300
Message-ID: <4804B2D5.8000708@indt.org.br>
References: <20080325114302.GA4652@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:39382 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756671AbYDONyi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 09:54:38 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3FDsZJm000698
	for <linux-omap@vger.kernel.org>; Tue, 15 Apr 2008 16:54:35 +0300
In-Reply-To: <20080325114302.GA4652@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org

Hi Balbi,

    I was with the patch below in my queue when you told about your 
email at linux-omap.

I guess that is the correct solution.

What do you think?

Subject: [PATCH] MMC: OMAP: Enable debounce clock 32 Khz
Enable debounce clock 32 Khz

---
 arch/arm/mach-omap2/clock34xx.h |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h 
b/arch/arm/mach-omap2/clock34xx.h
index 5881662..05e9dd5 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1364,6 +1364,39 @@ static struct clk usbtll_fck = {
     .recalc        = &followparent_recalc,
 };
 
+static struct clk mmchsdb3_fck = {
+    .name        = "mmchsdb_fck",
+    .id        = 3,
+    .parent        = &omap_32k_fck,
+    .enable_reg    = OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+    .enable_bit    = OMAP3430ES2_EN_MMC3_SHIFT,
+    .flags        = CLOCK_IN_OMAP3430ES2,
+    .clkdm_name    = "core_l4_clkdm",
+    .recalc        = &followparent_recalc,
+};
+
+static struct clk mmchsdb2_fck = {
+    .name        = "mmchsdb_fck",
+    .id        = 2,
+    .parent        = &omap_32k_fck,
+    .enable_reg    = OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+    .enable_bit    = OMAP3430_EN_MMC2_SHIFT,
+    .flags        = CLOCK_IN_OMAP343X,
+    .clkdm_name    = "core_l4_clkdm",
+    .recalc        = &followparent_recalc,
+};
+
+static struct clk mmchsdb1_fck = {
+    .name        = "mmchsdb_fck",
+    .id        = 1,
+    .parent        = &omap_32k_fck,
+    .enable_reg    = OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+    .enable_bit    = OMAP3430_EN_MMC1_SHIFT,
+    .flags        = CLOCK_IN_OMAP343X,
+    .clkdm_name    = "core_l4_clkdm",
+    .recalc        = &followparent_recalc,
+};
+
 /* CORE 96M FCLK-derived clocks */
 
 static struct clk core_96m_fck = {
@@ -3105,6 +3138,9 @@ static struct clk *onchip_34xx_clks[] __initdata = {
     &cpefuse_fck,
     &ts_fck,
     &usbtll_fck,
+    &mmchsdb1_fck,
+    &mmchsdb2_fck,
+    &mmchsdb3_fck,
     &core_96m_fck,
     &mmchs3_fck,
     &mmchs2_fck,






ext Felipe Balbi wrote:
> Hi all,
>
> omap hsmmc driver is always complaining about the debounce clock. The
> clock it's trying to get is not listed in clock34xx.c, the following
> patch gets rid of debounce clock warning by adding the clock to the
> clock list.
>
> ps: it's RFC since I'm not really sure if it's the right clock although
> docs says it's the functional 32k clock. Comments??
>
>
> >From 2ef178c513ade5c029be582aa55b87daba3e333d Mon Sep 17 00:00:00 2001
> From: Felipe Balbi <felipe.balbi@nokia.com>
> Date: Tue, 25 Mar 2008 13:38:50 +0200
> Subject: [RFC PATCH] ARCH: OMAP3: Missing mmc debounce clock
>
> This clock was missing from clock34xx.c so mmc was
> unable to get it on omap_hsmmc.c giving us an uneeded
> warning.
>
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/mach-omap2/clock34xx.h |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
> index b0741ba..056f8f6 100644
> --- a/arch/arm/mach-omap2/clock34xx.h
> +++ b/arch/arm/mach-omap2/clock34xx.h
> @@ -44,6 +44,15 @@ static struct clk omap_32k_fck = {
>  	.recalc		= &propagate_rate,
>  };
>  
> +/* MMC debounce clock derivates from 32k functional clock */
> +static struct clk mmchsdb_fck = {
> +	.name		= "mmchsdb_fck",
> +	.id		= 1,
> +	.parent		= &omap_32k_fck,
> +	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
> +	.recalc		= &followparent_recalc,
> +};
> +
>  static struct clk secure_32k_fck = {
>  	.name		= "secure_32k_fck",
>  	.rate		= 32768,
> @@ -2863,6 +2872,7 @@ static struct clk *onchip_34xx_clks[] __initdata = {
>  	&ts_fck,
>  	&usbtll_fck,
>  	&core_96m_fck,
> +	&mmchsdb_fck,
>  	&mmchs3_fck,
>  	&mmchs2_fck,
>  	&mspro_fck,
>   


-- 
Francisco Keppler Silva Alecrim - INdT
Phone: +55 92 2126-1017

