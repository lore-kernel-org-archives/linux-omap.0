From: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Wed, 30 Mar 2016 21:54:37 +0300
Message-ID: <56FC20ED.9090403@gmail.com>
References: <20160115224839.GA19432@atomide.com> <569A1E32.1020502@gmail.com>
 <56F2DF79.6010903@gmail.com> <87fuvgxtc3.fsf@intel.com>
 <56F3914B.4010206@gmail.com> <87a8loxsdm.fsf@intel.com>
 <56F4361C.9040907@gmail.com> <877fgkqn8c.fsf@intel.com>
 <56FBD4BF.6090905@gmail.com> <87h9fohyr1.fsf@intel.com>
 <56FBDC51.9020602@gmail.com> <56FC1FD8.6090003@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070104020500080907060100"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56FC1FD8.6090003-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, =?UTF-8?Q?pali_Roh=c3=a1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------070104020500080907060100
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30.03.2016 21:50, Ivaylo Dimitrov wrote:
>
>
> On 30.03.2016 17:01, Ivaylo Dimitrov wrote:
>>
>>
>> On 30.03.2016 16:38, Felipe Balbi wrote:
>>>
>>> Hi,
>>>
>>> Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>>>>> Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>>>>>>> Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>>>>>>>>> Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>>>>>>>>>> On 16.01.2016 12:40, Ivaylo Dimitrov wrote:
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> On 16.01.2016 00:48, Tony Lindgren wrote:
>>>>>>>>>>>> Hi all,
>>>>>>>>>>>>
>>>>>>>>>>>> Looks like there's some issue with the USB gadgets and
>>>>>>>>>>>> configfs.
>>>>>>>>>>>>
>>>>>>>>>>>> I'm seeing rmmod of the UDC driver cause a warning and then
>>>>>>>>>>>> reboot
>>>>>>>>>>>> hangs the system. This happens at least with v4.4, and I've
>>>>>>>>>>>> reproduced
>>>>>>>>>>>> it with dwc3 and musb so it seems to be generic.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Having configfs is not needed, disabling usb gadgets (#
>>>>>>>>>>> CONFIG_USB_MUSB_GADGET is not set) seems to solved at least
>>>>>>>>>>> poweroff
>>>>>>>>>>> hang issue on N900. Also, g_nokia is not a module in the
>>>>>>>>>>> config I use,
>>>>>>>>>>> so I guess the problem is not related whether gadgets are
>>>>>>>>>>> modular or
>>>>>>>>>>> not. Unfortunately I was not able to test reboot, as rootfs
>>>>>>>>>>> became
>>>>>>>>>>> corrupted after the first poweroff :( . So it looks like my
>>>>>>>>>>> theory that
>>>>>>>>>>> onenand corruption on N900 is because poweroff/reboot hangs is
>>>>>>>>>>> wrong.
>>>>>>>>>>>
>>>>>>>>>>> Ivo
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Is there any progress on the issue?
>>>>>>>>>
>>>>>>>>
>>>>>>>> Doing Nokia-N900:/sys/bus/platform/drivers/musb-hdrc# echo
>>>>>>>> musb-hdrc.0.auto > unbind results in:
>>>>>>>>
>>>>>>>> <1>[ 1418.511260] Unable to handle kernel paging request at virtual
>>>>>>>> address 6c6c757a
>>>>>>>> <7>[ 1418.677215] pvr: Xorg: cleaning up 49 unfreed resources
>>>>>>>> <1>[ 1418.683349] pgd = c0004000
>>>>>>>> <1>[ 1418.739959] [6c6c757a] *pgd=00000000
>>>>>>>> <0>[ 1418.746307] Internal error: Oops: 5 [#1] PREEMPT ARM
>>>>>>>> <4>[ 1418.753997] Modules linked in: sha256_generic hmac drbg
>>>>>>>> ansi_cprng
>>>>>>>> ctr ccm vfat fat rfcomm sd_mod scsi_mod bnep bluetooth omaplfb
>>>>>>>> pvrsrvkm
>>>>>>>> ipv6 bq2415x_charger uinput radio_platform_si4713 joydev cmt_speech
>>>>>>>> hsi_char video_bus_switch arc4 wl1251_spi wl1251 isp1704_charger
>>>>>>>> gpio_keys mac80211 smc91x mii cfg80211 omap_wdt crc7 omap_sham
>>>>>>>> tsc2005
>>>>>>>> tsc200x_core bq27xxx_battery_i2c si4713 adp1653 tsl2563 leds_lp5523
>>>>>>>> leds_lp55xx_common bq27xxx_battery rtc_twl twl4030_wdt et8ek8
>>>>>>>> ad5820
>>>>>>>> v4l2_common smiaregs twl4030_vibra videodev ff_memless
>>>>>>>> lis3lv02d_i2c
>>>>>>>> lis3lv02d media input_polldev omap_ssi_port ti_soc_thermal
>>>>>>>> nokia_modem
>>>>>>>> ssi_protocol omap_ssi hsi rx51_battery
>>>>>>>> <4>[ 1418.835906] CPU: 0 PID: 53 Comm: file-storage Not tainted
>>>>>>>> 4.5.0-rc5+ #59
>>>>>>>> <4>[ 1418.846130] Hardware name: Nokia RX-51 board
>>>>>>>> <4>[ 1418.853820] task: ceb8a300 ti: ce008000 task.ti: ce008000
>>>>>>>> <4>[ 1418.862792] PC is at handle_exception+0xa8/0x418
>>>>>>>> <4>[ 1418.871002] LR is at recalc_sigpending+0x18/0x7c
>>>>>>>> <4>[ 1418.879241] pc : [<c031d0e4>]    lr : [<c0037b84>]    psr:
>>>>>>>> 80000013
>>>>>>>> <4>[ 1418.879241] sp : ce009ea0  ip : 00000000  fp : 00000000
>>>>>>>> <4>[ 1418.898284] r10: 00000000  r9 : 00000000  r8 : 00000000
>>>>>>>> <4>[ 1418.907287] r7 : c031d8d0  r6 : 6c6c7566  r5 : 00000000  r4
>>>>>>>> : cebe1600
>>>>>>>> <4>[ 1418.917663] r3 : 6f642820  r2 : 00000000  r1 : 00000000  r0
>>>>>>>> : 00000000
>>>>>>>> <4>[ 1418.928039] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA
>>>>>>>> ARM
>>>>>>>> Segment none
>>>>>>>> <4>[ 1418.939025] Control: 10c5387d  Table: 8e244019  DAC: 00000051
>>>>>>>> <0>[ 1418.948516] Process file-storage (pid: 53, stack limit =
>>>>>>>> 0xce008210)
>>>>>>>> <0>[ 1418.958679] Stack: (0xce009ea0 to 0xce00a000)
>>>>>>>> <0>[ 1418.966735] 9ea0: 0000000f 00000000 00000000 00000b07
>>>>>>>> 00000000
>>>>>>>> 00000001 000003ff 00000001
>>>>>>>> <0>[ 1418.978973] 9ec0: ceb8a300 ceb8a300 00000000 c004841c
>>>>>>>> 00000000
>>>>>>>> 00000002 ce888000 c0451a50
>>>>>>>> <0>[ 1418.991180] 9ee0: ffffffff 00000000 00000000 00000008
>>>>>>>> cebe1600
>>>>>>>> 00000001 c0717dd0 00000001
>>>>>>>> <0>[ 1419.003387] 9f00: 00000000 00000000 ce009f14 c044ddf4
>>>>>>>> 00000000
>>>>>>>> c031c020 00000042 ce009f30
>>>>>>>> <0>[ 1419.015686] 9f20: ce009f30 00000000 cebe1600 c031d958
>>>>>>>> 00000000
>>>>>>>> c044d864 a0000013 00000000
>>>>>>>> <0>[ 1419.027923] 9f40: cebe1600 c031d8d0 cebfa100 cebfa100
>>>>>>>> 00000000
>>>>>>>> cebe1600 c031d8d0 00000000
>>>>>>>> <0>[ 1419.040130] 9f60: 00000000 00000000 00000000 c00474e4
>>>>>>>> dc4d900d
>>>>>>>> 00000000 31bc92e7 cebe1600
>>>>>>>> <0>[ 1419.052429] 9f80: 00000000 ce009f84 ce009f84 00000000
>>>>>>>> ce009f90
>>>>>>>> ce009f90 ce009fac cebfa100
>>>>>>>> <0>[ 1419.064697] 9fa0: c0047418 00000000 00000000 c000f218
>>>>>>>> 00000000
>>>>>>>> 00000000 00000000 00000000
>>>>>>>> <0>[ 1419.076934] 9fc0: 00000000 00000000 00000000 00000000
>>>>>>>> 00000000
>>>>>>>> 00000000 00000000 00000000
>>>>>>>> <0>[ 1419.089050] 9fe0: 00000000 00000000 00000000 00000000
>>>>>>>> 00000013
>>>>>>>> 00000000 00002000 30000891
>>>>>>>> <4>[ 1419.101043] [<c031d0e4>] (handle_exception) from [<c031d958>]
>>>>>>>> (fsg_main_thread+0x88/0x13dc)
>>>>>>>> <4>[ 1419.113189] [<c031d958>] (fsg_main_thread) from [<c00474e4>]
>>>>>>>> (kthread+0xcc/0xe0)
>>>>>>>> <4>[ 1419.124267] [<c00474e4>] (kthread) from [<c000f218>]
>>>>>>>> (ret_from_fork+0x14/0x3c)
>>>>>>>> <0>[ 1419.135101] Code: 1a000015 ea000040 e5946038 e0866285
>>>>>>>> (e5963014)
>>>>>>>> <4>[ 1419.330841] ---[ end trace 3377457e25b0732c ]---
>>>>>>>> <0>[ 1419.340972] Kernel panic - not syncing: Fatal exception
>>>>>>>>
>>>>>>>> weirdly, I have that log only in mtdoops, but not in dmesg.
>>>>>>>> However,
>>>>>>>> after that oops "reboot" command does not hang, but reboots the
>>>>>>>> device.
>>>>>>>
>>>>>>>
>>>>>>> So, what is handle_exception + 0xa8 ? You can figure that out either
>>>>>>> with gdb or addr2line assuming your vmlinux has dbg symbols.
>>>>>>>
>>>>>>> For gdb you would:
>>>>>>>
>>>>>>> gdb vmlinux
>>>>>>> (gdb) l *(handle_exception + 0xa8)
>>>>>>>
>>>>>>
>>>>>> Yeah, sorry I didn't do it with the previous mail.
>>>>>>
>>>>>> Reading symbols from
>>>>>> /home/ivo/workspace/linux-upstream/github/fmg/linux-n900/vmlinux...done.
>>>>>>
>>>>>>
>>>>>> (gdb) l *(handle_exception + 0xa8)
>>>>>> 0xc031d0e4 is in handle_exception
>>>>>> (drivers/usb/gadget/function/f_mass_storage.c:2373).
>>>>>> 2368
>>>>>> 2369        /* Cancel all the pending transfers */
>>>>>> 2370        if (likely(common->fsg)) {
>>>>>> 2371            for (i = 0; i < common->fsg_num_buffers; ++i) {
>>>>>> 2372                bh = &common->buffhds[i];
>>>>>> 2373                if (bh->inreq_busy)
>>>>>
>>>>> so this would mean we have a race here where bh->inreq_busy is still
>>>>> set
>>>>> while bh->inreq was already freed, right ? I'll try to reproduce this
>>>>> with dwc3 and let you know.
>>>>>
>>>>
>>>> I am not sure this is the case, what I see here is fsg_bind() and
>>>> fsg_unbind() called twice - "musb-hdrc loaded" -> fsg_bind() ->
>>>> fsg_bind(), "musb-hdrc unbind through sysfs" -> fsg_unbind() ->
>>>> fsg_unbind(). That seems to come from g_nokia being probed
>>>> (successfully) twice. No idea if this is normal - IIUC fsg main thread
>>>
>>> do you have two interfaces with mass storage ?
>>>
>>
>> There are 2 LUNs, not sure what you mean by 2 interfaces.
>>
>> Pali ^^^ ?
>>
>>>> seems to be created twice :). Maybe the problem is that the first time
>>>> musb-hdrc is probed it fails with -EPROBE_DEFER, however that
>>>> failure is
>>>> after gadget drivers got loaded and noone unloads them.
>>>
>>> gadget drivers will get added to a pending list, then later they'll
>>> bind. But they shouldn't bind() twice, unless there are multiple
>>> interfaces for them.
>>>
>>
>> Well, then it seems we have problem, as the 2 unbind() calls are with
>> one and the same "common" pointer (again, from memory).
>>
>>>> Just some wild guesses based on my memories as I've lost the logs
>>>> (power
>>>> outage). For sure I can recreate them if needed.
>>>
>>> okay.
>>
>> I will redo dump_stack() and printks and will provide logs as soon as I
>> have some time, so to stop counting on my memories.
>>
>
> Please find attached the relevant logs. It really seems that g_nokia is
> probed twice, with all the gadgets in it created two times. I am
> starting to suspect 855ed04a3758b205e84b269f92d26ab36ed8e2f7 ("usb:
> gadget: udc-core: independent registration of gadgets and gadget
> drivers") has something to do with the problem, though reverting it
> resulted in g_nokia not being probed at all :)
>
> Ivo

Sorry, forgot to attach the patch used to produce the log

--------------070104020500080907060100
Content-Type: text/x-diff;
 name="fsg.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fsg.diff"

diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index acf210f..0a29d84 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -2351,6 +2351,8 @@ static void handle_exception(struct fsg_common *common)
 	struct fsg_lun		*curlun;
 	unsigned int		exception_req_tag;
 
+	pr_err("%s %d current %p\n", __func__, __LINE__, current);
+
 	/*
 	 * Clear the existing signals.  Anything but SIGUSR1 is converted
 	 * into a high-priority EXIT exception.
@@ -2368,8 +2370,12 @@ static void handle_exception(struct fsg_common *common)
 
 	/* Cancel all the pending transfers */
 	if (likely(common->fsg)) {
+		pr_err("%s %d current %p common->fsg_num_buffers %d\n",
+		       __func__, __LINE__, current, common->fsg_num_buffers);
 		for (i = 0; i < common->fsg_num_buffers; ++i) {
 			bh = &common->buffhds[i];
+			pr_err("%s %d bh %p\n", __func__, __LINE__, bh);
+			msleep(2000);
 			if (bh->inreq_busy)
 				usb_ep_dequeue(common->fsg->bulk_in, bh->inreq);
 			if (bh->outreq_busy)
@@ -2377,6 +2383,8 @@ static void handle_exception(struct fsg_common *common)
 					       bh->outreq);
 		}
 
+		pr_err("%s %d current %p\n", __func__, __LINE__, current);
+
 		/* Wait until everything is idle */
 		for (;;) {
 			int num_active = 0;
@@ -2397,6 +2405,8 @@ static void handle_exception(struct fsg_common *common)
 			usb_ep_fifo_flush(common->fsg->bulk_out);
 	}
 
+	pr_err("%s %d current %p\n", __func__, __LINE__, current);
+
 	/*
 	 * Reset the I/O buffer states and pointers, the SCSI
 	 * state, and the exception.  Then invoke the handler.
@@ -2487,6 +2497,10 @@ static void handle_exception(struct fsg_common *common)
 	case FSG_STATE_IDLE:
 		break;
 	}
+
+	pr_err("%s %d current %p common->state %d\n", __func__, __LINE__,
+	       current, common->state);
+
 }
 
 
@@ -2515,6 +2529,8 @@ static int fsg_main_thread(void *common_)
 	 */
 	set_fs(get_ds());
 
+	pr_err("%s %d current %p\n", __func__, __LINE__, current);
+
 	/* The main loop */
 	while (common->state != FSG_STATE_TERMINATED) {
 		if (exception_in_progress(common) || signal_pending(current)) {
@@ -2527,6 +2543,8 @@ static int fsg_main_thread(void *common_)
 			continue;
 		}
 
+		pr_err("%s %d current %p\n", __func__, __LINE__, current);
+
 		if (get_next_command(common))
 			continue;
 
@@ -2572,6 +2590,8 @@ static int fsg_main_thread(void *common_)
 		up_write(&common->filesem);
 	}
 
+	pr_err("%s %d current %p\n", __func__, __LINE__, current);
+
 	/* Let fsg_unbind() know the thread has exited */
 	complete_and_exit(&common->thread_notifier, 0);
 }
@@ -2979,6 +2999,8 @@ EXPORT_SYMBOL_GPL(fsg_common_set_inquiry_string);
 
 int fsg_common_run_thread(struct fsg_common *common)
 {
+	pr_err("%s %d common->state %d common->thread_task %p\n", __func__,
+	       __LINE__, common->state, common->thread_task);
 	common->state = FSG_STATE_IDLE;
 	/* Tell the thread to start working */
 	common->thread_task =
@@ -3036,6 +3058,8 @@ static int fsg_bind(struct usb_configuration *c, struct usb_function *f)
 	int			ret;
 	struct fsg_opts		*opts;
 
+	dump_stack();
+	pr_err("%s %d common %p\n", __func__, __LINE__, common);
 	/* Don't allow to bind if we don't have at least one LUN */
 	ret = _fsg_common_get_max_lun(common);
 	if (ret < 0) {
@@ -3118,6 +3142,10 @@ static void fsg_unbind(struct usb_configuration *c, struct usb_function *f)
 	struct fsg_dev		*fsg = fsg_from_func(f);
 	struct fsg_common	*common = fsg->common;
 
+	dump_stack();
+	pr_err("%s %d common %p common->fsg %p fsg %p\n", __func__, __LINE__,
+	       common, common->fsg, fsg);
+
 	DBG(fsg, "unbind\n");
 	if (fsg->common->fsg == fsg) {
 		fsg->common->new_fsg = NULL;

--------------070104020500080907060100--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
