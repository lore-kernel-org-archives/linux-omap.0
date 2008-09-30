From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: Soft lockup when disconnecting musb isochronous device.
Date: Tue, 30 Sep 2008 20:08:28 +0200
Message-ID: <33E3735F-CE59-46DF-B601-189448DAE766@student.utwente.nl>
References: <e5e6ade50809260951g50c3d55cn71ce7e7a04803184@mail.gmail.com> <19F8576C6E063C45BE387C64729E739403DC1A61CA@dbde02.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1--322227104"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:60098 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052AbYI3SIs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Sep 2008 14:08:48 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E739403DC1A61CA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: Nathan Monson <nmonson@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1--322227104
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 30 sep 2008, om 08:03 heeft Gupta, Ajay Kumar het volgende  
geschreven:

>> I've been trying to get the UVC camera driver working in linux-omap  
>> on
>> the Beagleboard, which uses musb.  With the latest linux-omap git,
>> capture doesn't work.  Applying Ajay Gupta's MUSB patches posted here
>> on 9/8 allows capture to work until the device is closed.
>> With or without Ajay's patches, when the device is closed, the
>> following lockup occurs.  Let me know if there is anything I can do  
>> to
>> help debug this.
>
> Have you applied below patch posted on 25/08/2008?
> [PATCH v3] OMAP: MUSB: Corrects urb unlink function path

That patch isn't applied in the uImage Nathan is using, I'm adding it  
to the patchqueue and will build a new uImage[1]

regards,

Koen

