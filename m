From: Felipe Balbi <balbi@ti.com>
Subject: Re: USB lockups on BeagleBone/AM335x
Date: Thu, 20 Feb 2014 16:49:24 -0600
Message-ID: <20140220224902.GB10878@saruman.home>
References: <BCBA70ECF3E0284F86C53FAF9ED7FCA1426C07@SRVEXCH01.enatel.local>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48551 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522AbaBTWuv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Feb 2014 17:50:51 -0500
Content-Disposition: inline
In-Reply-To: <BCBA70ECF3E0284F86C53FAF9ED7FCA1426C07@SRVEXCH01.enatel.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chris Kimber <chris.kimber@enatel.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 20, 2014 at 10:39:00PM +0000, Chris Kimber wrote:
> Hi,
>=20
> I've been experiencing USB issues with a BeagleBone white rev A5.
> I've not seen any symptoms with the TI 3.2 kernel but I need to get
> access to some of the later drivers and didn't fancy back porting...=20
>=20
> So I've tried 3.8, 3,12 & 3.13 kernels with the patches from
> https://github.com/beagleboard/kernel and they seem to be able to talk
> to a USB memory stick but when making use of a cp210x and ftdi_sio
> based USB to UART adaptor the controller hangs.
>=20
> I've also tried linux-next, linux-usb and now linux-omap3 and they
> seem to be more unstable and even communicating with a USB stick seems
> flaky.
>=20
> I've got a test app that just writes "TESTING <count>\n" to the tty
> for ever.
>=20
> Here's some dmesg from linux-omap3 (1fbb354). I've added -DDEBUG to
> drivers/usb/{musb, serial}.
>=20
> OK:
> [   16.573781] tty ttyUSB0: serial_write - 11 byte(s)
> [   16.573802] cp210x ttyUSB0: usb_serial_generic_write_start - length =
=3D 11, data =3D 54 45 53 54 49 4e 47 20 34 32 0a
> [   16.573825] musb-hdrc musb-hdrc.1.auto: qh ce474b00 periodic slot 10
> [   16.573846] musb-hdrc musb-hdrc.1.auto: qh ce474b00 urb ce489700 dev2 =
ep1out-bulk, hw_ep 10, ce44f700/11
> [   16.573866] musb-hdrc musb-hdrc.1.auto: --> hw10 urb ce489700 spd2 dev=
2 ep1out h_addr00 h_port00 bytes 11
> [   16.573887] musb-hdrc musb-hdrc.1.auto: configure ep10/a4 packet_sz=3D=
64, mode=3D0, dma_addr=3D0x8e44f700, len=3D11 is_tx=3D1
> [   16.573905] musb-hdrc musb-hdrc.1.auto: Start TX10 dma
> [   16.573928] musb-hdrc musb-hdrc.1.auto: DMA transfer done on hw_ep=3D1=
0 bytes=3D11/11
> [   16.573945] musb-hdrc musb-hdrc.1.auto: OUT/TX10 end, csr 3500, dma
> [   16.573986] musb-hdrc musb-hdrc.1.auto: complete ce489700 usb_serial_g=
eneric_write_bulk_callback+0x0/0xd4 [usbserial] (0), dev2 ep1out, 11/11
>=20
> FAIL:
> [   16.574085] tty ttyUSB0: serial_write - 11 byte(s)
> [   16.574106] cp210x ttyUSB0: usb_serial_generic_write_start - length =
=3D 11, data =3D 54 45 53 54 49 4e 47 20 34 33 0a
> [   16.574129] musb-hdrc musb-hdrc.1.auto: qh ce474b00 periodic slot 10
> [   16.574149] musb-hdrc musb-hdrc.1.auto: qh ce474b00 urb ce489700 dev2 =
ep1out-bulk, hw_ep 10, ce44f700/11
> [   16.574169] musb-hdrc musb-hdrc.1.auto: --> hw10 urb ce489700 spd2 dev=
2 ep1out h_addr00 h_port00 bytes 11
> [   16.574191] musb-hdrc musb-hdrc.1.auto: configure ep10/a4 packet_sz=3D=
64, mode=3D0, dma_addr=3D0x8e44f700, len=3D11 is_tx=3D1
> [   16.574208] musb-hdrc musb-hdrc.1.auto: Start TX10 dma
> [   16.574231] musb-hdrc musb-hdrc.1.auto: DMA transfer done on hw_ep=3D1=
0 bytes=3D11/11
> [   16.574302] tty ttyUSB0: serial_write - 11 byte(s)
> [   16.574322] cp210x ttyUSB0: usb_serial_generic_write_start - length =
=3D 11, data =3D 54 45 53 54 49 4e 47 20 34 34 0a
> [   16.574381] tty ttyUSB0: serial_write - 11 byte(s)
> [   16.574452] tty ttyUSB0: serial_write - 11 byte(s)
> [   16.574508] tty ttyUSB0: serial_write - 11 byte(s)
> ...
> [   16.930271] tty ttyUSB0: serial_write - 1 byte(s)
>=20
> Then my test app blocks.
>=20
> It looks like in the first fail case the DMA "succeeds", but the USB
> controller doesn't send the frame and consequently the TXPKTRDY bit in
> the csr register never gets cleared. Thus musb_is_tx_fifo_empty()
> always returns false and consequently falls into
> cppi41_recheck_tx_req() waiting for the queue to clear.  Eventually we
> must fill up some buffer and cause my sending app to block.=20
>=20
> I've tried to force the FIFO to flush by setting the appropriate bits
> in the csr after a timeout and that doesn't seem to do anything.
>=20
> If I try and reboot the platform I get a punch of  warnings:
>=20
> / # reboot
> The system is going down NOW!
> Sent SIGTERM to all processes
> [  990.007339] ------------[ cut here ]------------
> [  990.014193] WARNING: CPU: 0 PID: 100 at drivers/dma/cppi41.c:605 cppi4=
1_dma_control+0x230/0x2a8()
> [  990.023567] Modules linked in: cp210x usbserial
> [  990.028383] CPU: 0 PID: 100 Comm: blast Not tainted 3.14.0-rc2+ #3
> [  990.034967] [<c00148d8>] (unwind_backtrace) from [<c00115cc>] (show_st=
ack+0x10/0x14)
> [  990.043179] [<c00115cc>] (show_stack) from [<c073b784>] (dump_stack+0x=
68/0x84)
> [  990.050823] [<c073b784>] (dump_stack) from [<c003a4b0>] (warn_slowpath=
_common+0x64/0x88)
> [  990.059375] [<c003a4b0>] (warn_slowpath_common) from [<c003a4ec>] (war=
n_slowpath_null+0x18/0x1c)
> [  990.068656] [<c003a4ec>] (warn_slowpath_null) from [<c0434cf8>] (cppi4=
1_dma_control+0x230/0x2a8)
> [  990.077948] [<c0434cf8>] (cppi41_dma_control) from [<c0543610>] (cppi4=
1_dma_channel_abort+0x108/0x148)
> [  990.087801] [<c0543610>] (cppi41_dma_channel_abort) from [<c053e5c8>] =
(musb_cleanup_urb+0x40/0x100)
> [  990.097364] [<c053e5c8>] (musb_cleanup_urb) from [<c053e7a8>] (musb_ur=
b_dequeue+0x120/0x154)
> [  990.106293] [<c053e7a8>] (musb_urb_dequeue) from [<c05240e0>] (unlink1=
+0xb4/0xc4)
> [  990.114206] [<c05240e0>] (unlink1) from [<c05254c8>] (usb_hcd_unlink_u=
rb+0x60/0x80)
> [  990.122304] [<c05254c8>] (usb_hcd_unlink_urb) from [<c052637c>] (usb_k=
ill_urb+0x50/0xc8)
> [  990.130917] [<c052637c>] (usb_kill_urb) from [<bf002c90>] (usb_serial_=
generic_close+0x20/0x64 [usbserial])
> [  990.141145] [<bf002c90>] (usb_serial_generic_close [usbserial]) from [=
<bf00fe88>] (cp210x_close+0xc/0x28 [cp210x])
> [  990.152094] [<bf00fe88>] (cp210x_close [cp210x]) from [<bf000024>] (se=
rial_port_shutdown+0x24/0x28 [usbserial])
> [  990.162771] [<bf000024>] (serial_port_shutdown [usbserial]) from [<c04=
4d484>] (tty_port_shutdown+0x6c/0x78)
> [  990.173071] [<c044d484>] (tty_port_shutdown) from [<c044dee8>] (tty_po=
rt_close+0x24/0x4c)
> [  990.181733] [<c044dee8>] (tty_port_close) from [<c0446120>] (tty_relea=
se+0x118/0x49c)
> [  990.190029] [<c0446120>] (tty_release) from [<c012c600>] (__fput+0xd4/=
0x1e4)
> [  990.197498] [<c012c600>] (__fput) from [<c0055974>] (task_work_run+0xb=
4/0xc8)
> [  990.205045] [<c0055974>] (task_work_run) from [<c003cae0>] (do_exit+0x=
3f8/0x948)
> [  990.212865] [<c003cae0>] (do_exit) from [<c003d0f4>] (do_group_exit+0x=
98/0xd4)
> [  990.220512] [<c003d0f4>] (do_group_exit) from [<c004a9c4>] (get_signal=
_to_deliver+0x510/0x58c)
> [  990.229616] [<c004a9c4>] (get_signal_to_deliver) from [<c0010a28>] (do=
_signal+0xa8/0x3b8)
> [  990.238260] [<c0010a28>] (do_signal) from [<c0011034>] (do_work_pendin=
g+0x54/0x9c)
> [  990.246264] [<c0011034>] (do_work_pending) from [<c000dea0>] (work_pen=
ding+0xc/0x20)
> [  990.254441] ---[ end trace 6bbc95d827ba3e8c ]---
>=20
> [  991.506236] ------------[ cut here ]------------
> [  991.511118] WARNING: CPU: 0 PID: 100 at drivers/usb/musb/musb_host.c:1=
28 musb_h_tx_flush_fifo+0x78/0xc4()
> [  991.521219] Could not flush host TX10 fifo: csr: 2503
> [  991.526552] Modules linked in: cp210x usbserial
> [  991.531352] CPU: 0 PID: 100 Comm: blast Tainted: G        W    3.14.0-=
rc2+ #3
> [  991.538897] [<c00148d8>] (unwind_backtrace) from [<c00115cc>] (show_st=
ack+0x10/0x14)
> [  991.547081] [<c00115cc>] (show_stack) from [<c073b784>] (dump_stack+0x=
68/0x84)
> [  991.554713] [<c073b784>] (dump_stack) from [<c003a4b0>] (warn_slowpath=
_common+0x64/0x88)
> [  991.563262] [<c003a4b0>] (warn_slowpath_common) from [<c003a554>] (war=
n_slowpath_fmt+0x2c/0x3c)
> [  991.572456] [<c003a554>] (warn_slowpath_fmt) from [<c053ccf0>] (musb_h=
_tx_flush_fifo+0x78/0xc4)
> [  991.581651] [<c053ccf0>] (musb_h_tx_flush_fifo) from [<c053e62c>] (mus=
b_cleanup_urb+0xa4/0x100)
> [  991.590844] [<c053e62c>] (musb_cleanup_urb) from [<c053e7a8>] (musb_ur=
b_dequeue+0x120/0x154)
> [  991.599759] [<c053e7a8>] (musb_urb_dequeue) from [<c05240e0>] (unlink1=
+0xb4/0xc4)
> [  991.607669] [<c05240e0>] (unlink1) from [<c05254c8>] (usb_hcd_unlink_u=
rb+0x60/0x80)
> [  991.615762] [<c05254c8>] (usb_hcd_unlink_urb) from [<c052637c>] (usb_k=
ill_urb+0x50/0xc8)
> [  991.624329] [<c052637c>] (usb_kill_urb) from [<bf002c90>] (usb_serial_=
generic_close+0x20/0x64 [usbserial])
> [  991.634544] [<bf002c90>] (usb_serial_generic_close [usbserial]) from [=
<bf00fe88>] (cp210x_close+0xc/0x28 [cp210x])
> [  991.645487] [<bf00fe88>] (cp210x_close [cp210x]) from [<bf000024>] (se=
rial_port_shutdown+0x24/0x28 [usbserial])
> [  991.656156] [<bf000024>] (serial_port_shutdown [usbserial]) from [<c04=
4d484>] (tty_port_shutdown+0x6c/0x78)
> [  991.666452] [<c044d484>] (tty_port_shutdown) from [<c044dee8>] (tty_po=
rt_close+0x24/0x4c)
> [  991.675095] [<c044dee8>] (tty_port_close) from [<c0446120>] (tty_relea=
se+0x118/0x49c)
> [  991.683372] [<c0446120>] (tty_release) from [<c012c600>] (__fput+0xd4/=
0x1e4)
> [  991.690824] [<c012c600>] (__fput) from [<c0055974>] (task_work_run+0xb=
4/0xc8)
> [  991.698368] [<c0055974>] (task_work_run) from [<c003cae0>] (do_exit+0x=
3f8/0x948)
> [  991.706184] [<c003cae0>] (do_exit) from [<c003d0f4>] (do_group_exit+0x=
98/0xd4)
> [  991.713821] [<c003d0f4>] (do_group_exit) from [<c004a9c4>] (get_signal=
_to_deliver+0x510/0x58c)
> [  991.722921] [<c004a9c4>] (get_signal_to_deliver) from [<c0010a28>] (do=
_signal+0xa8/0x3b8)
> [  991.731564] [<c0010a28>] (do_signal) from [<c0011034>] (do_work_pendin=
g+0x54/0x9c)
> [  991.739561] [<c0011034>] (do_work_pending) from [<c000dea0>] (work_pen=
ding+0xc/0x20)
> [  991.747736] ---[ end trace 6bbc95d827ba3e8e ]---
>=20
> Full dmesg: https://gist.github.com/anonymous/9124604
>=20
> Anyone have any ideas on where else to look?=20
>=20
> I've put my defconfig here https://gist.github.com/anonymous/9124565
> (it's based from the 3.13 one from the beagleboard github) just in
> case there is anything stupid going on.=20
>=20
> Is the USB in a known state of flux?

the short answer: yes

The long answer:

AM335x ES1.0 silicon (the one you have on your BBW) has many, many, many
known silicon bugs (mostly around CPPI 4.1 - the DMA controller) and
it's *very* difficult to have a stable USB with DMA on that device.

Surely we shouldn't have such failures, but it takes time and effort to
fix all of that in a way that doesn't regress any of the other numerous
platforms the MUSB driver supports.

Just to make sure this is a DMA problem, can you see if disabling DMA
altogether makes the test work ? (beware, throughput will *suck*).

cheers

--=20
balbi

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTBoZ0AAoJEIaOsuA1yqREvaEQAJysxIoRmBDm4WvrQ088g7+J
gHDBPbtlUAOsyl6V2YaMgd6pGSwRnybUOAuMsBpINJvULKqRMG4zuK8rBMDXt36v
rSQOrUwYduMTh8wJPyshVqV9xLiniPIiQQVYhVe8/SKNB+Euve0VhMhGpi8DSx/y
UjNZx5UGGpjiTFAVjnCYtsQU+gqNbs0/a4UpqFPxuyQMBHyNyVBJwH4b14V9M2xG
uj93U7P13lzyr8yoWcaFhc2gbx3oCn6E3ymBHKGLoIDJyIxxMpr8EijyIhrT+g84
a2qq3siPndhXU80/kCkAF+ROAttvqMxw0u/dLbjvgOV/FL+m6LOX8yzhADYj3lqH
ZEfRI++ZHSDSBSqWwr76kRD8ivMDCPMwdCttEJZcscbns+0xPw73SBQgZtXhWTaP
fdrLObrHFnFdzU9jGL//WMVhsdHrDzO1m60ytbfLUsxe0r/ej3yG6MBMUUVdF//o
hpmUwXmTg6OOxos5Y99UQWuNDRzhdTgAWIUoPa0WKvA8g8zZgQlRVluJt6L2ZP//
rNk6lnWCcZkNynJcArfI839FioT312vroDqhw2wJRN1xW+zmazVeZA8oRqeK4nA6
ZoAMMuuzUdM4Ueie9kRYg4Xl7K5VkR5o78kA7aBPRq7gIBqEst+8JsRHLghRs8Ml
e8JsHTCpOPinQCA8+n8J
=T2PF
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--
