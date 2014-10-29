From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 00/20] rtc: omap: fixes and power-off feature
Date: Wed, 29 Oct 2014 06:20:40 -0700
Message-ID: <5450E9A8.1060506@roeck-us.net>
References: <20141024192948.GE11455@saruman> <20141024193655.GD19377@localhost> <20141024194442.GG11455@saruman> <20141024195532.GF19377@localhost> <20141027162251.d7ff2a5f31917c638d4e47f7@linux-foundation.org> <20141028002552.GX12379@n2100.arm.linux.org.uk> <20141028081616.GL2006@localhost> <20141028084745.GY12379@n2100.arm.linux.org.uk> <20141028131257.GS2006@localhost> <20141028151610.GA12379@n2100.arm.linux.org.uk> <20141029123418.GB2265@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141029123418.GB2265@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Felipe Balbi <balbi@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, Tony Lindgren <tony@atomide.com>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Lokesh Vutla <lokeshvutla@ti.com>, nsekhar@ti.com, t-kristo@ti.com, j-keerthy@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/29/2014 05:34 AM, Johan Hovold wrote:
> On Tue, Oct 28, 2014 at 03:16:10PM +0000, Russell King - ARM Linux wrote:
>> On Tue, Oct 28, 2014 at 02:12:57PM +0100, Johan Hovold wrote:
>>> That's not what I was trying to refer to. But the patch set explicitly
>>> allows for multiple, prioritised power-off handlers, which can power
>>> off a board in different ways and with various degrees of success.
>>> Specifically, it allows for fallback handlers in case one or more
>>> power-off handlers fail.
>>>
>>> So if we allow for that, what is to prevent the final power-off handler
>>> from failing? And should this not be logged by arch code in the same way
>>> as failure to restart is?
>>
>> And how is that different from having a set of power-off handlers, and
>> reporting when each individual one fails?  Don't you want to know if
>> your primary high priority reboot handler fails, just as much as you
>> want to know if your final last-resort power-off handler fails?
>
> Good point. Failed power-off should probably be logged by the power-off
> call chain implementation (which seems to makes notifier chains a bad
> fit).
>
Good that I just replaced notifier chain with an open coded implementation.
Sure, that is possible, but I would prefer to do that as a follow-up commit,
and it should be discussed in the context of the power-off handler patch set.

> And what about any power-off latencies? Should this always be dealt with
> in the power-off handler?
>
> Again, if it's predictable and high, as in the OMAP RTC case, it should
> go in the handler. But what if it's just normal bus latencies
> (peripheral busses, i2c, or whatever people may come up with)?
>
> Should there always be a short delay before calling the next handler?
>
That delay would depend on the individual power-off handler, so I think
the current implementation works just fine (where power-off handlers
implement the delay).

We could move the delay into the infrastructure, but it would have
to be configurable. I would prefer to consider that as a follow-up patch
to not overload the power-off handler patch set with too many changes
at the same time.

>> Or different from having no power-off handlers.
>
> That is actually quite different, as in that case we call machine_halt
> instead (via kernel_halt).
>
>> Here's the x86 code:
>>
>> void machine_power_off(void)
>> {
>>          machine_ops.power_off();
>> }
>>
>> struct machine_ops machine_ops = {
>>          .power_off = native_machine_power_off,
>> ...
>>
>> static void native_machine_power_off(void)
>> {
>>          if (pm_power_off) {
>>                  if (!reboot_force)
>>                          machine_shutdown();
>>                  pm_power_off();
>>          }
>>          /* A fallback in case there is no PM info available */
>>          tboot_shutdown(TB_SHUTDOWN_HALT);
>> }
>>
>> void tboot_shutdown(u32 shutdown_type)
>> {
>>          void (*shutdown)(void);
>>
>>          if (!tboot_enabled())
>>                  return;
>>
>> See - x86 can very well just fall straight back out of machine_power_off()
>> if there's no pm_power_off() hook and tboot is not enabled.
>
> I never doubted that, but is the right thing to do? Not all arches do it
> that way.
>
> And what about the killing of init? Shall we simply consider that a
> systemd bug?
>
> 	case LINUX_REBOOT_CMD_POWER_OFF:
> 		kernel_power_off();
> 		do_exit(0);
> 		break;
>
> If power-off fails (for whatever reason), do_exit(0) will trigger a
> panic when called from PID 1.
>
Common handling of that condition - eg to call machine_halt() - might be
an option. Separate patch, though.

Guenter
