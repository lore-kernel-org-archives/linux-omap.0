From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH] Revert "ARM: AM33xx: fix module_wait_ready without
 clkctrl register"
Date: Tue, 12 Jul 2016 08:34:26 -0500
Message-ID: <5784F1E2.1060605@ti.com>
References: <20160711213938.28385-1-d-gerlach@ti.com> <5784653C.30502@ti.com>
 <57848DD9.5070400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <57848DD9.5070400@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, Paul Walmsley <paul@pwsan.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

On 07/12/2016 01:27 AM, Tero Kristo wrote:
> On 12/07/16 06:34, Lokesh Vutla wrote:
>>
>>
>> On Tuesday 12 July 2016 03:09 AM, Dave Gerlach wrote:
>>> This reverts commit 183e2077d007aa4b697efba095ecfea7244a6107.
>>>
>>> The original patch added a check to am33xx_cm_wait_module_ready for a
>>> clkctrl offset of 0 as an invalid case, however, clkctrl offset of 0 is
>>> perfectly valid for hwmods, in particular the rtc.
>>
>> Looks like a similar check is present for am33xx_cm_wait_module_idle.
>> Shouldn't that also be removed?
>
> Oh this is annoying, I didn't notice that RTC had mutant register when I
> did the patch to add the check in place, and didn't face this issue
> either during testing. However, this check must be in there to avoid any
> issues with the transition to the hwmod clock data, as all the clkctrl
> offsets will be removed from hwmod data.
>
> I think for RTC we probably need to add some sort of HWMOD flag, and add
> a check within the hwmod code itself against this. Just reverting this
> patch is wrong approach, as you need to fix it some other way then.

I agree, that was another option I considered, but I went with reverting 
it for now as there were no ill effects and we've made it this long with 
out it.

I can send a new version with a flag soon.

Regards,
Dave

>
> -Tero
>
>>
>> Thanks and regards,
>> Lokesh
>>
>>>
>>> Without reverting this patch sometimes external aborts are seen on
>>> am335x during boot. This is due to the am33xx_cm_wait_module_ready
>>> function immediately returning 0 rather than waiting for the RTC_CLKCTRL
>>> register to indicate it is actually ready before rtc register accesses
>>> happen.
>>>
>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>>> ---
>>>   arch/arm/mach-omap2/cm33xx.c | 3 ---
>>>   1 file changed, 3 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
>>> index c073fb57dd13..7b181f929525 100644
>>> --- a/arch/arm/mach-omap2/cm33xx.c
>>> +++ b/arch/arm/mach-omap2/cm33xx.c
>>> @@ -220,9 +220,6 @@ static int am33xx_cm_wait_module_ready(u8 part,
>>> s16 inst, u16 clkctrl_offs,
>>>   {
>>>       int i = 0;
>>>
>>> -    if (!clkctrl_offs)
>>> -        return 0;
>>> -
>>>       omap_test_timeout(_is_module_ready(inst, clkctrl_offs),
>>>                 MAX_MODULE_READY_TIME, i);
>>>
>>>
>
