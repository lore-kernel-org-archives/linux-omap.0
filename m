From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 4/9] ARM: OMAP2+: AM33XX: hwmod: Update TPTC0 hwmod with
 the right flags
Date: Fri, 18 Jan 2013 16:28:49 +0400
Message-ID: <50F94001.5050703@mvista.com>
References: <1358493569-17142-1-git-send-email-vaibhav.bedia@ti.com> <1358493569-17142-5-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:46095 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756286Ab3ARM3D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jan 2013 07:29:03 -0500
Received: by mail-la0-f44.google.com with SMTP id eb20so2681207lab.17
        for <linux-omap@vger.kernel.org>; Fri, 18 Jan 2013 04:29:01 -0800 (PST)
In-Reply-To: <1358493569-17142-5-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, b-cousson@ti.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

Hello.

On 18-01-2013 11:19, Vaibhav Bedia wrote:

> Third Party Transfer Controller (TPTC0) needs to be idled and
> put to standby under SW control. Add the appropriate flags in
> the TPTC0 hwmod entry.

> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> Change from RFC version:
> 	Clarify TPTC in the changelog

>   arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> index 8280f11..f2f408c 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> @@ -1823,6 +1823,7 @@ static struct omap_hwmod am33xx_tptc0_hwmod = {
>   	.class		= &am33xx_tptc_hwmod_class,
>   	.clkdm_name	= "l3_clkdm",
>   	.mpu_irqs	= am33xx_tptc0_irqs,
> +	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),

    Parens not needed here.

WBR, Sergei

