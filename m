From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH 0/8] ARM: dts: Add operating-points-v2 tables for TI
 platforms
Date: Mon, 20 Jun 2016 11:57:14 -0500
Message-ID: <5768206A.5050501@ti.com>
References: <cover.1463606963.git.d-gerlach@ti.com>
 <20160519044744.GE32001@vireshk-i7> <20160610110414.GX22406@atomide.com>
 <575AD3A0.1050203@ti.com> <20160611024400.GE27439@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160611024400.GE27439@vireshk-i7>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Yegor Yefremov <yegorslists@googlemail.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 06/10/2016 09:44 PM, Viresh Kumar wrote:
> On 10-06-16, 09:50, Nishanth Menon wrote:
>> On 06/10/2016 06:04 AM, Tony Lindgren wrote:
>>> * Viresh Kumar <viresh.kumar@linaro.org> [160518 21:49]:
>>>> On 18-05-16, 18:36, Dave Gerlach wrote:
>>>>> Hi,
>>>>> This series adds operating-points-v2 tables for am335x, am437x, dra7xx,
>>>>> and am57xx based platforms along with some support patches so that we
>>>>> can enable more OPPs for the CPU on these platforms.
>>>>>
>>>>> These patches rely on the ti-cpufreq series sent here [1] and provide
>>>>> opp-supported-hw data for each OPP so that only the appropriate OPPs
>>>>> for a specific piece of silicon get enabled.
>>>>
>>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>
>>> Applying all the dts changes into omap-for-v4.8/dt thanks.
>>>
>>> Tony
>>>
>> Viresh, are we ready with the cpufreq series?
>>
>> https://patchwork.kernel.org/patch/9122961/
>> https://patchwork.kernel.org/patch/9122921/
>>
>> Also current series: https://patchwork.kernel.org/patch/9123071/
>> Seems to have comments pending.
>>
>> Dave is on vacation for another week or so, doubt he can respond in
>> time -> Should we wait on this series till we get the cpufreq support in?
>
> Rafael handles all the merges, etc. It would be better if you can
> reply to that thread instead.
>

Sorry for the delay responding here, the only issue with this series 
would be that we haven't received an ACK on the DT binding doc from 
cpufreq series [1] from a DT maintainer, so if comments are received 
there these patches could potentially change. I had pinged but still no 
response either way.

Regards,
Dave

[1] https://patchwork.kernel.org/patch/9122921/
