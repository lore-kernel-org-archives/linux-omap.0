From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] pinctrl: single: remove misuse of IRQF_NO_SUSPEND
 flag
Date: Fri, 4 Dec 2015 16:11:06 +0000
Message-ID: <5661BB1A.6020709@arm.com>
References: <1448644860-29323-1-git-send-email-sudeep.holla@arm.com>
 <1448644860-29323-2-git-send-email-sudeep.holla@arm.com>
 <CACRpkdYy1fPAm5r0GxXxzgZA7RsqJ6ZtPtNzd1bzrfkME_j09g@mail.gmail.com>
 <20151203181337.GV23396@atomide.com> <56608B72.1040101@ti.com>
 <20151203213715.GA23396@atomide.com> <56616E74.9000604@ti.com>
 <20151204153504.GF23396@atomide.com> <5661B861.7010203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5661B861.7010203@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 04/12/15 15:59, Grygorii Strashko wrote:
>
> Sorry, I can't test it right now :(
> Potential fix below:

I had posted similar patch a while ago which Tony rejected.
I might have made a mistake of not putting them together, though they
were part of the same series[1], patch 12 and 16

> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 2dbd378..4e56fd9 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -481,7 +481,7 @@ int __init omap3_pm_init(void)
>
>          /* IO interrupt is shared with mux code */
>          ret = request_irq(omap_prcm_event_to_irq("io"),
> -               _prcm_int_handle_io, IRQF_SHARED | IRQF_NO_SUSPEND, "pm_io",
> +               _prcm_int_handle_io, IRQF_SHARED, "pm_io",
>                  omap3_pm_init);
>          enable_irq(omap_prcm_event_to_irq("io"));
>
> @@ -489,6 +489,7 @@ int __init omap3_pm_init(void)
>                  pr_err("pm: Failed to request pm_io irq\n");
>                  goto err2;
>          }
> +       enable_irq_wake(omap_prcm_event_to_irq("io"));
>
>          ret = pwrdm_for_each(pwrdms_setup, NULL);
>          if (ret) {
>
>
>

[1] http://lkml.iu.edu/hypermail/linux/kernel/1509.2/03937.html
-- 
Regards,
Sudeep
