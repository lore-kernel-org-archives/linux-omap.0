From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Mon, 13 Jul 2015 19:09:06 +0200
Message-ID: <201507131909.06521@pali>
References: <201507111405.06048@pali> <20150713080920.GA25585@earth> <20150713170344.GA5825@deathray>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3545633.BcKEKAUvs9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150713170344.GA5825@deathray>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart3545633.BcKEKAUvs9
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 13 July 2015 19:03:44 Michael Welling wrote:
> On Mon, Jul 13, 2015 at 10:09:21AM +0200, Sebastian Reichel wrote:
> > [+cc Michael Welling <mwelling@ieee.org>, author of all omap-spi
> > patches between 4.1 and 4.2-rc1]
> >=20
> > Hi,
> >=20
> > On Sun, Jul 12, 2015 at 11:44:25PM -0700, Tony Lindgren wrote:
> > > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150711 05:07]:
> > > > Hello,
> > > >=20
> > > > now I tested 4.2-rc1 release on Nokia N900 and couple of
> > > > drivers are broken and cause kernel oops...
> > > >=20
> > > > Basically wifi, touchscreen and rtc drivers not working...
> > > >=20
> > > > Here are some relevant snippets form dmesg:
> > > >=20
> > > > [   13.933959] Unhandled fault: external abort on non-linefetch
> > > > (0x1028) at 0xfa09802c [   13.940490] pgd =3D cfb38000
> > > > [   13.946594] [fa09802c] *pgd=3D48011452(bad)
> > > > [   13.952758] Internal error: : 1028 [#1] PREEMPT ARM
> > > > [   13.958862] Modules linked in: tsc2005(+) omap_sham
> > > > twl4030_wdt omap_wdt [   13.965332] CPU: 0 PID: 183 Comm:
> > > > modprobe Not tainted 4.2.0-rc1+ #363 [   13.971801] Hardware
> > > > name: Nokia RX-51 board
> > > > [   13.978302] task: cf572300 ti: cb1f2000 task.ti: cb1f2000
> > > > [   13.984924] PC is at omap2_mcspi_set_cs+0x44/0x4c
>=20
> Here is the disassembly of the omap2_mcspi_set_cs function from my
> compiler: 00000040 <omap2_mcspi_set_cs>:
>       40:       e2803e25        add     r3, r0, #592    ; 0x250
>       44:       e5902258        ldr     r2, [r0, #600]  ; 0x258
>       48:       e1d330b2        ldrh    r3, [r3, #2]
>       4c:       e3130004        tst     r3, #4
>       50:       12211001        eorne   r1, r1, #1
>       54:       e3520000        cmp     r2, #0
>       58:       012fff1e        bxeq    lr
>       5c:       e5923018        ldr     r3, [r2, #24]
>       60:       e3510000        cmp     r1, #0
>       64:       13c33601        bicne   r3, r3, #1048576        ;
> 0x100000 68:       03833601        orreq   r3, r3, #1048576        ;
> 0x100000 6c:       e5823018        str     r3, [r2, #24]
>       70:       e5902258        ldr     r2, [r0, #600]  ; 0x258
>       74:       e5922000        ldr     r2, [r2]
>       78:       e582302c        str     r3, [r2, #44]   ; 0x2c
>       7c:       e5903258        ldr     r3, [r0, #600]  ; 0x258
>       80:       e5933000        ldr     r3, [r3]
>       84:       e593202c        ldr     r2, [r3, #44]   ; 0x2c
>       88:       e12fff1e        bx      lr
>=20
> The omap2_mcspi_set_cs function is being called before the
> controller_state is initialized in omap2_mcspi_setup.
>=20
> That is why there is a conditional checking if controller_state is
> NULL.
>=20
> Perhaps the controller_state is uninitialized but has garbage instead
> of NULL causing the data abort.
>=20
> Though that does not make much sense because a similar check in the
> setup function did not cause a data abort in the past.
>=20
> Not sure what is going wrong here.
>=20
> Could you do a objdump with the compiler you are using?
>=20

Hello, here is my objdump of 4.2-rc2 version:

00000064 <omap2_mcspi_set_cs>:
      64:       e3003182        movw    r3, #386        ; 0x182
      68:       e19030b3        ldrh    r3, [r0, r3]
      6c:       e3130004        tst     r3, #4
      70:       0a000001        beq     7c <omap2_mcspi_set_cs+0x18>
      74:       e2711001        rsbs    r1, r1, #1
      78:       33a01000        movcc   r1, #0
      7c:       e5902188        ldr     r2, [r0, #392]  ; 0x188
      80:       e3520000        cmp     r2, #0
      84:       012fff1e        bxeq    lr
      88:       e5923018        ldr     r3, [r2, #24]
      8c:       e3510000        cmp     r1, #0
      90:       13c33601        bicne   r3, r3, #1048576        ; 0x100000
      94:       03833601        orreq   r3, r3, #1048576        ; 0x100000
      98:       e5823018        str     r3, [r2, #24]
      9c:       e5902188        ldr     r2, [r0, #392]  ; 0x188
      a0:       e5922000        ldr     r2, [r2]
      a4:       e582302c        str     r3, [r2, #44]   ; 0x2c
      a8:       e592302c        ldr     r3, [r2, #44]   ; 0x2c
      ac:       e12fff1e        bx      lr

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3545633.BcKEKAUvs9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlWj8LIACgkQi/DJPQPkQ1JTYgCeMEoTJXUrRpPFQvss/lWdfDLE
qo8AoJOtVB6irtgee72JllOqjIMpPKcY
=6dhn
-----END PGP SIGNATURE-----

--nextPart3545633.BcKEKAUvs9--
