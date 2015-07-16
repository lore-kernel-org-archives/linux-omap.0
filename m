From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/1] add pwm capability to dm816x
Date: Thu, 16 Jul 2015 06:07:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1507160605010.32764@utopia.booyaka.com>
References: <CAFZh4h8ikia8oKsZ6B12QZ1HdTV8Teu-+U9x_Ydu_-uOyh7-HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFZh4h8ikia8oKsZ6B12QZ1HdTV8Teu-+U9x_Ydu_-uOyh7-HA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Hutchinson <b.hutchman@gmail.com>
Cc: mturquette@linaro.org, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hello Brian,

On Mon, 15 Jun 2015, Brian Hutchinson wrote:

> Clocks 4-7 are capable of PWM output on dm816x.
> 
> This adds the pwm capability to those timers.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Brian Hutchinson <b.hutchman@gmail.com <tony@atomide.com>>

This patch seems to be corrupted.  The above line doesn't look right; 
there are some spurious newlines in the patch header, and tabs seem to 
have been converted to whitespace.  Some of these issues may be due to 
mailer problems.  Could you please fix and try again?


- Paul

> 
> --- arch/arm/mach-omap2/omap_hwmod_81xx_data.c_orig     2015-06-15
> 13:20:43.174343431 -0400
> +++ arch/arm/mach-omap2/omap_hwmod_81xx_data.c  2015-06-15
> 13:34:51.770551392 -0400
> @@ -546,6 +546,14 @@ static struct omap_timer_capability_dev_
>         .timer_capability       = OMAP_TIMER_ALWON,
>  };
> 
> +/* pwm timers dev attribute.
> + * timers 4-7 may be used for PWM output - see datasheet timer terminal
> + * functions table
> + */
> +static struct omap_timer_capability_dev_attr capability_pwm_dev_attr = {
> +       .timer_capability       = OMAP_TIMER_ALWON | OMAP_TIMER_HAS_PWM,
> +};
> +
>  static struct omap_hwmod dm816x_timer1_hwmod = {
>         .name           = "timer1",
>         .clkdm_name     = "alwon_l3s_clkdm",
> @@ -619,7 +627,7 @@ static struct omap_hwmod dm816x_timer4_h
>                         .modulemode = MODULEMODE_SWCTRL,
>                 },
>         },
> -       .dev_attr       = &capability_alwon_dev_attr,
> +       .dev_attr       = &capability_pwm_dev_attr,
>         .class          = &dm816x_timer_hwmod_class,
>  };
> 
> @@ -640,7 +648,7 @@ static struct omap_hwmod dm816x_timer5_h
>                         .modulemode = MODULEMODE_SWCTRL,
>                 },
>         },
> -       .dev_attr       = &capability_alwon_dev_attr,
> +       .dev_attr       = &capability_pwm_dev_attr,
>         .class          = &dm816x_timer_hwmod_class,
>  };
> 
> @@ -661,7 +669,7 @@ static struct omap_hwmod dm816x_timer6_h
>                         .modulemode = MODULEMODE_SWCTRL,
>                 },
>         },
> -       .dev_attr       = &capability_alwon_dev_attr,
> +       .dev_attr       = &capability_pwm_dev_attr,
>         .class          = &dm816x_timer_hwmod_class,
>  };
> 
> @@ -682,7 +690,7 @@ static struct omap_hwmod dm816x_timer7_h
>                         .modulemode = MODULEMODE_SWCTRL,
>                 },
>         },
> -       .dev_attr       = &capability_alwon_dev_attr,
> +       .dev_attr       = &capability_pwm_dev_attr,
>         .class          = &dm816x_timer_hwmod_class,
>  };
> 


- Paul
