From: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Wed, 30 Mar 2016 21:50:00 +0300
Message-ID: <56FC1FD8.6090003@gmail.com>
References: <20160115224839.GA19432@atomide.com> <569A1E32.1020502@gmail.com>
 <56F2DF79.6010903@gmail.com> <87fuvgxtc3.fsf@intel.com>
 <56F3914B.4010206@gmail.com> <87a8loxsdm.fsf@intel.com>
 <56F4361C.9040907@gmail.com> <877fgkqn8c.fsf@intel.com>
 <56FBD4BF.6090905@gmail.com> <87h9fohyr1.fsf@intel.com>
 <56FBDC51.9020602@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080103010002090107010107"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56FBDC51.9020602-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, =?UTF-8?Q?pali_Roh=c3=a1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------080103010002090107010107
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit



On 30.03.2016 17:01, Ivaylo Dimitrov wrote:
>
>
> On 30.03.2016 16:38, Felipe Balbi wrote:
>>
>> Hi,
>>
>> Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>>>> Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>>>>>> Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>>>>>>>> Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>>>>>>>>> On 16.01.2016 12:40, Ivaylo Dimitrov wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> On 16.01.2016 00:48, Tony Lindgren wrote:
>>>>>>>>>>> Hi all,
>>>>>>>>>>>
>>>>>>>>>>> Looks like there's some issue with the USB gadgets and configfs.
>>>>>>>>>>>
>>>>>>>>>>> I'm seeing rmmod of the UDC driver cause a warning and then
>>>>>>>>>>> reboot
>>>>>>>>>>> hangs the system. This happens at least with v4.4, and I've
>>>>>>>>>>> reproduced
>>>>>>>>>>> it with dwc3 and musb so it seems to be generic.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Having configfs is not needed, disabling usb gadgets (#
>>>>>>>>>> CONFIG_USB_MUSB_GADGET is not set) seems to solved at least
>>>>>>>>>> poweroff
>>>>>>>>>> hang issue on N900. Also, g_nokia is not a module in the
>>>>>>>>>> config I use,
>>>>>>>>>> so I guess the problem is not related whether gadgets are
>>>>>>>>>> modular or
>>>>>>>>>> not. Unfortunately I was not able to test reboot, as rootfs
>>>>>>>>>> became
>>>>>>>>>> corrupted after the first poweroff :( . So it looks like my
>>>>>>>>>> theory that
>>>>>>>>>> onenand corruption on N900 is because poweroff/reboot hangs is
>>>>>>>>>> wrong.
>>>>>>>>>>
>>>>>>>>>> Ivo
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Is there any progress on the issue?
>>>>>>>>
>>>>>>>
>>>>>>> Doing Nokia-N900:/sys/bus/platform/drivers/musb-hdrc# echo
>>>>>>> musb-hdrc.0.auto > unbind results in:
>>>>>>>
>>>>>>> <1>[ 1418.511260] Unable to handle kernel paging request at virtual
>>>>>>> address 6c6c757a
>>>>>>> <7>[ 1418.677215] pvr: Xorg: cleaning up 49 unfreed resources
>>>>>>> <1>[ 1418.683349] pgd = c0004000
>>>>>>> <1>[ 1418.739959] [6c6c757a] *pgd=00000000
>>>>>>> <0>[ 1418.746307] Internal error: Oops: 5 [#1] PREEMPT ARM
>>>>>>> <4>[ 1418.753997] Modules linked in: sha256_generic hmac drbg
>>>>>>> ansi_cprng
>>>>>>> ctr ccm vfat fat rfcomm sd_mod scsi_mod bnep bluetooth omaplfb
>>>>>>> pvrsrvkm
>>>>>>> ipv6 bq2415x_charger uinput radio_platform_si4713 joydev cmt_speech
>>>>>>> hsi_char video_bus_switch arc4 wl1251_spi wl1251 isp1704_charger
>>>>>>> gpio_keys mac80211 smc91x mii cfg80211 omap_wdt crc7 omap_sham
>>>>>>> tsc2005
>>>>>>> tsc200x_core bq27xxx_battery_i2c si4713 adp1653 tsl2563 leds_lp5523
>>>>>>> leds_lp55xx_common bq27xxx_battery rtc_twl twl4030_wdt et8ek8 ad5820
>>>>>>> v4l2_common smiaregs twl4030_vibra videodev ff_memless lis3lv02d_i2c
>>>>>>> lis3lv02d media input_polldev omap_ssi_port ti_soc_thermal
>>>>>>> nokia_modem
>>>>>>> ssi_protocol omap_ssi hsi rx51_battery
>>>>>>> <4>[ 1418.835906] CPU: 0 PID: 53 Comm: file-storage Not tainted
>>>>>>> 4.5.0-rc5+ #59
>>>>>>> <4>[ 1418.846130] Hardware name: Nokia RX-51 board
>>>>>>> <4>[ 1418.853820] task: ceb8a300 ti: ce008000 task.ti: ce008000
>>>>>>> <4>[ 1418.862792] PC is at handle_exception+0xa8/0x418
>>>>>>> <4>[ 1418.871002] LR is at recalc_sigpending+0x18/0x7c
>>>>>>> <4>[ 1418.879241] pc : [<c031d0e4>]    lr : [<c0037b84>]    psr:
>>>>>>> 80000013
>>>>>>> <4>[ 1418.879241] sp : ce009ea0  ip : 00000000  fp : 00000000
>>>>>>> <4>[ 1418.898284] r10: 00000000  r9 : 00000000  r8 : 00000000
>>>>>>> <4>[ 1418.907287] r7 : c031d8d0  r6 : 6c6c7566  r5 : 00000000  r4
>>>>>>> : cebe1600
>>>>>>> <4>[ 1418.917663] r3 : 6f642820  r2 : 00000000  r1 : 00000000  r0
>>>>>>> : 00000000
>>>>>>> <4>[ 1418.928039] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA
>>>>>>> ARM
>>>>>>> Segment none
>>>>>>> <4>[ 1418.939025] Control: 10c5387d  Table: 8e244019  DAC: 00000051
>>>>>>> <0>[ 1418.948516] Process file-storage (pid: 53, stack limit =
>>>>>>> 0xce008210)
>>>>>>> <0>[ 1418.958679] Stack: (0xce009ea0 to 0xce00a000)
>>>>>>> <0>[ 1418.966735] 9ea0: 0000000f 00000000 00000000 00000b07 00000000
>>>>>>> 00000001 000003ff 00000001
>>>>>>> <0>[ 1418.978973] 9ec0: ceb8a300 ceb8a300 00000000 c004841c 00000000
>>>>>>> 00000002 ce888000 c0451a50
>>>>>>> <0>[ 1418.991180] 9ee0: ffffffff 00000000 00000000 00000008 cebe1600
>>>>>>> 00000001 c0717dd0 00000001
>>>>>>> <0>[ 1419.003387] 9f00: 00000000 00000000 ce009f14 c044ddf4 00000000
>>>>>>> c031c020 00000042 ce009f30
>>>>>>> <0>[ 1419.015686] 9f20: ce009f30 00000000 cebe1600 c031d958 00000000
>>>>>>> c044d864 a0000013 00000000
>>>>>>> <0>[ 1419.027923] 9f40: cebe1600 c031d8d0 cebfa100 cebfa100 00000000
>>>>>>> cebe1600 c031d8d0 00000000
>>>>>>> <0>[ 1419.040130] 9f60: 00000000 00000000 00000000 c00474e4 dc4d900d
>>>>>>> 00000000 31bc92e7 cebe1600
>>>>>>> <0>[ 1419.052429] 9f80: 00000000 ce009f84 ce009f84 00000000 ce009f90
>>>>>>> ce009f90 ce009fac cebfa100
>>>>>>> <0>[ 1419.064697] 9fa0: c0047418 00000000 00000000 c000f218 00000000
>>>>>>> 00000000 00000000 00000000
>>>>>>> <0>[ 1419.076934] 9fc0: 00000000 00000000 00000000 00000000 00000000
>>>>>>> 00000000 00000000 00000000
>>>>>>> <0>[ 1419.089050] 9fe0: 00000000 00000000 00000000 00000000 00000013
>>>>>>> 00000000 00002000 30000891
>>>>>>> <4>[ 1419.101043] [<c031d0e4>] (handle_exception) from [<c031d958>]
>>>>>>> (fsg_main_thread+0x88/0x13dc)
>>>>>>> <4>[ 1419.113189] [<c031d958>] (fsg_main_thread) from [<c00474e4>]
>>>>>>> (kthread+0xcc/0xe0)
>>>>>>> <4>[ 1419.124267] [<c00474e4>] (kthread) from [<c000f218>]
>>>>>>> (ret_from_fork+0x14/0x3c)
>>>>>>> <0>[ 1419.135101] Code: 1a000015 ea000040 e5946038 e0866285
>>>>>>> (e5963014)
>>>>>>> <4>[ 1419.330841] ---[ end trace 3377457e25b0732c ]---
>>>>>>> <0>[ 1419.340972] Kernel panic - not syncing: Fatal exception
>>>>>>>
>>>>>>> weirdly, I have that log only in mtdoops, but not in dmesg. However,
>>>>>>> after that oops "reboot" command does not hang, but reboots the
>>>>>>> device.
>>>>>>
>>>>>>
>>>>>> So, what is handle_exception + 0xa8 ? You can figure that out either
>>>>>> with gdb or addr2line assuming your vmlinux has dbg symbols.
>>>>>>
>>>>>> For gdb you would:
>>>>>>
>>>>>> gdb vmlinux
>>>>>> (gdb) l *(handle_exception + 0xa8)
>>>>>>
>>>>>
>>>>> Yeah, sorry I didn't do it with the previous mail.
>>>>>
>>>>> Reading symbols from
>>>>> /home/ivo/workspace/linux-upstream/github/fmg/linux-n900/vmlinux...done.
>>>>>
>>>>> (gdb) l *(handle_exception + 0xa8)
>>>>> 0xc031d0e4 is in handle_exception
>>>>> (drivers/usb/gadget/function/f_mass_storage.c:2373).
>>>>> 2368
>>>>> 2369        /* Cancel all the pending transfers */
>>>>> 2370        if (likely(common->fsg)) {
>>>>> 2371            for (i = 0; i < common->fsg_num_buffers; ++i) {
>>>>> 2372                bh = &common->buffhds[i];
>>>>> 2373                if (bh->inreq_busy)
>>>>
>>>> so this would mean we have a race here where bh->inreq_busy is still
>>>> set
>>>> while bh->inreq was already freed, right ? I'll try to reproduce this
>>>> with dwc3 and let you know.
>>>>
>>>
>>> I am not sure this is the case, what I see here is fsg_bind() and
>>> fsg_unbind() called twice - "musb-hdrc loaded" -> fsg_bind() ->
>>> fsg_bind(), "musb-hdrc unbind through sysfs" -> fsg_unbind() ->
>>> fsg_unbind(). That seems to come from g_nokia being probed
>>> (successfully) twice. No idea if this is normal - IIUC fsg main thread
>>
>> do you have two interfaces with mass storage ?
>>
>
> There are 2 LUNs, not sure what you mean by 2 interfaces.
>
> Pali ^^^ ?
>
>>> seems to be created twice :). Maybe the problem is that the first time
>>> musb-hdrc is probed it fails with -EPROBE_DEFER, however that failure is
>>> after gadget drivers got loaded and noone unloads them.
>>
>> gadget drivers will get added to a pending list, then later they'll
>> bind. But they shouldn't bind() twice, unless there are multiple
>> interfaces for them.
>>
>
> Well, then it seems we have problem, as the 2 unbind() calls are with
> one and the same "common" pointer (again, from memory).
>
>>> Just some wild guesses based on my memories as I've lost the logs (power
>>> outage). For sure I can recreate them if needed.
>>
>> okay.
>
> I will redo dump_stack() and printks and will provide logs as soon as I
> have some time, so to stop counting on my memories.
>

Please find attached the relevant logs. It really seems that g_nokia is 
probed twice, with all the gadgets in it created two times. I am 
starting to suspect 855ed04a3758b205e84b269f92d26ab36ed8e2f7 ("usb: 
gadget: udc-core: independent registration of gadgets and gadget 
drivers") has something to do with the problem, though reverting it 
resulted in g_nokia not being probed at all :)

Ivo

--------------080103010002090107010107
Content-Type: text/plain; charset=UTF-8;
 name="fsg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fsg.txt"

************ boot log **********************

Jan  1 02:00:10 Nokia-N900 kernel: [    1.152130] HS USB OTG: no transceiver configured
Jan  1 02:00:10 Nokia-N900 kernel: [    1.157135] musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status -517
Jan  1 02:00:10 Nokia-N900 kernel: [    1.165771] udc-core: couldn't find an available UDC - added [g_nokia] to list of pending drivers
Jan  1 02:00:10 Nokia-N900 kernel: [    2.281066] twl 1-0048: PIH (irq 23) chaining IRQs 340..348
Jan  1 02:00:10 Nokia-N900 kernel: [    2.287109] twl 1-0048: power (irq 345) chaining IRQs 348..355
Jan  1 02:00:10 Nokia-N900 kernel: [    2.931243] twl4030_gpio twl4030-gpio: gpio (irq 340) chaining IRQs 356..373
Jan  1 02:00:10 Nokia-N900 kernel: [    3.291046] twl4030_usb 48070000.i2c:twl@48:twl4030-usb: Initialized TWL4030 USB module
Jan  1 02:00:10 Nokia-N900 kernel: [    3.302307] input: twl4030_pwrbutton as /devices/platform/68000000.ocp/48070000.i2c/i2c-1/1-0048/48070000.i2c:twl@48:pwrbutton/input/input0
Jan  1 02:00:10 Nokia-N900 kernel: [    3.317077] input: TWL4030 Keypad as /devices/platform/68000000.ocp/48070000.i2c/i2c-1/1-0048/48070000.i2c:twl@48:keypad/input/input1
Jan  1 02:00:10 Nokia-N900 kernel: [    3.570678] 48070000.i2c:twl@48:madc supply vusb3v1 not found, using dummy regulator
Jan  1 02:00:10 Nokia-N900 kernel: [    7.802825] using random self ethernet address
Jan  1 02:00:10 Nokia-N900 kernel: [    7.811431] using random host ethernet address
Jan  1 02:00:10 Nokia-N900 kernel: [    7.819793] Mass Storage Function, version: 2009/09/11
Jan  1 02:00:10 Nokia-N900 kernel: [    7.828918] LUN: removable file: (no medium)
Jan  1 02:00:10 Nokia-N900 kernel: [    7.837249] LUN: removable file: (no medium)
Jan  1 02:00:10 Nokia-N900 kernel: [    7.845367] LUN: removable file: (no medium)
Jan  1 02:00:10 Nokia-N900 kernel: [    7.853271] Number of LUNs=2
Jan  1 02:00:10 Nokia-N900 kernel: [    7.860839] g_nokia gadget: USB CDC Phonet function
Jan  1 02:00:10 Nokia-N900 kernel: [    7.869323] g_nokia gadget: using musb-hdrc, OUT ep1out, IN ep1in
Jan  1 02:00:10 Nokia-N900 kernel: [    7.880096] usb0: HOST MAC de:00:11:fa:e2:ea
Jan  1 02:00:10 Nokia-N900 kernel: [    7.888153] usb0: MAC 86:7b:b1:f2:e1:40
Jan  1 02:00:10 Nokia-N900 kernel: [    7.895629] fsg_common_run_thread 3003 common->state 7 common->thread_task   (null)
Jan  1 02:00:10 Nokia-N900 kernel: [    7.907501] CPU: 0 PID: 6 Comm: kworker/u2:0 Not tainted 4.6.0-rc1+ #6
Jan  1 02:00:10 Nokia-N900 kernel: [    7.917999] fsg_main_thread 2532 current ceb22d00
Jan  1 02:00:10 Nokia-N900 kernel: [    7.926544] Hardware name: Nokia RX-51 board
Jan  1 02:00:10 Nokia-N900 kernel: [    7.934631] Workqueue: deferwq deferred_probe_work_func
Jan  1 02:00:10 Nokia-N900 kernel: [    7.943756] [<c010bc18>] (unwind_backtrace) from [<c0109f38>] (show_stack+0x10/0x14)
Jan  1 02:00:10 Nokia-N900 kernel: [    7.955505] [<c0109f38>] (show_stack) from [<c041a4b4>] (fsg_bind+0x1c/0x200)
Jan  1 02:00:10 Nokia-N900 kernel: [    7.966552] [<c041a4b4>] (fsg_bind) from [<c040bef0>] (usb_add_function+0x84/0x130)
Jan  1 02:00:10 Nokia-N900 kernel: [    7.978149] [<c040bef0>] (usb_add_function) from [<c041b5d0>] (nokia_bind_config+0x1cc/0x328)
Jan  1 02:00:10 Nokia-N900 kernel: [    7.990692] [<c041b5d0>] (nokia_bind_config) from [<c040c5b4>] (usb_add_config+0x28/0xbc)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.002838] [<c040c5b4>] (usb_add_config) from [<c041b274>] (nokia_bind+0x160/0x2f0)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.014526] [<c041b274>] (nokia_bind) from [<c040e128>] (composite_bind+0x68/0x1a0)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.026092] [<c040e128>] (composite_bind) from [<c0410cc8>] (udc_bind_to_driver+0x2c/0xb8)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.038330] [<c0410cc8>] (udc_bind_to_driver) from [<c0410fe4>] (usb_add_gadget_udc_release+0x16c/0x268)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.055603] [<c0410fe4>] (usb_add_gadget_udc_release) from [<c0409610>] (musb_gadget_setup+0x138/0x168)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.073242] [<c0409610>] (musb_gadget_setup) from [<c04029b8>] (musb_probe+0x560/0x750)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.085754] [<c04029b8>] (musb_probe) from [<c03a3090>] (platform_drv_probe+0x58/0xa0)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.098266] [<c03a3090>] (platform_drv_probe) from [<c03a187c>] (driver_probe_device+0x120/0x2b0)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.111938] [<c03a187c>] (driver_probe_device) from [<c039ff58>] (bus_for_each_drv+0x48/0x8c)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.125335] [<c039ff58>] (bus_for_each_drv) from [<c03a16c8>] (__device_attach+0x88/0xf8)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.138336] [<c03a16c8>] (__device_attach) from [<c03a0d58>] (bus_probe_device+0x28/0x80)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.151519] [<c03a0d58>] (bus_probe_device) from [<c03a11b0>] (deferred_probe_work_func+0x58/0x84)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.170257] [<c03a11b0>] (deferred_probe_work_func) from [<c013b3c8>] (process_one_work+0x1c4/0x324)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.189514] [<c013b3c8>] (process_one_work) from [<c013b86c>] (worker_thread+0x314/0x4a8)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.203186] [<c013b86c>] (worker_thread) from [<c013fe5c>] (kthread+0xcc/0xe0)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.216003] [<c013fe5c>] (kthread) from [<c0107218>] (ret_from_fork+0x14/0x3c)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.228729] fsg_bind 3062 common ce000000
Jan  1 02:00:10 Nokia-N900 kernel: [    8.238067] g_nokia gadget: USB CDC Phonet function
Jan  1 02:00:10 Nokia-N900 kernel: [    8.248199] g_nokia gadget: using musb-hdrc, OUT ep1out, IN ep1in
Jan  1 02:00:10 Nokia-N900 kernel: [    8.259735] fsg_common_run_thread 3003 common->state 0 common->thread_task ceb22d00
Jan  1 02:00:10 Nokia-N900 kernel: [    8.273040] CPU: 0 PID: 6 Comm: kworker/u2:0 Not tainted 4.6.0-rc1+ #6
Jan  1 02:00:10 Nokia-N900 kernel: [    8.284973] fsg_main_thread 2532 current ceb23200
Jan  1 02:00:10 Nokia-N900 kernel: [    8.294952] Hardware name: Nokia RX-51 board
Jan  1 02:00:10 Nokia-N900 kernel: [    8.304412] Workqueue: deferwq deferred_probe_work_func
Jan  1 02:00:10 Nokia-N900 kernel: [    8.315002] [<c010bc18>] (unwind_backtrace) from [<c0109f38>] (show_stack+0x10/0x14)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.328155] [<c0109f38>] (show_stack) from [<c041a4b4>] (fsg_bind+0x1c/0x200)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.340606] [<c041a4b4>] (fsg_bind) from [<c040bef0>] (usb_add_function+0x84/0x130)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.353668] [<c040bef0>] (usb_add_function) from [<c041b5d0>] (nokia_bind_config+0x1cc/0x328)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.367706] [<c041b5d0>] (nokia_bind_config) from [<c040c5b4>] (usb_add_config+0x28/0xbc)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.381286] [<c040c5b4>] (usb_add_config) from [<c041b28c>] (nokia_bind+0x178/0x2f0)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.394348] [<c041b28c>] (nokia_bind) from [<c040e128>] (composite_bind+0x68/0x1a0)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.407257] [<c040e128>] (composite_bind) from [<c0410cc8>] (udc_bind_to_driver+0x2c/0xb8)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.420776] [<c0410cc8>] (udc_bind_to_driver) from [<c0410fe4>] (usb_add_gadget_udc_release+0x16c/0x268)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.440185] [<c0410fe4>] (usb_add_gadget_udc_release) from [<c0409610>] (musb_gadget_setup+0x138/0x168)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.459686] [<c0409610>] (musb_gadget_setup) from [<c04029b8>] (musb_probe+0x560/0x750)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.473083] [<c04029b8>] (musb_probe) from [<c03a3090>] (platform_drv_probe+0x58/0xa0)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.486358] [<c03a3090>] (platform_drv_probe) from [<c03a187c>] (driver_probe_device+0x120/0x2b0)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.500671] [<c03a187c>] (driver_probe_device) from [<c039ff58>] (bus_for_each_drv+0x48/0x8c)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.514709] [<c039ff58>] (bus_for_each_drv) from [<c03a16c8>] (__device_attach+0x88/0xf8)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.528259] [<c03a16c8>] (__device_attach) from [<c03a0d58>] (bus_probe_device+0x28/0x80)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.541778] [<c03a0d58>] (bus_probe_device) from [<c03a11b0>] (deferred_probe_work_func+0x58/0x84)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.560760] [<c03a11b0>] (deferred_probe_work_func) from [<c013b3c8>] (process_one_work+0x1c4/0x324)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.580139] [<c013b3c8>] (process_one_work) from [<c013b86c>] (worker_thread+0x314/0x4a8)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.593933] [<c013b86c>] (worker_thread) from [<c013fe5c>] (kthread+0xcc/0xe0)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.606719] [<c013fe5c>] (kthread) from [<c0107218>] (ret_from_fork+0x14/0x3c)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.619415] fsg_bind 3062 common ce000000
Jan  1 02:00:10 Nokia-N900 kernel: [    8.628662] g_nokia gadget: N900 (PC-Suite Mode)
Jan  1 02:00:10 Nokia-N900 kernel: [    8.638488] g_nokia gadget: g_nokia ready

