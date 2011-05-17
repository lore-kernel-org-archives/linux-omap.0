From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [RFC PATCH v3] Consolidate SRAM support
Date: Tue, 17 May 2011 18:36:33 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CF13ED4@dbde02.ent.ti.com>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
 <20110512174546.GB8633@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43764 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754725Ab1EQNGt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 May 2011 09:06:49 -0400
In-Reply-To: <20110512174546.GB8633@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Russell,

On Thu, May 12, 2011 at 23:15:46, Russell King - ARM Linux wrote:

> diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
> index 1bd73a0..c2f9767 100644
> --- a/arch/arm/mach-davinci/pm.c
> +++ b/arch/arm/mach-davinci/pm.c

[...]

> @@ -123,14 +118,14 @@ static int __init davinci_pm_probe(struct platform_device *pdev)
>  		return -ENOENT;
>  	}
>  
> -	davinci_sram_suspend = sram_alloc(davinci_cpu_suspend_sz, NULL);
> -	if (!davinci_sram_suspend) {
> +	davinci_sram_suspend_mem = pv_pool_alloc(davinci_pv_pool,
> +				davinci_cpu_suspend_sz, NULL);
> +	if (!davinci_sram_suspend_mem) {
>  		dev_err(&pdev->dev, "cannot allocate SRAM memory\n");
>  		return -ENOMEM;
>  	}
> -
> -	davinci_sram_push(davinci_sram_suspend, davinci_cpu_suspend,
> -						davinci_cpu_suspend_sz);
> +	davinci_sram_suspend = fncpy(davinci_sram_suspend_mem,
> +				davinci_cpu_suspend, davinci_cpu_suspend_sz);

This gave these build errors:

arch/arm/mach-davinci/pm.c: In function 'davinci_pm_probe':
arch/arm/mach-davinci/pm.c:127: error: lvalue required in asm statement
arch/arm/mach-davinci/pm.c:127: error: invalid lvalue in asm output 0
make[1]: *** [arch/arm/mach-davinci/pm.o] Error 1

Replacing davinci_cpu_suspend with &davinci_cpu_suspend fixed the issue.

With that change done, tested suspend-to-RAM on DA850 platform.
Also tested audio driver on DM365 platform with IRAM buffers enabled.

Can you also fold the following patch in? Without this the
kernel panics when suspend-to-RAM is enabled. 

diff --git a/arch/arm/mach-davinci/sleep.S b/arch/arm/mach-davinci/sleep.S
index fb5e72b..2cef533 100644
--- a/arch/arm/mach-davinci/sleep.S
+++ b/arch/arm/mach-davinci/sleep.S
@@ -37,6 +37,7 @@
 #define DEEPSLEEP_SLEEPENABLE_BIT      BIT(31)

        .text
+       .align 3
 /*
  * Move DaVinci into deep sleep state
  *

Thanks,
Sekhar

