From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 06/11] omap4: Fix omap_l2_cache_init not to run for
 other omaps
Date: Sat, 1 May 2010 11:48:13 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5217DFB@dbde02.ent.ti.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
 <20100430203359.25812.56284.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44343 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164Ab0EAGSZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 02:18:25 -0400
In-Reply-To: <20100430203359.25812.56284.stgit@baageli.muru.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony,

> -----Original Message-----
> From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-kernel-
> bounces@lists.infradead.org] On Behalf Of Tony Lindgren
> Sent: Saturday, May 01, 2010 2:04 AM
> To: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> Subject: [PATCH 06/11] omap4: Fix omap_l2_cache_init not to run for other omaps
> 
> In multi-omap configuration all the initcalls run. To avoid
> bad things from happening with 44xx specific initcalls on
> other omaps, we need to check that the booted system is
> omap4 before running.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index b88f28c..e603b00 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -55,6 +55,9 @@ static int __init omap_l2_cache_init(void)
>  	extern void omap_smc1(u32 fn, u32 arg);
>  	void __iomem *l2cache_base;
> 
> +	if (!cpu_is_omap44xx())
> +		return -ENODEV;
> +

This check is already present just 3 lines below.

>  	/* To avoid code running on other OMAPs in
>  	 * multi-omap builds
>  	 */
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
