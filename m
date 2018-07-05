From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 4/6] bus: ti-sysc: Add support for software reset
Date: Thu, 5 Jul 2018 08:47:58 -0700
Message-ID: <20180705154758.GA112168@atomide.com>
References: <20180705142319.19583-1-faiz_abbas@ti.com>
 <20180705142319.19583-5-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180705142319.19583-5-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, paul@pwsan.com, t-kristo@ti.com, mark.rutland@arm.com
List-Id: linux-omap@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180705 14:24]:
> +static int sysc_reset(struct sysc *ddata)
> +{
> +	int offset = ddata->offsets[SYSC_SYSCONFIG];
> +	int val = sysc_read(ddata, offset);

Can you please just warn and return early for now if no
syss_mask is specified? Otherwise we'll have mysterious
errors if somebody leaves out "ti,hwmods" for module types
we do not yet support reset for.

> +	val |= (0x1 << ddata->cap->regbits->srst_shift);
> +	sysc_write(ddata, offset, val);
> +
> +	/* Poll on reset status */
> +	if (ddata->cfg.syss_mask) {
> +		offset = ddata->offsets[SYSC_SYSSTATUS];
> +
> +		return readl_poll_timeout(ddata->module_va + offset, val,
> +				(val & ddata->cfg.syss_mask) == 0x0,
> +				100, MAX_MODULE_SOFTRESET_WAIT);
> +	}
> +
> +	return 0;
> +}
> +

Otherwise looks good to me.

Thanks,

Tony
