From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 10/13] ARM: OMAP2+: hwmod: AM43x operations
Date: Wed, 21 Aug 2013 17:00:29 +0530
Message-ID: <5214A4D5.4000700@ti.com>
References: <cover.1375443858.git.afzal@ti.com>
 <838ab5ad788f64cef1e8859409490aa2b495d1ee.1375443858.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <838ab5ad788f64cef1e8859409490aa2b495d1ee.1375443858.git.afzal@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Afzal Mohammed <afzal@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, benoit.cousson@gmail.com, Ambresh K <ambresh@ti.com>, Benoit Cousson <benoit.cousson@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Friday 02 August 2013 07:08 PM, Afzal Mohammed wrote:
> Reuse OMAP4 operations on AM43x.
> 
> Signed-off-by: Ambresh K <ambresh@ti.com>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 7f4db12..a1b7e20 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -4123,6 +4123,14 @@ void __init omap_hwmod_init(void)
>  		soc_ops.init_clkdm = _init_clkdm;
>  		soc_ops.update_context_lost = _omap4_update_context_lost;
>  		soc_ops.get_context_lost = _omap4_get_context_lost;
> +	} else if (soc_is_am43xx()) {
> +		soc_ops.enable_module = _omap4_enable_module;
> +		soc_ops.disable_module = _omap4_disable_module;
> +		soc_ops.wait_target_ready = _omap4_wait_target_ready;
> +		soc_ops.assert_hardreset = _omap4_assert_hardreset;
> +		soc_ops.deassert_hardreset = _omap4_deassert_hardreset;
> +		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
> +		soc_ops.init_clkdm = _init_clkdm;

Did you leave out soc_ops.update_context_lost and soc_ops.get_context_lost on
purpose?

>  	} else if (soc_is_am33xx()) {
>  		soc_ops.enable_module = _am33xx_enable_module;
>  		soc_ops.disable_module = _am33xx_disable_module;
> 
