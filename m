From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: [PATCH] Patch for Touch Screen noise on OMAP3EVM.
Date: Fri, 29 Aug 2008 10:50:48 +0300
Message-ID: <31e679430808290050g797e4b90g1b5fcb316dd97cd7@mail.gmail.com>
References: <764af1890808290007t4ec0afabs4980f23237629f2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.179]:45911 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbYH2Huu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 03:50:50 -0400
Received: by ik-out-1112.google.com with SMTP id c28so412879ika.5
        for <linux-omap@vger.kernel.org>; Fri, 29 Aug 2008 00:50:48 -0700 (PDT)
In-Reply-To: <764af1890808290007t4ec0afabs4980f23237629f2c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Naveen Atmakuri <naveen.maillist@gmail.com>
Cc: linux-omap-open-source@linux.omap.com, linux-omap@vger.kernel.org

The new list is linux-omap@vger.kernel.org

Thanks

On Fri, Aug 29, 2008 at 10:07 AM, Naveen Atmakuri
<naveen.maillist@gmail.com> wrote:
> When git kernel tree is used on a OMAP3EVM board file for touch screen
> testing, it shows lot of jitter. With this patch the jitter can be reduced.
>
> Signed-off-by: Naveen Atmakuri <anaveen@mistralsolutions.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c
> b/arch/arm/mach-omap2/board-omap3evm.c
> index 4963f0f..9a4784e 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -27,6 +27,8 @@
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>
>
>  #include <mach/gpio.h>
>  #include <mach/keypad.h>
> @@ -132,8 +134,16 @@ static int ads7846_get_pendown_state(void)
>  }
>
>  struct ads7846_platform_data ads7846_config = {
> +    .x_max                  = 0x0fff,
> +    .y_max                  = 0x0fff,
> +    .x_plate_ohms           = 180,
> +    .pressure_max           = 255,
> +    .debounce_max           = 10,
> +    .debounce_tol           = 3,
> +    .debounce_rep           = 1,
>     .get_pendown_state    = ads7846_get_pendown_state,
>     .keep_vref_on        = 1,
> +    .settle_delay_usecs     = 150,
>  };
>
>  static struct omap2_mcspi_device_config ads7846_mcspi_config = {
> --
> 1.5.6
>
> Warm Regards,
> Naveen Atmakuri.
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>



-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
