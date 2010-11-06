From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 6/7] omap: mailbox: fix detection for previously supported
 chips
Date: Sat, 06 Nov 2010 14:11:34 -0400
Message-ID: <4CD59A56.4070003@ti.com>
References: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com> <1289006244-27147-7-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47797 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab0KFSK3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 6 Nov 2010 14:10:29 -0400
In-Reply-To: <1289006244-27147-7-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Anna, Suman" <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 11/5/2010 9:17 PM, Ramirez Luna, Omar wrote:
> Fix the mailbox detection for OMAP3630 and 2430, also minor
> cleanup on conditional ifdef's that could affect it.
>
> Given that 2430 has an iva too include it, as the same steps
> for omap3 apply.
>
> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com>
> ---
>   arch/arm/mach-omap2/mailbox.c |   16 ++++++++++------
>   1 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index bf598a3..5e9ea0f 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -276,7 +276,7 @@ static struct omap_mbox_ops omap2_mbox_ops = {
>
>   /* FIXME: the following structs should be filled automatically by the user id */
>
> -#if defined(CONFIG_ARCH_OMAP3430) || defined(CONFIG_ARCH_OMAP2420)
> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP2)
>   /* DSP */
>   static struct omap_mbox2_priv omap2_mbox_dsp_priv = {
>   	.tx_fifo = {
> @@ -301,7 +301,7 @@ struct omap_mbox mbox_dsp_info = {
>   };
>   #endif
>
> -#if defined(CONFIG_ARCH_OMAP3430)
> +#if defined(CONFIG_ARCH_OMAP3)

Ideally you should get rid of all the CONFIG_ARCH_OMAPXXX or cpu_is_omap 
in that code. This is a driver, it should be generic.
If you have to handle differences between OMAP version, please do that 
in the devices, not in the driver.

This patch just contains a few of them, but the original mailbox.c file 
is full of that kind of test.
I know that you are not the original writer of this code, but since the 
clean it, it will be good to remove all the legacy code.

Thanks,
Benoit

>   struct omap_mbox *omap3_mboxes[] = {&mbox_dsp_info, NULL };
>   #endif
>
> @@ -389,15 +389,19 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>
>   	if (false)
>   		;
> -#if defined(CONFIG_ARCH_OMAP3430)
> -	else if (cpu_is_omap3430()) {
> +#if defined(CONFIG_ARCH_OMAP3)
> +	else if (cpu_is_omap34xx()) {
>   		list = omap3_mboxes;
>
>   		list[0]->irq = platform_get_irq_byname(pdev, "dsp");
>   	}
>   #endif
> -#if defined(CONFIG_ARCH_OMAP2420)
> -	else if (cpu_is_omap2420()) {
> +#if defined(CONFIG_ARCH_OMAP2)
> +	else if (cpu_is_omap2430()) {
> +		list = omap2_mboxes;
> +
> +		list[0]->irq = platform_get_irq_byname(pdev, "dsp");
> +	} else if (cpu_is_omap2420()) {
>   		list = omap2_mboxes;
>
>   		list[0]->irq = platform_get_irq_byname(pdev, "dsp");

