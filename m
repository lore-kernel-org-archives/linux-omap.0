From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v2] ARM: dts: dra7: Correct clock tree for sys_32k_ck
Date: Thu, 31 Mar 2016 14:52:41 +0530
Message-ID: <56FCEC61.5020400@ti.com>
References: <1457957001-720-1-git-send-email-j-keerthy@ti.com>
 <20160330211828.GE9329@atomide.com> <20160330213224.GH9329@atomide.com>
 <56FCC3FF.7080901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56FCC3FF.7080901@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, mark.rutland@arm.com, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-omap@vger.kernel.org



On Thursday 31 March 2016 12:00 PM, Tero Kristo wrote:
> On 03/31/2016 12:32 AM, Tony Lindgren wrote:
>> * Tony Lindgren <tony@atomide.com> [160330 14:19]:
>>> * Keerthy <j-keerthy@ti.com> [160314 05:04]:
>>>> This is w.r.t J6/J6eco: 32clk is pseudo (erratum i856) - clock source.
>>>> Errata i856 for the AM572x (DRA7xx) points out that the 32.768KHz
>>>> external
>>>> crystal is not enabled at power up. Instead the CPU falls back to using
>>>> an emulation for the 32KHz clock which is SYSCLK1/610.  SYSCLK1 is
>>>> usually
>>>> 20MHz on boards so far (which gives an emulated frequency of 32.786KHz)
>>>
>>> Thanks applying into omap-for-v4.6/fixes.
>>
>> Actually let's wait a review from Tero on this one, not sure
>> about the pseudo clock naming here. So dropping for now.
>
> The patch is fine for me, I didn't comment anything before as I thought
> you already applied it.
>
> Acked-by: Tero Kristo <t-kristo@ti.com>

Thanks Tero.

>
>>
>> Regards,
>>
>> Tony
>>
>
