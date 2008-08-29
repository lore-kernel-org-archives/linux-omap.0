From: David Brownell <david-b@pacbell.net>
Subject: Re: Enabling MUSB support
Date: Fri, 29 Aug 2008 13:05:31 -0700
Message-ID: <200808291305.31639.david-b@pacbell.net>
References: <1f11a5490808270626t5b4aa599i18b730d12a6c4667@mail.gmail.com> <200808291112.24443.david-b@pacbell.net> <20080829190048.GA6768@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:35366 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751918AbYH2UNQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Aug 2008 16:13:16 -0400
In-Reply-To: <20080829190048.GA6768@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: felipe.balbi@nokia.com, ext Ashwin Bihari <abihari@gmail.com>, linux-omap@vger.kernel.org

On Friday 29 August 2008, Felipe Balbi wrote:
> On Fri, Aug 29, 2008 at 11:12:24AM -0700, David Brownell wrote:
> > On Wednesday 27 August 2008, David Brownell wrote:
> > > I tried it on Beagle and found that OTG mode wanted to oops
> > > while binding the gadget driver ... static config. =A0That's
> > > with current GIT. =A0Peripheral-only had the same issue ISTR.
> >=20
> > This was with the new "CDC Composite" driver (ECM and ACM),
> > so maybe Anand's observation is a useful clue.  That code
> > surely does things a bit differently than older stuff.  I
> > can try another gadget driver later.
> >=20
> > However that code comes up fine on all the other peripheral
> > controller drivers I tried (at least three), suggesting the
> > issue is with the MUSB code...
>=20
> I took a look at it today and couldn't come up with anything, but it
> looks like the problem appears when composite.c:config_desc() is call=
ed.
> It looks like windows doesn't accept any of the config descriptor sen=
t by
> g_ether when windows sends a get_config_descriptor request.

You're talking about some other problem.  I'm talking about
the one where it *OOPSES* while binding to the gadget driver.


> > > Host mode seemed to come up partially. =A0There seem to be
> > > issues with control-OUT transfers, which caused problems
> > > trying to use the Ethernet adapter I was hooking up.
>=20
> I've got a dlink adapter at work, I'll see if I can reproduce an try =
to
> patch.

This one's a bit old ... "DSB-650TX Ethernet", 10-BaseT,
full speed, pegasus driver.


> > A bit more info on the host side problem ... see part of
> > a debug trace, appended.
> >=20
> > The adapter enumerates OK then seems to trigger a VBUS_ERR,
> > which is the first problem.

The VBUS_ERR seems associated with network traffic.  It works
OK-ish if the Ethernet cable isn't connected ... chattier than
I'd like, but otherwise OK.


> > The nasty failure which follows seems to be that an ep0
> > request gets wrongly sent to the hardware while the device
> > should be in disconnect processing, and that request can't
> > be aborted.
> >=20
> > ...
> >=20
> > However the VBUS_ERR is as always tricky to sort out.  The
> > device lists its MaxPower as 286mA (on a non-Beagle host),
> > which *should* be well within the ability of a Beagle to
> > source ... but maybe it had a mini-surge that was enough
> > to cause trouble on that OTG port.  (DaVinci EVM boards
> > have a honking HUGE capacitor on VBUS, which smooths out
> > such surges but prevent OTG timings from working.)
>=20
> Beagle should be sourcing up to 200mA. See if this patch helps:

Just 200 mA?  That could explain a lot.  Though looking
at the Beagle TRM, it says "100mA" (as with TUSB) ...
some version of this patch seems necessary.  (I have some
others to usb-musb.c, will send them all.)


> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb=
-musb.c
> index 3f90a93..a3f37ee 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -129,6 +129,7 @@ static struct musb_hdrc_platform_data musb_plat =3D=
 {
>                         : "usbhs_ick",
>         .set_clock      =3D musb_set_clock,
>         .config         =3D &musb_config,
> +       .power          =3D 100 /* up to 200mA */
>  };
> =20
>  static u64 musb_dmamask =3D ~(u32)0;
>=20
>=20
> > Next test:  can using an external (powered) hub avoid this
> > VBUS_ERR on the Beagle's OTG port.
>=20
> Should help.

Did help.  But I confirmed some root hub problems ... after I
removed the Ethernet adapter, it refused to enumerate the hub.
Didn't even try... I had to reboot.  This particular hub is
a bit odd, which may explain why I had to reboot with the
hub connected ... it wouldn't enumerate otherwise.


> > 	... another ep3in/status message ...
> >=20
> > musb_host_rx 1557: RX2 count 8, buffer 0x8780b5b8 len 0/8
> > dma_channel_program 229: ep2-Rx pkt_sz 8, dma_addr 0x8780b5b8 lengt=
h 8, mode 0
> > dma_controller_irq 343: ch c7911040, 0x8780b5b8 -> 0x8780b5c0 (8 / =
8) =3D> complete
> > musb_ep_program 644: <-- hw2 urb c7976b80 spd2 dev2 ep3in h_addr00 =
h_port00 bytes 8
>=20
> I think I recall seeing this with my sniffer, but as it seemed not be
> generating much problems, I let it be since I had other stuff to chec=
k.
> Looks like I was wrong... :-s

The ep3in/status stuff is no problem.  The problem is the VBUS_ERR irq.

Which is explained by wrongly initializing the root hub power capabilit=
ies.
If the root hub can't support 500 mA per port, it's got to say so!


> bummer
>=20
> >=20
> > 	ERROR!!!
> >=20
> > musb_stage0_irq 401: <=3D=3D Power=3Df0, DevCtl=3D90, int_usb=3D0x8=
8
> > musb_stage0_irq 568: VBUS_ERROR in a_host (91, <VBusValid), retry #=
1, port1 00000103
> > musb_stage0_irq 401: <=3D=3D Power=3De0, DevCtl=3D5d, int_usb=3D0x1=
0
> > musb_stage0_irq 637: CONNECT (a_host) devctl 5d
>=20
> The above patch should help since that config would be ruled out due =
to
> power constraints.

Right.  Testing soon ...

>=20
> > ------------[ cut here ]------------
> > WARNING: at drivers/usb/musb/musb_host.c:125 musb_h_tx_flush_fifo+0=
xbc/0xdc()
> > Could not flush host TX0 fifo: csr: 000a
> > [<c002a45c>] (dump_stack+0x0/0x14) from [<c004cf18>] (warn_slowpath=
+0x60/0x7c)
> > [<c004ceb8>] (warn_slowpath+0x0/0x7c) from [<c01ee64c>] (musb_h_tx_=
flush_fifo+0xbc/0xdc)
> >  r3:00000000 r2:c032a8f8
> >  r6:c8800102 r5:ffffffff r4:0000000a
> > [<c01ee590>] (musb_h_tx_flush_fifo+0x0/0xdc) from [<c01ef440>] (mus=
b_cleanup_urb+0xbc/0x110)
> >  r8:00000000 r7:c7976980 r6:c8800100 r5:00000000 r4:c785621c
> > [<c01ef384>] (musb_cleanup_urb+0x0/0x110) from [<c01efb68>] (musb_u=
rb_dequeue+0x13c/0x16c)
> > [<c01efa2c>] (musb_urb_dequeue+0x0/0x16c) from [<c01d3fe4>] (unlink=
1+0x6c/0xe4)
> > ...
> > ---[ end trace 3e2a9bb5b77f00a0 ]---
>=20
> musb overcurrent protection seems to be broken. Something else for ne=
xt
> week.

Well, *recovery* seems broken, yes.  I'm not sure this got properly
reported as an overcurrent event to the root hub code, either.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
