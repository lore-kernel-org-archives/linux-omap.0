From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4 01/11] ARM: OMAP2+: CM: cm_inst offset s16->u16
Date: Mon, 30 Sep 2013 03:23:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1309300314520.17980@utopia.booyaka.com>
References: <cover.1380179370.git.afzal@ti.com> <5e9ef86c35c60862a1c2aa24172e41ee4c6f07de.1380179370.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42445 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058Ab3I3DXa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Sep 2013 23:23:30 -0400
In-Reply-To: <5e9ef86c35c60862a1c2aa24172e41ee4c6f07de.1380179370.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Ankur Kishore <a-kishore@ti.com>

Hi

On Thu, 26 Sep 2013, Afzal Mohammed wrote:

> Most of the AM43x CM reg address offsets are with MSB bit '1' (on
> 16-bit value) leading to arithmetic miscalculations while calculating
> CLOCK ENABLE register's address because cm_inst field was a type of
> "const s16", so make it "const u16".
> 
> Also modify relevant functions so as to take care of the above.
> 
> [afzal@ti.com: fixup and cleanup]
> 
> Signed-off-by: Ankur Kishore <a-kishore@ti.com>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/clockdomain.h |  2 +-
>  arch/arm/mach-omap2/cm33xx.c      | 16 ++++++++--------
>  arch/arm/mach-omap2/cm33xx.h      | 10 +++++-----
>  arch/arm/mach-omap2/cminst44xx.c  | 20 ++++++++++----------
>  arch/arm/mach-omap2/cminst44xx.h  | 26 +++++++++++++-------------
>  5 files changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
> index 4b03394..5431b0c 100644
> --- a/arch/arm/mach-omap2/clockdomain.h
> +++ b/arch/arm/mach-omap2/clockdomain.h
> @@ -132,7 +132,7 @@ struct clockdomain {
>  	u8 _flags;
>  	const u8 dep_bit;
>  	const u8 prcm_partition;
> -	const s16 cm_inst;
> +	const u16 cm_inst;
>  	const u16 clkdm_offs;
>  	struct clkdm_dep *wkdep_srcs;
>  	struct clkdm_dep *sleepdep_srcs;

OMAP3 has at least one CM_INST that's negative:

./prcm-common.h:40:#define OMAP3430_IVA2_MOD				-0x800

Have you tested this on OMAP34xx/35xx to ensure that the generated 
addresses for IVA2_MOD-based addresses doesn't change?  Seems like there's 
a risk that they might change, due to sign extension.


- Paul
