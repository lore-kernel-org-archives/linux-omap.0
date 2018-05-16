From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] arm: mach-omap2: pdata-quirks: Add a quirk function
 to convey off mode state
Date: Wed, 16 May 2018 07:36:27 -0700
Message-ID: <20180516143627.GE98604@atomide.com>
References: <1526449230-27618-1-git-send-email-j-keerthy@ti.com>
 <1526449230-27618-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1526449230-27618-2-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>
Cc: t-kristo@ti.com, linux-gpio@vger.kernel.org, linus.walleij@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180516 05:42]:
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
> @@ -35,6 +35,7 @@
>  #include "omap-secure.h"
>  #include "soc.h"
>  #include "hsmmc.h"
> +#include "pm.h"
>  
>  static struct omap_hsmmc_platform_data __maybe_unused mmc_pdata[2];
>  
> @@ -489,12 +490,17 @@ static int ti_sysc_shutdown_module(struct device *dev,
>  	.shutdown_module = ti_sysc_shutdown_module,
>  };
>  
> +int context_may_be_lost(void)
> +{
> +	return enable_off_mode;
> +}
>  static struct pcs_pdata pcs_pdata;

Hmm seems that this could be generic so also gpio-omap can use
this to remove omap2_gpio_prepare_for_idle() and
omap2_gpio_resume_after_idle(). So how about just make it:

int context_may_be_lost(struct device *dev);

And then we can easily add more logic to it as needed for
gpio-omap in addition to enable_off_mode.

Regards,

Tony
