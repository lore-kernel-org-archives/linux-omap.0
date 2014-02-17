From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 1/1] ARM: OMAP5: Fix reboot handling
Date: Mon, 17 Feb 2014 12:28:00 +0530
Message-ID: <5301B2F8.2000007@ti.com>
References: <1392592544-7884-1-git-send-email-vaibhav.bedia@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43302 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151AbaBQG6z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Feb 2014 01:58:55 -0500
In-Reply-To: <1392592544-7884-1-git-send-email-vaibhav.bedia@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@gmail.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Monday 17 February 2014 04:45 AM, Vaibhav Bedia wrote:
> Use the correct register offset for issuing the
> reset command in OMAP5. Since dev_inst is set dynamically
> OMAP4 should not be affected by this change.
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@gmail.com>

Acked-by: Rajendra Nayak <rnayak@ti.com>

> ---
> Applies on top of v3.14-rc3
> 
>  arch/arm/mach-omap2/prminst44xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
> index 6334b96..280f3c5 100644
> --- a/arch/arm/mach-omap2/prminst44xx.c
> +++ b/arch/arm/mach-omap2/prminst44xx.c
> @@ -183,11 +183,11 @@ void omap4_prminst_global_warm_sw_reset(void)
>  					OMAP4_PRM_RSTCTRL_OFFSET);
>  	v |= OMAP4430_RST_GLOBAL_WARM_SW_MASK;
>  	omap4_prminst_write_inst_reg(v, OMAP4430_PRM_PARTITION,
> -				 OMAP4430_PRM_DEVICE_INST,
> +				 dev_inst,
>  				 OMAP4_PRM_RSTCTRL_OFFSET);
>  
>  	/* OCP barrier */
>  	v = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
> -				    OMAP4430_PRM_DEVICE_INST,
> +				    dev_inst,
>  				    OMAP4_PRM_RSTCTRL_OFFSET);
>  }
> 

