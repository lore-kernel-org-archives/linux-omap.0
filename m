From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Mon, 04 Apr 2016 07:41:16 +0300
Message-ID: <8737r27zpv.fsf@intel.com>
References: <20160115224839.GA19432@atomide.com> <569A1E32.1020502@gmail.com> <56F2DF79.6010903@gmail.com> <87fuvgxtc3.fsf@intel.com> <56F3914B.4010206@gmail.com> <87a8loxsdm.fsf@intel.com> <56F4361C.9040907@gmail.com> <877fgkqn8c.fsf@intel.com> <56FBD4BF.6090905@gmail.com> <87h9fohyr1.fsf@intel.com> <56FBDC51.9020602@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56FBDC51.9020602-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>>>>>>>>>>> Looks like there's some issue with the USB gadgets and configfs.
>>>>>>>>>>>
>>>>>>>>>>> I'm seeing rmmod of the UDC driver cause a warning and then reb=
oot
>>>>>>>>>>> hangs the system. This happens at least with v4.4, and I've rep=
roduced
>>>>>>>>>>> it with dwc3 and musb so it seems to be generic.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Having configfs is not needed, disabling usb gadgets (#
>>>>>>>>>> CONFIG_USB_MUSB_GADGET is not set) seems to solved at least powe=
roff
>>>>>>>>>> hang issue on N900. Also, g_nokia is not a module in the config =
I use,
>>>>>>>>>> so I guess the problem is not related whether gadgets are modula=
r or
>>>>>>>>>> not. Unfortunately I was not able to test reboot, as rootfs beca=
me
>>>>>>>>>> corrupted after the first poweroff :( . So it looks like my theo=
ry that
>>>>>>>>>> onenand corruption on N900 is because poweroff/reboot hangs is w=
rong.
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
>>>>>>> <1>[ 1418.683349] pgd =3D c0004000
>>>>>>> <1>[ 1418.739959] [6c6c757a] *pgd=3D00000000
>>>>>>> <0>[ 1418.746307] Internal error: Oops: 5 [#1] PREEMPT ARM
>>>>>>> <4>[ 1418.753997] Modules linked in: sha256_generic hmac drbg ansi_=
cprng
>>>>>>> ctr ccm vfat fat rfcomm sd_mod scsi_mod bnep bluetooth omaplfb pvrs=
rvkm
>>>>>>> ipv6 bq2415x_charger uinput radio_platform_si4713 joydev cmt_speech
>>>>>>> hsi_char video_bus_switch arc4 wl1251_spi wl1251 isp1704_charger
>>>>>>> gpio_keys mac80211 smc91x mii cfg80211 omap_wdt crc7 omap_sham tsc2=
005
>>>>>>> tsc200x_core bq27xxx_battery_i2c si4713 adp1653 tsl2563 leds_lp5523
>>>>>>> leds_lp55xx_common bq27xxx_battery rtc_twl twl4030_wdt et8ek8 ad5820
>>>>>>> v4l2_common smiaregs twl4030_vibra videodev ff_memless lis3lv02d_i2c
>>>>>>> lis3lv02d media input_polldev omap_ssi_port ti_soc_thermal nokia_mo=
dem
>>>>>>> ssi_protocol omap_ssi hsi rx51_battery
>>>>>>> <4>[ 1418.835906] CPU: 0 PID: 53 Comm: file-storage Not tainted
>>>>>>> 4.5.0-rc5+ #59
>>>>>>> <4>[ 1418.846130] Hardware name: Nokia RX-51 board
>>>>>>> <4>[ 1418.853820] task: ceb8a300 ti: ce008000 task.ti: ce008000
>>>>>>> <4>[ 1418.862792] PC is at handle_exception+0xa8/0x418
>>>>>>> <4>[ 1418.871002] LR is at recalc_sigpending+0x18/0x7c
>>>>>>> <4>[ 1418.879241] pc : [<c031d0e4>]    lr : [<c0037b84>]    psr: 80=
000013
>>>>>>> <4>[ 1418.879241] sp : ce009ea0  ip : 00000000  fp : 00000000
>>>>>>> <4>[ 1418.898284] r10: 00000000  r9 : 00000000  r8 : 00000000
>>>>>>> <4>[ 1418.907287] r7 : c031d8d0  r6 : 6c6c7566  r5 : 00000000  r4 :=
 cebe1600
>>>>>>> <4>[ 1418.917663] r3 : 6f642820  r2 : 00000000  r1 : 00000000  r0 :=
 00000000
>>>>>>> <4>[ 1418.928039] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA A=
RM
>>>>>>> Segment none
>>>>>>> <4>[ 1418.939025] Control: 10c5387d  Table: 8e244019  DAC: 00000051
>>>>>>> <0>[ 1418.948516] Process file-storage (pid: 53, stack limit =3D 0x=
ce008210)
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
>>>>>>> <0>[ 1419.135101] Code: 1a000015 ea000040 e5946038 e0866285 (e59630=
14)
>>>>>>> <4>[ 1419.330841] ---[ end trace 3377457e25b0732c ]---
>>>>>>> <0>[ 1419.340972] Kernel panic - not syncing: Fatal exception
>>>>>>>
>>>>>>> weirdly, I have that log only in mtdoops, but not in dmesg. However,
>>>>>>> after that oops "reboot" command does not hang, but reboots the dev=
ice.
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
>>>>> /home/ivo/workspace/linux-upstream/github/fmg/linux-n900/vmlinux...do=
ne.
>>>>> (gdb) l *(handle_exception + 0xa8)
>>>>> 0xc031d0e4 is in handle_exception
>>>>> (drivers/usb/gadget/function/f_mass_storage.c:2373).
>>>>> 2368=09
>>>>> 2369		/* Cancel all the pending transfers */
>>>>> 2370		if (likely(common->fsg)) {
>>>>> 2371			for (i =3D 0; i < common->fsg_num_buffers; ++i) {
>>>>> 2372				bh =3D &common->buffhds[i];
>>>>> 2373				if (bh->inreq_busy)
>>>>
>>>> so this would mean we have a race here where bh->inreq_busy is still s=
et
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

do you call fsg_bind() twice ?

>>> seems to be created twice :). Maybe the problem is that the first time
>>> musb-hdrc is probed it fails with -EPROBE_DEFER, however that failure is
>>> after gadget drivers got loaded and noone unloads them.
>>
>> gadget drivers will get added to a pending list, then later they'll
>> bind. But they shouldn't bind() twice, unless there are multiple
>> interfaces for them.
>>
>
> Well, then it seems we have problem, as the 2 unbind() calls are with=20
> one and the same "common" pointer (again, from memory).

yeah, sounds like we have a problem indeed.

>>> Just some wild guesses based on my memories as I've lost the logs (power
>>> outage). For sure I can recreate them if needed.
>>
>> okay.
>
> I will redo dump_stack() and printks and will provide logs as soon as I=20
> have some time, so to stop counting on my memories.

cool, thanks

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXAfBsAAoJEIaOsuA1yqREyeQP/2WuyVRqOgY52ffh7derVUpy
7WAIUAEqSGlOW2r6CLbNAGSXGUKlZTVUWS1gERq4UycM2Eg79nWjEOgrdRnWXv63
rvz4Zh2F5Ke9+cBKZS+fvR3iKhLFmPa+jl+/J4tcWcq1v8K/cA6/JqFRK0oibK0E
9Xo02vQTK6Fr/Ki5IXGVAhcmN/vO3TsyobrbwTu4l6VziluZAnJ6LES0gOPtEcCk
79OO0VBCTinjhNSelJiliFs+SFBqN5NVRURUMgN7BW8JBfDNaO1tEvE/9EJyeHqO
JghqhV1ENkZan3+kXxwNsLlPVIZb2SPdz6W95uuSWDV4OJfDFhUCV9py7G6GqjsX
Ej5QC5iH/1QEOSvrJq3UKKDYGaDsxtuvbCcJtba9hom4bTptuTyu9YkwuY8Aes5Y
OSJKCNtsuz4JBdOqa4ZBIcbLo3NDT3+mCThAyiF9xHx592UY/l4AMI0n/BiXH9fR
QPkTHX9IGOgJTBA5jUcPny88qbUOA9tahOIJM5YkJGkaqISDUWKYf8OZrELDuuaT
7n3FkQCLcMb64SbqSlwEZFEHcGrKt3+3NJuqaB5Uy2yQKun0xpuwx0AdRXIh970J
yppUvhi9Ig9QI5TmqsunXerA2g0Ufy2OKcIL0OLT9jBVSn7FzfwZk3XiFgdRw3nB
yMme9tJbtTmqJP1AK+TX
=P8ba
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
