From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/9] ARM: dts: omap5-uevm: fixup wrong regulator
 configuration
Date: Mon, 29 Jul 2013 09:13:09 -0500
Message-ID: <51F67875.9020602@ti.com>
References: <1374079538-19548-1-git-send-email-nm@ti.com>
 <51F63C74.6070503@ti.com> <51F66B65.4030702@ti.com>
 <51F670AF.9080808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51F670AF.9080808@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <benoit.cousson@gmail.com>
Cc: devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, J Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <benoit.cousson@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/29/2013 08:39 AM, Benoit Cousson wrote:
> Hi Nishanth,
>
> On 29/07/2013 15:17, Nishanth Menon wrote:
>> On 07/29/2013 04:57 AM, Keerthy wrote:
>>> Hi Nishanth,
>>>
>>> On Wednesday 17 July 2013 10:15 PM, Nishanth Menon wrote:
>>>> Due to wrong older revision of documentation used as reference, we
>>>> seem to have a bunch of LDOs wrongly configured on OMAP5 uEVM. This
>>>> series is based power tree on production board 750-2628-XXX platform.
>>>> Unfortunately, the wrong voltages may be detrimental to OMAP5 as they
>>>> supply hardware blocks at voltages that are out of specification.
>>>
>>> This series looks good to me.
>>>
>>> Acked-by:  J Keerthy <j-keerthy@ti.com>
>>
>> Tony, Benoit - this series could prevent OMAP5 from being damaged on
>> uEVMs with current 3.11 rc - could you suggest what we need to do to
>> get it in?
>
> I'm still on vacation with no way to pull any patch... but I can still
> comment on the series quickly.

Thanks for responding while on vacation.

>
> It seems to me that this series contains some real fixes that might
> damage the board due to hihest voltage than expected and some which are
> just improvement like for the SMPS9 or LDO[28]. In theory they should no
> go necesseraly to -rc, but, I guess that's fine for that one.
>
> All the "fixes" are sharing more than 50% of the changelog content with
> only 2 changes in the code, so you'd better squash them into one patch
> to avoid repeating the same thing again and again.
>
Reason for keeping them separate was to allow any future git bisect to 
narrow down to precise patch.
<--->
  ARM: dts: omap5-uevm: update SMPS9 settings
   ARM: dts: omap5-uevm: update and disable unused regulators LDO[28]
   ARM: dts: omap5-uevm: update LDO1 voltage to 1.5V and settings
   ARM: dts: omap5-uevm: update LDO3 voltage to 1.5V and settings
   ARM: dts: omap5-uevm: update LDO4 voltage to 1.5V and settings
   ARM: dts: omap5-uevm: update LDO6 voltage to 1.2V
   ARM: dts: omap5-uevm: update LDO7 voltage to 2V and settings
   ARM: dts: omap5-uevm: update SDCARD LDO9 and resource REGEN3
<---->

Would you have suggestions on what to squash up?


-- 
Regards,
Nishanth Menon
