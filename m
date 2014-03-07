From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 1/8] CLK: ti: dra7: Initialize USB_DPLL
Date: Fri, 7 Mar 2014 15:43:14 +0200
Message-ID: <5319CCF2.8090902@ti.com>
References: <1394197751-28984-1-git-send-email-rogerq@ti.com>
 <1394197751-28984-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1394197751-28984-2-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>, balbi@ti.com, tony@atomide.com
Cc: devicetree@vger.kernel.org, george.cherian@ti.com, Mike Turquette <mturquette@linaro.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 03/07/2014 03:09 PM, Roger Quadros wrote:
> USB_DPLL must be initialized and locked at boot so that
> USB modules can work.
>
> Also program USB_DLL_M2 output to half rate.
>
> CC: Mike Turquette <mturquette@linaro.org>
> CC: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   drivers/clk/ti/clk-7xx.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
> index 9977653..f89f3c2 100644
> --- a/drivers/clk/ti/clk-7xx.c
> +++ b/drivers/clk/ti/clk-7xx.c
> @@ -18,6 +18,7 @@
>
>   #define DRA7_DPLL_ABE_DEFFREQ				361267200
>   #define DRA7_DPLL_GMAC_DEFFREQ				1000000000
> +#define DRA7_DPLL_USB_DEFFREQ				960000000
>
>
>   static struct ti_dt_clk dra7xx_clks[] = {
> @@ -328,5 +329,15 @@ int __init dra7xx_dt_clk_init(void)
>   	if (rc)
>   		pr_err("%s: failed to configure GMAC DPLL!\n", __func__);
>
> +	dpll_ck = clk_get_sys(NULL, "dpll_usb_ck");
> +	rc = clk_set_rate(dpll_ck, DRA7_DPLL_USB_DEFFREQ);
> +	if (rc)
> +		pr_err("%s: failed to configure USB DPLL!\n", __func__);
> +
> +	dpll_ck = clk_get_sys(NULL, "dpll_usb_m2_ck");
> +	rc = clk_set_rate(dpll_ck, DRA7_DPLL_USB_DEFFREQ/2);
> +	if (rc)
> +		pr_err("%s: failed to set USB_DPLL M2 OUT\n", __func__);
> +

I would rather see this done using the default-rate mechanism provided here:

https://www.mail-archive.com/linux-omap@vger.kernel.org/msg101300.html

However, this remains to be commented by Mike whether the patch is okay 
or not.

-Tero

>   	return rc;
>   }
>
