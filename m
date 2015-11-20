From: santosh shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH v2] clocksource: arm_global_timer: fix suspend resume
Date: Fri, 20 Nov 2015 10:52:00 -0800
Message-ID: <564F6BD0.3050804@oracle.com>
References: <1448027861-21472-1-git-send-email-grygorii.strashko@ti.com>
 <564F570C.7030409@oracle.com> <564F67ED.9000905@ti.com>
 <564F6A92.7080006@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <564F6A92.7080006@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Zyngier <marc.zyngier@arm.com>, Grygorii Strashko <grygorii.strashko@ti.com>, linux@arm.linux.org.uk, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>
Cc: kernel@stlinux.com, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, John Stultz <john.stultz@linaro.org>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 11/20/2015 10:46 AM, Marc Zyngier wrote:
> On 20/11/15 18:35, Grygorii Strashko wrote:
>> Hi Santosh,
>>
>> On 11/20/2015 07:23 PM, santosh shilimkar wrote:
>>> + Thomas, Marc
>>>
>>> On 11/20/2015 5:57 AM, Grygorii Strashko wrote:
>>>> Now the System stall is observed on TI AM437x based board
>>>> (am437x-gp-evm) during resuming from System suspend when ARM Global
>>>> timer is selected as clocksource device - SysRq are working, but
>>>> nothing else. The reason of stall is that ARM Global timer loses its
>>>> contexts.
>>>>
>>>> The reason of stall is that ARM Global timer loses its contexts during
>>>> System suspend:
>>>>      GT_CONTROL.TIMER_ENABLE = 0 (unbanked)
>>>>      GT_COUNTERx = 0
>>>>
>>>> Hence, update ARM Global timer driver to reflect above behaviour
>>>> - re-enable ARM Global timer on resume GT_CONTROL.TIMER_ENABLE = 1
>>>> - ensure clocksource and clockevent devices have coresponding flags
>>>>     (CLOCK_SOURCE_SUSPEND_NONSTOP and CLOCK_EVT_FEAT_C3STOP) set
>>>>     depending on presence of "always-on" DT property.
>>>>
>>> Something which loses context in low power states can't be
>>> called "always-on"
>>
>> Sry, it's kinda new area for me and I could make mistakes.
>>
>> While working on this patch I've:
>>   - re-used implementation from ARM arch timer
>> commit 82a5619410d4c4df65c04272db198eca5a867c18
>> Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Date:   Tue Apr 8 10:04:32 2014 +0100
>>
>>      clocksource: arch_arm_timer: Fix age-old arch timer C3STOP detection issue
>
> [...]
>
> This patch has a very specific purpose: instructing the core code that
> this timer will never stop ticking, ever. It is really targeted at
> virtual machines, whose timer is backed by the host timer, even when the
> VM is not running.
>
> Using it on actual hardware is may not be the best idea, specially in
> the presence of PM.
>
Exactly. Thanks for clarifying the commit Marc.

Regards,
Santosh
