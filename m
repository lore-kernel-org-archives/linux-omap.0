From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: clock: fix mult and div mask for USB_DPLL
Date: Tue, 24 Jan 2012 10:53:14 +0100
Message-ID: <4F1E7F8A.4010805@ti.com>
References: <1326929954-3912-1-git-send-email-ameya.palande@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37286 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677Ab2AXJxS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jan 2012 04:53:18 -0500
In-Reply-To: <1326929954-3912-1-git-send-email-ameya.palande@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@ti.com>, "Hilman, Kevin" <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, "Turquette, Mike" <mturquette@ti.com>

+ Mike

On 1/19/2012 12:39 AM, Ameya Palande wrote:
> Signed-off-by: Ameya Palande<ameya.palande@ti.com>

Assuming that you will re-send with Kevin's comment taken into account, 
the fix is indeed very valid.

Acked-by: Benoit Cousson <b-cousson@ti.com>

> ---
>   arch/arm/mach-omap2/clock44xx_data.c |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index 08e86d7..053cc15 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -953,8 +953,8 @@ static struct dpll_data dpll_usb_dd = {
>   	.modes		= (1<<  DPLL_LOW_POWER_BYPASS) | (1<<  DPLL_LOCKED),
>   	.autoidle_reg	= OMAP4430_CM_AUTOIDLE_DPLL_USB,
>   	.idlest_reg	= OMAP4430_CM_IDLEST_DPLL_USB,
> -	.mult_mask	= OMAP4430_DPLL_MULT_MASK,
> -	.div1_mask	= OMAP4430_DPLL_DIV_MASK,
> +	.mult_mask	= OMAP4430_DPLL_MULT_USB_MASK,
> +	.div1_mask	= OMAP4430_DPLL_DIV_0_7_MASK,

We were wrongly assuming that all DPLLs were using the same mask, which 
cannot be the case for the USB DPLL since that one has a higher max 
multiplier and max divider than the other ones (4095/256 instead of 
2047/128).

For Mike and Paul,

It is indeed a bug in the clock generator script.

Regards,
Benoit
