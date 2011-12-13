From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv11 1/8] ARM: OMAP2+: hwmod: Add API to enable IO ring
 wakeup.
Date: Tue, 13 Dec 2011 14:33:43 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112131431310.12046@utopia.booyaka.com>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com> <1323713733-13115-2-git-send-email-t-kristo@ti.com> <alpine.DEB.2.00.1112131354380.12046@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34091 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab1LMVdo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Dec 2011 16:33:44 -0500
In-Reply-To: <alpine.DEB.2.00.1112131354380.12046@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "R, Govindraj" <govindraj.raja@ti.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Govindraj, Tero,

another question about this patch:

On Tue, 13 Dec 2011, Paul Walmsley wrote:

> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 207a2ff..ec19841 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -381,6 +381,43 @@ static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
>  }
>  
>  /**
> + * _set_ioring_wakeup - enable/disable IO pad wakeup flag for dynamic muxing
> + * @oh: struct omap_hwmod *
> + * @set_wake: bool value indicating to set (true) or clear (false) wakeup enable
> + *
> + * Set or clear the I/O pad wakeup flag in the dynamic mux entries for
> + * the hwmod @oh.  This function does not change anything in the
> + * hardware.  Rather, the @oh->mux->pads_dynamic array is changed, and
> + * these settings are later written to the SCM PADCTRL registers when
> + * the hwmod is enabled or idled.  No return value.
> + *
> + * XXX Shouldn't the dynamic pad changes affect hwmod shutdown as
> + * well?
> + * XXX Shouldn't this function update the hardware SCM PADCONF registers if
> + * anything has changed?
> + */
> +static void _set_ioring_wakeup(struct omap_hwmod *oh, bool set_wake)
> +{
> +	struct omap_device_pad *pad;
> +	int j;
> +
> +	if (!oh->mux || !oh->mux->enabled)
> +		return;
> +
> +	for (j = 0; j < oh->mux->nr_pads_dynamic; j++) {
> +		pad = oh->mux->pads_dynamic[j];
> +
> +		if (!(pad->flags & OMAP_DEVICE_PAD_WAKEUP))
> +			continue;
> +
> +		if (set_wake)
> +			pad->idle |= OMAP_WAKEUP_EN;
> +		else
> +			pad->idle &= ~OMAP_WAKEUP_EN;
> +	}
> +}

It appears that this loop only affects dynamic mux entries.  Should it 
also affect static mux entries?


- Paul
