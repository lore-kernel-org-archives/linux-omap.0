From: Felipe Balbi <balbi@ti.com>
Subject: Re: Routable IRQs
Date: Wed, 30 Dec 2015 12:41:37 -0600
Message-ID: <87ziwrixsu.fsf@ti.com>
References: <878u4dj9r7.fsf@ti.com> <alpine.DEB.2.11.1512301903450.28591@nanos>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1512301903450.28591@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi Thomas,

Thomas Gleixner <tglx@linutronix.de> writes:
> On Tue, 29 Dec 2015, Felipe Balbi wrote:
>> Anyway, the interesting part is that PRUSS has 64 events (on current
>> incarnations at least) and PRUSS has 10 physical IRQ lines to the ARM
>> land. Each of these 64 events can be routed to any of these 10 IRQ
>> lines. This might not be very useful on UP (AM335x & AM437x) other than
>> the fact that soft-IP drivers running on Linux would need to guarantee
>> they are the ones who should handle the IRQ. However, on SMP (AM57xx) we
>> could have real tangible benefits by means of IRQ affinity, etc.
>>=20
>> So, the question is, what is there in IRQ subsystem today for routable
>> IRQ support ?
>>=20
>> If a Diagram helps here's a simple one. Note that I'm not showing
>> details on the PRUSS side, but that side can also map events pretty much
>> any way it wants.
>>=20
>>  .--------------------.             .--------------------.
>>  |      HOST CPU      |             |       PRUSS        |
>>  |--------------------|             |--------------------|
>>  |                    |             |                    |
>>  |               irq0 |<-.----------|evt0                |
>>  |                    |  |          |                    |
>>  |               irq1 |  |  .-------|evt1                |
>>  |                    |  |  |       |                    |
>>  |               irq2 |  '----------|evt2                |
>>  |                    |     |       |                    |
>>  |               irq3 |     |       |                    |
>>  |                    |     |       |                    |
>>  |               irq4 |     |       | .                  |
>>  |                    |     |       |                    |
>>  |               irq5 |     |       | .                  |
>>  |                    |     |       |                    |
>>  |               irq6 |     |       | .                  |
>>  |                    |     |       |                    |
>>  |               irq7 |<----'       |                    |
>>  |                    |             |                    |
>>  |               irq8 |             |                    |
>>  |                    |             |                    |
>>  |               irq9 |<------------|evtN                |
>>  '--------------------'             '--------------------'
>>=20
>> Given this setup, what I want to do, is let soft-IP drivers running on
>> linux rely on standard *request_*irq() calls and DTS descrition. But I'm
>> still considering how/if we should describe the routing itself or just
>> go round-robin (i.o.w. irq0 -> evt0, irq1 -> evt1, ..., irq9 -> evt9,
>> irq0 -> evt10, ...).
>>=20
>> Thoughts ?
>
> I have a few questions:
>
>  - Is there a "mapping" block between PRUSS and the host interrupt contro=
ller
>    or is this "mapping" block part of PRUSS?

The description in TRM is a bit "poor", but from what I can gather, the
mapping is done on an interrupt controller inside the PRUSS. However,
Linux is the one who's got the driver for that INTC (well, Linux will be
the one with the soft ethernet/uart/whatever IP to talk to). All of its
(INTC's) registers are memory mapped to the ARM side.

>  - We all know how well shared interrupts work. Is there a point of suppo=
rting
>    64 interrupts when you only have 10 irq lines available?

I'm looking at these 64 events more like MSI kind of events. It's just
that the events themselves can be routed to any of the 10 available HW
IRQ lines.

>  - I assume that the PRUSS interrupt mapping is more or less a question o=
f the
>    firmware implementation. So you either have a fixed association in the
>    firmware which is reflected in the DT description of the IP block or y=
ou
>    need an interface to tell the PRUSS firmware which event it should map=
 to
>    which irq line. Is there actually a value in doing the latter?

right, I'd say the mapping is pretty static. Unless Suman has some extra
information which I don't. I guess the question was really to see if
there was an easy way for doing this so we don't have to mess with DTS
for every other FW and their neighbor.

Chances are (or at least I'm speculating) in most cases we won't use
more than 10 events anyway (Suman ?) so we might not run into any
troubles.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWhCVhAAoJEIaOsuA1yqRERGUP/2MA/+ybo+2nWISpUr3RWu/A
W7nVkk9XHjWyIkru2JCfFedsLvu6e994hPD6ah24CNodYdlL86c6SBqOod6bhbzQ
5ajCDuZI5EWtKt/PpGwCr7GUyF51MhQ5s3P6bT+4GUyfvFIuNAha9o+Hz6Zh+C3G
2vFu51SVzHHt453Nk0DSm6xuH1mNpwBprlUwo23cDrj9YKoJgBIuMAr7qa5Gy6a8
7s9T1XFrj8XkzbiJfDx4NRD8w4lMhoHopAmZ+eOLfaXcQlDqniD62+ZmQLdqJQL4
eCx1v8u+DZ3ChC7P8O8cVTUfAHVcDfZAbf32nuKPddvvD3lA9ZIjU1kGNDafjjm7
CPVqLnyeCpHuhfWht4ef2a5Xtv/Xz9viIUFqK7rQuKTzTYWAl2nbh0EtT/nLvQte
hQPEnH6KBvCpaFjAzFKygg4m4PoswTEP1+Ln9J3bGQvbHNYuRXfBM6pHfYJSKmev
btxnW4RcWtK8CMmdaAwkPe/0ywT762Ly8hHZdBUlq3jsuVEfiqoGlxWNrfZSpE0B
1S/rmsdyDhCqp7+1440ael7NxEyTVGTbrZAtwq8nWPkOPLWXmFkFvMzOr8d7uuqD
30ZEiSk6cjKdc3Lc91sYQY88xT746Mo4AFEv4bMBkyeMVbhEUuO4FpPfvjsItsmj
cFY6qD+DzlPtWup23G9A
=Wany
-----END PGP SIGNATURE-----
--=-=-=--
