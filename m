From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v4 12/12] video: da8xx-fb: CCF clock divider handling
Date: Wed, 23 Jan 2013 12:22:04 -0800
Message-ID: <20130123202204.9205.66575@quantum>
References: <cover.1358937685.git.afzal@ti.com>
 <fa8dab522507e087d5a94bac13dda71544911707.1358937685.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <fa8dab522507e087d5a94bac13dda71544911707.1358937685.git.afzal@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>
List-Id: linux-omap@vger.kernel.org

Quoting Afzal Mohammed (2013-01-23 03:48:56)
<snip>
> +static inline void da8xx_fb_clkc_enable(void)
> +{
>         if (lcd_revision == LCD_VERSION_2)
>                 lcdc_write(LCD_V2_DMA_CLK_EN | LCD_V2_LIDD_CLK_EN |
>                                 LCD_V2_CORE_CLK_EN, LCD_CLK_ENABLE_REG);
>  }
>  
> -static inline void da8xx_fb_calc_config_clk_divider(struct da8xx_fb_par *par,
> +#ifdef CONFIG_COMMON_CLK
> +static inline int da8xx_fb_calc_config_clk_divider(struct da8xx_fb_par *par,
> +                                                   struct fb_videomode *mode)
> +{
> +       int ret;
> +
> +       ret = clk_set_rate(par->child_clk, PICOS2KHZ(mode->pixclock) * 1000);
> +       if (IS_ERR_VALUE(ret)) {
> +               dev_err(par->dev, "unable to setup pixel clock of %u ps",
> +                       mode->pixclock);
> +               return ret;
> +       }
> +       da8xx_fb_clkc_enable();

It looks like you are using the legacy method to enable/disable the
clock and using the CCF basic divider to set the rate.  This feels a bit
hacky to me.  If you want to model your clock in CCF then you should
probably model the whole clock, not just the rate-change aspects of it.

Have you looked at the composite clock patches from Prashant?  Those
might give you the divider+gate properties that you are looking for:
http://article.gmane.org/gmane.linux.kernel/1416697

Regards,
Mike
