From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/5 v14] arm: omap: usb: ehci and ohci hwmod structures
 for omap3
Date: Thu, 13 Oct 2011 12:30:45 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110131227270.24155@utopia.booyaka.com>
References: <1318319355-20168-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1318319355-20168-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, khilman@ti.com, b-cousson@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com
List-Id: linux-omap@vger.kernel.org

On Tue, 11 Oct 2011, Keshava Munegowda wrote:

> Following 2 hwmod structures are added
>     1. usb_host_hs
>          The hwmod of usbhs with uhh, ehci and ohci base addresses
>          functional clock and ehci, ohci irqs
> 
>     2. usb_tll_hs
>           hwmod of usbhs with the TLL base address and irq.
> 
> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> Reviewed-by: Partha Basak <parthab@india.ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  230 ++++++++++++++++++++++++++++
>  1 files changed, 230 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 59fdb9f..c06b4a4 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -84,6 +84,8 @@ static struct omap_hwmod omap3xxx_mcbsp4_hwmod;

...

> +static struct omap_hwmod_ocp_if omap34xx_ick_cfg__usb_tll_hs = {
> +	.clk		= "usbtll_ick",
> +	.addr		= omap34xx_usb_tll_hs_addrs,
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};

This version doesn't respond to my previous comment:

"This interface is missing a .master and .slave.  It must have both.  So, 
dropping this patch until it's fixed."

Insert boilerplate frustration here...


- Paul
