From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v8 06/14] CLK: TI: OMAP3: Get rid of unused USB Host dummy
 clocks
Date: Tue, 25 Feb 2014 11:32:19 +0200
Message-ID: <530C6323.90205@ti.com>
References: <1392896409-5101-1-git-send-email-rogerq@ti.com> <1392896409-5101-7-git-send-email-rogerq@ti.com> <20140225084327.22529.86075@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140225084327.22529.86075@quantum>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Mike,

On 02/25/2014 10:43 AM, Mike Turquette wrote:
> Quoting Roger Quadros (2014-02-20 03:40:01)
>> The OMAP USB Host MFD driver no longer expects these non-existing
>> clocks from the OMAP3 platform, so get rid of them.
> 
> Looks good to me.

Is it OK if I squash this patch with [1] and take it through the MFD tree?
Keeping them separate could break functionality if both don't go in together.

[1] - http://article.gmane.org/gmane.linux.ports.arm.kernel/303266

cheers,
-roger

> 
>>
>> CC: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
>> CC: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>  arch/arm/mach-omap2/cclock3xxx_data.c | 4 ----
>>  drivers/clk/ti/clk-3xxx.c             | 4 ----
>>  2 files changed, 8 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/cclock3xxx_data.c
>> index 3b05aea..4299a55 100644
>> --- a/arch/arm/mach-omap2/cclock3xxx_data.c
>> +++ b/arch/arm/mach-omap2/cclock3xxx_data.c
>> @@ -3495,10 +3495,6 @@ static struct omap_clk omap3xxx_clks[] = {
>>         CLK(NULL,       "dss_tv_fck",   &dss_tv_fck),
>>         CLK(NULL,       "dss_96m_fck",  &dss_96m_fck),
>>         CLK(NULL,       "dss2_alwon_fck",       &dss2_alwon_fck),
>> -       CLK(NULL,       "utmi_p1_gfclk",        &dummy_ck),
>> -       CLK(NULL,       "utmi_p2_gfclk",        &dummy_ck),
>> -       CLK(NULL,       "xclk60mhsp1_ck",       &dummy_ck),
>> -       CLK(NULL,       "xclk60mhsp2_ck",       &dummy_ck),
>>         CLK(NULL,       "init_60m_fclk",        &dummy_ck),
>>         CLK(NULL,       "gpt1_fck",     &gpt1_fck),
>>         CLK(NULL,       "aes2_ick",     &aes2_ick),
>> diff --git a/drivers/clk/ti/clk-3xxx.c b/drivers/clk/ti/clk-3xxx.c
>> index d323023..0d1750a 100644
>> --- a/drivers/clk/ti/clk-3xxx.c
>> +++ b/drivers/clk/ti/clk-3xxx.c
>> @@ -130,10 +130,6 @@ static struct ti_dt_clk omap3xxx_clks[] = {
>>         DT_CLK(NULL, "dss_tv_fck", "dss_tv_fck"),
>>         DT_CLK(NULL, "dss_96m_fck", "dss_96m_fck"),
>>         DT_CLK(NULL, "dss2_alwon_fck", "dss2_alwon_fck"),
>> -       DT_CLK(NULL, "utmi_p1_gfclk", "dummy_ck"),
>> -       DT_CLK(NULL, "utmi_p2_gfclk", "dummy_ck"),
>> -       DT_CLK(NULL, "xclk60mhsp1_ck", "dummy_ck"),
>> -       DT_CLK(NULL, "xclk60mhsp2_ck", "dummy_ck"),
>>         DT_CLK(NULL, "init_60m_fclk", "dummy_ck"),
>>         DT_CLK(NULL, "gpt1_fck", "gpt1_fck"),
>>         DT_CLK(NULL, "aes2_ick", "aes2_ick"),
>> -- 
>> 1.8.3.2
>>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
