From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC/PATCH 1/5] usb: otg: add notifier support
Date: Tue, 26 Jan 2010 07:07:22 -0800
Message-ID: <201001260707.23339.david-b@pacbell.net>
References: <6ed0b2680912101251jeec28e6i216dfc51caab13aa@mail.gmail.com> <201001260316.20529.david-b@pacbell.net> <20100126141016.GD10690@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp105.sbc.mail.gq1.yahoo.com ([67.195.14.108]:44639 "HELO
	smtp105.sbc.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753755Ab0AZPHZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jan 2010 10:07:25 -0500
In-Reply-To: <20100126141016.GD10690@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Grazvydas Ignotas <notasas@gmail.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>

On Tuesday 26 January 2010, Felipe Balbi wrote:
> >> +enum usb_xceiv_events {
> >
> >Let's keep charger events separate from anything else,
> >like "enter host mode" or "enter peripheral mode" (or
> >even "disconnect"). =A0The audiences for any other types
> >of event would be entirely different.
>=20
> the idea was to notify USB events to interested drivers, not only "us=
b=20
> charger events".

There are thousands of events that could be issued.
I'd rather start with one specific problem, which
can really benefit from being solved.

If necessary, other events can be added later.


> >Right now there's a mess in terms of charger hookup,
> >so getting that straight is IMO a priority over any
> >other type of event. =A0Using events will decouple a
> >bunch of drivers, and simplify driver configuration.
>=20
> well, if you consider that this transceiver isn't really otg specific=
,=20
> then this is already wrong.

It's the only transceiver interface we have; and it
works for OTG transceivers in peripheral-only mode,
as well as host-only and dual-role modes.  So it's
not especially wrong.


However, "you can consume N milliAmperes now" doesn't
need to be coupled to a transceiver at all.  In fact,
it works just fine with any pure peripheral interface.
The gadget stack uses such calls ... and doesn't need
to be coupled to any transceiver.  (But obviously it
can hook up to an OTG transceiver.)


=20
> >> +=A0=A0=A0=A0USB_EVENT_NONE, =A0 =A0 =A0 =A0 /* no events or cable=
 disconnected */
> >> +=A0=A0=A0=A0USB_EVENT_VBUS, =A0 =A0 =A0 =A0 /* vbus valid event *=
/
> >> +=A0=A0=A0=A0USB_EVENT_ID, =A0 =A0 =A0 =A0 =A0 /* id was grounded =
*/
> >> +=A0=A0=A0=A0USB_EVENT_CHARGER, =A0 =A0 =A0/* usb dedicated charge=
r */
> >> +=A0=A0=A0=A0USB_EVENT_ENUMERATED, =A0 /* gadget driver enumerated=
 */
> >
> >Those seem like the wrong events. =A0The right events for a charger
> >would be more along the lines of:
> >
> > - For peripheral: =A0"you may use N milliAmperes now".
> > - General: =A0"Don't Charge" (a.k.a. "use 0 mA").
>=20
> I have to disagree, which information would you used to kick the usb=20
> dedicated charger detection other than VBUS irq from transceiver ?

That's why I said what I did about the separate charger spec (and=20
you quoted it below):  it's not going to be less than those two
ops, which your events don't really capture.

That's "bonus" functionality though ... among other reasons, it's
not all that common yet.  The basic "charge battery over USB"
scenario needs to work without that stuff.

=20
> So we need at least that, and also need to notify when the charger=20
> detection is finished, so we can enable data pullups on the link.=20
> Remember we might be connected to a charging downstream port.

So you're presuming some separate component will do charger
detection by listening for events?  If it's mucking with the
pullups, that seems very much like what an OTG transciever
needs to be managing.  And thus, perhaps, transceiver code.

If there's such a separate component, I'd like to see some
detail about how it'd work.  But ... at first glance, it'd
have thought it'd be simplest inside a transceiver driver.


> >I don't see how "N" would be passed with those events ...
>=20
> there's a void * we can use to pass bMaxPower field of the selected=20
> configuration.

Needs to be part of the event spec...

=20
> >Haven't looked at the details of the charger spec, but
> >those two events are the *basics* from the USB 2.0 spec,
> >so "official" charger hardware wouldn't be less capable.
>=20
> I believe the dedicated charger is also "basic".

We could take a vote to see how many folk have even seen
one, much less own one.  They're not very common, and not
part of the USB 2.0 spec.  That's why I say "not basic".

=20
> >Thing like different levels of VBUS validity, ID grounding,
> >and so forth ... wouldn't be very relevant. =A0An OTG driver
> >will do various things, internally, when ID grounds; but
> >anything else is a function of what role eventually gets
> >negotiated. =A0And for the charger, they all add up to "Don't
> >Charge" (since ID grounded means A-role, sourcing power).
>=20
> ID grounding event is necessary if you have an external charge pump.=20
> At least the boards I've been working use an external chip as the USB=
=20
> Charger and Charge pump, iow, the transceiver doesn't source VBUS on =
ID=20
> ground, but the charger chip is put into "boost" mode for that role.

As you say:  transceiver stuff.  What I'm used to seeing is
what the OTG spec says:  ID grounding is an event, which
triggers state machine transitions.  One such transition
involves sourcing VBUS power and making sure it ramps up
properly.  Activating that, and monitoring it, depend on
hardware details which are tightly coupled to transceiver
logic and implementation.


> >> =A0#define USB_OTG_PULLUP_ID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(1 <<=
 0)
> >> =A0#define USB_OTG_PULLDOWN_DP=A0=A0=A0=A0=A0=A0=A0=A0=A0(1 << 1)
> >> =A0#define USB_OTG_PULLDOWN_DM=A0=A0=A0=A0=A0=A0=A0=A0=A0(1 << 2)
> >> @@ -70,6 +80,9 @@ struct otg_transceiver {
> >> =A0=A0=A0=A0=A0struct otg_io_access_ops=A0=A0=A0=A0=A0=A0=A0=A0*io=
_ops;
> >> =A0=A0=A0=A0=A0void __iomem=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0*io_priv;
> >>
> >> +=A0=A0=A0=A0/* for notification of usb_xceiv_events */
> >> +=A0=A0=A0=A0struct blocking_notifier_head=A0=A0=A0notifier;
> >
> >Why "blocking"? =A0That seems kind of unnatural; for example,
> >the main users -- like usb_gadget_vbus_draw() -- would be
> >called in IRQ context (blocking not allowed).
>=20
> what about irqs running in thread, wouldn't we "BUG sleeping in irq=20
> context" ?

Iff the IRQ has a thread context, it can block.

But a SET_CONFIGURATION request is mostly going to
be delivered to a hard IRQ context, and that is what
will pass the host's vbus_draw configuration to the
hardware.  (Same for most of the other events you
sketched.)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
