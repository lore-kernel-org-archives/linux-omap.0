From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC/PATCH 1/5] usb: otg: add notifier support
Date: Tue, 26 Jan 2010 21:09:34 +0200
Message-ID: <20100126190934.GC20049@nokia.com>
References: <6ed0b2680912101251jeec28e6i216dfc51caab13aa@mail.gmail.com>
 <201001260316.20529.david-b@pacbell.net>
 <20100126141016.GD10690@nokia.com>
 <201001260707.23339.david-b@pacbell.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754956Ab0AZTME@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201001260707.23339.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Grazvydas Ignotas <notasas@gmail.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 26, 2010 at 04:07:22PM +0100, ext David Brownell wrote:
>On Tuesday 26 January 2010, Felipe Balbi wrote:
>> >> +enum usb_xceiv_events {
>> >
>> >Let's keep charger events separate from anything else,
>> >like "enter host mode" or "enter peripheral mode" (or
>> >even "disconnect"). =A0The audiences for any other types
>> >of event would be entirely different.
>>
>> the idea was to notify USB events to interested drivers, not only "u=
sb
>> charger events".
>
>There are thousands of events that could be issued.
>I'd rather start with one specific problem, which
>can really benefit from being solved.
>
>If necessary, other events can be added later.
>
>
>> >Right now there's a mess in terms of charger hookup,
>> >so getting that straight is IMO a priority over any
>> >other type of event. =A0Using events will decouple a
>> >bunch of drivers, and simplify driver configuration.
>>
>> well, if you consider that this transceiver isn't really otg specifi=
c,
>> then this is already wrong.
>
>It's the only transceiver interface we have; and it
>works for OTG transceivers in peripheral-only mode,
>as well as host-only and dual-role modes.  So it's
>not especially wrong.
>
>
>However, "you can consume N milliAmperes now" doesn't
>need to be coupled to a transceiver at all.  In fact,
>it works just fine with any pure peripheral interface.
>The gadget stack uses such calls ... and doesn't need
>to be coupled to any transceiver.  (But obviously it
>can hook up to an OTG transceiver.)
>
>
>
>> >> +=A0=A0=A0=A0USB_EVENT_NONE, =A0 =A0 =A0 =A0 /* no events or cabl=
e disconnected */
>> >> +=A0=A0=A0=A0USB_EVENT_VBUS, =A0 =A0 =A0 =A0 /* vbus valid event =
*/
>> >> +=A0=A0=A0=A0USB_EVENT_ID, =A0 =A0 =A0 =A0 =A0 /* id was grounded=
 */
>> >> +=A0=A0=A0=A0USB_EVENT_CHARGER, =A0 =A0 =A0/* usb dedicated charg=
er */
>> >> +=A0=A0=A0=A0USB_EVENT_ENUMERATED, =A0 /* gadget driver enumerate=
d */
>> >
>> >Those seem like the wrong events. =A0The right events for a charger
>> >would be more along the lines of:
>> >
>> > - For peripheral: =A0"you may use N milliAmperes now".
>> > - General: =A0"Don't Charge" (a.k.a. "use 0 mA").
>>
>> I have to disagree, which information would you used to kick the usb
>> dedicated charger detection other than VBUS irq from transceiver ?
>
>That's why I said what I did about the separate charger spec (and
>you quoted it below):  it's not going to be less than those two
>ops, which your events don't really capture.
>
>That's "bonus" functionality though ... among other reasons, it's
>not all that common yet.  The basic "charge battery over USB"
>scenario needs to work without that stuff.
>
>
>> So we need at least that, and also need to notify when the charger
>> detection is finished, so we can enable data pullups on the link.
>> Remember we might be connected to a charging downstream port.
>
>So you're presuming some separate component will do charger
>detection by listening for events?  If it's mucking with the
>pullups, that seems very much like what an OTG transciever
>needs to be managing.  And thus, perhaps, transceiver code.

well, if you have access to twl5031 docs you'd understand what I'm=20
talking about, the charger detection involves at least 3 blocks on=20
twl5031 plus musb to enable/disable pullups. The sequence is pretty muc=
h=20
as below:

1. vbus irq
2. usb_gadget_disconnect()
3. disable usb ldos
4. switch usb3v1 supply from vbat to vbus (to let charger detection wor=
k=20
on low bat)
5. enable usb3v1 *only*
6. call the notifier chain
7. BCC module kicks charger detection
8. disable usb3v1
9. switch usb3v1 supply back to vbat
10. enable usb ldos
11. usb_gadget_connect() (necessary since we might be connected to=20
charging port)

vbus irq comes from transceiver (drivers/usb/otg/twl4030-usb.c),=20
notifier (currently) is also issued from there.=20
usb_gadget_connect/disconnect() is implemented in=20
drivers/usb/musb/musb_gadget.c, BCC module is a power_supply driver (no=
t=20
in mainline yet, I guess).

And after all that, we still have bq2415x as the charger chip itself. O=
n=20
that we configure input current and all the filters imposed by pse law.=
=20
There's also the battery monitoring part which will involve the MADC=20
part of twl4030/5030/5031/tpsxxxxx and some temperature sensor (maybe).

So the whole thing is quite complicated and should probably be moved to=
=20
some "core" code.

>If there's such a separate component, I'd like to see some
>detail about how it'd work.  But ... at first glance, it'd
>have thought it'd be simplest inside a transceiver driver.

well, we could export some symbols to the transceiver to access the BCC=
=20
address space in twl, but why if we can let bcc do that by itself if we=
=20
just tell it "hey dude, vbus is alive".

>We could take a vote to see how many folk have even seen
>one, much less own one.  They're not very common, and not
>part of the USB 2.0 spec.  That's why I say "not basic".

ok, got it. But we already have plenty of devices on the market which=20
support them. Look at n900, for example, the only way to charge its=20
battery if via usb port ;-)

>> what about irqs running in thread, wouldn't we "BUG sleeping in irq
>> context" ?
>
>Iff the IRQ has a thread context, it can block.

ok, so what do you suggest in this case ?

we know that on omaps vbus will come from an i2c-connected transceiver=20
so its irq handler will be running in a thread and VBUS is the first=20
valuable information we have on usb point of view.

--=20
balbi
