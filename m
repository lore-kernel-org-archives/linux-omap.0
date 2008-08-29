From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Enabling MUSB support
Date: Fri, 29 Aug 2008 23:21:16 +0300
Message-ID: <20080829202114.GA14130@frodo>
References: <1f11a5490808270626t5b4aa599i18b730d12a6c4667@mail.gmail.com> <200808291112.24443.david-b@pacbell.net> <20080829190048.GA6768@frodo> <200808291305.31639.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:57949 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbYH2UVr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 16:21:47 -0400
Content-Disposition: inline
In-Reply-To: <200808291305.31639.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, felipe.balbi@nokia.com, ext Ashwin Bihari <abihari@gmail.com>, linux-omap@vger.kernel.org

On Fri, Aug 29, 2008 at 01:05:31PM -0700, David Brownell wrote:
> On Friday 29 August 2008, Felipe Balbi wrote:
> > On Fri, Aug 29, 2008 at 11:12:24AM -0700, David Brownell wrote:
> > > On Wednesday 27 August 2008, David Brownell wrote:
> > > > I tried it on Beagle and found that OTG mode wanted to oops
> > > > while binding the gadget driver ... static config. =A0That's
> > > > with current GIT. =A0Peripheral-only had the same issue ISTR.
> > >=20
> > > This was with the new "CDC Composite" driver (ECM and ACM),
> > > so maybe Anand's observation is a useful clue.  That code
> > > surely does things a bit differently than older stuff.  I
> > > can try another gadget driver later.
> > >=20
> > > However that code comes up fine on all the other peripheral
> > > controller drivers I tried (at least three), suggesting the
> > > issue is with the MUSB code...
> >=20
> > I took a look at it today and couldn't come up with anything, but i=
t
> > looks like the problem appears when composite.c:config_desc() is ca=
lled.
> > It looks like windows doesn't accept any of the config descriptor s=
ent by
> > g_ether when windows sends a get_config_descriptor request.
>=20
> You're talking about some other problem.  I'm talking about
> the one where it *OOPSES* while binding to the gadget driver.

Hmm, that I've never seend. Using musb with omap3 and n810.

> > > > Host mode seemed to come up partially. =A0There seem to be
> > > > issues with control-OUT transfers, which caused problems
> > > > trying to use the Ethernet adapter I was hooking up.
> >=20
> > I've got a dlink adapter at work, I'll see if I can reproduce an tr=
y to
> > patch.
>=20
> This one's a bit old ... "DSB-650TX Ethernet", 10-BaseT,
> full speed, pegasus driver.

Bummer, I don't have full speed ones...

> > Beagle should be sourcing up to 200mA. See if this patch helps:
>=20
> Just 200 mA?  That could explain a lot.  Though looking
> at the Beagle TRM, it says "100mA" (as with TUSB) ...
> some version of this patch seems necessary.  (I have some
> others to usb-musb.c, will send them all.)

Yeah, the TRM says 100mA but I could use 200mA storage devices with
heavy transfers without any problems.

Cool, please send them all. That file is not on mainline yet, so please
send to linux-omap, Tony should apply them here before merging
usb-musb.c upstream.

> > diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/u=
sb-musb.c
> > index 3f90a93..a3f37ee 100644
> > --- a/arch/arm/mach-omap2/usb-musb.c
> > +++ b/arch/arm/mach-omap2/usb-musb.c
> > @@ -129,6 +129,7 @@ static struct musb_hdrc_platform_data musb_plat=
 =3D {
> >                         : "usbhs_ick",
> >         .set_clock      =3D musb_set_clock,
> >         .config         =3D &musb_config,
> > +       .power          =3D 100 /* up to 200mA */
> >  };
> > =20
> >  static u64 musb_dmamask =3D ~(u32)0;
> >=20
> >=20
> > > Next test:  can using an external (powered) hub avoid this
> > > VBUS_ERR on the Beagle's OTG port.
> >=20
> > Should help.
>=20
> Did help.  But I confirmed some root hub problems ... after I
> removed the Ethernet adapter, it refused to enumerate the hub.
> Didn't even try... I had to reboot.  This particular hub is
> a bit odd, which may explain why I had to reboot with the
> hub connected ... it wouldn't enumerate otherwise.

Do you have the BLACKLIST_HUB set? (just to be sure).

> > I think I recall seeing this with my sniffer, but as it seemed not =
be
> > generating much problems, I let it be since I had other stuff to ch=
eck.
> > Looks like I was wrong... :-s
>=20
> The ep3in/status stuff is no problem.  The problem is the VBUS_ERR ir=
q.

