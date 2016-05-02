From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: BUG: spinlock vs. mutex in SyS_finit_module / usbhs_runtime_resume / omap_tll_enable / clk_prepare_lock
Date: Mon, 2 May 2016 15:03:34 +0200
Message-ID: <006C30D2-0AF9-489E-9406-3CF977789BFA@goldelico.com>
References: <01E66DD1-5A58-434F-98E8-CB0F9F741810@goldelico.com> <57274AF9.1040205@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57274AF9.1040205@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, LKML <linux-kernel@vger.kernel.org>, kernel@pyra-handheld.com, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

Hi Roger,

> Am 02.05.2016 um 14:41 schrieb Roger Quadros <rogerq@ti.com>:
> 
> Hi Nikolaus,
> 
> On 30/04/16 20:24, H. Nikolaus Schaller wrote:
>> Hi,
>> I have observed this kernel oops on an omap5 board from time to time (approx. 1% of boot processes):
>> 
>> [    5.830970] ehci-omap: OMAP-EHCI Host Controller driver
>> [    5.830974] driver_register 'ehci-omap'
>> [    5.895849] driver_register 'wl1271_sdio'
>> [    5.896870] BUG: scheduling while atomic: udevd/994/0x00000002
>> [    5.896876] 4 locks held by udevd/994:
>> [    5.896904]  #0:  (&dev->mutex){......}, at: [<c049597c>] __driver_attach+0x60/0xac
>> [    5.896923]  #1:  (&dev->mutex){......}, at: [<c049598c>] __driver_attach+0x70/0xac
>> [    5.896946]  #2:  (tll_lock){+.+...}, at: [<c04c2630>] omap_tll_enable+0x2c/0xd0
>> [    5.896966]  #3:  (prepare_lock){+.+...}, at: [<c05ce9c8>] clk_prepare_lock+0x48/0xe0
>> [    5.897042] Modules linked in: wlcore_sdio(+) ehci_omap(+) dwc3_omap snd_soc_ts3a225e leds_is31fl319x bq27xxx_battery_i2c tsc2007 bq27xxx_battery bq2429x_charger ina2xx tca8418_keypad as5013 leds_tca6507 twl6040_vibra gpio_twl6040 bmp085_i2c(+) palmas_gpadc usb3503 palmas_pwrbutton bmg160_i2c(+) bmp085 bma150(+) bmg160_core bmp280 input_polldev snd_soc_omap_mcbsp snd_soc_omap_mcpdm snd_soc_omap snd_pcm_dmaengine
>> [    5.897048] Preemption disabled at:[<  (null)>]   (null)
>> [    5.897051] 
>> [    5.897059] CPU: 0 PID: 994 Comm: udevd Not tainted 4.6.0-rc5-letux+ #233
>> [    5.897062] Hardware name: Generic OMAP5 (Flattened Device Tree)
>> [    5.897076] [<c010e714>] (unwind_backtrace) from [<c010af34>] (show_stack+0x10/0x14)
>> [    5.897087] [<c010af34>] (show_stack) from [<c040aa7c>] (dump_stack+0x88/0xc0)
>> [    5.897099] [<c040aa7c>] (dump_stack) from [<c020c558>] (__schedule_bug+0xac/0xd0)
>> [    5.897111] [<c020c558>] (__schedule_bug) from [<c06f3d44>] (__schedule+0x88/0x7e4)
>> [    5.897120] [<c06f3d44>] (__schedule) from [<c06f46d8>] (schedule+0x9c/0xc0)
>> [    5.897129] [<c06f46d8>] (schedule) from [<c06f4904>] (schedule_preempt_disabled+0x14/0x20)
>> [    5.897140] [<c06f4904>] (schedule_preempt_disabled) from [<c06f64e4>] (mutex_lock_nested+0x258/0x43c)
>> [    5.897150] [<c06f64e4>] (mutex_lock_nested) from [<c05ce9c8>] (clk_prepare_lock+0x48/0xe0)
>> [    5.897160] [<c05ce9c8>] (clk_prepare_lock) from [<c05d0e7c>] (clk_prepare+0x10/0x28)
>> [    5.897169] [<c05d0e7c>] (clk_prepare) from [<c04c2668>] (omap_tll_enable+0x64/0xd0)
>> [    5.897180] [<c04c2668>] (omap_tll_enable) from [<c04c1728>] (usbhs_runtime_resume+0x18/0x17c)
>> [    5.897192] [<c04c1728>] (usbhs_runtime_resume) from [<c049d404>] (pm_generic_runtime_resume+0x2c/0x40)
>> [    5.897202] [<c049d404>] (pm_generic_runtime_resume) from [<c049f180>] (__rpm_callback+0x38/0x68)
>> [    5.897210] [<c049f180>] (__rpm_callback) from [<c049f220>] (rpm_callback+0x70/0x88)
>> [    5.897218] [<c049f220>] (rpm_callback) from [<c04a0a00>] (rpm_resume+0x4ec/0x7ec)
>> [    5.897227] [<c04a0a00>] (rpm_resume) from [<c04a0f48>] (__pm_runtime_resume+0x4c/0x64)
>> [    5.897236] [<c04a0f48>] (__pm_runtime_resume) from [<c04958dc>] (driver_probe_device+0x30/0x70)
>> [    5.897246] [<c04958dc>] (driver_probe_device) from [<c04959a4>] (__driver_attach+0x88/0xac)
>> [    5.897256] [<c04959a4>] (__driver_attach) from [<c04940f8>] (bus_for_each_dev+0x50/0x84)
>> [    5.897267] [<c04940f8>] (bus_for_each_dev) from [<c0494e40>] (bus_add_driver+0xcc/0x1e4)
>> [    5.897276] [<c0494e40>] (bus_add_driver) from [<c0496914>] (driver_register+0xac/0xf4)
>> [    5.897286] [<c0496914>] (driver_register) from [<c01018e0>] (do_one_initcall+0x100/0x1b8)
>> [    5.897296] [<c01018e0>] (do_one_initcall) from [<c01c7a54>] (do_init_module+0x58/0x1c0)
>> [    5.897304] [<c01c7a54>] (do_init_module) from [<c01c8a3c>] (SyS_finit_module+0x88/0x90)
>> [    5.897313] [<c01c8a3c>] (SyS_finit_module) from [<c0107120>] (ret_fast_syscall+0x0/0x1c)
>> [    5.912697] ------------[ cut here ]------------
>> [    5.912711] WARNING: CPU: 0 PID: 994 at kernel/sched/core.c:2996 _raw_spin_unlock+0x28/0x58
>> [    5.912717] DEBUG_LOCKS_WARN_ON(val > preempt_count())
>> 
>> A liitle analysis of the code shows me:
>> 
>> * udevd tries to initialize some (usb driver?) module
>> * this calls usbhs_runtime_resume: http://lxr.free-electrons.com/source/drivers/mfd/omap-usb-host.c#L310
>> * which calls omap_tll_enable: http://lxr.free-electrons.com/source/drivers/mfd/omap-usb-tll.c#L403
>> * this does a spinlock: http://lxr.free-electrons.com/source/drivers/mfd/omap-usb-tll.c#L413
>> * but calls clk_prepare_enable: http://lxr.free-electrons.com/source/include/linux/clk.h#L467
>> * which calls: http://lxr.free-electrons.com/source/drivers/clk/clk.c#L658
>> * and there is a another lock being tried in clk_prepare_lock: http://lxr.free-electrons.com/source/drivers/clk/clk.c#L91
>> * and that is a mutex_try_lock
>> 
>> So the lock dependency report is very valid. Inside a spinlock, there is a mutex_try_lock.
>> 
>> It appears as if the spinlock was introduced in 2008 by 76a0775d46da052f123b8598a3dfc3b330b8de4f
>> And the mutex in 2013 by 533ddeb1e86f506129ee388a6cc13796dcf31311
>> 
>> Please fix.
>> 
>> Thank you,
>> Nikolaus
> 
> Does this patch fix it for you?
> 
> --
> cheers,
> -roger
> 
> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
> index b7b3e8e..c30290f 100644
> --- a/drivers/mfd/omap-usb-tll.c
> +++ b/drivers/mfd/omap-usb-tll.c
> @@ -269,6 +269,8 @@ static int usbtll_omap_probe(struct platform_device *pdev)
> 
> 		if (IS_ERR(tll->ch_clk[i]))
> 			dev_dbg(dev, "can't get clock : %s\n", clkname);
> +		else
> +			clk_prepare(tll->ch_clk[i]);
> 	}
> 
> 	pm_runtime_put_sync(dev);
> @@ -301,9 +303,12 @@ static int usbtll_omap_remove(struct platform_device *pdev)
> 	tll_dev = NULL;
> 	spin_unlock(&tll_lock);
> 
> -	for (i = 0; i < tll->nch; i++)
> -		if (!IS_ERR(tll->ch_clk[i]))
> +	for (i = 0; i < tll->nch; i++) {
> +		if (!IS_ERR(tll->ch_clk[i])) {
> +			clk_unprepare(tll->ch_clk[i]);
> 			clk_put(tll->ch_clk[i]);
> +		}
> +	}
> 
> 	pm_runtime_disable(&pdev->dev);
> 	return 0;
> @@ -420,7 +425,7 @@ int omap_tll_enable(struct usbhs_omap_platform_data *pdata)
> 			if (IS_ERR(tll->ch_clk[i]))
> 				continue;
> 
> -			r = clk_prepare_enable(tll->ch_clk[i]);
> +			r = clk_enable(tll->ch_clk[i]);
> 			if (r) {
> 				dev_err(tll_dev,
> 				 "Error enabling ch %d clock: %d\n", i, r);
> @@ -448,7 +453,7 @@ int omap_tll_disable(struct usbhs_omap_platform_data *pdata)
> 	for (i = 0; i < tll->nch; i++) {
> 		if (omap_usb_mode_needs_tll(pdata->port_mode[i])) {
> 			if (!IS_ERR(tll->ch_clk[i]))
> -				clk_disable_unprepare(tll->ch_clk[i]);
> +				clk_disable(tll->ch_clk[i]);
> 		}
> 	}

I will give it a try. Since it is sporadic I can tell only after some days of use if it did not happen any more.

BR and thanks,
Nikolaus
