From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 02/10] clk: ti: Add few dm814x clock aliases
Date: Tue, 8 Dec 2015 21:26:08 +0200
Message-ID: <56672ED0.4050405@ti.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
 <1449013103-23238-3-git-send-email-tony@atomide.com>
 <20151208165732.GY23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151208165732.GY23396@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

On 12/08/2015 06:57 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [151201 15:43]:
>> The timer clock aliases are needed early on dm814x. Let's also
>> add the aliases for the interconnects and MMC.
>>
>> Cc: Michael Turquette <mturquette@baylibre.com>
>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>> Cc: Tero Kristo <t-kristo@ti.com>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> Anybody from the clock department care to ack this one?

Sorry been rather busy lately...

> I'd like to
> get this series into Linux next as it fixes some some issues.

Yeah looks good to me, don't have access to dm814x so can't test.

Acked-by: Tero Kristo <t-kristo@ti.com>

Are you planning to push this via omap tree if this is critical for you?

-Tero

>
> Regards,
>
> Tony
>
>
>>   drivers/clk/ti/clk-814x.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/clk/ti/clk-814x.c b/drivers/clk/ti/clk-814x.c
>> index e172920..9e85fcc 100644
>> --- a/drivers/clk/ti/clk-814x.c
>> +++ b/drivers/clk/ti/clk-814x.c
>> @@ -14,10 +14,14 @@ static struct ti_dt_clk dm814_clks[] = {
>>   	DT_CLK(NULL, "devosc_ck", "devosc_ck"),
>>   	DT_CLK(NULL, "mpu_ck", "mpu_ck"),
>>   	DT_CLK(NULL, "sysclk4_ck", "sysclk4_ck"),
>> +	DT_CLK(NULL, "sysclk5_ck", "sysclk5_ck"),
>>   	DT_CLK(NULL, "sysclk6_ck", "sysclk6_ck"),
>> +	DT_CLK(NULL, "sysclk8_ck", "sysclk8_ck"),
>>   	DT_CLK(NULL, "sysclk10_ck", "sysclk10_ck"),
>>   	DT_CLK(NULL, "sysclk18_ck", "sysclk18_ck"),
>>   	DT_CLK(NULL, "timer_sys_ck", "devosc_ck"),
>> +	DT_CLK(NULL, "timer1_fck", "timer1_fck"),
>> +	DT_CLK(NULL, "timer2_fck", "timer2_fck"),
>>   	DT_CLK(NULL, "cpsw_125mhz_gclk", "cpsw_125mhz_gclk"),
>>   	DT_CLK(NULL, "cpsw_cpts_rft_clk", "cpsw_cpts_rft_clk"),
>>   	{ .node_name = NULL },
>> --
>> 2.6.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