That irq is buggy, we had to put a retry since musb was rasing that
interrupt durring enumeration for a few usb devices (bad capacitors?).

> Which is explained by wrongly initializing the root hub power capabil=
ities.
> If the root hub can't support 500 mA per port, it's got to say so!

Yeah... I agree here. That power field was missing.

> > > ------------[ cut here ]------------
> > > WARNING: at drivers/usb/musb/musb_host.c:125 musb_h_tx_flush_fifo=
+0xbc/0xdc()
> > > Could not flush host TX0 fifo: csr: 000a
> > > [<c002a45c>] (dump_stack+0x0/0x14) from [<c004cf18>] (warn_slowpa=
th+0x60/0x7c)
> > > [<c004ceb8>] (warn_slowpath+0x0/0x7c) from [<c01ee64c>] (musb_h_t=
x_flush_fifo+0xbc/0xdc)
> > >  r3:00000000 r2:c032a8f8
> > >  r6:c8800102 r5:ffffffff r4:0000000a
> > > [<c01ee590>] (musb_h_tx_flush_fifo+0x0/0xdc) from [<c01ef440>] (m=
usb_cleanup_urb+0xbc/0x110)
> > >  r8:00000000 r7:c7976980 r6:c8800100 r5:00000000 r4:c785621c
> > > [<c01ef384>] (musb_cleanup_urb+0x0/0x110) from [<c01efb68>] (musb=
_urb_dequeue+0x13c/0x16c)
> > > [<c01efa2c>] (musb_urb_dequeue+0x0/0x16c) from [<c01d3fe4>] (unli=
nk1+0x6c/0xe4)
> > > ...
> > > ---[ end trace 3e2a9bb5b77f00a0 ]---
> >=20
> > musb overcurrent protection seems to be broken. Something else for =
next
> > week.
>=20
> Well, *recovery* seems broken, yes.  I'm not sure this got properly
> reported as an overcurrent event to the root hub code, either.

at least for tusb we had quite a big trouble making it work nicely on
n810 times. Take a look at tusb6010.c:tusb_otg_ints()

 741                         case OTG_STATE_A_WAIT_VFALL:
 742                                 /* REVISIT this irq triggers durin=
g short
 743                                  * spikes caused by enumeration ..=
=2E
 744                                  */
 745                                 if (musb->vbuserr_retry) {
 746                                         musb->vbuserr_retry--;
 747                                         tusb_source_power(musb, 1)=
;
 748                                 } else {
 749                                         musb->vbuserr_retry
 750                                                 =3D VBUSERR_RETRY_=
COUNT;
 751                                         tusb_source_power(musb, 0)=
;

and musb_core.c:musb_stage0_irq()

 536                 case OTG_STATE_A_WAIT_VRISE:
 537                         if (musb->vbuserr_retry) {
 538                                 musb->vbuserr_retry--;
 539                                 ignore =3D 1;
 540                                 devctl |=3D MUSB_DEVCTL_SESSION;
 541                                 musb_writeb(mbase, MUSB_DEVCTL, de=
vctl);
 542                         } else {
 543                                 musb->port1_status |=3D
 544                                           (1 << USB_PORT_FEAT_OVER=
_CURRENT)
 545                                         | (1 << USB_PORT_FEAT_C_OV=
ER_CURRENT);
 546                         }
 547                         break;

Maybe we need a bit of change there, and instead of if, use a while
loop, true until vbuserr_retry goes to 0, something like:

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.=
c
index b398776..bcd0832 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -534,15 +534,15 @@ static irqreturn_t musb_stage0_irq(struct musb *m=
usb, u8 int_usb,
                         */
                case OTG_STATE_A_WAIT_BCON:
                case OTG_STATE_A_WAIT_VRISE:
-                       if (musb->vbuserr_retry) {
-                               musb->vbuserr_retry--;
+                       while(--vbuserr_retry) {
                                ignore =3D 1;
                                devctl |=3D MUSB_DEVCTL_SESSION;
                                musb_writeb(mbase, MUSB_DEVCTL, devctl)=
;
-                       } else {
-                               musb->port1_status |=3D
-                                         (1 << USB_PORT_FEAT_OVER_CURR=
ENT)
-                                       | (1 << USB_PORT_FEAT_C_OVER_CU=
RRENT);
+
+                               if (vbuserr_retry =3D=3D 0)
+                                       musb->port1_status |=3D
+                                               (1 << USB_PORT_FEAT_OVE=
R_CURRENT)
+                                               | (1 << USB_PORT_FEAT_C=
_OVER_CURRENT);
                        }
                        break;
                default:

Didn't test though. If it works nicely, the same logic will have to go
to tusb6010.c

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
