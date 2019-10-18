From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH -next] ARM: OMAP2+: Make some functions static
Date: Fri, 18 Oct 2019 07:57:53 -0700
Message-ID: <20191018145753.GO5610@atomide.com>
References: <20191018120701.29364-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191018120701.29364-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: khilman@kernel.org, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* YueHaibing <yuehaibing@huawei.com> [191018 12:08]:
> Fix sparse warnings:
> 
> arch/arm/mach-omap2/pmic-cpcap.c:29:15: warning: symbol 'omap_cpcap_vsel_to_uv' was not declared. Should it be static?
> arch/arm/mach-omap2/pmic-cpcap.c:43:15: warning: symbol 'omap_cpcap_uv_to_vsel' was not declared. Should it be static?
> arch/arm/mach-omap2/pmic-cpcap.c:93:15: warning: symbol 'omap_max8952_vsel_to_uv' was not declared. Should it be static?
> arch/arm/mach-omap2/pmic-cpcap.c:107:15: warning: symbol 'omap_max8952_uv_to_vsel' was not declared. Should it be static?
> arch/arm/mach-omap2/pmic-cpcap.c:140:15: warning: symbol 'omap_fan535503_vsel_to_uv' was not declared. Should it be static?
> arch/arm/mach-omap2/pmic-cpcap.c:155:15: warning: symbol 'omap_fan535508_vsel_to_uv' was not declared. Should it be static?
> arch/arm/mach-omap2/pmic-cpcap.c:173:15: warning: symbol 'omap_fan535503_uv_to_vsel' was not declared. Should it be static?
> arch/arm/mach-omap2/pmic-cpcap.c:192:15: warning: symbol 'omap_fan535508_uv_to_vsel' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks applying into omap-for-v5.5/pm.

Regards,

Tony
