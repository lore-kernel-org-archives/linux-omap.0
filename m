From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] pinctrl: single: Drop custom names
Date: Wed, 26 Oct 2016 07:17:48 -0700
Message-ID: <20161026141748.vka5vv725nz6ytgf@atomide.com>
References: <20161025160900.2724-1-tony@atomide.com>
 <20161025160900.2724-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161025160900.2724-2-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [161025 09:10]:
> We no longer need to allocate custom names as those are dynamically
> generated in pinctrl_register_one_pin() if no name is passed to
> pinctrl_register_pins().
...

> @@ -354,13 +337,16 @@ static void pcs_pin_dbg_show(struct pinctrl_dev *pctldev,
>  {
>  	struct pcs_device *pcs;
>  	unsigned val, mux_bytes;
> +	unsigned long offset;
>  
>  	pcs = pinctrl_dev_get_drvdata(pctldev);
>  
>  	mux_bytes = pcs->width / BITS_PER_BYTE;
> -	val = pcs->read(pcs->base + pin * mux_bytes);
> +	offset = pin * mux_bytes;
> +	val = pcs->read(pcs->base + offset);
>  
> -	seq_printf(s, "%08x %s " , val, DRIVER_NAME);
> +	seq_printf(s, "%lx %08x %s ", pcs->res->start + offset, val,
> +		   DRIVER_NAME);
>  }

This should use %zx instead of %lx to avoid build warnings on 64-bit
systems as reported by kbuild test robot.

Regards,

Tony
