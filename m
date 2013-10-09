From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH v3] ARM: omap: edma: add suspend suspend/resume hooks
Date: Tue, 8 Oct 2013 23:28:54 -0500
Message-ID: <5254DB86.4000104@ti.com>
References: <1380639886-9526-1-git-send-email-zonque@gmail.com>
Reply-To: <joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41460 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195Ab3JIE3c (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 00:29:32 -0400
In-Reply-To: <1380639886-9526-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com

On 10/01/2013 10:04 AM, Daniel Mack wrote:
> This patch makes the edma driver resume correctly after suspend. Tested
> on an AM33xx platform with cyclic audio streams.
> 
> The code was shamelessly taken from an ancient BSP tree.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  arch/arm/common/edma.c | 133 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 133 insertions(+)
> 
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index 2a72169..d787f14 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -258,6 +258,20 @@ struct edma {
>  				void *data);
>  		void *data;
>  	} intr_data[EDMA_MAX_DMACH];
> +
> +	struct {
> +		struct edmacc_param *prm_set;
> +		unsigned int *ch_map;               /* 64 registers */
> +		unsigned int *que_num;              /* 8 registers */

This is OK to save.

> +		unsigned int sh_esr;
> +		unsigned int sh_esrh;
> +		unsigned int sh_eesr;
> +		unsigned int sh_eesrh;
> +		unsigned int sh_iesr;
> +		unsigned int sh_iesrh;

Are all these really necessary?

esr and eer- No one should really be setting the esr and should not depend on it
when going to a low power state. I wouldn't expect any driver to suspend between
edma_start and edma_stop. In DMA Engine, this would correspond to the driver
getting a successful callback.

Before suspend, drivers using DMA should anyway be done with using the channel
before they can goto suspend, correct me if I'm wrong. So this seems unnecessary
to do.

Only thing that makes sense to me to save here is the iesr registers.

> +		unsigned int que_tc_map;
> +		unsigned int que_pri;

This is OK to save.

> +	} context;
>  };
>  
>  static struct edma *edma_cc[EDMA_MAX_CC];
> @@ -1655,6 +1669,16 @@ static int edma_probe(struct platform_device *pdev)
>  			memcpy_toio(edmacc_regs_base[j] + PARM_OFFSET(i),
>  					&dummy_paramset, PARM_SIZE);
>  
> +		/* resume context */
> +		edma_cc[j]->context.prm_set =
> +			kzalloc((sizeof(struct edmacc_param) *
> +				 edma_cc[j]->num_slots), GFP_KERNEL);

Why should you back-up PaRAM set? I feel this is not necessary. PaRAM set will
be setup again for the transfer after the resume, and there shouldn't be any
pending transfers before the suspend.

Looks like in your audio driver you need to make sure any pending DMA transfers
are completed before suspending (unless you're already doing so).

> +		edma_cc[j]->context.ch_map =
> +			kzalloc((sizeof(unsigned int) *
> +				 edma_cc[j]->num_channels), GFP_KERNEL);
> +		edma_cc[j]->context.que_num =
> +			kzalloc((sizeof(unsigned int) * 8), GFP_KERNEL);

Can these allocations be moved to the suspend path? For systems that don't
suspend/resume even once, I feel we shouldn't allocate memory that we don't use.
These allocations are better to do there.

-Joel

