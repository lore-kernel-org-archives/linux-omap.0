From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 09/13] OMAP3: Introduce voltage domain info in the hwmod structures.
Date: Fri, 04 Feb 2011 08:10:21 -0800
Message-ID: <87k4hfsrv6.fsf@ti.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
	<1295618465-15234-10-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:36388 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752104Ab1BDQK3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 11:10:29 -0500
Received: by mail-pz0-f47.google.com with SMTP id 12so424719pzk.6
        for <linux-omap@vger.kernel.org>; Fri, 04 Feb 2011 08:10:28 -0800 (PST)
In-Reply-To: <1295618465-15234-10-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Fri, 21 Jan 2011 19:31:01 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Thara Gopinath <thara@ti.com>

Vishwanath BS <vishwanath.bs@ti.com> writes:

> From: Thara Gopinath <thara@ti.com>
>
> This patch adds voltage domain info in the relevant
> device hwmod structures so as to enable OMAP3 DVFS
> support.

Has there been work yet on the autogen scripts to auto-generate this for
OMAP4?

Kevin

> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 8d81813..c57f34d 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -94,6 +94,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l3_main_masters[] = {
>  static struct omap_hwmod omap3xxx_l3_main_hwmod = {
>  	.name		= "l3_main",
>  	.class		= &l3_hwmod_class,
> +	.vdd_name	= "core",
>  	.masters	= omap3xxx_l3_main_masters,
>  	.masters_cnt	= ARRAY_SIZE(omap3xxx_l3_main_masters),
>  	.slaves		= omap3xxx_l3_main_slaves,
> @@ -384,6 +385,7 @@ static struct omap_hwmod omap3xxx_mpu_hwmod = {
>  	.name		= "mpu",
>  	.class		= &mpu_hwmod_class,
>  	.main_clk	= "arm_fck",
> +	.vdd_name	= "mpu",
>  	.masters	= omap3xxx_mpu_masters,
>  	.masters_cnt	= ARRAY_SIZE(omap3xxx_mpu_masters),
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> @@ -412,6 +414,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_iva_masters[] = {
>  static struct omap_hwmod omap3xxx_iva_hwmod = {
>  	.name		= "iva",
>  	.class		= &iva_hwmod_class,
> +	.vdd_name	= "mpu",
>  	.masters	= omap3xxx_iva_masters,
>  	.masters_cnt	= ARRAY_SIZE(omap3xxx_iva_masters),
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
