From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Thu, 24 Mar 2016 09:11:17 +0200
Message-ID: <87a8loxsdm.fsf@intel.com>
References: <20160115224839.GA19432@atomide.com> <569A1E32.1020502@gmail.com> <56F2DF79.6010903@gmail.com> <87fuvgxtc3.fsf@intel.com> <56F3914B.4010206@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56F3914B.4010206-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>> Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>>> On 16.01.2016 12:40, Ivaylo Dimitrov wrote:
>>>> Hi,
>>>>
>>>> On 16.01.2016 00:48, Tony Lindgren wrote:
>>>>> Hi all,
>>>>>
>>>>> Looks like there's some issue with the USB gadgets and configfs.
>>>>>
>>>>> I'm seeing rmmod of the UDC driver cause a warning and then reboot
>>>>> hangs the system. This happens at least with v4.4, and I've reproduced
>>>>> it with dwc3 and musb so it seems to be generic.
>>>>>
>>>>
>>>> Having configfs is not needed, disabling usb gadgets (#
>>>> CONFIG_USB_MUSB_GADGET is not set) seems to solved at least poweroff
>>>> hang issue on N900. Also, g_nokia is not a module in the config I use,
>>>> so I guess the problem is not related whether gadgets are modular or
>>>> not. Unfortunately I was not able to test reboot, as rootfs became
>>>> corrupted after the first poweroff :( . So it looks like my theory that
>>>> onenand corruption on N900 is because poweroff/reboot hangs is wrong.
>>>>
>>>> Ivo
>>>
>>>
>>> Is there any progress on the issue?
>>
>
> Doing Nokia-N900:/sys/bus/platform/drivers/musb-hdrc# echo=20
> musb-hdrc.0.auto > unbind results in:
>
> <1>[ 1418.511260] Unable to handle kernel paging request at virtual=20
> address 6c6c757a
> <7>[ 1418.677215] pvr: Xorg: cleaning up 49 unfreed resources
> <1>[ 1418.683349] pgd =3D c0004000
> <1>[ 1418.739959] [6c6c757a] *pgd=3D00000000
> <0>[ 1418.746307] Internal error: Oops: 5 [#1] PREEMPT ARM
> <4>[ 1418.753997] Modules linked in: sha256_generic hmac drbg ansi_cprng=
=20
> ctr ccm vfat fat rfcomm sd_mod scsi_mod bnep bluetooth omaplfb pvrsrvkm=20
> ipv6 bq2415x_charger uinput radio_platform_si4713 joydev cmt_speech=20
> hsi_char video_bus_switch arc4 wl1251_spi wl1251 isp1704_charger=20
> gpio_keys mac80211 smc91x mii cfg80211 omap_wdt crc7 omap_sham tsc2005=20
> tsc200x_core bq27xxx_battery_i2c si4713 adp1653 tsl2563 leds_lp5523=20
> leds_lp55xx_common bq27xxx_battery rtc_twl twl4030_wdt et8ek8 ad5820=20
> v4l2_common smiaregs twl4030_vibra videodev ff_memless lis3lv02d_i2c=20
> lis3lv02d media input_polldev omap_ssi_port ti_soc_thermal nokia_modem=20
> ssi_protocol omap_ssi hsi rx51_battery
> <4>[ 1418.835906] CPU: 0 PID: 53 Comm: file-storage Not tainted=20
> 4.5.0-rc5+ #59
> <4>[ 1418.846130] Hardware name: Nokia RX-51 board
> <4>[ 1418.853820] task: ceb8a300 ti: ce008000 task.ti: ce008000
> <4>[ 1418.862792] PC is at handle_exception+0xa8/0x418
> <4>[ 1418.871002] LR is at recalc_sigpending+0x18/0x7c
> <4>[ 1418.879241] pc : [<c031d0e4>]    lr : [<c0037b84>]    psr: 80000013
> <4>[ 1418.879241] sp : ce009ea0  ip : 00000000  fp : 00000000
> <4>[ 1418.898284] r10: 00000000  r9 : 00000000  r8 : 00000000
> <4>[ 1418.907287] r7 : c031d8d0  r6 : 6c6c7566  r5 : 00000000  r4 : cebe1=
600
> <4>[ 1418.917663] r3 : 6f642820  r2 : 00000000  r1 : 00000000  r0 : 00000=
000
> <4>[ 1418.928039] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM=20
> Segment none
> <4>[ 1418.939025] Control: 10c5387d  Table: 8e244019  DAC: 00000051
> <0>[ 1418.948516] Process file-storage (pid: 53, stack limit =3D 0xce0082=
10)
> <0>[ 1418.958679] Stack: (0xce009ea0 to 0xce00a000)
> <0>[ 1418.966735] 9ea0: 0000000f 00000000 00000000 00000b07 00000000=20
> 00000001 000003ff 00000001
> <0>[ 1418.978973] 9ec0: ceb8a300 ceb8a300 00000000 c004841c 00000000=20
> 00000002 ce888000 c0451a50
> <0>[ 1418.991180] 9ee0: ffffffff 00000000 00000000 00000008 cebe1600=20
> 00000001 c0717dd0 00000001
> <0>[ 1419.003387] 9f00: 00000000 00000000 ce009f14 c044ddf4 00000000=20
> c031c020 00000042 ce009f30
> <0>[ 1419.015686] 9f20: ce009f30 00000000 cebe1600 c031d958 00000000=20
> c044d864 a0000013 00000000
> <0>[ 1419.027923] 9f40: cebe1600 c031d8d0 cebfa100 cebfa100 00000000=20
> cebe1600 c031d8d0 00000000
> <0>[ 1419.040130] 9f60: 00000000 00000000 00000000 c00474e4 dc4d900d=20
> 00000000 31bc92e7 cebe1600
> <0>[ 1419.052429] 9f80: 00000000 ce009f84 ce009f84 00000000 ce009f90=20
> ce009f90 ce009fac cebfa100
> <0>[ 1419.064697] 9fa0: c0047418 00000000 00000000 c000f218 00000000=20
> 00000000 00000000 00000000
> <0>[ 1419.076934] 9fc0: 00000000 00000000 00000000 00000000 00000000=20
> 00000000 00000000 00000000
> <0>[ 1419.089050] 9fe0: 00000000 00000000 00000000 00000000 00000013=20
> 00000000 00002000 30000891
> <4>[ 1419.101043] [<c031d0e4>] (handle_exception) from [<c031d958>]=20
> (fsg_main_thread+0x88/0x13dc)
> <4>[ 1419.113189] [<c031d958>] (fsg_main_thread) from [<c00474e4>]=20
> (kthread+0xcc/0xe0)
> <4>[ 1419.124267] [<c00474e4>] (kthread) from [<c000f218>]=20
> (ret_from_fork+0x14/0x3c)
> <0>[ 1419.135101] Code: 1a000015 ea000040 e5946038 e0866285 (e5963014)
> <4>[ 1419.330841] ---[ end trace 3377457e25b0732c ]---
> <0>[ 1419.340972] Kernel panic - not syncing: Fatal exception
>
> weirdly, I have that log only in mtdoops, but not in dmesg. However,=20
> after that oops "reboot" command does not hang, but reboots the device.


So, what is handle_exception + 0xa8 ? You can figure that out either
with gdb or addr2line assuming your vmlinux has dbg symbols.

For gdb you would:

gdb vmlinux
(gdb) l *(handle_exception + 0xa8)

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW85MVAAoJEIaOsuA1yqREn1cQAI+oA9VkxEQQF0tnBbh5vmbd
oTeENcNto7V7XMhuL+VlugnzDD22udF12FGCDDQv1cifLjYzg+puNyxsVMpQgnpu
DWzcfCgvgfFX+DdofHTryupDgaVhKdykYzBliJEvP1M3GIz4VODJWX7bnAstBY4Q
RoNVuJX/nb0d0ByMZX9otW0lLGmBzg1dFc6gBU99dxZOVjZ7sIvLb0pi9SR7v/A6
NP/TXSjK89LR8H/yU2T+2v/mOT/O3IlqZTCso0uGyPJ1ucT9GyaapPVuJOVQGv+u
Ysz4fV6yICTaCA0oaHB4iqos9/tZuqQviryqExQAxOAZq5eEEooB7C7ChnaySJs4
YR93sWToXA7jFjjVQn6E7zzfzI+jrgZ3k27ZNlr63XVvLBlD/BHazUCXAeQ9FIq/
V3gR3dNTncf19DOuCSdBLoqfquzP14+LsPXoq5JA/SjBWqGxTSbqDR1vkWTUHNAC
9kXJjc1jDm1SdjT+IJ2m4726PUVoCyscB/rQjf+P/wns4xSwiSYtRheH4FuGsBmb
k0l/xq67Gi/ZOdsJ/BViB8pwMI2/xHgzkhLYYcrvXC2GME2sy/nc+ewiN+kbaYgS
LpRJTmrXOTRZg+CcdGrOpV5ZCGkJMi9xchA3j2mfW7lrn6y2Hl6jwcJYoYq73yiy
7ktoS8crhU8xPBTdtKj0
=rg99
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
