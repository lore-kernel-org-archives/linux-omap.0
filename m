From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [RFC PATCH 09/10] arm/dts: OMAP4: Add gpio nodes
Date: Thu, 8 Sep 2011 11:16:20 -0700
Message-ID: <20110908181620.GH2967@ponder.secretlab.ca>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<1314191356-10963-10-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1314191356-10963-10-git-send-email-b-cousson-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: khilman-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, manjugk-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Charulatha V <charu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 24, 2011 at 03:09:15PM +0200, Benoit Cousson wrote:
> Add the 6 GPIOs controller nodes.
> Since the GPIO driver is still under cleanup, a couple of temp
> hacks are needed. They will be removed as soon as the driver will
> be cleaned.
> 
> Remove gpio static device initialisation if CONFIG_OF is defined.
> 
> Signed-off-by: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Cc: Charulatha V <charu-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/omap4.dtsi |   69 ++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/gpio.c   |    2 +
>  2 files changed, 71 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 231d7b4..f672927 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -110,5 +110,74 @@
>  			compatible = "ti,omap-spinlock";
>  			hwmods = "spinlock";
>  		};
> +
> +		gpio1: gpio@1 {
> +			compatible = "ti,omap4-gpio", "ti,omap-gpio";
> +			hwmods = "gpio1";
> +			/* id should not be needed with a global GPIO parent */
> +			id = <1>;
> +			bank_width = <32>;
> +			debounce;
> +			/* XXX: big hack until the bank_count is removed */
> +			bank_count = <6>;
> +			no_idle_on_suspend;
> +			#gpio-cells = <2>;
> +			gpio-controller;
> +		};
> +
> +		gpio2: gpio@2 {
> +			compatible = "ti,omap4-gpio", "ti,omap-gpio";
> +			hwmods = "gpio2";
> +			id = <2>;
> +			bank_width = <32>;
> +			debounce;
> +			no_idle_on_suspend;
> +			#gpio-cells = <2>;
> +			gpio-controller;
> +		};
> +
> +		gpio3: gpio@3 {
> +			compatible = "ti,omap4-gpio", "ti,omap-gpio";
> +			hwmods = "gpio3";
> +			id = <3>;
> +			bank_width = <32>;
> +			debounce;
> +			no_idle_on_suspend;
> +			#gpio-cells = <2>;
> +			gpio-controller;
> +		};
> +
> +		gpio4: gpio@4 {
> +			compatible = "ti,omap4-gpio", "ti,omap-gpio";
> +			hwmods = "gpio4";
> +			id = <4>;
> +			bank_width = <32>;
> +			debounce;
> +			no_idle_on_suspend;
> +			#gpio-cells = <2>;
> +			gpio-controller;
> +		};
> +
> +		gpio5: gpio@5 {
> +			compatible = "ti,omap4-gpio", "ti,omap-gpio";
> +			hwmods = "gpio5";
> +			id = <5>;
> +			bank_width = <32>;
> +			debounce;
> +			no_idle_on_suspend;
> +			#gpio-cells = <2>;
> +			gpio-controller;
> +		};
> +
> +		gpio6: gpio@6 {
> +			compatible = "ti,omap4-gpio", "ti,omap-gpio";
> +			hwmods = "gpio6";
> +			id = <6>;
> +			bank_width = <32>;
> +			debounce;
> +			no_idle_on_suspend;
> +			#gpio-cells = <2>;
> +			gpio-controller;
> +		};
>  	};
>  };
> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> index 8cbfbc2..c51e952 100644
> --- a/arch/arm/mach-omap2/gpio.c
> +++ b/arch/arm/mach-omap2/gpio.c
> @@ -16,6 +16,7 @@
>   * GNU General Public License for more details.
>   */
>  
> +#ifndef CONFIG_OF
>  #include <linux/gpio.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> @@ -126,3 +127,4 @@ static int __init omap2_gpio_init(void)
>  						NULL);
>  }
>  postcore_initcall(omap2_gpio_init);
> +#endif

Same as on earlier patch, don't #ifndef CONFIG_OF out non-DT code.

g.

> -- 
> 1.7.0.4
> 
