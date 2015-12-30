From: Felipe Balbi <balbi@ti.com>
Subject: Re: Routable IRQs
Date: Wed, 30 Dec 2015 14:10:58 -0600
Message-ID: <87vb7fitnx.fsf@ti.com>
References: <878u4dj9r7.fsf@ti.com> <alpine.DEB.2.11.1512301903450.28591@nanos> <87ziwrixsu.fsf@ti.com> <alpine.DEB.2.11.1512302037340.28591@nanos>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1512302037340.28591@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Thomas Gleixner <tglx@linutronix.de> writes:
> Felipe,
>
> On Wed, 30 Dec 2015, Felipe Balbi wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>> >  - Is there a "mapping" block between PRUSS and the host interrupt con=
troller
>> >    or is this "mapping" block part of PRUSS?
>>=20
>> The description in TRM is a bit "poor", but from what I can gather, the
>> mapping is done on an interrupt controller inside the PRUSS. However,
>> Linux is the one who's got the driver for that INTC (well, Linux will be
>> the one with the soft ethernet/uart/whatever IP to talk to). All of its
>> (INTC's) registers are memory mapped to the ARM side.
>
> Ok. And the INTC registers include the "mapping" configuration, right?

right. A bunch of 32 bit registers each with several 4 bit fields (one
for each of the 64 events) where we write the physical IRQ number.

>> >  - We all know how well shared interrupts work. Is there a point of su=
pporting
>> >    64 interrupts when you only have 10 irq lines available?
>>=20
>> I'm looking at these 64 events more like MSI kind of events. It's just
>
> Well, that's fine to look at them this way, but they will end up
> shared no matter what.

sure :-)

>> that the events themselves can be routed to any of the 10 available HW
>> IRQ lines.
>>=20
>> >  - I assume that the PRUSS interrupt mapping is more or less a questio=
n of the
>> >    firmware implementation. So you either have a fixed association in =
the
>> >    firmware which is reflected in the DT description of the IP block o=
r you
>> >    need an interface to tell the PRUSS firmware which event it should =
map to
>> >    which irq line. Is there actually a value in doing the latter?
>>=20
>> right, I'd say the mapping is pretty static. Unless Suman has some extra
>> information which I don't. I guess the question was really to see if
>> there was an easy way for doing this so we don't have to mess with DTS
>> for every other FW and their neighbor.
>
> Well, you will need information about every other firmware simply because=
 you
> need to know which events the firmware is actually using and what the pur=
pose
> of the particular event is.
>
> Assume you have a simple uart with 3 events (RX, TX, status). So how will=
 the
> firmware tell you which event is which? You have a few options:
>
>  1) DT + fixed mapping scheme:=20
>
>     Describe the PRUSS event number in DT and have a fixed mapping scheme=
 like
>     the one you mentioned evt0 -> irq0 .....
>
>  2) DT + DT mapping scheme
>
>     Describe the PRUSS event number in DT and describe the mapping scheme=
 in
>     DT as well
>
>  3) DT + dynamic mapping scheme
>
>     Describe the PRUSS event number in DT and let your interrupt controll=
er
>     associate the irq number dynamically. That's kind of similar to MSI w=
ith
>     the exception that it needs to support shared interrupts.
>
>  4) Fully dynamic association
>
>     Have a query interface to the firmware which tells you which event it=
 uses
>     for which particular purpose (RX, TX ...) and then establish a dynamic
>     mapping to one of the interrupts.
>
> Not sure which level of complexity you want :)

I guess only 1, 2 are anything worth considering, most likely. 4 would
just be too much headache :-p

3 might be doable too, though a bit more complex. Suman (who has been
working on this for much longer than I have) might have some extra info
to add, but he's on vacations for now. Hopefully, he'll add to this
thread once he's back.

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWhDpTAAoJEIaOsuA1yqRE2D4P/iTDPAscBByE+sYeICRWcuon
BOmChFIfBHA9rjxEO0lTmrLg+Mk8+vFP0jsLo+ScVEqWESwHc5t/TvEDvQepVscI
GxUCuUBYnzaSUJZDVhI3lOTv84HvMgW5qmdwnpfJxJYDlW0HddX+Er2Ff3Wpa7Ir
ifmH9lRm5TXhnt3S6UnN+YbrlXgM/1uaY0pWl2IYi2ui5XE4hUTmkgN4+NJRNMIY
sD1voN9vLmsn1fkLvVbTUZ2LH8Ed6T+5cLsHS2q7uC1WuJcvoo6mOywOjQBFlXqA
OxAJokrRhpatgR6tpLetSkv0SoXlcqGWeJspNmIQQ4ymx0+le85EZ6w1cvammpOA
/TxohJzEfEJdsrHzpYhNLVt9ivlg5uFiUjRz6WEseUD4GrFGdupQ0/CfA5x/M9TU
YYRLP6ia8j2IfHQk4XykBh1ePXYVeJyAeyktciSxcC6mq0V2Qt/sViqerlBhNyFJ
6qgQe5nhz6zX/oknTy1zpsVYGDTX39dt3YLZG+9C01V75OOSWjsHmtS5BaI3xztw
G81TPqZTkgv0d02qGCsyk9RQwedB7+8QeR7DE7yP8U2s0gCWd2mqA90CuWKKJ4Cq
A4wKuSC51YYWMLwEKUFyJZywwrS/vQhA7eN1Y0F6nfhjarkIUjqdyMGId+QgfzoX
sVL5l0bViPEqFURtKZKx
=UHFJ
-----END PGP SIGNATURE-----
--=-=-=--