[1] When I can access my buildmachine again, *$(*$(#@*$ rain

>
>
> This patch is accepted and is pending to be merged with latest OMAP  
> GIT.
>
> Regards,
> Ajay
>
>
> BUG: soft lockup - CPU#0 stuck for 61s! [mjpg_streamer:1770]
> Modules linked in: ipv6 pegasus uvcvideo compat_ioctl32 videodev  
> v4l1_compat
>
> Pid: 1770, comm:        mjpg_streamer
> CPU: 0    Not tainted  (2.6.27-rc7-omap1 #4)
> PC is at __mutex_lock_slowpath+0x1ec/0x204
> LR is at __mutex_lock_slowpath+0x1c4/0x204
> pc : [<c0320fa0>]    lr : [<c0320f78>]    psr: 60000013
> sp : c7265ca0  ip : c7265ca0  fp : c7265cd4
> r10: c79eb400  r9 : c7128218  r8 : c78a6a08
> r7 : c78df9c0  r6 : 60000013  r5 : c0437690  r4 : c7265ca4
> r3 : 00000000  r2 : 00000000  r1 : c7264000  r0 : c0437690
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 00c5387f  Table: 87348018  DAC: 00000015
> [<c0034ca8>] (show_regs+0x0/0x50) from [<c007959c>]
> (softlockup_tick+0x100/0x140)
> r5:000000bc r4:0000007f
> [<c007949c>] (softlockup_tick+0x0/0x140) from [<c005c08c>]
> (run_local_timers+0x1c/0x20)
> [<c005c070>] (run_local_timers+0x0/0x20) from [<c005c4e8>]
> (update_process_times+0x30/0x5c)
> [<c005c4b8>] (update_process_times+0x0/0x5c) from [<c006f138>]
> (tick_sched_timer+0x8c/0xd8)
> r5:c7265c58 r4:c044d630
> [<c006f0ac>] (tick_sched_timer+0x0/0xd8) from [<c0069090>]
> (__run_hrtimer+0x58/0x94)
> r7:c0425e60 r6:c044d630 r5:c0425e60 r4:c044d630
> [<c0069038>] (__run_hrtimer+0x0/0x94) from [<c0069c64>]
> (hrtimer_interrupt+0x130/0x1a0)
> r5:000000b9 r4:183847b0
> [<c0069b34>] (hrtimer_interrupt+0x0/0x1a0) from [<c003d248>]
> (omap2_gp_timer_interrupt+0x28/0x34)
> [<c003d220>] (omap2_gp_timer_interrupt+0x0/0x34) from [<c0079a58>]
> (handle_IRQ_event+0x3c/0x74)
> [<c0079a1c>] (handle_IRQ_event+0x0/0x74) from [<c007b2a4>]
> (handle_level_irq+0xd4/0xf0)
> r7:c78df9c0 r6:00000000 r5:0000005f r4:c04279a8
> [<c007b1d0>] (handle_level_irq+0x0/0xf0) from [<c0033048>]
> (__exception_text_start+0x48/0x64)
> r5:c04279a8 r4:0000005f
> [<c0033000>] (__exception_text_start+0x0/0x64) from [<c0033830>]
> (__irq_svc+0x30/0x80)
> Exception stack(0xc7265c58 to 0xc7265ca0)
> 5c40:                                                       c0437690  
> c7264000
> 5c60: 00000000 00000000 c7265ca4 c0437690 60000013 c78df9c0 c78a6a08  
> c7128218
> 5c80: c79eb400 c7265cd4 c7265ca0 c7265ca0 c0320f78 c0320fa0 60000013  
> ffffffff
> r7:c78df9c0 r6:60000013 r5:d8200000 r4:ffffffff
> [<c0320db4>] (__mutex_lock_slowpath+0x0/0x204) from [<c0320fc8>]
> (mutex_lock+0x10/0x14)
> r7:c7893000 r6:c7170c00 r5:c7170c00 r4:c791c738
> [<c0320fb8>] (mutex_lock+0x0/0x14) from [<c01ed760>] (usb_kill_urb 
> +0x38/0x104)
> [<c01ed728>] (usb_kill_urb+0x0/0x104) from [<c01ece30>]
> (usb_hcd_flush_endpoint+0xb0/0xcc)
> r6:c791c740 r5:c7170c00 r4:c791c738
> [<c01ecd80>] (usb_hcd_flush_endpoint+0x0/0xcc) from [<c01ee044>]
> (usb_disable_endpoint+0x5c/0x6c)
> r7:c7893000 r6:c78a6a40 r5:c7893000 r4:c791c740
> [<c01edfe8>] (usb_disable_endpoint+0x0/0x6c) from [<c01ee180>]
> (usb_disable_interface+0x34/0x4c)
> r5:00000028 r4:00000001
> [<c01ee14c>] (usb_disable_interface+0x0/0x4c) from [<c01ef4e0>]
> (usb_set_interface+0xec/0x178)
> r7:00000001 r6:00000000 r5:c7893000 r4:c78a6e00
> [<c01ef3f4>] (usb_set_interface+0x0/0x178) from [<bf014c48>]
> (uvc_video_enable+0x3c/0x74 [uvcvideo])
> r8:c721c050 r7:c7265e68 r6:c721c094 r5:00000000 r4:c721c050
> [<bf014c0c>] (uvc_video_enable+0x0/0x74 [uvcvideo]) from [<bf014308>]
> (uvc_v4l2_do_ioctl+0xce4/0xf50 [uvcvideo])
> r7:c7265e68 r6:c79f9e00 r5:c78d4760 r4:40045613
> [<bf013624>] (uvc_v4l2_do_ioctl+0x0/0xf50 [uvcvideo]) from
> [<bf008e20>] (video_usercopy+0x1b8/0x2b8 [videodev])
> [<bf008c68>] (video_usercopy+0x0/0x2b8 [videodev]) from [<bf012fdc>]
> (uvc_v4l2_ioctl+0x54/0x68 [uvcvideo])
> [<bf012f88>] (uvc_v4l2_ioctl+0x0/0x68 [uvcvideo]) from [<c00ace28>]
> (vfs_ioctl+0x68/0x78)
> r7:c79eb400 r6:00000003 r5:40c78ccc r4:40045613
> [<c00acdc0>] (vfs_ioctl+0x0/0x78) from [<c00ad0a8>] (do_vfs_ioctl 
> +0x270/0x280)
> r5:40c78ccc r4:c79eb400
> [<c00ace38>] (do_vfs_ioctl+0x0/0x280) from [<c00ad0f8>] (sys_ioctl 
> +0x40/0x64)
> r7:c79eb400 r6:40045613 r5:40c78ccc r4:00000003
> [<c00ad0b8>] (sys_ioctl+0x0/0x64) from [<c0033c80>] (ret_fast_syscall 
> +0x0/0x2c)
>
> - Nathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-1--322227104
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI4mshMkyGM64RGpERAiHPAJ40h+UGRDo7QdsnPq/Gg8c7hZIjiQCeJGqR
SA4qnguLXczOBOcfccLYDdc=
=gwne
-----END PGP SIGNATURE-----

--Apple-Mail-1--322227104--
