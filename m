From: Felipe Balbi <balbi@ti.com>
Subject: Routable IRQs
Date: Tue, 29 Dec 2015 14:11:08 -0600
Message-ID: <878u4dj9r7.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi Thomas & Jason,

I'm dealing with an interesting situation which I'm wondering if Linux
already support for.

Basically, in some TI SoCs we have what's referred to as Programmable
Real-Time Unit SubSystem (PRUSS). That's essentially a really simple,
low latency, single cycle architecture which is pretty darn good for bit
banging peripherals (ETH, SPI, I2C, UART, etc). It's very predicatable
because every instruction takes 5ns and interrupts don't cause
exceptions, they just get registered.

Anyway, the interesting part is that PRUSS has 64 events (on current
incarnations at least) and PRUSS has 10 physical IRQ lines to the ARM
land. Each of these 64 events can be routed to any of these 10 IRQ
lines. This might not be very useful on UP (AM335x & AM437x) other than
the fact that soft-IP drivers running on Linux would need to guarantee
they are the ones who should handle the IRQ. However, on SMP (AM57xx) we
could have real tangible benefits by means of IRQ affinity, etc.

So, the question is, what is there in IRQ subsystem today for routable
IRQ support ?

If a Diagram helps here's a simple one. Note that I'm not showing
details on the PRUSS side, but that side can also map events pretty much
any way it wants.

 .--------------------.             .--------------------.
 |      HOST CPU      |             |       PRUSS        |
 |--------------------|             |--------------------|
 |                    |             |                    |
 |               irq0 |<-.----------|evt0                |
 |                    |  |          |                    |
 |               irq1 |  |  .-------|evt1                |
 |                    |  |  |       |                    |
 |               irq2 |  '----------|evt2                |
 |                    |     |       |                    |
 |               irq3 |     |       |                    |
 |                    |     |       |                    |
 |               irq4 |     |       | .                  |
 |                    |     |       |                    |
 |               irq5 |     |       | .                  |
 |                    |     |       |                    |
 |               irq6 |     |       | .                  |
 |                    |     |       |                    |
 |               irq7 |<----'       |                    |
 |                    |             |                    |
 |               irq8 |             |                    |
 |                    |             |                    |
 |               irq9 |<------------|evtN                |
 '--------------------'             '--------------------'

Given this setup, what I want to do, is let soft-IP drivers running on
linux rely on standard *request_*irq() calls and DTS descrition. But I'm
still considering how/if we should describe the routing itself or just
go round-robin (i.o.w. irq0 -> evt0, irq1 -> evt1, ..., irq9 -> evt9,
irq0 -> evt10, ...).

Thoughts ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWgujdAAoJEIaOsuA1yqRECIgP/0YmgvMEvPLR+hFgHHgeQk9o
C0AqsGqGO6T37xgl0dkiBCS42cbZzv74D4BYcH8Ta/cl7OCWSU8e1pDnXOYiVuxh
2d3ikmO+wC1MHwbREpsdrUaH/6CHDHDj9QakpUvLhQ19LEFZQr8mLS5uH1mQIqIG
Mgl7cNfC+n0wf/LQbhFLJyLtgXVbdxWFMW9/JEwrlvTySUxZuA8DiqpqUWE0VP9o
bUDaTPVcd27deivsogh97D4tLBorHT3VlqRqEuy8wPxLFhwY8BUyi/sOaZst303t
amqRdg+0rJshpYRE0Orau3nrXBfmoHb0PvOPkb/izTaK3HLPDoabpziZhjLnuhJ+
pqTfnBnrLZXUKSYztn7I2Z+JjgOhT+Jy1UeNEyOcsPvVuEi63amdTsExBhWsVQWn
4zbfIK5eAjEb6Ulk0Y65eOJILA1/hR1xCb75WI6kSHYtrf9yvxl98rrL0hXuat2/
pDj+7YOEgG28+tLwy69b0JDoV6UETXBwoiQqprsH0fAsw06QFikJfmJtOEVrPPDO
NnZxgnkxkXWrnETbZHACW7Ikyw89XouAR9WwyYBqtBhtIU/yxU/7CrPIVBGdu+TX
1MypVpXWsEZ30LoQ4fzstf8yZg+gzhxkQOEaGahp/liuKXtnYTjR178MjlGQ0Z6X
6TV2AY1O6ObSZ5UQmgtS
=Jmmh
-----END PGP SIGNATURE-----
--=-=-=--
