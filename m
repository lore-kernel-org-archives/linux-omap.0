From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/8] ARM: OMAP5: hwmod_data: Add data for IPU & DSP
 processors
Date: Wed, 11 Oct 2017 11:41:12 -0700
Message-ID: <20171011184112.GF4394@atomide.com>
References: <20170821234818.4755-1-s-anna@ti.com>
 <20170821234818.4755-7-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170821234818.4755-7-s-anna@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Suman Anna <s-anna@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna@ti.com> [170821 16:48]:
> OMAP5, like OMAP4, also has an IPU and a DSP processor subsystems.
> The relevant hwmod classes and data structures are added for these
> devices.
> 
> Do note that these hwmod data strucutures do not have a .modulemode
> field as the devices are managed together with their corresponding
> MMUs. Each of the processor subsystem and its MMU are present within
> the same clock domain and requires the domain be clocked and enabled
> until the last entity is disabled. The module is disabled properly
> during the omap_device_idle processing of the MMU hwmod while
> disabling the MMU.

I think we can make that issue go away, see below.

> --- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
> @@ -335,6 +335,36 @@ static struct omap_hwmod omap54xx_dmic_hwmod = {
> +/* dsp */
> +static struct omap_hwmod omap54xx_dsp_hwmod = {
> +	.name		= "dsp",
> +	.class		= &omap54xx_dsp_hwmod_class,
> +	.clkdm_name	= "dsp_clkdm",
> +	.rst_lines	= omap54xx_dsp_resets,
> +	.rst_lines_cnt	= ARRAY_SIZE(omap54xx_dsp_resets),
> +	.main_clk	= "dpll_iva_h11x2_ck",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_offs = OMAP54XX_CM_DSP_DSP_CLKCTRL_OFFSET,
> +			.rstctrl_offs = OMAP54XX_RM_DSP_RSTCTRL_OFFSET,
> +			.context_offs = OMAP54XX_RM_DSP_DSP_CONTEXT_OFFSET,
> +		},
> +	},
> +};
> +
> +/*

I don't think we should add a second instance for the DSP_CLKCTRL.

We already have mmu_dsp instance and I'm pretty sure this should be
just one parent "ti,sysc-omap4" interconnect target module instance.
Then the MMU and DSP can be children of that node. I think it's set
the same way for all omap4 and later SoCs. So let's wait on
this series until we have this verified.

Tehn for resets, in the long run we can add reset controller support
to the ti-sysc driver and then the MMU driver can do the reset with
device_reset(dev->parent). Also a separate resetctrl driver is needed
that the ti-sysc driver can request.

But yeah sorry no immediate solution available for the reset part.

Regards,

Tony
