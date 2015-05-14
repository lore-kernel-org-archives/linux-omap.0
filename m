From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [PATCH] gpio: pcf875x: Revert "gpio: pcf857x: Propagate wake-up
 setting to parent irq controller"
Date: Thu, 14 May 2015 15:32:05 +0300
Message-ID: <555495C5.3040904@linaro.org>
References: <1431353601-21295-1-git-send-email-rogerq@ti.com> <CAMuHMdUhhKSw0fEB5XCMsrM+uKZRCRMZTiBvPpG8k2wo2gX-zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUhhKSw0fEB5XCMsrM+uKZRCRMZTiBvPpG8k2wo2gX-zA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Roger Quadros <rogerq@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 05/11/2015 08:36 PM, Geert Uytterhoeven wrote:
> On Mon, May 11, 2015 at 4:13 PM, Roger Quadros <rogerq@ti.com> wrote:
>> commit b80eef95beb0 ('gpio: pcf857x: Propagate wake-up setting to parent irq controller')
>> introduces the following recursive locking warning while suspending dra7-evm.
>>
>> The issue addressed by that commit has been already resolved by
>> commit 10a50f1ab5f0 ('genirq: Set IRQCHIP_SKIP_SET_WAKE flag for dummy_irq_chip')
> 
> That's not 100% correct: commit b80eef95beb0 ('gpio: pcf857x: Propagate wake-up
> setting to parent irq controller') fixes _two_ things:
>    1. warning due to missing irq_set_wake / IRQCHIP_SKIP_SET_WAKE,
>    2. propagating set_wake, so the parent interrupt controller stays awake, as
>       it's needed for wake-up,
> 
> Only the first issue is addressed by commit 10a50f1ab5f0 ('genirq: Set
> IRQCHIP_SKIP_SET_WAKE flag for dummy_irq_chip').
> 
>> and so let's revert commit b80eef95beb0 ('gpio: pcf857x: Propagate wake-up setting to parent irq controller')
>>
>> At least the recursive locking message no longer appears after the revert.
>>
>> [   30.591905] PM: Syncing filesystems ... done.
>> [   30.623060] Freezing user space processes ... (elapsed 0.003 seconds) done.
>> [   30.634470] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
>> [   30.658288] sd 0:0:0:0: [sda] Synchronizing SCSI cache
>> [   30.663678]
>> [   30.663681] =============================================
>> [   30.663683] [ INFO: possible recursive locking detected ]
>> [   30.663688] 4.1.0-rc3 #1115 Not tainted
>> [   30.663693] ---------------------------------------------
>> [   30.663697] suspend.sh/2319 is trying to acquire lock:
>> [   30.663719]  (class){......}, at: [<c0096ebc>] __irq_get_desc_lock+0x48/0x88
>> [   30.663722]
>> [   30.663722] but task is already holding lock:
>> [   30.663734]  (class){......}, at: [<c0096ebc>] __irq_get_desc_lock+0x48/0x88
> 
> Does this mean .set_irq_wake() cannot call irq_set_irq_wake()?
> Many GPIO drivers do that, as they need to propagate wake-up state to the
> parent interrupt controller?

As I remember, there was similar problem, so I found corresponding patch (just FYI)

ab2b926 mfd: Fix twl6030 lockdep recursion warning on setting wake IRQs

Not sure such kind of solution is the best choice (

-- 
regards,
-grygorii
