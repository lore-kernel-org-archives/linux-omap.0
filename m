From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 2/3] bus: ti-sysc: Fix timer handling with drop
 pm_runtime_irq_safe()
Date: Sat, 26 Jan 2019 20:31:51 +0100
Message-ID: <2369C6FA-32A2-4F29-9DFB-60D576AB867F@goldelico.com>
References: <20190122175717.13428-1-tony@atomide.com>
 <20190122175717.13428-3-tony@atomide.com> <20190126194145.2b3484da@aktux>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190126194145.2b3484da@aktux>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ladislav Michl <ladis@linux-mips.org>, Keerthy <j-keerthy@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Tero Kristo <t-kristo@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Pavel Machek <pavel@ucw.cz>, Andreas Kemnade <andreas@kemnade.info>, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


> Am 26.01.2019 um 19:41 schrieb Andreas Kemnade <andreas@kemnade.info>:
> 
> On Tue, 22 Jan 2019 09:57:16 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> 
>> Commit 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
>> them with ti-sysc") started producing a warning for pwm-omap-dmtimer:
>> 
>> WARNING: CPU: 0 PID: 77 at drivers/bus/omap_l3_noc.c:147
>> l3_interrupt_handler+0x2f8/0x388
>> 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2 (Idle):
>> Data Access in Supervisor mode during Functional access
>> ...
>> __pm_runtime_idle
>> omap_dm_timer_disable
>> pwm_omap_dmtimer_start
>> pwm_omap_dmtimer_enable
>> pwm_apply_state
>> pwm_vibrator_start
>> pwm_vibrator_play_work
>> 
>> This is because the timer that pwm-omap-dmtimer is using is now being
>> probed with ti-sysc interconnect target module instead of omap_device
>> and the ti-sysc quirk for SYSC_QUIRK_LEGACY_IDLE is not fully
>> compatible with what omap_device has been doing.
>> 
>> We could fix this by reverting the timer changes and have the timer
>> probe again with omap_device. Or we could add more quirk handling to
>> ti-sysc driver. But as these options don't work nicely as longer term
>> solutions, let's just make timers probe with ti-sysc without any
>> quirks.
>> 
>> To do this, all we need to do is remove quirks for timers for ti-sysc,
>> and drop the bogus pm_runtime_irq_safe() flag for timer-ti-dm.
>> 
>> We should not use pm_runtime_irq_safe() anyways for drivers as it will
>> take a permanent use count on the parent device blocking the parent
>> devices from idling and has been forcing ti-sysc driver to use a
>> quirk flag.
>> 
>> Note that we will move the timer data to DEBUG section later on in
>> clean-up patches.
>> 
> together with 1/3 it fixes things on pyra.
> 
> Tested-By: Andreas Kemnade <andreas@kemnade.info>

H. Nikolaus Schaller <hns@goldelico.com>