*********** unbind ***********

Jan  1 06:02:14 Nokia-N900 kernel: [  194.511474] CPU: 0 PID: 3241 Comm: sh Not tainted 4.6.0-rc1+ #6
Jan  1 06:02:14 Nokia-N900 kernel: [  194.517944] Hardware name: Nokia RX-51 board
Jan  1 06:02:14 Nokia-N900 kernel: [  194.534576] [<c010bc18>] (unwind_backtrace) from [<c0109f38>] (show_stack+0x10/0x14)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.561431] [<c0109f38>] (show_stack) from [<c0417310>] (fsg_unbind+0x14/0xc0)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.572906] [<c0417310>] (fsg_unbind) from [<c040b94c>] (remove_config+0x44/0x88)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.583038] [<c040b94c>] (remove_config) from [<c040e05c>] (__composite_unbind+0x3c/0x98)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.594787] [<c040e05c>] (__composite_unbind) from [<c04102c4>] (usb_gadget_remove_driver+0x7c/0xa4)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.607330] [<c04102c4>] (usb_gadget_remove_driver) from [<c0410388>] (usb_del_gadget_udc+0x54/0xa4)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.619812] [<c0410388>] (usb_del_gadget_udc) from [<c0401c1c>] (musb_shutdown+0x24/0xdc)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.630096] [<c0401c1c>] (musb_shutdown) from [<c0402160>] (musb_remove+0x20/0x80)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.640960] [<c0402160>] (musb_remove) from [<c03a301c>] (platform_drv_remove+0x24/0x40)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.649780] [<c03a301c>] (platform_drv_remove) from [<c03a1b80>] (__device_release_driver+0x94/0x108)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.661956] [<c03a1b80>] (__device_release_driver) from [<c03a1c10>] (device_release_driver+0x1c/0x28)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.674468] [<c03a1c10>] (device_release_driver) from [<c03a04e0>] (unbind_store+0x58/0x8c)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.686157] [<c03a04e0>] (unbind_store) from [<c039fd74>] (drv_attr_store+0x20/0x2c)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.697113] [<c039fd74>] (drv_attr_store) from [<c0242e10>] (sysfs_kf_write+0x3c/0x48)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.708251] [<c0242e10>] (sysfs_kf_write) from [<c0242038>] (kernfs_fop_write+0x134/0x198)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.718597] [<c0242038>] (kernfs_fop_write) from [<c01dbca4>] (__vfs_write+0x2c/0xd4)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.728759] [<c01dbca4>] (__vfs_write) from [<c01dd28c>] (vfs_write+0xa0/0x18c)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.738006] [<c01dd28c>] (vfs_write) from [<c01dd570>] (SyS_write+0x3c/0x78)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.747650] [<c01dd570>] (SyS_write) from [<c0107160>] (ret_fast_syscall+0x0/0x3c)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.757141] fsg_unbind 3147 common ce000000 common->fsg   (null) fsg cebc4b40
Jan  1 06:02:14 Nokia-N900 kernel: [  194.768341] CPU: 0 PID: 3241 Comm: sh Not tainted 4.6.0-rc1+ #6
Jan  1 06:02:14 Nokia-N900 kernel: [  194.777221] Hardware name: Nokia RX-51 board
Jan  1 06:02:14 Nokia-N900 kernel: [  194.783477] [<c010bc18>] (unwind_backtrace) from [<c0109f38>] (show_stack+0x10/0x14)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.793243] [<c0109f38>] (show_stack) from [<c0417310>] (fsg_unbind+0x14/0xc0)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.802398] [<c0417310>] (fsg_unbind) from [<c040b94c>] (remove_config+0x44/0x88)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.811828] [<c040b94c>] (remove_config) from [<c040e05c>] (__composite_unbind+0x3c/0x98)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.821990] [<c040e05c>] (__composite_unbind) from [<c04102c4>] (usb_gadget_remove_driver+0x7c/0xa4)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.833190] [<c04102c4>] (usb_gadget_remove_driver) from [<c0410388>] (usb_del_gadget_udc+0x54/0xa4)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.845916] [<c0410388>] (usb_del_gadget_udc) from [<c0401c1c>] (musb_shutdown+0x24/0xdc)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.856445] [<c0401c1c>] (musb_shutdown) from [<c0402160>] (musb_remove+0x20/0x80)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.865997] [<c0402160>] (musb_remove) from [<c03a301c>] (platform_drv_remove+0x24/0x40)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.877380] [<c03a301c>] (platform_drv_remove) from [<c03a1b80>] (__device_release_driver+0x94/0x108)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.888977] [<c03a1b80>] (__device_release_driver) from [<c03a1c10>] (device_release_driver+0x1c/0x28)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.901336] [<c03a1c10>] (device_release_driver) from [<c03a04e0>] (unbind_store+0x58/0x8c)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.910308] [<c03a04e0>] (unbind_store) from [<c039fd74>] (drv_attr_store+0x20/0x2c)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.921081] [<c039fd74>] (drv_attr_store) from [<c0242e10>] (sysfs_kf_write+0x3c/0x48)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.929595] [<c0242e10>] (sysfs_kf_write) from [<c0242038>] (kernfs_fop_write+0x134/0x198)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.941925] [<c0242038>] (kernfs_fop_write) from [<c01dbca4>] (__vfs_write+0x2c/0xd4)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.951721] [<c01dbca4>] (__vfs_write) from [<c01dd28c>] (vfs_write+0xa0/0x18c)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.959686] [<c01dd28c>] (vfs_write) from [<c01dd570>] (SyS_write+0x3c/0x78)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.969329] [<c01dd570>] (SyS_write) from [<c0107160>] (ret_fast_syscall+0x0/0x3c)
Jan  1 06:02:14 Nokia-N900 kernel: [  194.978790] fsg_unbind 3147 common ce000000 common->fsg   (null) fsg ce006180
Jan  1 06:02:14 Nokia-N900 kernel: [  194.987823] handle_exception 2354 current ceb23200
Jan  1 06:02:14 Nokia-N900 kernel: [  194.994323] handle_exception 2408 current ceb23200
Jan  1 06:02:14 Nokia-N900 kernel: [  194.999542] handle_exception 2502 current ceb23200 common->state 7
Jan  1 06:02:14 Nokia-N900 kernel: [  195.008117] fsg_main_thread 2593 current ceb23200


