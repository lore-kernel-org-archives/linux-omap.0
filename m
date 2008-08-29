From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Enabling MUSB support
Date: Fri, 29 Aug 2008 22:00:51 +0300
Message-ID: <20080829190048.GA6768@frodo>
References: <1f11a5490808270626t5b4aa599i18b730d12a6c4667@mail.gmail.com> <20080827133825.GC7354@gandalf.research.nokia.com> <200808272354.28531.david-b@pacbell.net> <200808291112.24443.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:34913 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575AbYH2TBP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 15:01:15 -0400
Content-Disposition: inline
In-Reply-To: <200808291112.24443.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: felipe.balbi@nokia.com, ext Ashwin Bihari <abihari@gmail.com>, linux-omap@vger.kernel.org

On Fri, Aug 29, 2008 at 11:12:24AM -0700, David Brownell wrote:
> On Wednesday 27 August 2008, David Brownell wrote:
> > I tried it on Beagle and found that OTG mode wanted to oops
> > while binding the gadget driver ... static config. =A0That's
> > with current GIT. =A0Peripheral-only had the same issue ISTR.
>=20
> This was with the new "CDC Composite" driver (ECM and ACM),
> so maybe Anand's observation is a useful clue.  That code
> surely does things a bit differently than older stuff.  I
> can try another gadget driver later.
>=20
> However that code comes up fine on all the other peripheral
> controller drivers I tried (at least three), suggesting the
> issue is with the MUSB code...

I took a look at it today and couldn't come up with anything, but it
looks like the problem appears when composite.c:config_desc() is called=
=2E
It looks like windows doesn't accept any of the config descriptor sent =
by
g_ether when windows sends a get_config_descriptor request.

I put some printks on that list_for_each_entry() and w_value never
changes suggesting that a set_configuration never happened (if I'm not
wrong).

I tested with g_ether before the composite fw and it works fine. And
looking at your commit message for the g_ether conversion to composite
fw, I assumed there should be something wrong with g_ether. I'll look
more at it next week:

commit 45fe3b8e5342cd1ce307099459c74011d8e01986
Author: David Brownell <dbrownell@users.sourceforge.net>
Date:   Thu Jun 19 18:20:04 2008 -0700

    usb ethernet gadget: split RNDIS function
   =20
    This is a RNDIS function driver, extracted from the all-in-one
    Ethernet gadget driver.
   =20
    Lightly tested ... there seems to be a pre-existing problem when
    talking to Windows XP SP2, not quite sure what's up with that yet.
   =20
    Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


> > Host mode seemed to come up partially. =A0There seem to be
> > issues with control-OUT transfers, which caused problems
> > trying to use the Ethernet adapter I was hooking up.

I've got a dlink adapter at work, I'll see if I can reproduce an try to
patch.

> A bit more info on the host side problem ... see part of
> a debug trace, appended.
>=20
> The adapter enumerates OK then seems to trigger a VBUS_ERR,
> which is the first problem.
>=20
> The nasty failure which follows seems to be that an ep0
> request gets wrongly sent to the hardware while the device
> should be in disconnect processing, and that request can't
> be aborted.
>=20
> I'm pretty sure I used this specific adapter with earlier
> MUSB testing on DaVinci, but maybe not ... at any rate, I
> think the parts of the problem *after* VBUS_ERR are probably
> triggered by things this adapter's driver does and others
> generally don't do.  (Still an MUSB bug, but that's just
> why it would seem to hide.)
>=20
> However the VBUS_ERR is as always tricky to sort out.  The
> device lists its MaxPower as 286mA (on a non-Beagle host),
> which *should* be well within the ability of a Beagle to
> source ... but maybe it had a mini-surge that was enough
> to cause trouble on that OTG port.  (DaVinci EVM boards
> have a honking HUGE capacitor on VBUS, which smooths out
> such surges but prevent OTG timings from working.)

Beagle should be sourcing up to 200mA. See if this patch helps:

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-m=
usb.c
index 3f90a93..a3f37ee 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -129,6 +129,7 @@ static struct musb_hdrc_platform_data musb_plat =3D=
 {
                        : "usbhs_ick",
        .set_clock      =3D musb_set_clock,
        .config         =3D &musb_config,
+       .power          =3D 100 /* up to 200mA */
 };
=20
 static u64 musb_dmamask =3D ~(u32)0;


> Next test:  can using an external (powered) hub avoid this
> VBUS_ERR on the Beagle's OTG port.

Should help.

> 	enumerated and bound to driver, which started to come up.
>=20
> eth0: set allmulti
>=20
> musb_ep_program 644: --> hw0 urb c7976980 spd2 dev2 ep0out h_addr00 h=
_port00 bytes 8
> musb_h_ep0_continue 989: Sending 3 bytes to c780bbc0
> __musb_giveback 292: complete c7976980 (-115), dev2 ep0out, 3/3
>=20
> 	... another ep3in/status message ...
>=20
> musb_host_rx 1557: RX2 count 8, buffer 0x8780b5b8 len 0/8
> dma_channel_program 229: ep2-Rx pkt_sz 8, dma_addr 0x8780b5b8 length =
8, mode 0
> dma_controller_irq 343: ch c7911040, 0x8780b5b8 -> 0x8780b5c0 (8 / 8)=
 =3D> complete
