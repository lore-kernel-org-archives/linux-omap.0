From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: [PATCH] arm: make FORCE_MAX_ZONEORDER configurable for TI AM33XX
Date: Tue, 25 Sep 2012 10:05:30 +0200
Message-ID: <506165CA.7070406@visionsystems.de>
References: <1341325242-17638-1-git-send-email-yegorslists@googlemail.com>
 <20120924171858.GG28835@atomide.com>
 <CAGm1_ks_GvSTH8DJ6d3R5OjPNEOhQ39hNo4grg1Pn-NqFX5VKQ@mail.gmail.com>
 <20120924231619.GA28941@n2100.arm.linux.org.uk>
 <20120925003758.GP28835@atomide.com>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120925003758.GP28835@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dejan Gacnik <dejan.gacnik@gmail.com>, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Yegor Yefremov <yegorslists@googlemail.com>
List-Id: linux-omap@vger.kernel.org

On 25.09.2012 02:37, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120924 16:17]:
>> On Mon, Sep 24, 2012 at 09:05:11PM +0200, Yegor Yefremov wrote:
>>> On Mon, Sep 24, 2012 at 7:18 PM, Tony Lindgren <tony@atomide.com> wrote:
>>>> * yegorslists@googlemail.com <yegorslists@googlemail.com> [120703 07:26]:
>>>>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>>>>
>>>>> FORCE_MAX_ZONEORDER of 12 is needed to allocation more than 4MB
>>>>> of consistent DMA memory (da8xx frame buffer driver).
>>>>
>>>> Sorry for the delay on this one, looks like this one is
>>>> still valid. I'll apply it.
>>>
>>> Thanks.
>>>
>>> Yegor
>>>
>>>>> Signed-off-by: Dejan Gacnik <dejan.gacnik@gmail.com>
>>>>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>>>>> ---
>>>>>  arch/arm/Kconfig |    5 +++--
>>>>>  1 files changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>>> index e876819..ff14c1e 100644
>>>>> --- a/arch/arm/Kconfig
>>>>> +++ b/arch/arm/Kconfig
>>>>> @@ -1725,8 +1725,9 @@ config HW_PERF_EVENTS
>>>>>  source "mm/Kconfig"
>>>>>
>>>>>  config FORCE_MAX_ZONEORDER
>>>>> -     int "Maximum zone order" if ARCH_SHMOBILE
>>>>> -     range 11 64 if ARCH_SHMOBILE
>>>>> +     int "Maximum zone order"
>>>>> +     depends on ARCH_SHMOBILE || SOC_AM33XX
>>>>> +     range 11 64 if ARCH_SHMOBILE || SOC_AM33XX
>>>>>       default "9" if SA1111
>>>>>       default "11"
>>
>> NAK.  This patch breaks SA1111 platforms.  To see why, read the patch.
> 
> OK let's drop this.

How should I change the patch to make it proper? SA1111 is broken anyway:

config FORCE_MAX_ZONEORDER
        int "Maximum zone order" if ARCH_SHMOBILE
        range 11 64 if ARCH_SHMOBILE
        default "9" if SA1111
        default "11"

AFAIK if ARCH_SHMOBILE defines dependency on ARCH_SHMOBILE, so SA1111 won't be evaluated (at least if I select SA1111 include/generated/autoconf.h shows "11"). If I add SA1111 to dependency list like this:

depends on ARCH_SHMOBILE || SOC_AM33XX || SA1111

the prompt in "Kernel features" becomes visible, but it doesn't have the default value of "9", but "11".

Am I missing something?

Yegor
