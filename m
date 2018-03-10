From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: Nokia N900: v4.16-rc4: oops in iio when grepping sysfs
Date: Sat, 10 Mar 2018 20:19:20 +0900
Message-ID: <CAC5umygQvPHPFt7ek_WpTmYHh_=NnDCGBEB+HcgWZgmRG5Rvxw@mail.gmail.com>
References: <20180309221220.GA15272@amd> <20180309222821.GA16973@kroah.com> <20180309230124.GA17721@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180309230124.GA17721@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg KH <greg@kroah.com>, Jonathan Cameron <jic23@kernel.org>, javier@osg.samsung.com, gregor.boirie@parrot.com, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, Sakari Ailus <sakari.ailus@linux.intel.com>, =?UTF-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, security@kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

2018-03-10 8:01 GMT+09:00 Pavel Machek <pavel@ucw.cz>:
> Hi!
>
>> > Hmm. Looks like there's a lot of fun to be had with sysfs.
>> >
>> >
>> > pavel@n900:~$ uname -a
>> > Linux n900 4.16.0-rc4-59690-g7f84626-dirty #543 Thu Mar 8 19:53:30 CET
>> > 2018 armv7l GNU/Linux
>> >
>> > [  306.402496] bq2415x: command Timer reset
>> > [  312.761322] adp1653 2-0030: Read Addr:03 Val:00 ok
>> > [  313.264129] Unable to handle kernel NULL pointer dereference at
>> > virtual address 00000
>> > 000
>> > [  313.272308] pgd = 01336620
>> > [  313.275146] [00000000] *pgd=800af831, *pte=00000000, *ppte=00000000
>> > [  313.281463] Internal error: Oops: 80000007 [#1] ARM
>> > [  313.286376] Modules linked in:
>> > [  313.289459] CPU: 0 PID: 3584 Comm: grep Tainted: G        W
>> > 4.16.0-rc4-59690-g
>> > 7f84626-dirty #543
>> > [  313.298919] Hardware name: Nokia RX-51 board
>> > [  313.303222] PC is at   (null)
>> > [  313.306213] LR is at iio_ev_state_show+0x38/0x54
>> > [  313.310852] pc : [<00000000>]    lr : [<c05d69c0>]    psr: a0000013
>> > [  313.317169] sp : c7b47e70  ip : c087bb24  fp : 00000001
>> > [  313.322418] r10: cb19e000  r9 : c0857220  r8 : 00001000
>> > [  313.327667] r7 : 00000fff  r6 : cb711c80  r5 : cb19e000  r4 :
>> > 00000000
>> > [  313.334228] r3 : 00000001  r2 : 00000000  r1 : c087b4dc  r0 :
>> > ce584800
>> > [  313.340789] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
>> > Segment none
>> > [  313.347991] Control: 10c5387d  Table: 87bec019  DAC: 00000051
>> > [  313.353759] Process grep (pid: 3584, stack limit = 0xc4e45eab)
>> > [  313.359619] Stack: (0xc7b47e70 to 0xc7b48000)
>> > [  313.364013] 7e60:                                     c05d6988
>> > cb711b00 ce585c00 c0450d68
>> > [  313.471038] [<c05d69c0>] (iio_ev_state_show) from [<c0450d68>]
>> > (dev_attr_show+0x1c/0x4c)
>> > [  313.479187] [<c0450d68>] (dev_attr_show) from [<c023f934>]
>> > (sysfs_kf_seq_show+0x90/0x108)
>> > [  313.487426] [<c023f934>] (sysfs_kf_seq_show) from [<c023e2f8>]
>> > (kernfs_seq_show+0x24/0x28)
>> > [  313.495758] [<c023e2f8>] (kernfs_seq_show) from [<c01fc954>]
>> > (seq_read+0x1dc/0x500)
>> > [  313.503479] [<c01fc954>] (seq_read) from [<c01d9f80>]
>> > (__vfs_read+0x2c/0x120)
>> > [  313.510681] [<c01d9f80>] (__vfs_read) from [<c01da0fc>]
>> > (vfs_read+0x88/0x114)
>> > [  313.517852] [<c01da0fc>] (vfs_read) from [<c01da584>]
>> > (SyS_read+0x40/0x8c)
>> > [  313.524780] [<c01da584>] (SyS_read) from [<c0101000>]
>> > (ret_fast_syscall+0x0/0x54)
>> > [  313.532318] Exception stack(0xc7b47fa8 to 0xc7b47ff0)
>> > [  313.537414] 7fa0:                   00035330 00042000 00000003
>> > 00042000 00008000 00008000
>> >
>>
>> What file are you opening to cause this?
>
> Strace says:
>
> openat(7, "in_intensity_both_thresh_rising_en",
>> > O_RDONLY|O_LARGEFILE|O_NOFOLLOW) = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=4096, ...}) = 0
> ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbe83b714) = -1 ENOTTY
>> > (Inappropriate ioctl for device)
> read(3,
> Message from syslogd@localhost at Mar  9 23:54:39 ...
>  kernel:[ 3097.357696] Internal error: Oops: 80000007 [#2] ARM
>
> So that would be:
>
> ./devices/platform/68000000.ocp/48072000.i2c/i2c-2/2-0029/iio:device1/events/in_intensity_both_thresh_rising_en
>
> And indeed, manually cat-ing that file reproduces the problem.

This problem happens when no irq is defined for this device.

In this case, tsl2563_info_no_irq whose read_event_config field is NULL
is selected as iio_info.  On the other hand, iio_chan_spec for this
driver always registers event_spec.

So sysfs files related to the channel events are always created even if
no irq is defined.

I think we can fix this issue by defining another iio_chan_spec with
no event_spec for no irq case.

Jonathan, do you have any other idea how to fix this issue?
