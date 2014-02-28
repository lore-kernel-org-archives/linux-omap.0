From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v3 1/2] CLK: TI: OMAP4/5/DRA7: Remove gpmc_fck from dummy
 clocks
Date: Fri, 28 Feb 2014 20:27:03 +0200
Message-ID: <5310D4F7.7090508@ti.com>
References: <1393411089-9550-1-git-send-email-florian.vaussard@epfl.ch>
 <1393411089-9550-2-git-send-email-florian.vaussard@epfl.ch>
 <20140226204003.4353.17772@quantum> <20140228172836.GB15399@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140228172836.GB15399@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>, =?ISO-8859-1?Q?Beno=EEt_?= =?ISO-8859-1?Q?Cousson?= <bcousson@baylibre.com>, Florian Vaussard <florian.vaussard@epfl.ch>
List-Id: linux-omap@vger.kernel.org

On 02/28/2014 07:28 PM, Tony Lindgren wrote:
> * Mike Turquette <mturquette@linaro.org> [140226 12:43]:
>> Quoting Florian Vaussard (2014-02-26 02:38:08)
>>> When arch/arm/mach-omap2/gpmc.c calls clk_get(..., "fck"), it will
>>> get a dummy clock and try to use it. As the rate is configured to zero,
>>> this will result in several divisions by zero, and misconfigured
>>> timings, with devices on the bus being lost in the La La Land.
>>>
>>> It is better to remove gpmc_fck from the dummy clocks, so that gpmc.c
>>> can fail gracefully.
>>>
>>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>>
>> Looks good to me.
>
> Can that be upgraded to an ack then?

Looks good to me also.

Acked-by: Tero Kristo <t-kristo@ti.com>

>
> Regards,
>
> Tony
>
>>> ---
>>>   drivers/clk/ti/clk-44xx.c | 1 -
>>>   drivers/clk/ti/clk-54xx.c | 1 -
>>>   drivers/clk/ti/clk-7xx.c  | 1 -
>>>   3 files changed, 3 deletions(-)
>>>
>>> diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
>>> index ae00218..02517a8 100644
>>> --- a/drivers/clk/ti/clk-44xx.c
>>> +++ b/drivers/clk/ti/clk-44xx.c
>>> @@ -222,7 +222,6 @@ static struct ti_dt_clk omap44xx_clks[] = {
>>>          DT_CLK(NULL, "auxclk5_src_ck", "auxclk5_src_ck"),
>>>          DT_CLK(NULL, "auxclk5_ck", "auxclk5_ck"),
>>>          DT_CLK(NULL, "auxclkreq5_ck", "auxclkreq5_ck"),
>>> -       DT_CLK("50000000.gpmc", "fck", "dummy_ck"),
>>>          DT_CLK("omap_i2c.1", "ick", "dummy_ck"),
>>>          DT_CLK("omap_i2c.2", "ick", "dummy_ck"),
>>>          DT_CLK("omap_i2c.3", "ick", "dummy_ck"),
>>> diff --git a/drivers/clk/ti/clk-54xx.c b/drivers/clk/ti/clk-54xx.c
>>> index 0ef9f58..08f3d1b 100644
>>> --- a/drivers/clk/ti/clk-54xx.c
>>> +++ b/drivers/clk/ti/clk-54xx.c
>>> @@ -182,7 +182,6 @@ static struct ti_dt_clk omap54xx_clks[] = {
>>>          DT_CLK(NULL, "auxclk3_src_ck", "auxclk3_src_ck"),
>>>          DT_CLK(NULL, "auxclk3_ck", "auxclk3_ck"),
>>>          DT_CLK(NULL, "auxclkreq3_ck", "auxclkreq3_ck"),
>>> -       DT_CLK(NULL, "gpmc_ck", "dummy_ck"),
>>>          DT_CLK("omap_i2c.1", "ick", "dummy_ck"),
>>>          DT_CLK("omap_i2c.2", "ick", "dummy_ck"),
>>>          DT_CLK("omap_i2c.3", "ick", "dummy_ck"),
>>> diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
>>> index 9977653..f7e4073 100644
>>> --- a/drivers/clk/ti/clk-7xx.c
>>> +++ b/drivers/clk/ti/clk-7xx.c
>>> @@ -262,7 +262,6 @@ static struct ti_dt_clk dra7xx_clks[] = {
>>>          DT_CLK(NULL, "vip1_gclk_mux", "vip1_gclk_mux"),
>>>          DT_CLK(NULL, "vip2_gclk_mux", "vip2_gclk_mux"),
>>>          DT_CLK(NULL, "vip3_gclk_mux", "vip3_gclk_mux"),
>>> -       DT_CLK(NULL, "gpmc_ck", "dummy_ck"),
>>>          DT_CLK("omap_i2c.1", "ick", "dummy_ck"),
>>>          DT_CLK("omap_i2c.2", "ick", "dummy_ck"),
>>>          DT_CLK("omap_i2c.3", "ick", "dummy_ck"),
>>> --
>>> 1.8.1.2
>>>
