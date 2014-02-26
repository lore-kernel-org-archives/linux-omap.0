From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 1/2] clk: ti: am335x: remove unecessary cpu0 clk node
Date: Wed, 26 Feb 2014 00:53:52 -0800
Message-ID: <20140226085352.22529.78661@quantum>
References: <20140225082411.22529.21466@quantum>
 <BFF39FC5-A6EA-47D2-9345-6952157D57DD@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <BFF39FC5-A6EA-47D2-9345-6952157D57DD@aol.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kodiak Furr <boxerapp@aol.com>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Quoting Kodiak Furr (2014-02-25 16:51:34)
> Kodiak Furr liked your message with Boxer.

Dear Mr. Furr,

I don't know what Boxer is, but thanks for the like.

Regards,
Mike

> 
> 
> On February 25, 2014 at 2:24:11 AM CST, Mike Turquette <mturquette@linaro.org>
> wrote:
> 
>     Quoting Nishanth Menon (2014-01-29 10:19:16)
>     > cpu0 clock node has no functionality, since cpufreq-cpu0 is already
>     > capable of picking up the clock from dts.
>     >
>     > Signed-off-by: Nishanth Menon
> 
>     Taken into clk-next!
> 
>     Regards,
>     Mike
> 
>     > ---
>     > drivers/clk/ti/clk-33xx.c | 1 -
>     > 1 file changed, 1 deletion(-)
>     >
>     > diff --git a/drivers/clk/ti/clk-33xx.c b/drivers/clk/ti/clk-33xx.c
>     > index 776ee45..028b337 100644
>     > --- a/drivers/clk/ti/clk-33xx.c
>     > +++ b/drivers/clk/ti/clk-33xx.c
>     > @@ -34,7 +34,6 @@ static struct ti_dt_clk am33xx_clks[] = {
>     > DT_CLK(NULL, "dpll_core_m5_ck", "dpll_core_m5_ck"),
>     > DT_CLK(NULL, "dpll_core_m6_ck", "dpll_core_m6_ck"),
>     > DT_CLK(NULL, "dpll_mpu_ck", "dpll_mpu_ck"),
>     > - DT_CLK("cpu0", NULL, "dpll_mpu_ck"),
>     > DT_CLK(NULL, "dpll_mpu_m2_ck", "dpll_mpu_m2_ck"),
>     > DT_CLK(NULL, "dpll_ddr_ck", "dpll_ddr_ck"),
>     > DT_CLK(NULL, "dpll_ddr_m2_ck", "dpll_ddr_m2_ck"),
>     > --
>     > 1.7.9.5
>     >
>     --
>     To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>     the body of a message to majordomo@vger.kernel.org
>     More majordomo info at http://vger.kernel.org/majordomo-info.html
>     Please read the FAQ at http://www.tux.org/lkml/
> 
