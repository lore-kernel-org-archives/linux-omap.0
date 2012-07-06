From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] Watchdog: OMAP: Fix the runtime pm code to avoid module
 getting stuck intransition state.
Date: Fri, 6 Jul 2012 12:51:03 +0530
Message-ID: <CAMQu2gwDdonnvFuDpy06aRA2O4Sj1Jh+pEWAGQV3az6BHQKf4w@mail.gmail.com>
References: <1339996996-3257-1-git-send-email-lokeshvutla@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EAF87AB@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EAF87AB@DBDE01.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "Vutla, Lokesh" <lokeshvutla@ti.com>, Wim Van Sebroeck <wim@iguana.be>, linux-omap <linux-omap@vger.kernel.org>, linux-watchdog <linux-watchdog@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

(+ linux-omap, linux-watchdog)

Vaibhav,

On Thu, Jul 5, 2012 at 8:06 PM, Bedia, Vaibhav <vaibhav.bedia@ti.com> wrote:
> Hi,
>
> On Mon, Jun 18, 2012 at 10:53:16, Vutla, Lokesh wrote:
>> OMAP watchdong driver is adapted to runtime PM like a general device
>> driver but it is not appropriate. It is causing couple of functional
>> issues.
>>
>
> A few questions based on the description given in the commit message.
>
>> 1. On OMAP4 SYSCLK can't be gated, because of issue with WDTIMER2 module,
>> which constantly stays in "in transition" state. Value of register
>> CM_WKUP_WDTIMER2_CLKCTRL is always 0x00010000 in this case.
>> Issue occurs immediately after first idle, when hwmod framework tries
>> to disable WDTIMER2 functional clock - "wd_timer2_fck". After this
>> module falls to "in transition" state, and SYSCLK gating is blocked.
>>
>
> From what I know, a value of 0x00010000 for timers (WDT or DMTIMERs)
> indicates that the iclk is gated but the fclk is running. In fact,
> if the IP supports swakeup mechanism this is the value expected in the
> *_CLKCTRL registers of the timers for the swakeup to work.
>
Nope. That case will be 0x00020000

Read 0x1: Module is performing transition: wakeup, or
sleep, or sleep abortion
Read 0x2: Module is in idle mode (only INTRCONN part).
It is functional if using separate functional clock
Read 0x3: Module is disabled and cannot be accessed

> Sounds like on OMAP4 the WDT needs to be stopped first and then the
> PRCM idle request sent otherwise SYSCLK gating will be blocked.
>
Any module stuck in-transition will get the clock-domain from idle.

>> 2. Due to runtime PM, watchdog timer may be completely disabled.
>> In current code base watchdog timer is not disabled only because of
>> issue 1. Otherwise state of WDTIMER2 module will be "Disabled", and there
>> will be no interrupts from omap_wdt. In other words watchdog will not
>> work at all.
>
> But the current driver doesn't make use of any interrupts, right?
>
How is the interrupt related. You enable that when you enable WDT
petting using delay_interrupt()

> If the WDT was never started, runtime PM handling for the WDT should be
> able to get the IP to a "disabled" state. Is the issue over here due
> to the WDT counter incrementing and still the PRCM idle request being
> sent for disabling it? If so, perhaps a better solution would be have
> a custom runtime PM handling for WDT which checks if the counter
> is incrementing or not. If it is not incrementing then it can just
> go ahead and disable the clocks. However, if the counter is incrementing
> then the runtime PM activities on the driver should be forbidden till
> an entry to a low power state where SYSCLK needs to be gated is required.
>
If you look at the test case mentioned, the watchdong is started. Your
first observation is not as per the hardware behavior, so other points
becomes not relevant.

Regards
Santosh
