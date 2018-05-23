From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH v2] OMAP: CLK: CLKSRC: Add suspend resume hooks
Date: Thu, 24 May 2018 02:08:06 +0530
Message-ID: <ea82b336-7e99-bc41-4b51-54fe208c5e55@ti.com>
References: <1527013340-8036-1-git-send-email-j-keerthy@ti.com>
 <20180523184116.GS98604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180523184116.GS98604@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 5/24/2018 12:11 AM, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [180522 11:24]:
>> Add the save and restore for clksrc as part of suspend and resume
>> so that it saves the counter value and restores. This is needed in
>> modes like rtc+ddr in self-refresh not doing this stalls the time.
> Can't we now do this all in drivers/clocksource/timer-ti-*.c?

arch/arm/boot/dts/am4372.dtsi has compatible ti,omap-counter32k
which is arch/arm/mach-omap2/timer.c compatible

IMHO clocksource suspend resume best fits under mach-omap2/timer.c
just like clockevent has suspend/resume.

>
>> @@ -490,6 +513,15 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
>>   	res = omap_dm_timer_init_one(&clksrc, fck_source, property,
>>   				     &clocksource_gpt.name,
>>   				     OMAP_TIMER_NONPOSTED);
>> +
>> +	if (soc_is_am43xx()) {
>> +		clocksource_gpt.suspend = omap2_gptimer_clksrc_suspend;
>> +		clocksource_gpt.resume = omap2_gptimer_clksrc_resume;
>> +
>> +		clocksource_gpt_hwmod =
>> +			omap_hwmod_lookup(clocksource_gpt.name);
>> +	}
>> +
> Then you can do this based on a quirk flag set by compatible.
>
> Regards,
>
> Tony
