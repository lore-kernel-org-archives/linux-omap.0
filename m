From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [RFC] omap: mailbox: fix detection for previously supported
 chips
Date: Thu, 23 Sep 2010 19:08:29 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A530450EDDD15@dlee03.ent.ti.com>
References: <1285201299-18306-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55049 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753041Ab0IXAIg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 20:08:36 -0400
In-Reply-To: <1285201299-18306-1-git-send-email-omar.ramirez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, "Anna, Suman" <s-anna@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony

Ramirez Luna, Omar wrote:
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
> diff --git a/arch/arm/mach-omap2/mailbox.c
> b/arch/arm/mach-omap2/mailbox.c index 42dbfa4..26d6fb0 100644 ---
> a/arch/arm/mach-omap2/mailbox.c +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -394,15 +394,19 @@ static int __devinit omap2_mbox_probe(struct
> platform_device *pdev) 
> 
>  	if (false)
>  		;
> -#if defined(CONFIG_ARCH_OMAP3430)
> -	else if (cpu_is_omap3430()) {
> +#if defined(CONFIG_ARCH_OMAP3)
> +	else if (omap3_has_iva()) {

Hmm, seems omap3_has_ ##feat are only available for built-in and not module configurations, this patch is not so good after all since it throws:

ERROR: "omap3_features" [arch/arm/mach-omap2/mailbox_mach.ko] undefined!

Regards,

Omar

