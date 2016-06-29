From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [RESEND PATCHv2 03/28] ARM: OMAP2+: omap_device: create clock
 alias purely from DT data
Date: Wed, 29 Jun 2016 10:10:18 +0300
Message-ID: <5773745A.6020307@ti.com>
References: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
 <1465844702-12200-4-git-send-email-t-kristo@ti.com>
 <20160628070011.GD28140@atomide.com> <577373F0.5080700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <577373F0.5080700@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 29/06/16 10:08, Tero Kristo wrote:
> On 28/06/16 10:00, Tony Lindgren wrote:
>> * Tero Kristo <t-kristo@ti.com> [160613 12:07]:
>>> This avoids the need to add most of the clock aliases under
>>> drivers/clk/ti/clk-xyz.c files.
>>
>> This is a nice improvment, probably best to queu this along
>> with the rest of the series via the clock tree:
>>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>>
>> Or please let me know if you want me to pick this separately.
>>
>> Regards,
>>
>> Tony
>>
>
> Patches #3, #6, #7, #8 you can pick up separately (but you will have
> some conflicts due to missing ti_clk_get implementation.) These patches
> are required for this series to work properly though.

And patch #9 you can pick up also obviously...

>
> If we want to re-work the clk_get / ti_clk_get implementation, we should
> probably postpone it to 4.8, and that would push this series forward
> also. In that case, you can pick up the above patches for merge
> yourself, and we would handle the rest separately.
>
> -Tero

