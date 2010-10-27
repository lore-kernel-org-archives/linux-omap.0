From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 4/5] omap: mailbox: fix detection for previously
 supported chips
Date: Wed, 27 Oct 2010 10:36:58 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030D3105B2@dbde02.ent.ti.com>
References: <1288129984-22957-1-git-send-email-omar.ramirez@ti.com>
 <1288129984-22957-5-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49508 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132Ab0J0FHM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Oct 2010 01:07:12 -0400
In-Reply-To: <1288129984-22957-5-git-send-email-omar.ramirez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Dmitry Kasatkin <dmitry.kasatkin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Anna, Suman" <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Ramirez Luna, Omar
> Sent: Wednesday, October 27, 2010 3:23 AM
> To: Tony Lindgren; Hiroshi DOYU
> Cc: Felipe Contreras; Dmitry Kasatkin; Kevin Hilman; Ramirez 
> Luna, Omar; Anna, Suman; Paul Walmsley; Cousson, Benoit; 
> Raja, Govindraj; C.A, Subramaniam; linux-omap@vger.kernel.org
> Subject: [PATCH 4/5] omap: mailbox: fix detection for 
> previously supported chips
> 
> Fix the mailbox detection for OMAP3630 and 2430, also minor
> cleanup on conditional ifdef's that could affect it.
> 
> Given that 2430 has an iva too include it, as the same steps
> for omap3 apply.
> 
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
>  arch/arm/mach-omap2/mailbox.c |   16 ++++++++++------
>  1 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mailbox.c 
> b/arch/arm/mach-omap2/mailbox.c
> index 61f2149..b8fd120 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -277,7 +277,7 @@ static struct omap_mbox_ops omap2_mbox_ops = {
>  
>  /* FIXME: the following structs should be filled 
> automatically by the user id */
>  
> -#if defined(CONFIG_ARCH_OMAP3430) || defined(CONFIG_ARCH_OMAP2420)
> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP2)
>  /* DSP */
>  static struct omap_mbox2_priv omap2_mbox_dsp_priv = {
>  	.tx_fifo = {
> @@ -302,7 +302,7 @@ struct omap_mbox mbox_dsp_info = {
>  };
>  #endif
>  
> -#if defined(CONFIG_ARCH_OMAP3430)
> +#if defined(CONFIG_ARCH_OMAP3)
>  struct omap_mbox *omap3_mboxes[] = { &mbox_dsp_info, NULL };
>  #endif
>  
> @@ -390,15 +390,19 @@ static int __devinit 
> omap2_mbox_probe(struct platform_device *pdev)
>  
>  	if (false)
>  		;
> -#if defined(CONFIG_ARCH_OMAP3430)
> -	else if (cpu_is_omap3430()) {
> +#if defined(CONFIG_ARCH_OMAP3)
> +	else if (cpu_is_omap34xx()) {

Use cpu_is_* check only. No need to have #if CONFIG_ARCH_* checks.

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

Ditto

>  		list = omap2_mboxes;
>  
>  		list[0]->irq = platform_get_irq_byname(pdev, "dsp");
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 