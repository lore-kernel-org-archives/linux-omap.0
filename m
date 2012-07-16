From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv4 5/8] ARM: OMAP3: set autoidle flag for sdrc_ick
Date: Mon, 16 Jul 2012 16:09:08 +0530
Message-ID: <5003EF4C.6070700@ti.com>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com> <1342189185-5306-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:51017 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752421Ab2GPKjP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jul 2012 06:39:15 -0400
Received: by obbeh20 with SMTP id eh20so9987394obb.24
        for <linux-omap@vger.kernel.org>; Mon, 16 Jul 2012 03:39:14 -0700 (PDT)
In-Reply-To: <1342189185-5306-6-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Friday 13 July 2012 07:49 PM, Tero Kristo wrote:
> sdrc_ick doesn't have autoidle flag on HW, but is always automatically
> idled. Thus mark the autoidle flag statically as true for it to reflect
> hardware behavior. The clock will no longer show as active in usecount
> dumps and will allow the voltdm->sleep / wakeup calls to work properly.
>
> Signed-off-by: Tero Kristo<t-kristo@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> Cc: Kevin Hilman<khilman@ti.com>

Reviewed-by: Rajendra Nayak <rnayak@ti.com>

> ---
>   arch/arm/mach-omap2/clock3xxx_data.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
> index 1efdec2..596e041 100644
> --- a/arch/arm/mach-omap2/clock3xxx_data.c
> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> @@ -1751,6 +1751,7 @@ static struct clk sdrc_ick = {
>   	.flags		= ENABLE_ON_INIT,
>   	.clkdm_name	= "core_l3_clkdm",
>   	.recalc		=&followparent_recalc,
> +	.autoidle	= true,
>   };
>
>   static struct clk gpmc_fck = {

