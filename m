From: David Brownell <david-b@pacbell.net>
Subject: Re: Enabling MUSB support
Date: Fri, 29 Aug 2008 11:12:24 -0700
Message-ID: <200808291112.24443.david-b@pacbell.net>
References: <1f11a5490808270626t5b4aa599i18b730d12a6c4667@mail.gmail.com> <20080827133825.GC7354@gandalf.research.nokia.com> <200808272354.28531.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:31043 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756285AbYH2STH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Aug 2008 14:19:07 -0400
In-Reply-To: <200808272354.28531.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: ext Ashwin Bihari <abihari@gmail.com>, linux-omap@vger.kernel.org

On Wednesday 27 August 2008, David Brownell wrote:
> I tried it on Beagle and found that OTG mode wanted to oops
> while binding the gadget driver ... static config. =A0That's
> with current GIT. =A0Peripheral-only had the same issue ISTR.

This was with the new "CDC Composite" driver (ECM and ACM),
so maybe Anand's observation is a useful clue.  That code
surely does things a bit differently than older stuff.  I
can try another gadget driver later.

However that code comes up fine on all the other peripheral
controller drivers I tried (at least three), suggesting the
issue is with the MUSB code...


> Host mode seemed to come up partially. =A0There seem to be
> issues with control-OUT transfers, which caused problems
> trying to use the Ethernet adapter I was hooking up.

A bit more info on the host side problem ... see part of
a debug trace, appended.

The adapter enumerates OK then seems to trigger a VBUS_ERR,
which is the first problem.

The nasty failure which follows seems to be that an ep0
request gets wrongly sent to the hardware while the device
should be in disconnect processing, and that request can't
be aborted.

I'm pretty sure I used this specific adapter with earlier
MUSB testing on DaVinci, but maybe not ... at any rate, I
think the parts of the problem *after* VBUS_ERR are probably
triggered by things this adapter's driver does and others
generally don't do.  (Still an MUSB bug, but that's just
why it would seem to hide.)

However the VBUS_ERR is as always tricky to sort out.  The
device lists its MaxPower as 286mA (on a non-Beagle host),
which *should* be well within the ability of a Beagle to
source ... but maybe it had a mini-surge that was enough
to cause trouble on that OTG port.  (DaVinci EVM boards
have a honking HUGE capacitor on VBUS, which smooths out
such surges but prevent OTG timings from working.)

Next test:  can using an external (powered) hub avoid this
VBUS_ERR on the Beagle's OTG port.

- Dave

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

	enumerated and bound to driver, which started to come up.

eth0: set allmulti

musb_ep_program 644: --> hw0 urb c7976980 spd2 dev2 ep0out h_addr00 h_p=
ort00 bytes 8
musb_h_ep0_continue 989: Sending 3 bytes to c780bbc0
__musb_giveback 292: complete c7976980 (-115), dev2 ep0out, 3/3

	... another ep3in/status message ...

musb_host_rx 1557: RX2 count 8, buffer 0x8780b5b8 len 0/8
dma_channel_program 229: ep2-Rx pkt_sz 8, dma_addr 0x8780b5b8 length 8,=
 mode 0
dma_controller_irq 343: ch c7911040, 0x8780b5b8 -> 0x8780b5c0 (8 / 8) =3D=
> complete
musb_ep_program 644: <-- hw2 urb c7976b80 spd2 dev2 ep3in h_addr00 h_po=
rt00 bytes 8

	... another ep3in/status message ...

musb_host_rx 1557: RX2 count 8, buffer 0x8780b5b8 len 0/8
dma_channel_program 229: ep2-Rx pkt_sz 8, dma_addr 0x8780b5b8 length 8,=
 mode 0
dma_controller_irq 343: ch c7911040, 0x8780b5b8 -> 0x8780b5c0 (8 / 8) =3D=
> complete
musb_ep_program 644: <-- hw2 urb c7976b80 spd2 dev2 ep3in h_addr00 h_po=
rt00 bytes 8

	ERROR!!!

musb_stage0_irq 401: <=3D=3D Power=3Df0, DevCtl=3D90, int_usb=3D0x88
musb_stage0_irq 568: VBUS_ERROR in a_host (91, <VBusValid), retry #1, p=
ort1 00000103
musb_stage0_irq 401: <=3D=3D Power=3De0, DevCtl=3D5d, int_usb=3D0x10
musb_stage0_irq 637: CONNECT (a_host) devctl 5d

musb_hub_control 344: port status 00010101

musb_cleanup_urb 1934: abort RX1 DMA for urb c7976a00 --> 0
__musb_giveback 292: complete c7976a00 (-115), dev2 ep1in, 0/1544

musb_cleanup_urb 1934: abort RX2 DMA for urb c7976b80 --> 0
__musb_giveback 292: complete c7976b80 (-115), dev2 ep3in, 8/8

	This is odd:  why was a new ep0 request even *accepted* ??

musb_ep_program 644: --> hw0 urb c7976980 spd2 dev2 ep0out h_addr00 h_p=
ort00 bytes 8