> musb_ep_program 644: <-- hw2 urb c7976b80 spd2 dev2 ep3in h_addr00 h_=
port00 bytes 8
>=20
> 	... another ep3in/status message ...
>=20
> musb_host_rx 1557: RX2 count 8, buffer 0x8780b5b8 len 0/8
> dma_channel_program 229: ep2-Rx pkt_sz 8, dma_addr 0x8780b5b8 length =
8, mode 0
> dma_controller_irq 343: ch c7911040, 0x8780b5b8 -> 0x8780b5c0 (8 / 8)=
 =3D> complete
> musb_ep_program 644: <-- hw2 urb c7976b80 spd2 dev2 ep3in h_addr00 h_=
port00 bytes 8

I think I recall seeing this with my sniffer, but as it seemed not be
generating much problems, I let it be since I had other stuff to check.
Looks like I was wrong... :-s

bummer

>=20
> 	ERROR!!!
>=20
> musb_stage0_irq 401: <=3D=3D Power=3Df0, DevCtl=3D90, int_usb=3D0x88
> musb_stage0_irq 568: VBUS_ERROR in a_host (91, <VBusValid), retry #1,=
 port1 00000103
> musb_stage0_irq 401: <=3D=3D Power=3De0, DevCtl=3D5d, int_usb=3D0x10
> musb_stage0_irq 637: CONNECT (a_host) devctl 5d

The above patch should help since that config would be ruled out due to
power constraints.

> ------------[ cut here ]------------
> WARNING: at drivers/usb/musb/musb_host.c:125 musb_h_tx_flush_fifo+0xb=
c/0xdc()
> Could not flush host TX0 fifo: csr: 000a
> [<c002a45c>] (dump_stack+0x0/0x14) from [<c004cf18>] (warn_slowpath+0=
x60/0x7c)
> [<c004ceb8>] (warn_slowpath+0x0/0x7c) from [<c01ee64c>] (musb_h_tx_fl=
ush_fifo+0xbc/0xdc)
>  r3:00000000 r2:c032a8f8
>  r6:c8800102 r5:ffffffff r4:0000000a
> [<c01ee590>] (musb_h_tx_flush_fifo+0x0/0xdc) from [<c01ef440>] (musb_=
cleanup_urb+0xbc/0x110)
>  r8:00000000 r7:c7976980 r6:c8800100 r5:00000000 r4:c785621c
> [<c01ef384>] (musb_cleanup_urb+0x0/0x110) from [<c01efb68>] (musb_urb=
_dequeue+0x13c/0x16c)
> [<c01efa2c>] (musb_urb_dequeue+0x0/0x16c) from [<c01d3fe4>] (unlink1+=
0x6c/0xe4)
> [<c01d3f78>] (unlink1+0x0/0xe4) from [<c01d49b4>] (usb_hcd_unlink_urb=
+0x24/0x30)
>  r9:c79de400 r8:c785fe0c r7:c785fdac r6:00001388 r5:c7976980
> r4:c7976980
> [<c01d4990>] (usb_hcd_unlink_urb+0x0/0x30) from [<c01d5550>] (usb_kil=
l_urb+0x6c/0x114)
> [<c01d54e4>] (usb_kill_urb+0x0/0x114) from [<c01d63b4>] (usb_start_wa=
it_urb+0xb4/0xc4)
>  r5:c7976980 r4:00000000
> [<c01d6300>] (usb_start_wait_urb+0x0/0xc4) from [<c01d65a8>] (usb_con=
trol_msg+0xc0/0xe4)
>  r8:00000000 r7:00000001 r6:00000000 r5:00000000 r4:c794bd08
> [<c01d64e8>] (usb_control_msg+0x0/0xe4) from [<c01d75c4>] (usb_set_in=
terface+0x168/0x18c)
> [<c01d745c>] (usb_set_interface+0x0/0x18c) from [<c01d8eb4>] (usb_unb=
ind_interface+0x64/0xac)
> [<c01d8e50>] (usb_unbind_interface+0x0/0xac) from [<c0193fe4>] (__dev=
ice_release_driver+0x6c/0x9c)
>  r9:c79de578 r8:c79de400 r7:c79de460 r6:c79ccc00 r5:c035b704
> r4:c79ccc20
> [<c0193f78>] (__device_release_driver+0x0/0x9c) from [<c01940f0>] (de=
vice_release_driver+0x24/0x30)
>  r5:c79ccd38 r4:c79ccc20
> [<c01940cc>] (device_release_driver+0x0/0x30) from [<c01d8a48>] (usb_=
driver_release_interface+0x94/0x98)
>  r5:c79cc600 r4:c79ccc00
> [<c01d89b4>] (usb_driver_release_interface+0x0/0x98) from [<c01d8ad8>=
] (usb_forced_unbind_intf+0x20/0x30)
>  r7:c79cc600 r6:00000000 r5:c79cc600 r4:c79ccc00
> [<c01d8ab8>] (usb_forced_unbind_intf+0x0/0x30) from [<c01d0d1c>] (usb=
_reset_device+0x9c/0x188)
>  r5:c79cc600 r4:c79ccc00
> [<c01d0c80>] (usb_reset_device+0x0/0x188) from [<c01d2e08>] (hub_thre=
ad+0xb78/0xec4)
> [<c01d2290>] (hub_thread+0x0/0xec4) from [<c0062128>] (kthread+0x54/0=
x80)
> [<c00620d4>] (kthread+0x0/0x80) from [<c004ffd0>] (do_exit+0x0/0x73c)
>  r5:00000000 r4:00000000
> ---[ end trace 3e2a9bb5b77f00a0 ]---

musb overcurrent protection seems to be broken. Something else for next
week.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
