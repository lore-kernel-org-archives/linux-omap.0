From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] clk: ti: fix flag space conflict with clkctrl clocks
Date: Thu, 29 Mar 2018 21:25:07 +0300
Message-ID: <0da17b8f-62af-1634-9dea-85445d28d587@ti.com>
References: <1522172824-14094-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1522172824-14094-1-git-send-email-t-kristo@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: sboyd@kernel.org, mturquette@baylibre.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

On 27/03/18 20:47, Tero Kristo wrote:
> The introduction of support for CLK_SET_RATE_PARENT flag for clkctrl
> clocks used a generic clock flag, which causes a conflict with the
> rest of the clkctrl flags, namely the NO_IDLEST flag. This can cause
> boot failures on certain platforms where this flag is introduced, by
> omitting the wait for the clockctrl module to be fully enabled before
> proceeding with rest of the code.
> 
> Fix this by moving all the clkctrl specific flags to their own bit-range.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Fixes: 49159a9dc3da ("clk: ti: add support for CLK_SET_RATE_PARENT flag")
> Reported-by: Christophe Lyon <christophe.lyon@linaro.org>

Stephen, can you pick this up as a late fix?

-Tero

> ---
>   drivers/clk/ti/clock.h | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
> index 90b86aa..b582780 100644
> --- a/drivers/clk/ti/clock.h
> +++ b/drivers/clk/ti/clock.h
> @@ -76,6 +76,11 @@ enum {
>   #define CLKF_CORE			(1 << 9)
>   #define CLKF_J_TYPE			(1 << 10)
>   
> +/* CLKCTRL flags */
> +#define CLKF_SW_SUP			BIT(5)
> +#define CLKF_HW_SUP			BIT(6)
> +#define CLKF_NO_IDLEST			BIT(7)
> +
>   #define CLK(dev, con, ck)		\
>   	{				\
>   		.lk = {			\
> @@ -185,10 +190,6 @@ struct omap_clkctrl_data {
>   extern const struct omap_clkctrl_data dm814_clkctrl_data[];
>   extern const struct omap_clkctrl_data dm816_clkctrl_data[];
>   
> -#define CLKF_SW_SUP	BIT(0)
> -#define CLKF_HW_SUP	BIT(1)
> -#define CLKF_NO_IDLEST	BIT(2)
> -
>   typedef void (*ti_of_clk_init_cb_t)(void *, struct device_node *);
>   
>   struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
