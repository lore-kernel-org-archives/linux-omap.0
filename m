From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] gpio: omap: fix debounce time calculation
Date: Thu, 12 Nov 2015 12:09:24 -0600
Message-ID: <87egfvqecr.fsf@saruman.tx.rr.com>
References: <1447350640-20347-1-git-send-email-balbi@ti.com> <5644D4F5.8070006@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <5644D4F5.8070006@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Grygorii Strashko <grygorii.strashko@ti.com> writes:
> On 11/12/2015 07:50 PM, Felipe Balbi wrote:
>> According to TRM, debounce is measured in periods of
>> the functional clock of the GPIO IP. This means that
>
>
> What TRM? link pls.
>
> http://www.ti.com/lit/ug/spruhl7d/spruhl7d.pdf
>
> 28.4.1.24 GPIO_DEBOUNCINGTIME Register (offset =3D 154h) [reset =3D 0h]
>
> The GPIO_DEBOUNCINGTIME register controls debouncing time (the value is
> global for all ports). The debouncing cell is running with the
> debouncing clock (32 kHz), this register represents the number of the
> clock cycle(s) (31 s long) to be used.
>
> Debouncing Value in 31 microsecond steps.
> Debouncing Value =3D (DEBOUNCETIME + 1) * 31 microseconds.

DRA7xx:

"
8-bit values specifying the debouncing time. It is n-
periods of the muxed clock, which can come from either
a true 32k oscillator/pad of from the system clock. It
depends on which boot mode is selected. For more
information see Chapter 32, Initialization.
"

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWRNXWAAoJEIaOsuA1yqREZ5sQAKBx4H2qmLesywtx4sjiKGWO
s+zjtK+Ri/pPxxPZ5juMtGrYx9ofY1JSS8XFDLyzv3+wg9Pk+Rlsn/r+Dw82hPEE
Ol/C8SHbRuh9rb0Sv6IvP9oq5/oDiO6k6C8OxpCyzhA8x/4ra5PnJVSPFffBjfvp
qWvgTHTLb/N3L0z6b5SKlqdBmjV/jOSr9CVwXWvzaxR1f0y0PXEpZN5SThp00REn
Fiig/kzFE3h1nrNjlI88EwJyn4QFav9cghjgfnCxyTLWheRb9zY6QxBxc0t2dQL6
NotsDJCl7mr4MJ0abL/1bgRpQbzcL+MDuSaLkd/qviFVLGloqe+xiD/mVcYr+sch
LcK0vquA78B1dsKyV9yWtJ30YPJZzSalE98HCcIivaKpL7866CEji254DgspB6t+
HGmmRUwTq7a6oNqrMCq5vEsXCcQSY2UNifDEXcJ46nw1vZ5SzzXzRcdPCnEbxQ8C
obNwRvf0ho58mnYMOIaDgaFuhZbw2dScC1sTIu5kIjHfrPrvBb9tuoeE39x2Ec3V
E8c/K0ImKf5QjXOjnDFCtbexp89upRf6/837md6dGnIcVCyFJBb6vpPnScgeXp1u
/UTErpJTvEoPA/Ar9hm3hlmr9zBVgjzk+dS9ix4s50p2tcyGhyX9XZOGw7uWaMB4
TKpmCPjJpasAOoXjkQvi
=4ZxX
-----END PGP SIGNATURE-----
--=-=-=--
