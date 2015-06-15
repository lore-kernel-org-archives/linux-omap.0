From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 1/1] add pwm capability to dm816x
Date: Mon, 15 Jun 2015 22:32:59 +0300
Message-ID: <557F286B.6010003@ti.com>
References: <CAFZh4h8ikia8oKsZ6B12QZ1HdTV8Teu-+U9x_Ydu_-uOyh7-HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFZh4h8ikia8oKsZ6B12QZ1HdTV8Teu-+U9x_Ydu_-uOyh7-HA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Hutchinson <b.hutchman@gmail.com>, mturquette@linaro.org, sboyd@codeaurora.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, paul@pwsan.com, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On 06/15/2015 09:36 PM, Brian Hutchinson wrote:
> Clocks 4-7 are capable of PWM output on dm816x.
>
> This adds the pwm capability to those timers.

Use checkpatch pls, I see lots of whitespace errors.

Also, I don't think Mike / Stephen care about this patch, as it is 
against omap hwmod data only.

-Tero

>
> Cc: Paul Walmsley <paul@pwsan.com <mailto:paul@pwsan.com>>
> Cc: Tero Kristo <t-kristo@ti.com <mailto:t-kristo@ti.com>>
> Cc: Tony Lindgren <tony@atomide.com <mailto:tony@atomide.com>>
> Signed-off-by: Brian Hutchinson <b.hutchman@gmail.com
> <mailto:b.hutchman@gmail.com><mailto:tony@atomide.com>>
>
> --- arch/arm/mach-omap2/omap_hwmod_81xx_data.c_orig     2015-06-15
> 13:20:43.174343431 -0400
> +++ arch/arm/mach-omap2/omap_hwmod_81xx_data.c  2015-06-15
> 13:34:51.770551392 -0400
> @@ -546,6 +546,14 @@ static struct omap_timer_capability_dev_
>          .timer_capability       = OMAP_TIMER_ALWON,
>   };
>
> +/* pwm timers dev attribute.
> + * timers 4-7 may be used for PWM output - see datasheet timer terminal
> + * functions table
> + */
> +static struct omap_timer_capability_dev_attr capability_pwm_dev_attr = {
> +       .timer_capability       = OMAP_TIMER_ALWON | OMAP_TIMER_HAS_PWM,
> +};
> +
>   static struct omap_hwmod dm816x_timer1_hwmod = {
>          .name           = "timer1",
>          .clkdm_name     = "alwon_l3s_clkdm",
> @@ -619,7 +627,7 @@ static struct omap_hwmod dm816x_timer4_h
>                          .modulemode = MODULEMODE_SWCTRL,
>                  },
>          },
> -       .dev_attr       = &capability_alwon_dev_attr,
> +       .dev_attr       = &capability_pwm_dev_attr,
>          .class          = &dm816x_timer_hwmod_class,
>   };
>
> @@ -640,7 +648,7 @@ static struct omap_hwmod dm816x_timer5_h
>                          .modulemode = MODULEMODE_SWCTRL,
>                  },
>          },
> -       .dev_attr       = &capability_alwon_dev_attr,
> +       .dev_attr       = &capability_pwm_dev_attr,
>          .class          = &dm816x_timer_hwmod_class,
>   };
>
> @@ -661,7 +669,7 @@ static struct omap_hwmod dm816x_timer6_h
>                          .modulemode = MODULEMODE_SWCTRL,
>                  },
>          },
> -       .dev_attr       = &capability_alwon_dev_attr,
> +       .dev_attr       = &capability_pwm_dev_attr,
>          .class          = &dm816x_timer_hwmod_class,
>   };
>
> @@ -682,7 +690,7 @@ static struct omap_hwmod dm816x_timer7_h
>                          .modulemode = MODULEMODE_SWCTRL,
>                  },
>          },
> -       .dev_attr       = &capability_alwon_dev_attr,
> +       .dev_attr       = &capability_pwm_dev_attr,
>          .class          = &dm816x_timer_hwmod_class,
>   };