musb_h_tx_flush_fifo 119: Host TX FIFONOTEMPTY csr: 0a
musb_h_tx_flush_fifo 119: Host TX FIFONOTEMPTY csr: 0a

	... repeated 1000 times before giving up.
	... stack backtrace added by me, for debug.

------------[ cut here ]------------
WARNING: at drivers/usb/musb/musb_host.c:125 musb_h_tx_flush_fifo+0xbc/=
0xdc()
Could not flush host TX0 fifo: csr: 000a
[<c002a45c>] (dump_stack+0x0/0x14) from [<c004cf18>] (warn_slowpath+0x6=
0/0x7c)
[<c004ceb8>] (warn_slowpath+0x0/0x7c) from [<c01ee64c>] (musb_h_tx_flus=
h_fifo+0xbc/0xdc)
 r3:00000000 r2:c032a8f8
 r6:c8800102 r5:ffffffff r4:0000000a
[<c01ee590>] (musb_h_tx_flush_fifo+0x0/0xdc) from [<c01ef440>] (musb_cl=
eanup_urb+0xbc/0x110)
 r8:00000000 r7:c7976980 r6:c8800100 r5:00000000 r4:c785621c
[<c01ef384>] (musb_cleanup_urb+0x0/0x110) from [<c01efb68>] (musb_urb_d=
equeue+0x13c/0x16c)
[<c01efa2c>] (musb_urb_dequeue+0x0/0x16c) from [<c01d3fe4>] (unlink1+0x=
6c/0xe4)
[<c01d3f78>] (unlink1+0x0/0xe4) from [<c01d49b4>] (usb_hcd_unlink_urb+0=
x24/0x30)
 r9:c79de400 r8:c785fe0c r7:c785fdac r6:00001388 r5:c7976980
r4:c7976980
[<c01d4990>] (usb_hcd_unlink_urb+0x0/0x30) from [<c01d5550>] (usb_kill_=
urb+0x6c/0x114)
[<c01d54e4>] (usb_kill_urb+0x0/0x114) from [<c01d63b4>] (usb_start_wait=
_urb+0xb4/0xc4)
 r5:c7976980 r4:00000000
[<c01d6300>] (usb_start_wait_urb+0x0/0xc4) from [<c01d65a8>] (usb_contr=
ol_msg+0xc0/0xe4)
 r8:00000000 r7:00000001 r6:00000000 r5:00000000 r4:c794bd08
[<c01d64e8>] (usb_control_msg+0x0/0xe4) from [<c01d75c4>] (usb_set_inte=
rface+0x168/0x18c)
[<c01d745c>] (usb_set_interface+0x0/0x18c) from [<c01d8eb4>] (usb_unbin=
d_interface+0x64/0xac)
[<c01d8e50>] (usb_unbind_interface+0x0/0xac) from [<c0193fe4>] (__devic=
e_release_driver+0x6c/0x9c)
 r9:c79de578 r8:c79de400 r7:c79de460 r6:c79ccc00 r5:c035b704
r4:c79ccc20
[<c0193f78>] (__device_release_driver+0x0/0x9c) from [<c01940f0>] (devi=
ce_release_driver+0x24/0x30)
 r5:c79ccd38 r4:c79ccc20
[<c01940cc>] (device_release_driver+0x0/0x30) from [<c01d8a48>] (usb_dr=
iver_release_interface+0x94/0x98)
 r5:c79cc600 r4:c79ccc00
[<c01d89b4>] (usb_driver_release_interface+0x0/0x98) from [<c01d8ad8>] =
(usb_forced_unbind_intf+0x20/0x30)
 r7:c79cc600 r6:00000000 r5:c79cc600 r4:c79ccc00
[<c01d8ab8>] (usb_forced_unbind_intf+0x0/0x30) from [<c01d0d1c>] (usb_r=
eset_device+0x9c/0x188)
 r5:c79cc600 r4:c79ccc00
[<c01d0c80>] (usb_reset_device+0x0/0x188) from [<c01d2e08>] (hub_thread=
+0xb78/0xec4)
[<c01d2290>] (hub_thread+0x0/0xec4) from [<c0062128>] (kthread+0x54/0x8=
0)
[<c00620d4>] (kthread+0x0/0x80) from [<c004ffd0>] (do_exit+0x0/0x73c)
 r5:00000000 r4:00000000
---[ end trace 3e2a9bb5b77f00a0 ]---

__musb_giveback 292: complete c7976980 (-115), dev2 ep0out, 0/0
musb_hub_control 344: port status 00120103

musb_h_ep0_irq 1046: no response, csr0 0010
musb_h_ep0_irq 1093: no URB for end 0

	... ( lather, rinse ) * repeat
	... details not shown here

usb 1-1: reset full speed USB device using musb_hdrc and address 2

musb_ep_program 644: --> hw0 urb c7976a00 spd2 dev0 ep0out h_addr00 h_p=
ort00 bytes 8
__musb_giveback 292: complete c7976a00 (-115), dev0 ep0in, 8/64
musb_hub_control 344: port status 00120103

	...

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
