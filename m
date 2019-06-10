From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH -next] ARM: OMAP2+: Make some variables static
Date: Mon, 10 Jun 2019 05:18:43 -0700
Message-ID: <20190610121843.GY5447@atomide.com>
References: <20190413141744.34488-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190413141744.34488-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yue Haibing <yuehaibing@huawei.com>
Cc: paul@pwsan.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Yue Haibing <yuehaibing@huawei.com> [190413 07:18]:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warnings:
> 
> arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c:532:25: warning: symbol 'am33xx_gpio_hwmod_class' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c:542:19: warning: symbol 'am33xx_gpio1_hwmod' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c:562:19: warning: symbol 'am33xx_gpio2_hwmod' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c:582:19: warning: symbol 'am33xx_gpio3_hwmod' was not declared. Should it be static?

I just noticed this is still pending, sorry for the delay. Applying into
omap-for-v5.3/soc.

Regards,

Tony