*******************  /dev/mtd2ro ******************************************

<7>[ 3141.642486] pvr: hildon-desktop: cleaning up 366 unfreed resources
<6>[ 3146.602142] wlan0: deauthenticating from 10:fe:ed:dd:f7:61 by local choice (Reason: 3=DEAUTH_LEAVING)
<4>[ 3147.980529] sched: RT throttling activated
<7>[ 3149.357116] wl1251: down
<7>[ 3150.421325] wl1251: 151 tx blocks at 0x3b788, 35 rx blocks at 0x3a780
<7>[ 3150.444519] wl1251: firmware booted (Rev 4.0.4.3.7)
<6>[ 3150.722106] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
<1>[ 3154.986114] Unable to handle kernel paging request at virtual address 6c6c757a
<1>[ 3155.123931] pgd = c0004000
<1>[ 3155.187896] [6c6c757a] *pgd=00000000
<0>[ 3155.226989] Internal error: Oops: 5 [#1] PREEMPT ARM
<4>[ 3155.227020] Modules linked in: smiapp smiapp_pll sha256_generic hmac drbg ansi_cprng ctr ccm vfat fat rfcomm sd_mod scsi_mod bnep bluetooth omaplfb pvrsrvkm ipv6 bq2415x_charger uinput radio_platform_si4713 joydev cmt_speech hsi_char video_bus_switch arc4 isp1704_charger wl1251_spi gpio_keys wl1251 smc91x mii mac80211 omap3_isp cfg80211 omap_wdt videobuf2_v4l2 videobuf2_dma_contig videobuf2_memops videobuf2_core omap_sham crc7 tsc2005 tsc200x_core bq27xxx_battery_i2c bq27xxx_battery leds_lp5523 leds_lp55xx_common adp1653 si4713 et8ek8 tsl2563 smiaregs ad5820 v4l2_common videodev twl4030_wdt rtc_twl twl4030_vibra ff_memless lis3lv02d_i2c lis3lv02d media input_polldev omap_ssi_port ti_soc_thermal nokia_modem ssi_protocol omap_ssi hsi rx51_battery
<4>[ 3155.227264] CPU: 0 PID: 55 Comm: file-storage Not tainted 4.6.0-rc1+ #2
<4>[ 3155.227264] Hardware name: Nokia RX-51 board
<4>[ 3155.227294] task: ceb22d00 ti: ce00a000 task.ti: ce00a000
<4>[ 3155.227325] PC is at handle_exception+0xa8/0x418
<4>[ 3155.227325] LR is at recalc_sigpending+0x18/0x7c
<4>[ 3155.227355] pc : [<c0418a94>]    lr : [<c0130484>]    psr: 80000013
<4>[ 3155.227355] sp : ce00bea0  ip : 00000000  fp : 00000000
<4>[ 3155.227355] r10: 00000000  r9 : 00000000  r8 : 00000000
<4>[ 3155.227355] r7 : c0419280  r6 : 6c6c7566  r5 : 00000000  r4 : ce000000
<4>[ 3155.227355] r3 : 6f642820  r2 : 00000000  r1 : 00000000  r0 : 00000000
<4>[ 3155.227386] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
<4>[ 3155.227386] Control: 10c5387d  Table: 8e270019  DAC: 00000051
<0>[ 3155.227386] Process file-storage (pid: 55, stack limit = 0xce00a210)
<0>[ 3155.227386] Stack: (0xce00bea0 to 0xce00c000)
<0>[ 3155.227416] bea0: 0000000f 00000000 00000000 00001123 00000000 00000001 000003ff 00000001
<0>[ 3155.227416] bec0: ceb22d00 ceb22d00 00000000 c0140e20 00000000 00000002 ce886000 c054ed90
<0>[ 3155.227447] bee0: ffffffff 00000000 00000000 00000008 ce000000 00000001 c09506e0 00000001
<0>[ 3155.227447] bf00: 00000000 00000000 ce00bf14 c054b230 00000000 c04179cc 00000042 ce00bf30
<0>[ 3155.227478] bf20: ce00bf30 00000000 ce000000 c0419308 00000000 c054aca4 a0000013 00000000
<0>[ 3155.227478] bf40: ce000000 c0419280 cebf6c40 cebf6c40 00000000 ce000000 c0419280 00000000
<0>[ 3155.227508] bf60: 00000000 00000000 00000000 c013fe5c 00000000 00000000 00000000 ce000000
<0>[ 3155.227508] bf80: 00000000 ce00bf84 ce00bf84 00000000 ce00bf90 ce00bf90 ce00bfac cebf6c40
<0>[ 3155.227539] bfa0: c013fd90 00000000 00000000 c0107218 00000000 00000000 00000000 00000000
<0>[ 3155.227539] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
<0>[ 3155.227569] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
<4>[ 3155.227600] [<c0418a94>] (handle_exception) from [<c0419308>] (fsg_main_thread+0x88/0x13dc)
<4>[ 3155.227630] [<c0419308>] (fsg_main_thread) from [<c013fe5c>] (kthread+0xcc/0xe0)
<4>[ 3155.227661] [<c013fe5c>] (kthread) from [<c0107218>] (ret_from_fork+0x14/0x3c)
<0>[ 3155.227661] Code: 1a000015 ea000040 e5946038 e0866285 (e5963014) 
<4>[ 3155.227691] ---[ end trace 13330bb6a6df861f ]---
<7>[ 3155.248535] pvr: Xorg: cleaning up 49 unfreed resources
<7>[ 3155.266998] mtdoops: ready 14, 15 (no erase)
<0>[ 3155.267089] Kernel panic - not syncing: Fatal exception



--------------080103010002090107010107--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
