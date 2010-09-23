From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [RFC] omap: mailbox: fix detection for previously supported
 chips
Date: Thu, 23 Sep 2010 07:56:05 -0500
Message-ID: <A24693684029E5489D1D202277BE894472802A7F@dlee02.ent.ti.com>
References: <1285201299-18306-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54385 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080Ab0IWM4M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 08:56:12 -0400
In-Reply-To: <1285201299-18306-1-git-send-email-omar.ramirez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, "Anna, Suman" <s-a>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>

Hi Omar,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Omar Ramirez Luna
> Sent: Wednesday, September 22, 2010 7:22 PM
> To: Tony Lindgren; Hiroshi DOYU; Felipe Contreras; Anna, Suman; linux-
> omap@vger.kernel.org
> Cc: Ramirez Luna, Omar
> Subject: [RFC] omap: mailbox: fix detection for previously supported chips
> 
> Fix the mailbox support detection for OMAP3630, 3530/25 and 2430.
> 
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
> - Testing was made under 3630 and 3430 boards.
> - Given that 2430 uses similar initialization than OMAP3, changes
>   to handle this case was added to the patch.
> - HWMOD adaptation hopefully should solve this mess, but as of now
>   mailbox should work as before at least.
> 
>  arch/arm/mach-omap2/mailbox.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index 42dbfa4..26d6fb0 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -394,15 +394,19 @@ static int __devinit omap2_mbox_probe(struct
> platform_device *pdev)
> 
>  	if (false)
>  		;
> -#if defined(CONFIG_ARCH_OMAP3430)
> -	else if (cpu_is_omap3430()) {
> +#if defined(CONFIG_ARCH_OMAP3)
> +	else if (omap3_has_iva()) {
>  		list = omap3_mboxes;
> 
>  		list[0]->irq = platform_get_irq_byname(pdev, "dsp");
>  	}
>  #endif
> -#if defined(CONFIG_ARCH_OMAP2420)
> -	else if (cpu_is_omap2420()) {
> +#if defined(CONFIG_ARCH_OMAP2)
> +	else if (cpu_is_omap2430()) {
> +		list = omap2_mboxes;
> +
> +		list[0]->irq = platform_get_irq_byname(pdev, "dsp");
> +	} else if (cpu_is_omap2420()) {

Isn't both 2430 and 2420 doing the exact same?

If yes, How about just doing:

	else if (cpu_is_omap2430() || cpu_is_omap2420()) {

>  		list = omap2_mboxes;
> 
>  		list[0]->irq = platform_get_irq_byname(pdev, "dsp");

Regards,
Sergio

> --
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
