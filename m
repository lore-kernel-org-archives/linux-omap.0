From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] arm: dra7: Add hwmod entry for i2c6
Date: Wed, 25 May 2016 11:10:43 -0500
Message-ID: <5745CE83.9010006@ti.com>
References: <20160525125341.10044-1-rk@ti.com>
 <20160525125341.10044-2-rk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160525125341.10044-2-rk@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravikumar Kattekola <rk@ti.com>, paul@pwsan.com, tony@atomide.com, linux@armlinux.org.uk, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 05/25/2016 07:53 AM, Ravikumar Kattekola wrote:
> dra72x device has i2c6 controller.
> Adding hwmod definition for the same.
> 
> Reference DRA72x TRM [ SPRUHP2Q ]
> 
> Signed-off-by: Ravikumar Kattekola <rk@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> index d0e7e525..b84c0f7 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -1127,6 +1127,20 @@ static struct omap_hwmod dra7xx_i2c5_hwmod = {
>  	.dev_attr	= &i2c_dev_attr,
>  };
>  
> +/* i2c6 */
> +static struct omap_hwmod dra7xx_i2c6_hwmod = {
> +	.name		= "i2c6",
> +	.class		= &dra7xx_i2c_hwmod_class,
> +	.clkdm_name	= "l4per2_clkdm",
> +	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
> +	.main_clk	= "func_96m_fclk",
> +	.prcm = {
> +		.omap4 = {
> +		},
> +	},
> +	.dev_attr	= &i2c_dev_attr,
> +};
> +
>  /*
>   * 'mailbox' class
>   *
> @@ -3186,6 +3200,14 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per1__i2c5 = {
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
> +/* l4_per2 -> i2c6 */
> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__i2c6 = {
> +	.master		= &dra7xx_l4_per2_hwmod,
> +	.slave		= &dra7xx_i2c6_hwmod,
> +	.clk		= "l3_iclk_div",
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
>  /* l4_cfg -> mailbox1 */
>  static struct omap_hwmod_ocp_if dra7xx_l4_cfg__mailbox1 = {
>  	.master		= &dra7xx_l4_cfg_hwmod,
> @@ -3857,6 +3879,7 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
>  	&dra7xx_l4_per1__i2c3,
>  	&dra7xx_l4_per1__i2c4,
>  	&dra7xx_l4_per1__i2c5,
> +	&dra7xx_l4_per2__i2c6,
>  	&dra7xx_l4_cfg__mailbox1,
>  	&dra7xx_l4_per3__mailbox2,
>  	&dra7xx_l4_per3__mailbox3,
> 

responding to the specific patches themselves:
NAK. reasoning:
a) i2c6 is a custom IP integration with completely non-standard
dependencies with cross device dependencies for pretty much a specific
usecase -> usage is pretty much limited for generic support - the
decision is NOT to support this instance in Linux kernel - internal
discussion forwarded to developer.
b) the patches themselves are wrong -> it applies to DRA72x not
generic DRA7x platform
c) patches themselves are in the wrong format (wrong subject line etc).
d) patches don't handle the SoC internal device dependencies either ->
in short will not function in a generic solution for all variations of
platforms.

-- 
Regards,
Nishanth Menon
