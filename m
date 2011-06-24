From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 14/25] ARM: pm: plat-s3c24xx: cleanup s3c_cpu_save
Date: Fri, 24 Jun 2011 15:48:28 +0900
Message-ID: <006d01cc323a$beed0c80$3cc72580$%kim@samsung.com>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
 <E1QZpLW-0005mn-4R@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <E1QZpLW-0005mn-4R@rmk-PC.arm.linux.org.uk>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Russell King - ARM Linux wrote:
> 
> s3c_cpu_save does not need to save any registers with the new
> cpu_suspend calling convention.  Remove these redundant instructions.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Tested-by: Kukjin Kim <kgene.kim@samsung.com>

It works fine on Samsung stuff with this whole series.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
>  arch/arm/plat-s3c24xx/sleep.S |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c24xx/sleep.S b/arch/arm/plat-s3c24xx/sleep.S
> index f822e62..6ada459 100644
> --- a/arch/arm/plat-s3c24xx/sleep.S
> +++ b/arch/arm/plat-s3c24xx/sleep.S
> @@ -48,10 +48,8 @@
>  	*/
> 
>  ENTRY(s3c_cpu_save)
> -	stmfd	sp!, { r4 - r12, lr }
>  	adr	r3, BSYM(s3c24xx_finish_suspend)
> -	bl	cpu_suspend
> -	ldmfd	sp!, { r4 - r12, pc }
> +	b	cpu_suspend
> 
>  s3c24xx_finish_suspend:
>  	@@ jump to final code to send system to sleep
> --
> 1.7.4.4
