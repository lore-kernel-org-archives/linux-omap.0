From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [4.4-rc][PATCH] ARM: dts: am4372: disable arm twd and global
 timer's nodes
Date: Wed, 18 Nov 2015 17:35:43 +0200
Message-ID: <564C9ACF.6040107@ti.com>
References: <1447855315-419-1-git-send-email-grygorii.strashko@ti.com>
 <20151118141537.GC10644@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151118141537.GC10644@leverpostej>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, slash.tmp@free.fr, tony@atomide.com, nsekhar@ti.com, Felipe Balbi <balbi@ti.com>, t-kristo@ti.com, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Mark,

On 11/18/2015 04:15 PM, Mark Rutland wrote:
> On Wed, Nov 18, 2015 at 04:01:55PM +0200, Grygorii Strashko wrote:
>> Keep ARM TWD and Global timer's nodes disabled by default - if someone
>> would like to use them then those nodes have to be enabled explicitly
>> in board file.
>>
>> The reason for this change is:
>> - ARM TWD is not always-on timer on am437x and it will stop in low
>>    CPUIdle states and, therefore, broadcast timer has to configured
>>    properly if CPU_IDLE=y.
>> - ARM Global timer is not always-on timer on am437x and it can't be
>>    used as clocksource device if CPU_IDLE=y.
> 
> I don't understand. What timer do you use in the absence of a TWD, and
> if it is better why is it not used even if TWD is present?

OMAP GP timer as clockevent device
"ti,omap-counter32k" as clocksource
both are in wakeup (always-on) PM domain.

I see some problems with selecting clocksource/event device (but may be I'm mistaken):
- Current clock event will be selected using "rating" field in clock_event_device
  structure and now ARM TWD has higer value (350) vs OMAP GP timer (300),
  so ARM TWD will be always selected if it's present. 
- we have to force all am437x user to use kernel cmdline parameter "clocksource="
  if ARM Global timer is present, but shouldn't be used. But even in this case,
  it will be selected as sched_clock.

We can see benefits from using these timers when Power mangement is not the case,
for example on -RT kernel where CPUIdle is not the target.

By this change, and taking into account discovered issues, I want to make people,
who would like to use these timers on AM437x based boards, responsible for such
decision with assumption that they know what they are doing.
And this is simplest way I found to disable those timers without modifying kernel.

> 
>> - ARM Global timer driver doesn't support CPUfreq now.
> 
> Surely that should be fixed in the driver (e.g. make it fail to probe if
> CPUfreq is present)? It's broken for any other users too...

May be.

Also, there is additional issue with ARM global timer which I've not
mentioned here, because I sent the fix for it already (in progress):
https://lkml.org/lkml/2015/11/13/456

and there is ongoing discussion:
http://www.spinics.net/lists/arm-kernel/msg459649.html

-- 
regards,
-grygorii
